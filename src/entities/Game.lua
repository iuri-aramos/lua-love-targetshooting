---@class Game
---@field backgroundSound any
---@field LARGURA number
---@field ALTURA number
---@field CENTRO_X number
---@field CENTRO_Y number
---@field TEMPORIZADOR number
---@field SCORE number
local Game = {}
Game.__index = Game

---@return Game
function Game:new()
    local game = setmetatable({}, self)
    game.backgroundSound = nil
    game.LARGURA = 0
    game.ALTURA = 0
    game.CENTRO_X = 0
    game.CENTRO_Y = 0
    game.TEMPORIZADOR = 0
    game.SCORE = 0

    return game
end

function Game:setBackgroundSound(sound)
    self.backgroundSound = love.audio.newSource(sound, "static")
    self.backgroundSound:setVolume(0.2)
    self.backgroundSound:setLooping(true)
end

function Game:saveScore()
    local file = io.open("score.txt", "a")
    if file then
        file:write(self.SCORE .. "\n")
        file:close()
    else
        print("Erro ao salvar o score.")
    end
end

function Game:loadScores()
    local file = io.open("score.txt", "r")
    if file then
        local score = file:read("*a")
        file:close()
        return score
    else
        print("Erro ao ler o score.")
        return ""
    end
end

function Game:showScore()
    local score = self:loadScores()
    if score and score ~= "" then
        love.graphics.setFont(love.graphics.newFont(20))
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("SCORES:\n" .. score, 10, 10)
    end
end

return Game
