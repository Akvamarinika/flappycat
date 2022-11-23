SceneStart = {}
SceneStart.__index = SceneStart

function SceneStart:create() 
	local sceneStart = {}
    setmetatable(sceneStart, SceneStart)

	self.imgTitle = love.graphics.newImage('assets/sprites/title.png')
	self.imgEnter = love.graphics.newImage('assets/sprites/press.png')

	
	sounds['music_game']:stop()
	sounds['music_start']:setLooping(true)
	sounds['music_start']:play()
	return sceneStart
end

function SceneStart:enter() 
end

function SceneStart:exit() 
end

function SceneStart:update(dt) 
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		sceneManager:change('countdown')
        ---sceneManager:change('game')
    end
end

function SceneStart:load()
end

function SceneStart:draw(dt)
	--love.graphics.setFont(gameFont)
	--love.graphics.printf("Scene1", 0, 64, VIRTUAL_WIDTH, 'center')

	--love.graphics.setFont(gameFont2)
	--love.graphics.printf("Press enter", 0, 100, VIRTUAL_WIDTH, 'center')

	love.graphics.draw(self.imgTitle, VIRTUAL_WIDTH / 2  - (self.imgTitle:getWidth()/2 * 0.7), VIRTUAL_HEIGHT / 2 - (self.imgTitle:getHeight()/2 * 0.7 + 100 ), 0, 0.7, 0.7) 

	if math.floor(love.timer.getTime()) % 2 == 0 then
		love.graphics.draw(self.imgEnter, VIRTUAL_WIDTH / 2  - (self.imgEnter:getWidth()/2 * 0.5), VIRTUAL_HEIGHT / 2 - (self.imgEnter:getHeight()/2 * 0.5), 0, 0.5, 0.5) 
	end

	
end

