SceneManager = {}
SceneManager.__index = SceneManager

function SceneManager:create(states)
    local sceneManager = {}
    setmetatable(sceneManager, SceneManager)
    
    --таблица состояний для каждой сцены:
    sceneManager.emptyState = {
        update = function() end,
        draw = function() end,
        enter = function() end,
        exit = function() end
    }
    
    sceneManager.statesTable = states or {}
    --print( sceneManager.statesTable['start'])
    sceneManager.current = sceneManager.emptyState
    return sceneManager
end

function SceneManager:change(stateName, param)
   -- print('state: '..stateName)
    assert(self.statesTable[stateName]) -- сработает если Состояния нужного нет в таблице
    self.current:exit()
    self.current = self.statesTable[stateName]()    ---вызов фун-ии из statesTable
    self.current:enter(param)
end

function SceneManager:update(dt)
	self.current:update(dt)
end

function SceneManager:draw(dt)
	self.current:draw(dt)
end

function SceneManager:printStatesTable()
    for k, val in pairs(self.statesTable) do
        print(k)
    end
end