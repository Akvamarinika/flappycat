Pipe = {}
Pipe.__index = Pipe

PIPE_HEIGHT = 576 --288
PIPE_WIDTH = 80    -- 52
PIPE_SCROLL = 60

local PIPE_IMAGE = love.graphics.newImage('assets/pipe-red2.png')

function Pipe:create(orientation, y) 
    local pipe = {}
    setmetatable(pipe, Pipe)

    --случайное размещение труб внизу экрана
    pipe.location = Vector:create(VIRTUAL_WIDTH, y)

    pipe.width = PIPE_IMAGE:getWidth()
    pipe.height = PIPE_HEIGHT
    pipe.orientation = orientation

    return pipe
end


function Pipe:update(dt)
    --перемещение трубы по оси X влево:
    --self.location.x = self.location.x + (PIPE_SCROLL * dt) --60px in sec



end    


function Pipe:draw(dt)
    --love.graphics.draw(PIPE_IMAGE, math.floor(self.location.x + 0.5), math.floor(self.location.y))
    love.graphics.draw(PIPE_IMAGE, self.location.x, 
                        (self.orientation == 'top' and self.location.y + PIPE_HEIGHT or self.location.y), 
                        0,  --поворот
                        1,  --масштаб по оси X
                        self.orientation == 'top' and -1 or 1) --масштаб по оси Y
end