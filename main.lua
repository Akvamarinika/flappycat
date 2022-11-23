-- библиотека обработки виртуальных разрешений
push = require 'push'

require('Cat')
require('Pipe')
require('PipePair')
require('Vector')
require("Animation")
require('scenes/SceneManager')
require('scenes/SceneStart')
require('scenes/SceneGame')
require('scenes/SceneGameOver')
require('scenes/Score')
require('scenes/Number')
require('scenes/CountDown')

-- размеры физического окна:
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- виртуальное разрешение игры
VIRTUAL_WIDTH = 1024
VIRTUAL_HEIGHT = 576

--флаг для остановки прокрутки объектов:
isScrolling = true

background = love.graphics.newImage('assets/background.png')
background_2 = love.graphics.newImage('assets/background_2.png')
backgroundScroll = 0 --прокрутка фона по оси Х, начальное значение

local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0  --прокрутка земли по оси Х, начальное значение
 
-- скорость, с которой мы должны прокручивать наши изображения, в масштабе dt
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

-- точка зацикливания, в которой мы должны зациклить наш фон обратно на X 0
local BACKGROUND_LOOPING_POINT = 1024
local GROUND_LOOPING_POINT = 987

function love.load()
	--фильтр убиратает размытие при масштабировании изображений:
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --настройки разрешения экрана:
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    --шрифты:
    --gameFont = love.graphics.newFont('.ttf', 14)
    --love.graphics.setFont(gameFont)

    --таблица со звуковыми файлами:
    sounds = {
        ['point'] = love.audio.newSource('assets/audio/point.wav', 'static'),
        ['jump'] = love.audio.newSource('assets/audio/jump.wav', 'static'),
        ['collision'] = love.audio.newSource('assets/audio/collision.wav', 'static'),
        ['die'] = love.audio.newSource('assets/audio/die.wav', 'static'),
        ['music_start'] = love.audio.newSource('assets/audio/menu8bit.mp3', 'static'),
        ['music_game'] = love.audio.newSource('assets/audio/vesna8bit.mp3', 'static')
        }

    sceneManager = SceneManager:create( {
        ['start'] = function() return SceneStart:create() end,
        ['game'] = function() return SceneGame:create() end,
        ['game_over'] = function() return SceneGameOver:create() end,
        ['countdown'] = function() return CountDown:create() end
    })

    sceneManager:change('start')
    
    --создание таблицы для хранения нажатых клавиш(в одном кадре):
    love.keyboard.keysPressed = {}
end

--ресайз окна, динамическое изменение Scale:
function love.resize(weightWin, heightW)
    push:resize(weightWin, heightW)
end


function love.update(dt)
   if isScrolling then
        -- Фоновая прокрутка: прокручивать фон с заданной скоростью * dt, возвращаясь к 0 после точки цикла
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT -- BACKGROUND_LOOPING_POINT сбрасывает цикл на начало

        -- прокручивать землю с заданной скоростью * dt, возвращаясь к 0 после прохождения ширины экрана
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT

    end

    sceneManager:update(dt)

    --очищаем таблицу нажатых клавиш:
    love.keyboard.keysPressed = {}
end


function love.draw(dt)
    push:start()

    -- рисуем фон в отрицательной точке зацикливания:
    --love.graphics.draw(background_2, -backgroundScroll, 0) 
    love.graphics.draw(background, -backgroundScroll, 0)

    r, g, b, a = love.graphics.getColor()


    sceneManager:draw(dt)

    -- рисуем землю поверх фона ближе к низу экрана, в отрицательной точке зацикливания:
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 80)

    

    push:finish()
end

function love.keypressed(key)
    --нажата клавиша в текущем кадре:
    love.keyboard.keysPressed[key] = true

    --выход из игры:
	if key=="escape" then
		love.event.quit() 
	end
end

--проверка таблицы нажатых клавиш:
function love.keyboard.wasPressed(key)  
    return love.keyboard.keysPressed[key] --true/false
end