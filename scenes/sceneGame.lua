require("vector")
require("cat")

SceneGame = {}
SceneGame.__index = SceneGame

function SceneGame:create() 
    local sceneGame = {}
    setmetatable(sceneGame, SceneGame)

    sounds['music_start']:stop()
    sounds['music_game']:setLooping(true)
	sounds['music_game']:play()

    --игровой счет:
   -- self.score = 0
    self.score = Score:create()
    --self.score = Score:load()

    --таблица с трубами:
    sceneGame.pipePairs = {}

    --промежуток м/у трубами:
    sceneGame.lastY = -PIPE_HEIGHT + math.random(80) + 20

    --таймер появления труб:
    sceneGame.spawnTimer = 0

    sceneGame.seconds = 2

    --игрок
    sceneGame.cat = Cat:create()
    sceneGame.cat:load()
    sceneGame.timer = 0

    return sceneGame

end

function SceneGame:enter() 
end

function SceneGame:exit() 
end

function SceneGame:update(dt) 
    self.spawnTimer = self.spawnTimer + dt
    

    --если прошло 2 сек создается новая пара труб:
    if self.spawnTimer > self.seconds then

        local y = math.max(-PIPE_HEIGHT + 10, 
              math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        table.insert(self.pipePairs, PipePair:create(y))
        --print('NEW pipePair')
        self.spawnTimer = 0
    end

    
    self.cat:update(dt)
    
    for k, pair in pairs(self.pipePairs) do
        --print('++++++++++')
        --print(k)

        --если очки не начислены и игрок прошел трубу:
        if not pair.isScored and 
            (pair.location.x + PIPE_WIDTH < self.cat.location.x) then
                --self.score = self.score + 1
                self.score:update()
                pair.isScored = true
                sounds['point']:play()
        end

        pair:update(dt)     -- обновляем позицию трубы

        --движение труб по оси Y с увелич. счета:
        if self.score.value >= 20 and (pair.location.x + PIPE_WIDTH > self.cat.location.x) and k == 5 then
            pair:up(dt)
        end

        if self.score.value >= 20 and (pair.location.x + PIPE_WIDTH > self.cat.location.x) and k == 4 then
            pair:down(dt)
            --pair:test(dt)
        end

        if self.score.value >= 10 and self.score.value < 20 and (pair.location.x + PIPE_WIDTH > self.cat.location.x) and k == 4 then

            if self.score.value % 2 == 0 then
                pair:up(dt)
            else    
                pair:down(dt)
            end
            
            --pair:test(dt)
        end

        --генерация труб со случайным временем:
        if self.score.value % 3 == 0 and (pair.location.x + PIPE_WIDTH > self.cat.location.x) then
            self.seconds = math.random() + math.random(2, 5)
        end
    end


     -- проверка коллизии трубы с игроком:
    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.cat:collision(pipe) then
--            
                if isScrolling then
                    sounds['collision']:play()
                    sounds['die']:play()
                end    

                self.timer = self.timer + dt
                isScrolling = false -- остановить прокрутку 

                if self.timer > self.seconds and (not isScrolling) then
                    sceneManager:change('game_over', { score = self.score})
                end
            end
        end

        -- если труба зашла за левый край сцены:
        if pair.location.x < -PIPE_WIDTH then
            pair.remove = true
        end
    end


    --удаление труб с флагом == true:
    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    -- когда игрок коснулся земли, сменить сцену и сбросить счет:
    
    --print(self.cat.location.y)
    if self.cat.location.y + self.cat.height >= VIRTUAL_HEIGHT - 79 then
        --print('++++++++++')
--      sceneManager:change('start')

        if isScrolling then
            sounds['collision']:play()
            sounds['die']:play()
        end    

        self.timer = self.timer + dt
        isScrolling = false -- остановить прокрутку

        if self.timer > self.seconds and (not isScrolling) then
            sceneManager:change('game_over', { score = self.score})
        end
        
    end
    
end


function SceneGame:load()
    sounds['music_game']:setLooping(true)
    sounds['music_game']:play()
end


function SceneGame:draw(dt)
    if self.score.value > 10 then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(background_2, -backgroundScroll, 0)
    
        --background = background_2
    end


	-- отрисовка всех труб:
    for k, pair in pairs(self.pipePairs) do
        pair:draw()
    end

    --вывод игрового счета (вверху слева):
--    love.graphics.setFont(fontName)
--    love.graphics.print("Score: " .. tostring(self.score.value), 10, 10)

    self.score:draw()

    if isScrolling then
        self.cat:draw()
    else
        self.cat:drawHit()
    end
    
    
end


