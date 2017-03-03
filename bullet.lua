bullet = class("bullet")

function bullet:init(x, y, angle)
	self.x = x
	self.y = y

	self.r = 1

	self.width = self.r
	self.height = self.r

	self.speedx = math.cos(angle) * 160
	self.speedy = math.sin(angle) * 160

	self.mask = 
	{
		false, false, false
	}
	
	self.active = true
	self.gravity = 0

	shootSound:play()
end

function bullet:draw()
	if not inCamera(self, 0, 0, 400, 240) then
		self.remove = true
	end

	love.graphics.setColor(255, 255, 0)
	love.graphics.circle("fill", self.x + self.r, self.y + self.r, self.r)
	love.graphics.setColor(255, 255, 255)
end