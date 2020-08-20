local Object = require("libraries.classic")
local Background = Object:extend()

local Vector = require("libraries.vector")

Background.CONST_SPEED = 120

function Background:new()
    self.texture = love.graphics.newImage("graphics/menu/background.png")

    self.quads = {}
    for i = 1, 3 do
        self.quads[i] = love.graphics.newQuad(0, (i - 1) * 720, 1280, 720, self.texture)
    end

    self.height = 720

    self.scroll = Vector(0, -self.height)
    self.main = Vector()

    self.timer = 0
    self.quadi = nil

    self:diceRoll()
end

function Background:diceRoll()
    local rand = love.math.random(1, 3)

    if self.quadi ~= rand then
        self.quadi = rand
    else
        self:diceRoll()
    end
end

function Background:update(dt)
    self.scroll.y = self.scroll.y + Background.CONST_SPEED * dt
    self.main.y = self.main.y + Background.CONST_SPEED * dt

    if self.main.y > vars.WINDOW_H then
        self.main.y = -self.height
    elseif self.scroll.y > vars.WINDOW_H then
        self.scroll.y = -self.height
    end

    self.timer = self.timer + dt
    if self.timer > 0.25 then
        self:diceRoll()
        self.timer = 0
    end
end

function Background:draw()
    -- scrolly backdrop
    love.graphics.draw(self.texture, self.quads[self.quadi], self.scroll.x, self.scroll.y)

    -- main backdrop
    love.graphics.draw(self.texture, self.quads[self.quadi], self.main.x, self.main.y)
end

return Background
