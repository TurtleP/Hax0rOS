io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest")
function love.load()
	math.randomseed(os.time())
	math.random()
	math.random()

	class = require 'middleclass'

	require 'physics'
	require 'player'
	require 'bullet'
	require 'dialog'
	require 'tile'
	
	require 'intro'
	require 'title'
	require 'game'

	--IMAGES
	
	logoImage = love.graphics.newImage("graphics/logo.png")
	logoQuads = {}
	for y = 1, 3 do
		logoQuads[y] = love.graphics.newQuad(0, (y - 1) * 140, 344, 140, logoImage:getWidth(), logoImage:getHeight())
	end
	
	eyesImage = love.graphics.newImage("graphics/eyes.png")
	eyesQuads = {}
	for i = 1, 4 do
		eyesQuads[i] = love.graphics.newQuad((i - 1) * 4, 0, 3, 3, eyesImage:getWidth(), eyesImage:getHeight())
	end

	dialogImage = {}

	introImage = {love.graphics.newImage("graphics/intro.png"), love.graphics.newImage("graphics/site.png")}

	--SOUNDS
	introSound = love.audio.newSource("audio/jingle.ogg")
	selectionSound = love.audio.newSource("audio/select.ogg")
	shootSound = love.audio.newSource("audio/shoot.ogg")
	poweroffSound = love.audio.newSource("audio/poweroff.ogg")
	dialogSound = love.audio.newSource("audio/dialog.ogg")
	deathSound = love.audio.newSource("audio/death.ogg")

	--FONTS
	buttonFont = love.graphics.newFont("graphics/GohuFont-Medium.ttf", 14)
	otherFont = love.graphics.newFont("graphics/GohuFont-Medium.ttf", 11)

	introInit()
end

function love.update(dt)
	dt = math.min(1/60, dt)
	if _G[state .. "Update"] then
		_G[state .. "Update"](dt)
	end
end

function love.draw()
	if _G[state .. "Draw"] then
		_G[state .. "Draw"]()
	end
end

function love.keypressed(key)
	if _G[state .. "KeyPressed"] then
		_G[state .. "KeyPressed"](key)
	end
end

function love.keyreleased(key)
	if _G[state .. "KeyReleased"] then
		_G[state .. "KeyReleased"](key)
	end
end

function string:replace(pos, t)
	return self:sub(1, pos) .. t .. self:sub(pos + 1)
end