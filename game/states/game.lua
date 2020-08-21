local Game = {}

tiled = require("libraries.tiled")
physics = require("libraries.physics")

function Game:load()
    tiled.loadMap("test")
    self.player = physics:getEntity("player")

    self.shakeIntensity = 0
end

function Game:update(dt)
    tiled.update(dt)

    if self.shakeIntensity > 0 then
        self.shakeIntensity = self.shakeIntensity - 5 * dt
    end
end

function Game:draw()
    if self.shakeIntensity > 0 then
        local x, y = (love.math.random() * 2 - 1) * self.shakeIntensity,  (love.math.random() * 2 - 1) * self.shakeIntensity
        love.graphics.translate(x, y)
    end

    tiled.draw()
end

function Game:addEntity(entity)
    tiled.addEntity(entity)
end

function Game:shakeScreen(amount)
    self.shakeIntensity = math.abs(amount)
end

function Game:gamepadpressed(joy, button)
    if not self.player then
        return
    end

    self.player:debugButtons(button)
end

function Game:gamepadaxis(joy, axis, value)
    if not self.player then
        return
    end

    if axis == "rightx" then
        self.player:setEyeX(value)
    elseif axis == "righty" then
        self.player:setEyeY(value)
    end

    if axis == "leftx" then
        if value > 0.5 then
            self.player:moveLeft(false)
            self.player:moveRight(true)
        elseif value < -0.5 then
            self.player:moveRight(false)
            self.player:moveLeft(true)
        else
            self.player:moveLeft(false)
            self.player:moveRight(false)
        end
    end

    if axis == "lefty" then
        if value > 0.5 then
            self.player:moveUp(false)
            self.player:moveDown(true)
        elseif value < -0.5 then
            self.player:moveDown(false)
            self.player:moveUp(true)
        else
            self.player:moveUp(false)
            self.player:moveDown(false)
        end
    end
end

function Game:unload()

end

return Game
