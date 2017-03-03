player = class("player")

function player:init(x, y)
	self.x = x
	self.y = y

	self.width = 8
	self.height = 8

	self.active = true
	self.gravity = 0

	self.r = 4

	self.mask = {true, true, false}

	self.category = 3

	self.rightKey = false
	self.leftKey = false
	self.upKey = false
	self.downKey = false

	self.maxSpeed = 80
	self.moveRate = 32

	self.speedx = 0
	self.speedy = 0

	self.fade = 1
	self.timer = 0
	self.waveTimer = 0

	self.shotTime = 0.2
	self.eyeAdd = {self.r / 2, self.r / 2}
	
	self.blinkDelay = math.random(2, 3)
	self.blinkTimer = 0
	self.blinkQuadi = 1

	self.friction = 0.94 --wew power of 2

	self.deathSpheres = {}
end

function player:update(dt)
	if self.rightKey then
		self.speedx = math.min(self.speedx + self.moveRate, self.maxSpeed)
	elseif self.leftKey then
		self.speedx = math.max(self.speedx - self.moveRate, -self.maxSpeed)
	end

	if self.upKey then
		self.speedy = math.max(self.speedy - self.moveRate, -self.maxSpeed)
	elseif self.downKey then
		self.speedy = math.min(self.speedy + self.moveRate, self.maxSpeed)
	end
	
	local mathf = math.ceil
	if self.speedx > 0 then
		mathf = math.floor
	end
	self.speedx = mathf(self.speedx * self.friction, 0)
	
	mathf = math.ceil
	if self.speedy > 0 then
		mathf = math.floor
	end
	self.speedy = mathf(self.speedy * self.friction, 0)
	

	--self.speedx = self.speedx * self.friction
	--self.speedy = self.speedy * self.friction
	
	self.shotTime = math.max(self.shotTime - dt, 0)

	self.timer = self.timer + dt
	self.fade = math.abs( math.sin( self.fade + math.pi ) / 2 ) + 0.5

	if self.speedx == 0 and self.speedy == 0 then
		self.waveTimer = self.waveTimer + dt
	else
		self.waveTimer = 0
	end
		
	if self.speedx < 0 then
		self.eyeAdd[1] = math.max(self.eyeAdd[1] - 8 * dt, 1)
	else
		self.eyeAdd[1] = math.min(self.eyeAdd[1] + 8 * dt, self.r / 2 + 2)
	end
		
	if self.speedy < 0 then
		self.eyeAdd[2] = math.max(self.eyeAdd[2] - 8 * dt, 0.25)
	elseif self.speedy == 0 then
		if self.eyeAdd[2] < self.r / 2 then
			self.eyeAdd[2] = math.min(self.eyeAdd[2] + 8 * dt, self.r / 2)
		else
			self.eyeAdd[2] = math.max(self.eyeAdd[2] - 8 * dt, self.r / 2)
		end
	elseif self.speedy > 0 then
		self.eyeAdd[2] = math.min(self.eyeAdd[2] + 8 * dt, self.r / 2 + 2)
	end
		
	self.blinkDelay = self.blinkDelay - dt
	if self.blinkDelay < 0 then
		if self.blinkQuadi < 4 then
			self.blinkTimer = self.blinkTimer + 8 * dt
			self.blinkQuadi = math.floor(self.blinkTimer % 4) + 1
		else
			self.blinkQuadi = 1
			self.blinkDelay = math.random(2, 3)
			self.blinkTimer = 0
		end
	end

	if not inCamera(self, 0, 0, 400, 240) then
		self:die()
	end

	for i = 1, #self.deathSpheres do
		self.deathSpheres[i]:update(dt)
	end
end

function player:draw()
	if self.dead then
		for i = 1, #self.deathSpheres do
			self.deathSpheres[i]:draw()
		end
		return
	end

	local add = 0

	if self.speedx == 0 and self.speedy == 0 then
		add = math.sin(self.waveTimer * 2) * 2
	end
		
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("fill", self.x + self.r, self.y + self.r + add, self.r)
	love.graphics.circle("line", self.x + self.r, self.y + self.r + add, self.r)
		
	love.graphics.draw(eyesImage, eyesQuads[self.blinkQuadi], math.floor(self.x + self.eyeAdd[1]), math.floor(self.y + add + self.eyeAdd[2]))
end

function player:moveRight(move)
	self.rightKey = move
end

function player:moveLeft(move)
	self.leftKey = move
end

function player:moveUp(move)
	self.upKey = move
end

function player:moveDown(move)
	self.downKey = move
end

function player:die()
	if not self.dead then
		self.dead =  true

		local ang = {math.pi / 4, math.pi / 2, (math.pi * 3) / 4, math.pi, (math.pi * 5) / 4, (math.pi * 3) / 2, (math.pi * 7) / 4, math.pi * 2}
		for i = 1, #ang do
			table.insert(self.deathSpheres, sphere:new(self.x + self.r, self.y + self.r, ang[i]))
		end
		love.audio.stop()

		deathSound:play()
	end
end

function player:shoot()
	if self.shotTime > 0 then
		return
	end

	if self.speedx == -0 then
		self.speedx = 0
	end
	
	local temp = bullet:new(self.x + self.r, self.y + self.r + math.sin(self.waveTimer * 2) * 2, math.atan2(self.speedy, self.speedx))

	table.insert(objects["bullet"], temp)

	table.insert(cameraObjects, {"bullet", temp, #objects["bullet"]})

	self.shotTime = 0.2
end

--------------

sphere = class("sphere")

function sphere:init(x, y, ang)
	self.x = x
	self.y = y

	self.speedx = math.cos(ang) * 64
	self.speedy = math.sin(ang) * 64

	self.r = 1

	self.fade = 1

	self.timer = 0
	self.lifeTime = 0.8
end

function sphere:update(dt)
	self.x = self.x + self.speedx * dt
	self.y = self.y + self.speedy * dt

	self.lifeTime = self.lifeTime - dt
	if self.lifeTime < 0 then
		self.fade = math.max(self.fade - dt / 0.5, 0)
	end

	self.timer = self.timer + 2 * dt
end

function sphere:draw()
	love.graphics.setColor(255, 255, 255, 255 * self.fade)
	love.graphics.circle("fill", self.x, self.y, math.abs( math.sin( self.timer * math.pi ) / 2 ) + 0.5)
	love.graphics.setColor(255, 255, 255, 255)
end