Animation = {}
Animation.__index = Animation

function Animation:create(imgTable) 
	local animation = {}
    setmetatable(animation, Animation)

	animation.imagesTable = imgTable
	animation.location = Vector:create(0, 0)
    animation.currentFrame = 1
    animation.delay = 0.15
    animation.timePassed = 0 -- с момента изменения последнего кадра
	return animation
end


function Animation:update(dt) 
    self.timePassed = self.timePassed + dt

	if self.timePassed > self.delay then
        self.timePassed = self.timePassed - self.delay
        self.currentFrame = self.currentFrame % #self.imagesTable + 1
       -- print('animation:')
       -- print(self.currentFrame)
    end
end


function Animation:draw(x, y, imgRotate)
    --love.graphics.draw(self.imagesTable[self.currentFrame], x, y, imgRotate)
    --love.graphics.draw(self.imagesTable[self.currentFrame], x, y, 0, 0.5, 0.5) -- 0 is for rotation

    --точка поворота вокруг центра картинки:
    love.graphics.draw(self.imagesTable[self.currentFrame], x, y, imgRotate, 1, 1, self.imagesTable[self.currentFrame]:getWidth()/2, self.imagesTable[self.currentFrame]:getHeight()/2)
    

 end