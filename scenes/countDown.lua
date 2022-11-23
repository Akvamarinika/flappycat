CountDown = {}
CountDown.__index = CountDown

--игровая 1 секунда:
local COUNTDOWN_TIME = 0.65

function CountDown:create() 
	local countDown = {}
    setmetatable(countDown, CountDown)
    self.countSeconds = 3
    self.timer = 0

    self.imagesTable = {
        ["3"] = love.graphics.newImage('assets/sprites/3.png'),
        ["2"] = love.graphics.newImage('assets/sprites/2.png'),
        ["1"] = love.graphics.newImage('assets/sprites/1.png'),
		["0"] = love.graphics.newImage('assets/sprites/go.png')
	}

	return countDown
end

function CountDown:enter() 
end

function CountDown:exit() 
end

function CountDown:update(dt) 
    self.timer = self.timer + dt

    --если прошло больше 1 сек:
    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        --print("CountDown timer: "..tostring(self.timer))
        self.countSeconds = self.countSeconds - 1
        --print("countSeconds: "..tostring( self.countSeconds))

        if self.countSeconds == -1 then
            sceneManager:change('game')
        end
    end
end

--function CountDown:load()
--end

function CountDown:draw()
--    love.graphics.setFont(hugeFont)
   -- love.graphics.printf(tostring(self.countSeconds), 0, 120, VIRTUAL_WIDTH, 'center')
   local img = self.imagesTable[tostring(self.countSeconds)]
   love.graphics.draw(img, VIRTUAL_WIDTH / 2  - (img:getWidth()/2 ),
                     VIRTUAL_HEIGHT / 2 - (img:getHeight()/2), 0, 1, 1) 
end