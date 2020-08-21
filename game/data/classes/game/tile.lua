local Entity = require("data.classes.entity")
local Tile = Entity:extend()

Tile.texture = love.graphics.newImage("graphics/game/tiles.png")
Tile.quads = {}

Tile.CONST_WIDTH = 32
Tile.CONST_HEIGHT = 32

function Tile:new(x, y, width, height, flags)
    Tile.super.new(self, x, y, width, height)

    self.tileWidth = width / Tile.CONST_WIDTH
    self.tileHeight = height / Tile.CONST_HEIGHT

    self.flags.noDraw = true
end

function Tile:static()
    return true
end

function Tile:__tostring()
    return "tile"
end

return Tile
