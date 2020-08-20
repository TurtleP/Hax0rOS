local fonts = {}

fonts.main = love.graphics.newFont("graphics/GohuMedium11.ttf", 22)
fonts.bigFont = love.graphics.newFont("graphics/GohuMedium11.ttf", 33)

-- ATTRIBUTES --

fonts.SMALL = {}
fonts.SMALL.WIDTH  = fonts.main:getWidth(" ")
fonts.SMALL.HEIGHT = fonts.main:getHeight()

return fonts
