local nest  = require("libraries.nest")
state = require("libraries.state")

fonts = require("data.fonts")
audio = require("data.audio")

debug = require("libraries.debug")

function love.load()
    -- nest.init("hac")

    vars = require("data.vars")

    state.switch("menu")

    love.graphics.setBackgroundColor(0.05, 0.05, 0.05)
    love.audio.setVolume(0.5)
end

function love.update(dt)
    state.update(dt)
end

function love.draw()
    state.draw()
end

function love.gamepadaxis(joy, axis, value)
    state.gamepadaxis(joy, axis, value)
end

function love.gamepadpressed(joy, button)
    if button == "back" then
        debug:toggle()
    end

    state.gamepadpressed(joy, button)
end

function love.gamepadreleased(joy, button)
    state.gamepadreleased(joy, button)
end
