function introInit()
	introTimer = 0
	introFade = 0

	state = "intro"

	introDelay = 0.2
end

function introUpdate(dt)
	introTimer = introTimer + dt

	if introTimer > 2.5 then
		introFade = math.max(introFade - 0.8 * dt, 0)
	else
		introFade = math.min(introFade + 0.7 * dt, 1)
	end

	if introDelay > 0 then
		introDelay = introDelay - dt
	else
		if introDelay ~= -1 then
			introSound:play()
			introDelay = -1
		end
	end

	if introTimer > 3.5 and introFade == 0 then
		titleInit()
	end
end

function introDraw()
	love.graphics.setColor(255, 255, 255, 255 * introFade)
	
	local i = 1
	love.graphics.draw(introImage[i], love.graphics.getWidth() / 2 - introImage[i]:getWidth() / 2, love.graphics.getHeight() / 2 - introImage[i]:getHeight() / 2)
	
	i = 2
	love.graphics.draw(introImage[i], love.graphics.getWidth() - introImage[i]:getWidth(), love.graphics.getHeight() - introImage[i]:getHeight())

	love.graphics.setColor(255, 255, 255, 255)
end