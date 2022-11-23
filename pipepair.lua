PipePair = {}
PipePair.__index = PipePair

--размер промежутка м/у трубами:
local GAP_HEIGHT = 155

function PipePair:create(y) 
    local pipePair = {}
    setmetatable(pipePair, PipePair)

    --создание пар труб за экраном (справа):
    pipePair.location = Vector:create(VIRTUAL_WIDTH + 32, y);

    pipePair.startPositionY = nil

    --табл. с верхней и нижней трубой:
    pipePair.pipes = {
        ['upper'] = Pipe:create('top', pipePair.location.y),
        ['lower'] = Pipe:create('bottom', pipePair.location.y + PIPE_HEIGHT + GAP_HEIGHT)
    }


    --флаг готовности к удалению со сцены:
    pipePair.remove = false

    --флаг для отслеж-ия начисления очков, когда игрок прошел пару труб:
    self.isScored = false

    return pipePair
end

function PipePair:update(dt)
    if isScrolling then
        if self.location.x > -PIPE_WIDTH then   --перемещение справа налево
            self.location.x = self.location.x - PIPE_SCROLL * dt
            self.pipes['lower'].location.x = self.location.x
            self.pipes['upper'].location.x = self.location.x
        else
            --когда пара труб за левым краем экрана:
            self.remove = true
        end
    end    
end

function PipePair:draw()
    for k, pipe in pairs(self.pipes) do
        pipe:draw()
    end
end


function PipePair:up(dt)
    if self.startPositionY == nil then
        self.startPositionY = self.location.y
    end

    local posDelta = love.math.random(0, 50)
    if self.location.y >= self.startPositionY - posDelta then
        self.location.y = self.location.y - 10 * dt
        self.pipes['lower'].location.y = self.location.y + PIPE_HEIGHT + GAP_HEIGHT
        self.pipes['upper'].location.y = self.location.y    
  end
end

function PipePair:down(dt)
    if self.startPositionY == nil then
        self.startPositionY = self.location.y
    end

    local posDelta = love.math.random(0, 50)
    if self.location.y <= self.startPositionY + posDelta then
        self.location.y = self.location.y + 10 * dt
        self.pipes['lower'].location.y = self.location.y + PIPE_HEIGHT + GAP_HEIGHT
        self.pipes['upper'].location.y = self.location.y 
    end
end