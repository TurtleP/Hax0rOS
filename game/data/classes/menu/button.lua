local Object = require("libraries.classic")
local Button = Object:extend()

function Button:new(text, func, x, y)
    self.x = x
    self.y = y

    self.text = text
    self.func = func

    self.selected = false
end

function Button:draw()
    love.graphics.setFont(fonts.bigFont)

    local add = ""
    if self.selected then
        add = "./"
    end

    love.graphics.print(add .. self.text, self.x, self.y)
end

function Button:select(value)
    self.selected = value
end

return Button
