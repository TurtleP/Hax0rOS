vars = require("data.vars")

local nest  = require("libraries.nest")
local state = require("libraries.state")

fonts = require("data.fonts")

local debug = require("libraries.debug")


function love.load()
    nest.init("hac")

    state.switch("menu")
end

function love.update(dt)
    state.update(dt)
end

function love.draw()
    state.draw()
end

function love.gamepadaxis(joy, axis, value)

end

function love.gamepadpressed(joy, button)
    if button == "a" then
        debug:toggle("fps")
    end
end
