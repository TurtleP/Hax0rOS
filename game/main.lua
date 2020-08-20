local nest  = require("libraries.nest")
local state = require("libraries.state")

fonts = require("data.fonts")
audio = require("data.audio")

local debug = require("libraries.debug")

function love.load()
    nest.init("hac")

    vars = require("data.vars")

    state.switch("menu")
end

function love.update(dt)
    state.update(dt)
end

function love.draw()
    state.draw()
    debug:draw()
end

function love.gamepadaxis(joy, axis, value)
    state.gamepadaxis(joy, axis, value)
end

function love.gamepadpressed(joy, button)
    if button == "back" then
        debug:toggle("fps")
    end

    state.gamepadpressed(joy, button)
end
