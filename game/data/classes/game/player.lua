local Entity = require("data.classes.entity")
local Player = Entity:extend()

local Vector = require("libraries.vector")
local Bullet = require("data.classes.game.bullet")

Player.texture = love.graphics.newImage("graphics/game/eyes.png")
Player.quads = {}
for i = 1, 4 do
    Player.quads[i] = love.graphics.newQuad((i - 1) * 10, 0, 9, 9, Player.texture)
end

Player.CONST_EYE_SPEED = 40
Player.CONST_MOVE_SPEED = 96
Player.CONST_MAX_SPEED = 240

Player.CONST_FRICTION = 0.96

function Player:new(x, y)
    Player.super.new(self, x, y, 32, 32)

    self.blinkDelay = math.random(4, 6)
    self.blinkTimer = 0
    self.blinkQuadi = 1

    self.blinkAnimation = {1, 2, 3, 4, 3, 2}

    self.eyesOrigin = Vector(self.width / 2, self.height / 2)
    self.eyes = self.eyesOrigin:clone()
    self.shootAngle = Vector()

    self.flags.fixEyes = {false, false}
    self.flags.float = true
    self.flags.shoot = false

    self.keys = {up = false, right = false, left = false, down = false}
end

function Player:update(dt)
    self.blinkDelay = self.blinkDelay - dt

    if self.blinkDelay < 0 then
        if self.blinkQuadi < #Player.quads then
            self.blinkTimer = self.blinkTimer + 8 * dt
            self.blinkQuadi = self.blinkAnimation[math.floor(self.blinkTimer % #self.blinkAnimation) + 1]
        else
            self.blinkQuadi = 1
            self.blinkDelay = math.random(4, 6)
            self.blinkTimer = 0
        end
    end

    if self.flags.fixEyes[1] and self.flags.fixEyes[2] then
        if self.eyes.x ~= self.width / 2 then
            self.eyes.x = math.min(self.eyes.x + Player.CONST_EYE_SPEED * dt, self.width / 2)
        end

        if self.eyes.y ~= self.height / 2 then
            if self.eyes.y < self.height / 2 then
                self.eyes.y = math.min(self.eyes.y + Player.CONST_EYE_SPEED * dt, self.height / 2)
            else
                self.eyes.y = math.max(self.eyes.y - Player.CONST_EYE_SPEED * dt, self.height / 2)
            end
        end

        if self.eyes == self.eyesOrigin then
            self.flags.fixEyes = {false, false}
            self.shootAngle = Vector()
        end
    end

    if self.flags.float then
        if self.keys.right then
            self.speed.x = math.min(self.speed.x + Player.CONST_MOVE_SPEED, Player.CONST_MAX_SPEED)
        elseif self.keys.left then
            self.speed.x = math.max(self.speed.x - Player.CONST_MOVE_SPEED, -Player.CONST_MAX_SPEED)
        end

        if self.keys.up then
            self.speed.y = math.max(self.speed.y - Player.CONST_MOVE_SPEED, -Player.CONST_MAX_SPEED)
        elseif self.keys.down then
            self.speed.y = math.min(self.speed.y + Player.CONST_MOVE_SPEED, Player.CONST_MAX_SPEED)
        end

        self.speed.x = self.speed.x * Player.CONST_FRICTION
        self.speed.y = self.speed.y * Player.CONST_FRICTION
    end
end

function Player:draw()
    love.graphics.circle("fill", self.x + self.width / 2, self.y + self.height / 2, 14 + math.cos(love.timer.getTime() * 9) + 2)
    love.graphics.draw(Player.texture, Player.quads[self.blinkQuadi], self.x + self.eyes.x, (self.y + self.eyes.y) - 5)
end

function Player:filter()
    return function(entity, other)
        if other:passive() or other:is("bullet") then
            return false
        end
        return "slide"
    end
end

function Player:floorCollide(a, b)
    if b == "tile" then
        if not self.flags.float then
            self.speed.y = -self.speed.y * 0.75
            return true
        end
    end
end

function Player:setEyeX(x)
    self.flags.fixEyes[1] = false

    if x > 0.5 then
        self.eyes.x = self.width / 2
    elseif x < -0.5 then
        self.eyes.x = 7
    else
        self.flags.fixEyes[1] = true
    end

    if math.abs(x) >= 0 then
        self.shootAngle.x = x
    end
end

function Player:setEyeY(y)
    self.flags.fixEyes[2] = false

    if y < -0.5 then
        self.eyes.y = self.height / 2 - 5
    elseif y > 0.5 then
        self.eyes.y = self.height - 8
    else
        self.flags.fixEyes[2] = true
    end

    if math.abs(y) > 0.5 then
        self.shootAngle.y = y
    end
end

function Player:debugButtons(button)
    if button == "x" then
        self.flags.float = not self.flags.float
    elseif button == "rightshoulder" then
        if math.abs(self.shootAngle.x) < 0.5 or math.abs(self.shootAngle.x) > 0.5 or math.abs(self.shootAngle.y) > 0.5 then
            tiled.addEntity(Bullet(self:center("x"), self:center("y"), self.shootAngle))
        end
    end
end

function Player:moveRight(value)
    self.keys.right = value
end

function Player:moveLeft(value)
    self.keys.left = value
end

function Player:moveUp(value)
    self.keys.up = value
end

function Player:moveDown(value)
    self.keys.down = value
end

function Player:gravity()
    if self.flags.float then
        return 0
    end
    return 720
end

function Player:__tostring()
    return "player"
end

return Player
