tile = class("tile")

function tile:init(x, y)
	self.x = x
	self.y = y

	self.width = 16
	self.height = 16

	self.category = 1
	
	self.active = true
	self.static = true
end

function tile:draw()
	love.graphics.print("[-]", self.x + (self.width / 2) - otherFont:getWidth("[-]") / 2, self.y + (self.height / 2) - otherFont:getHeight("[-]") /  2)
end