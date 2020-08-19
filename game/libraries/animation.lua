local animation = {}

function animation:new(tex, rate)
    local isTexture = type(tex) == "userdata"

    if isTexture then
        self.texture = tex
    else
        self.texture = love.graphics.newImage(tex)
    end

    self.quads = {}
    self.timer = 0
end

function animation:update(dt)
    self.timer = self.timer + self.rate * dt
end

return animation
