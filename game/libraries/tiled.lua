local Tiled = {}

-- Game Objects --

------------------

function Tiled:init()
    -- map listing
    self.maps = {}

    -- current map data
    self.data = {}

    if love.filesystem.getInfo("data/maps") then
        local items = love.filesystem.getDirectoryItems("data/maps")

        for i = 1, #items do
            if items[i]:find(".lua") then
                local name = items[i]:gsub(".lua", "")
                self.maps[name] = require("data.maps." .. name)
            end
        end
    end
end

function Tiled:clear()
    self.data = {}
end

function Tiled:loadMap(name)
    self:clear()

    local data = self.maps[name]

    return self.data
end

--[[
---- Spawns an Entity @entity
---- @entity: Entity class (usually already created and passed directly)
---- Used for dynamic map Entity loading (conditional stuff, etc)
--]]
function Tiled:addEntity(entity)
    physics:addEntity(entity)
    table.insert(self.data, entity)
end

function Tiled:removeEntity(entity, index)
    physics:removeEntity(entity)
    table.remove(self.data, index)
end

function Tiled:update(dt)
    physics:update(dt)

    for index, value in ipairs(self.data) do
        if value:remove() then
            self:removeEntity(value, index)
        end
    end
end

function Tiled:draw()
    for _, value in pairs(self.data) do
        value:draw()
    end
end

Tiled:init()

return Tiled
