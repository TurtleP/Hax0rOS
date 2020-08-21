local Entity = require("data.classes.entity")
local Bullet = Entity:extend()

function Bullet:new(x, y, vec)
    Bullet.super.new(self, x, y, 8, 8)

    local angle = vec:angleTo()

    self.speed.x = math.cos(angle) * 200
    self.speed.y = math.sin(angle) * 200
end

function Bullet:filter()
    return function(e, o)
        if o:is("player") then
            return false
        end
        return "slide"
    end
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Bullet:gravity()
    return 0
end

function Bullet:__tostring()
    return "bullet"
end

return Bullet
