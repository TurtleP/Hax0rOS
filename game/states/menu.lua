local Menu = {}

local Vector = require("libraries.vector")

local Button = require("data.classes.menu.button")
local Background = require("data.classes.menu.background")

function Menu:load()
    self.logo = love.graphics.newImage("graphics/menu/logo.png")

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

    self.strings =
    {
        prompt =
        {
            "root@term ~>",
            Vector(8, 8)
        },
        date =
        {
            os.date("%Y-%m-%d"),
            Vector(vars.WINDOW_W - fonts.main:getWidth(os.date("%Y-%m-%d")) - 8, 8)
        }
    }

    self.buttons = {}
    local text =
    {
        {"NEW HACK", function()

        end},
        {"VIEW CREDITS", function()

        end},
        {"POWER OFF", function()
            audio.stop().play("powerOff")
            self.shutDown = true
        end}
    }

    for i = 1, 3 do
        table.insert(self.buttons, Button(text[i][1], text[i][2], 8, 576 + (i - 1) * 48))
    end

    self.fade = 1
    self.shutDown = false
    self.currentButton = 1

    self.buttons[self.currentButton]:select(true)
    self.background = Background(love.math.random(1, 3))
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

    if self.shutDown then
        self.fade = math.max(self.fade - dt / 1.5, 0)

        if self.fade == 0 then
            love.event.quit()
        end
    end

    self.background:update(dt)
end

function Menu:draw()
    if self.shutDown then
        love.graphics.setColor(1, 1, 1, self.fade)
    end

    love.graphics.setColor(0, 1, 0, (math.abs(math.sin(love.timer.getTime())) + 0.45) * self.fade)
    self.background:draw()

    love.graphics.setColor(1, 1, 1, self.fade)

    love.graphics.setFont(fonts.main)
    love.graphics.print(self.strings.prompt[1], self.strings.prompt[2].x, self.strings.prompt[2].y)

    love.graphics.setColor(1, 1, 1, math.cos(love.timer.getTime() * 9) * self.fade)
    love.graphics.print("_", self.strings.prompt[2].x + fonts.main:getWidth(self.strings.prompt[1] .. "_"), self.strings.prompt[2].y)

    love.graphics.setColor(1, 1, 1, self.fade)
    love.graphics.print(self.strings.date[1], self.strings.date[2].x, self.strings.date[2].y)

    love.graphics.draw(self.logo, self.logoQuads[self.logoQuadi], self.logoPosition.x, self.logoPosition.y)

    for _, v in ipairs(self.buttons) do
        v:draw()
    end
end

function Menu:gamepadpressed(joy, button)
    self.buttons[self.currentButton]:select(false)

    if button == "dpdown" then
        self.currentButton = math.min(self.currentButton + 1, #self.buttons)
    elseif button == "dpup" then
        self.currentButton = math.max(self.currentButton - 1, 1)
    end

    self.buttons[self.currentButton]:select(true)

    if button == "a" then
        self.buttons[self.currentButton]:func()
    end
end

function Menu:unload()
    self.logo = nil

    self.audio:stop()
    self.audio = nil
end

return Menu
