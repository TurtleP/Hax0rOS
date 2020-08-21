local animation = {}

animation.scripts = {}

if love.filesystem.getInfo("data/animations") then
    local items = love.filesystem.getDirectoryItems("data/animations")

    for i = 1, #items do
        local name = items[i]:gsub(".lua", "")
        animation.scripts[name] = require("data.animations." .. name)
    end
end

function animation.update(dt)
    if not animation.current then
        return
    end

    if animation.index < #animation.current then
        if animation.sleep > 0 then
            animation.sleep = math.max(animation.sleep - dt, 0)
            return
        end

        animation.index = animation.index + 1

        local data = animation.current[animation.index]
        local command, args = data[1], data[2]

        if command == "wait" or command == "sleep" then
            animation.sleep = data[2]
        elseif command == "flash" then
            tiled.transition(true, args[1], args[2])
        elseif command == "create" then
            -- name, x/y/width/height, custom properties
            tiled.addEntity(tiled.loadEntity(args[1], args[2], args[3]))
        elseif command == "unflash" then
            tiled.transition(false, nil, args)
        elseif command == "setplayer" then
            state.set("player", physics:getEntity("player"))
        end
    end
end

function animation.start(name)
    if not animation.scripts[name] then
        return
    end

    animation.index = 0
    animation.sleep = 0

    animation.current = animation.scripts[name]
end

return animation
