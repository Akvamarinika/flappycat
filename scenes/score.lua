Score = {}
Score.__index = Score

function Score:create() 
	local score = {}
    setmetatable(score, Score)

	score.value = 0

	score.imagesTable = {
		["0"] = love.graphics.newImage('assets/sprites/0.png'),
		["1"] = love.graphics.newImage('assets/sprites/1.png'),
		["2"] = love.graphics.newImage('assets/sprites/2.png'),
		["3"] = love.graphics.newImage('assets/sprites/3.png'),
		["4"] = love.graphics.newImage('assets/sprites/4.png'),
		["5"] = love.graphics.newImage('assets/sprites/5.png'),
		["6"] = love.graphics.newImage('assets/sprites/6.png'),
		["7"] = love.graphics.newImage('assets/sprites/7.png'),
		["8"] = love.graphics.newImage('assets/sprites/8.png'),
		["9"] = love.graphics.newImage('assets/sprites/9.png')
	}

	score.location = Vector:create(VIRTUAL_WIDTH / 2 - (score.imagesTable["8"]:getWidth() / 2), 15 )
	return score
end

function Score:enter(sceneGame) 
    self.score = sceneGame.score
end

function Score:exit() 
end

function Score:update() 
	self.value = self.value + 1
end

function Score:load()
	self.imagesTable["0"] = love.graphics.newImage('assets/sprites/0.png')
	self.imagesTable["1"] = love.graphics.newImage('assets/sprites/1.png')
	self.imagesTable["2"] = love.graphics.newImage('assets/sprites/2.png')
	self.imagesTable["3"] = love.graphics.newImage('assets/sprites/3.png')
	self.imagesTable["4"] = love.graphics.newImage('assets/sprites/4.png')
	self.imagesTable["5"] = love.graphics.newImage('assets/sprites/5.png')
	self.imagesTable["6"] = love.graphics.newImage('assets/sprites/6.png')
	self.imagesTable["7"] = love.graphics.newImage('assets/sprites/7.png')
	self.imagesTable["8"] = love.graphics.newImage('assets/sprites/8.png')
	self.imagesTable["9"] = love.graphics.newImage('assets/sprites/9.png')
end

function Score:draw()
	local strScore = tostring(self.value)
	local strLen = #strScore

    for i = 1, strLen, 1 do
        local indexNum = strScore:sub(i, i)
		local num = Number:create(self.location.x, self.location.y, i, self.imagesTable[indexNum], self.value)
        num:draw()
    end
end





