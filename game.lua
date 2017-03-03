function gameInit()
	objects =
	{
		["player"] = {player:new(196, 116)},
		["bullet"] = {},
		["tile"] = {}
	}

	dialogs = {}
	cameraObjects = {}

	table.insert(dialogs, dialog:new(nil, "Uh. Well, looks like xorg hasn't started itself. Let's try using terminal mode. What can go wrong?"))
	
	state = "game"

	map = 
	{
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
	}

	for y, i in ipairs(map) do
		for x, j in ipairs(i) do
			if map[y][x] == 1 then
				table.insert(objects["tile"], tile:new((x - 1) * 16, (y - 1) * 16))
			end
		end
	end

	for k, v in pairs(objects) do
		for j, w in ipairs(v) do
			if #v > 0 then
				table.insert(cameraObjects, {k, w, j})
			end
		end
	end
end

function gameUpdate(dt)
	for i = 1, #dialogs do
		dialogs[i]:update(dt)

		if dialogs[i].remove then
			table.remove(dialogs, i)
		end
	end
	
	physicsupdate(dt)
end

function gameDraw()
	for k, v in ipairs(cameraObjects) do
		if v[2].draw then
			v[2]:draw()
		end
	end

	--love.graphics.print("Don't go out of bounds! (Will fix soon™)", 0, 240 - 11)

	for i = 1, #dialogs do
		dialogs[i]:draw()
	end
end

function gameKeyPressed(key)
	if not objects["player"][1] then
		return
	end
	
	if key == "up" then
		objects["player"][1]:moveUp(true)
	elseif key == "down" then
		objects["player"][1]:moveDown(true)
	elseif key == "right" then
		objects["player"][1]:moveRight(true)
	elseif key == "left" then
		objects["player"][1]:moveLeft(true)
	elseif key == "space" then
		objects["player"][1]:shoot()
	end

	if key == "`" then
		objects["player"][1]:die()
	end
end

function gameKeyReleased(key)
	if not objects["player"][1] then
		return
	end

	if key == "up" then
		objects["player"][1]:moveUp(false)
	elseif key == "down" then
		objects["player"][1]:moveDown(false)
	elseif key == "right" then
		objects["player"][1]:moveRight(false)
	elseif key == "left" then
		objects["player"][1]:moveLeft(false)
	end
end