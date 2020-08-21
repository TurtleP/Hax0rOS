local Entity = require("data.classes.entity")
local Bubble = Entity:extend()

function Bubble:new(x, y)
    Bubble.super.new(self, x, y, 4, 4)

    local spawn = physics:getEntity("spawn")
    self.target = {x = spawn.x + spawn.width / 2, y = spawn.y + spawn.height / 2}

    self.moveSpeed = 360
end

function Bubble:update(dt)
    local spinFactor = math.pi / 8

    local speedAngle = math.atan2(self.speed.y, self.speed.x)
    local targetAngle = math.atan2((self.target.y + self.height / 2) - self.y, self.target.x - self.x)

    if speedAngle < targetAngle and targetAngle - speedAngle > math.pi then
        spinFactor = spinFactor * -1.5
    elseif speedAngle > targetAngle and speedAngle - targetAngle <= math.pi then
        spinFactor = spinFactor * -1
    end

    speedAngle = speedAngle + spinFactor

    self.speed.x = self.moveSpeed * math.cos(speedAngle)
    self.speed.y = self.moveSpeed * math.sin(speedAngle)
end

function Bubble:draw()
    love.graphics.circle("fill", self.x + 2, self.y + 2, 0.5 + math.cos(love.timer.getTime() * 9) + 6)
end

function Bubble:filter()
    return function(entity, other)
        if other:passive() or other:is("tile") then
            return false
        elseif other:is("spawn") then
            state.call("shakeScreen", love.math.random(6, 10))
            other:addSize(2)
            self.flags.remove = true
            return false
        end
        return "slide"
    end
end

function Bubble:gravity()
    return 0
end

function Bubble:passive()
    return true
end

function Bubble:__tostring()
    return "bubble"
end

return Bubble
