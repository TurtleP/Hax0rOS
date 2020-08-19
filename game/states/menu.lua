local Menu = {}

local Vector = require("libraries.vector")

function Menu:load()
    self.logo = love.graphics.newImage("graphics/logo.png")

    self.logoQuads = {}
    for i = 1, 2 do
        self.logoQuads[i] = love.graphics.newQuad(0, (i - 1) * 280, 688, 280, self.logo)
    end

    self.logoQuadi = 1
    self.logoTimer = love.math.random(2)

    self.logoPosition = Vector((vars.WINDOW_W - self.logo:getWidth()) / 2, (vars.WINDOW_H - 280) / 2)
    self.delay = 0

    self.audio = love.audio.newSource("audio/title.ogg", "stream")
    self.audio:setLooping(true)
    self.audio:play()

    self.scissor = {0, 0, vars.WINDOW_W, vars.WINDOW_H}
end

function Menu:update(dt)
    self.logoTimer = math.max(self.logoTimer - dt, 0)

    if self.logoTimer == 0 then
        self.delay = self.delay + 8 * dt

        if self.delay < 1 then
            self.logoQuadi = love.math.random(#self.logoQuads)
        else
            self.logoQuadi = 1
            self.logoTimer = love.math.random(2)
            self.delay = 0
        end
    end
end

function Menu:draw()
    love.graphics.setScissor(unpack(self.scissor))

    love.graphics.setFont(fonts.Main)
    love.graphics.print("root@term ~>")

    love.graphics.draw(self.logo, self.logoQuads[self.logoQuadi], self.logoPosition.x, self.logoPosition.y)

    love.graphics.setScissor()
end

function Menu:unload()
    self.logo = nil

    self.audio:stop()
    self.audio = nil
end

return Menu
