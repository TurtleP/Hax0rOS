dialog = class("dialog")

function dialog:init(speaker, text)
	self.timer = 0
	self.i = 1

	self.string = ""
	self.renderNext = false

	self.x = 1
	self.y = 213
	self.width = 398
	self.height = 24

	self.pause = false

	self.speaker = speaker

	self.life = 0
	self.offset = 8
	
	self.text = self:align(text)
end

function dialog:update(dt)
	if self.i <= #self.text then
		if #self.string < #self.text and not self.pause then
			if self.timer < 0.03 then
				self.timer = self.timer + dt
			else
				self.string = self.string .. self.text:sub(self.i, self.i)

				self.i = self.i + 1
				dialogSound:play()
				self.timer = 0
			end
		else
			self.renderNext = true

			if love.keyboard.isDown("a") then
				self.pause = false
				self.timer = 0
				self.string = ""
				self.renderNext = false
			end
		end
	else
		self.life = self.life + dt
		if self.life > 1 then
			self.remove = true
		end
	end
end

function dialog:draw()
	--love.graphics.setScreen("top")

	--love.graphics.setScissor(self.x, self.y, self.width, self.height + 5)

	love.graphics.setColor(0, 0, 0, 200)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	
	love.graphics.setColor(255, 255, 255, 255)

	self:print(self.string, self.x + self.offset, self.y + 2)

	if self.renderNext then
		love.graphics.setColor(255, 0, 0, 255)
		--love.graphics.draw(selectionVerImage, selectionVerQuads[1], (self.x + self.width) - 10, (self.y + self.height) - 5 + math.sin(love.timer.getTime() * 4))
	end

	love.graphics.setColor(255, 255, 255, 255)

	--love.graphics.setScissor()
end

function dialog:print(text, x, y)
	local startx = x

	for i = 1, #text do
		if text:sub(i, i) == "\n" then
			startx = x - i * otherFont:getWidth(" ")
			y = y + 11
		elseif text:sub(i, i) == "~" then
			self.pause = true
		else
			love.graphics.print(text:sub(i, i), startx + (i - 1) * otherFont:getWidth(" "), y)
		end
	end
end

function dialog:align(text)
	local limit = self.width - self.offset --limited between where text starts to render and end width of dialog box
	local size = 0 --our sentence size atm

	for word in text:gmatch("%S+") do --match words n spaces
		local s, f = text:find(word)

		local sp = ""
		
		if f then --pay respects
			if text:sub(f + 1, f + 1) == " " then
				sp = " "
			end
		end

		size = size + otherFont:getWidth(word .. sp) --add to the size
		if size >= limit then --rip
			if not self.newLine then --make a newline happen (doesn't render, just tells it to 'newline' it)
				local first, last = text:find(word .. sp)

				text = text:replace(first - 1, "\n") --put a newline before the word that goes offscreen (see above)

				self.newLine = true
			else
				local first, last = text:find(word .. sp)

				text = text:replace(first - 1, "~") --tell dialog to 'stop' updating until jump is pressed

				self.newLine = false --allow newlines again
			end
			size = otherFont:getWidth(word .. sp)
		end
	end
	
	return text
end