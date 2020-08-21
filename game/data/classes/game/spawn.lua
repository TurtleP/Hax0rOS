local Entity = require("data.classes.entity")
local Spawn  = Entity:extend()

local Bubble = require("data.classes.game.bubble")

function Spawn:new(x, y)
    Spawn.super.new(self, x, y, 16, 16)

    self.coords =
    {
        {0, 0},   {0.5, 0}, {1, 0},
        {0, 0.5}, {1, 0.5}, {0, 1},
        {0.5, 1}, {1, 1}
    }

    self.timer = 0
    self.endTimer = 0

    self.coord = 1

    self.bubbles = {}
    self.size = 0
end

function Spawn:addSize(amount)
    self.size = self.size + amount
end

function Spawn:update(dt)
    self.timer = self.timer + 8 * dt

    if self.timer > 4 then
        if self.coord == #self.coords then
            self.endTimer = self.endTimer + dt

            if self.endTimer > 8 then
                self.flags.remove = true
            end
            return
        end

        local x, y = unpack(self.coords[self.coord])

        state.call("addEntity", Bubble(x * vars.WINDOW_W, y * vars.WINDOW_H))

        self.coord = self.coord + 1
        self.timer = 0
    end
end

function Spawn:static()
    return true
end

function Spawn:draw()
    if self.size == 0 then
        return
    end

    love.graphics.circle("fill", self.x + self.width / 2, self.y + self.height / 2, self.size + math.cos(love.timer.getTime() * 9) + 2)
end

function Spawn:__tostring()
    return "spawn"
end

return Spawn
