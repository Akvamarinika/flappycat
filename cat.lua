
Cat = {}
Cat.__index = Cat

local GRAVITY_Y = 20
local ANTIGRAVITY_Y = -5

local imagesFlyTable = {
    love.graphics.newImage('assets/sprites/fly/fluppycat_1.png'),
    love.graphics.newImage('assets/sprites/fly/fluppycat_2.png'),
    love.graphics.newImage('assets/sprites/fly/fluppycat_3.png'),
    love.graphics.newImage('assets/sprites/fly/fluppycat_4.png'),
    love.graphics.newImage('assets/sprites/fly/fluppycat_5.png'),
    love.graphics.newImage('assets/sprites/fly/fluppycat_6.png'),
    love.graphics.newImage('assets/sprites/fly/fluppycat_7.png'),
    love.graphics.newImage('assets/sprites/fly/fluppycat_8.png')
}

local imagesHitTable = {
    love.graphics.newImage('assets/sprites/hits/fluppycatHits_1.png'),
    love.graphics.newImage('assets/sprites/hits/fluppycatHits_2.png')
}


--local imagesDieTable = {
 --   love.graphics.newImage('assets/sprites/die/fluppycat_die_1.png'),
--    love.graphics.newImage('assets/sprites/die/fluppycat_die_2.png'),
 --   love.graphics.newImage('assets/sprites/die/fluppycat_die_3.png'),
--    love.graphics.newImage('assets/sprites/die/fluppycat_die_4.png'),
--    love.graphics.newImage('assets/sprites/die/fluppycat_die_5.png'),
--    love.graphics.newImage('assets/sprites/die/fluppycat_die_6.png'),
--    love.graphics.newImage('assets/sprites/die/fluppycat_die_7.png'),
--    love.graphics.newImage('assets/sprites/die/fluppycat_die_8.png')
--}           


function Cat:create() 
    local cat = {}
    setmetatable(cat, Cat)

    cat.animFly = Animation:create(imagesFlyTable)
    cat.animHit = Animation:create(imagesHitTable)
    --cat.animDie = Animation:create(imagesDieTable)

    cat.image = love.graphics.newImage('assets/sprites/fly/fluppycat_1.png')
    --размеры картинки:
    cat.width = cat.image:getWidth() 
    cat.height = cat.image:getHeight() 
    
    --self.gravityY = 20
    --self.antigravityY = -5
    cat.velocity = Vector:create(0, 0) 

    --расположение в середине экрана
    cat.location = Vector:create(VIRTUAL_WIDTH / 2 - (cat.width / 2), 
                                VIRTUAL_HEIGHT / 2 - (cat.height / 2))

    cat.imgRotate = 0.0

    return cat
end

function Cat:load()
  
end

function Cat:update(dt)
    -- участвует только скорость по оси Y + гравитация по Y * кадры в сек:
    self.velocity.y = self.velocity.y + GRAVITY_Y * dt

    --для поворота картинки (вниз):
    if self.velocity.y > 5 then
        self.imgRotate = self.imgRotate + 0.1

        if self.imgRotate > 2.0 then
            self.imgRotate = 2.0
        end
    end


    --движение вверх по оси Y (отрицательная гравитация):
    if isScrolling and love.keyboard.wasPressed('space') then
        self.velocity.y = ANTIGRAVITY_Y   
        sounds['jump']:play()
    end

   -- print('self.velocity.y')
    --print(self.velocity.y)

    --для поворота картинки (вверх):
    if self.velocity.y < 0 then
        self.imgRotate = self.imgRotate - 0.2

        if self.imgRotate < -0.8 then
            self.imgRotate = -0.8
        end
    end
            
    self.animFly:update(dt)

    --print('self.location.y')
    --print(self.location.y)

    --выход за границы по Y:
    if self.location.y >= 0 and self.location.y + self.height/2 <= VIRTUAL_HEIGHT - 79 then

        --изменение позиции по Y:
        self.location.y = self.location.y + self.velocity.y 

        if self.location.y < 0 then
            self.location.y = 0
        end

      --  if self.location.y > VIRTUAL_HEIGHT - 79 then
      --      self.location.y = VIRTUAL_HEIGHT - 79
       -- end
    end
    
end

function Cat:draw()
   -- love.graphics.draw(self.image, self.location.x, self.location.y)
    self.animFly:draw(self.location.x, self.location.y, self.imgRotate)

end

function Cat:drawHit()
     self.animHit:draw(self.location.x, self.location.y, self.imgRotate)
 end

function Cat:collision(pipe)
    --делаем персонажа на неск. px меньше, чем плитка:
    if (self.location.x + 2) + (self.width/2 - 5) >= pipe.location.x and self.location.x + 2 <= pipe.location.x + PIPE_WIDTH then
        if (self.location.y + 2) + (self.height/2 - 5) >= pipe.location.y and self.location.y + 2 <= pipe.location.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end