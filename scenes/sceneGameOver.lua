SceneGameOver = {}
SceneGameOver.__index = SceneGameOver

function SceneGameOver:create() 
	local sceneGameOver = {}
    setmetatable(sceneGameOver, SceneGameOver)
    self.imgTitle = love.graphics.newImage('assets/sprites/over.png')
    self.imgScore = love.graphics.newImage('assets/sprites/score.png')

    isScrolling = true
	return sceneGameOver
end

function SceneGameOver:enter(sceneGame) 
    self.score = sceneGame.score
end

function SceneGameOver:exit() 
end

function SceneGameOver:update(dt) 
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        sceneManager:change('start')
        --sceneManager:change('countdown')
    end
end

function SceneGameOver:load()
end

function SceneGameOver:draw(dt)
   -- love.graphics.setFont(mediumFont)
   --love.graphics.printf('Your score: ' .. tostring(self.score.value), 0, 100, VIRTUAL_WIDTH, 'center')

   --love.graphics.setFont(gameFont)
   --love.graphics.printf("Game Over!", 0, 64, VIRTUAL_WIDTH, 'center')


   local img = love.graphics.newImage('assets/sprites/8.png')
   love.graphics.draw(self.imgTitle, VIRTUAL_WIDTH / 2  - (self.imgTitle:getWidth()/2 * 0.7), VIRTUAL_HEIGHT / 2 - (self.imgTitle:getHeight()/2 * 0.7 + 100 ), 0, 0.7, 0.7) 

   love.graphics.draw(self.imgScore, VIRTUAL_WIDTH / 2  - (self.imgScore:getWidth()/2 * 0.7 + 50), VIRTUAL_HEIGHT / 2 - (self.imgScore:getHeight()/2 * 0.7), 0, 0.7, 0.7) 
   self.score.location = Vector:create(VIRTUAL_WIDTH / 2 - (img:getWidth() / 2 - 100), VIRTUAL_HEIGHT / 2 - (img:getHeight()/2 - 2))
   self.score:draw()

   --love.graphics.setFont(gameFont2)
   --love.graphics.printf("Press Enter to Start window!", 0, 160, VIRTUAL_WIDTH, 'center')
end

