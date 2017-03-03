function titleInit()
	titleSong = love.audio.newSource("audio/title.ogg")
	titleSong:setLooping(true)
	titleSong:play()

	buttons = {}
	table.insert(buttons, newButton("NEW HACK", 0, 178))
	table.insert(buttons, newButton("VIEW CREDITS", 0, 198))
	table.insert(buttons, newButton("POWER OFF", 0, 218))
	
	currentButton = 1
	buttons[currentButton]:select()
	shutDown = false
	shutDownFade = 1
	
	currentAnimation = 1
	eyeDelay = math.random(2)
	eyeTimer = 0

	love.graphics.setBackgroundColor(21, 21, 21)

	state = "title"
end

function newButton(text, x, y)
	local button = {}

	button.text = text

	button.x = x + 8
	button.y = y
	
	button.width = buttonFont:getWidth(text)

	button.timer = 0

	button.selected = false

	function button:draw()
		add = ""
		if self.selected then
			add = "./"
		end
		love.graphics.print(add .. self.text, self.x, self.y)
	end

	function button:reset()
		self.selected = false
		self.timer = 0
	end

	function button:select()
		self.timer = 0
		self.selected = true
	end

	return button
end

function titleUpdate(dt)
	dt = math.min(1/60, dt)
	
	if shutDown then
		shutDownFade = math.max(shutDownFade - dt / 1.25, 0)
		
		if shutDownFade == 0 then
			if not poweroffSound:isPlaying() then
				love.event.quit()
			end
		end
		return
	end

	eyeDelay = eyeDelay - dt
	if eyeDelay < 0 then
		eyeTimer = eyeTimer + 8 * dt
		if eyeTimer < 1 then
			currentAnimation = math.random(1, 2)
		else
			eyeDelay = math.random(2)
			currentAnimation = 1
			eyeTimer = 0
		end
	end
end

function titleDraw()
	if shutDown then
		love.graphics.setColor(255, 255, 255, 255 * shutDownFade)
	end
	
	love.graphics.setFont(buttonFont)

	for k, v in ipairs(buttons) do
		v:draw()
	end

	love.graphics.setFont(otherFont)

	love.graphics.draw(logoImage, logoQuads[currentAnimation], 200 - logoImage:getWidth() / 2, 50)

	love.graphics.setColor(255, 255, 255, 255 * shutDownFade)

	love.graphics.print("root@term ~$", 8, 8)
	love.graphics.print(os.date("%Y-%m-%d"), 400 - otherFont:getWidth(os.date("%Y-%m-%d")) - 8, 8)

	love.graphics.setColor(255, 255, 255, 255 * math.cos(love.timer.getTime() * 9) * shutDownFade)
	love.graphics.print("_", 8 + otherFont:getWidth("root@term ~$") + 2, 8)
	
	love.graphics.setColor(255, 255, 255, 255 * shutDownFade)
end

function titleKeyPressed(key)
	if key == "w" then
		if currentButton > 1 then
			selectionSound:play()
		end
		buttons[currentButton]:reset()
		currentButton = math.max(currentButton - 1, 1)
		buttons[currentButton]:select()
	elseif key == "s" then
		if currentButton < #buttons then
			selectionSound:play()
		end
		buttons[currentButton]:reset()
		currentButton = math.min(currentButton + 1, #buttons)
		buttons[currentButton]:select()
	elseif key == "return" then
		if currentButton == 1 then
			gameInit()
		elseif currentButton == 3 then
			shutDown = true
			titleSong:stop()
			poweroffSound:play()
		end
	end
end