local GAME_C = require("src.entities.Game")
local TARGET_C = require("src.entities.Target")
local SKY_C = require("src.entities.Sky")
local POINTER_C = require("src.entities.Pointer")

--
local GameStateManager = require("src.states.GameStateManager")

---@type Game
local game
---@type Target
local target
---@type Sky
local sky
---@type Pointer
local pointer

local listPlayersScore
local bigFont
local defaultFont

local function checkClickOnTarget(x, y)
    local distance = math.sqrt((x - target.x) ^ 2 + (y - target.y) ^ 2)
    return distance <= target.radius
end

local function mousePosition()
    return love.mouse.getX(), love.mouse.getY()
end

function love.resize(w, h)
    game.LARGURA = w
    game.ALTURA = h
    game.CENTRO_X = game.LARGURA / 2
    game.CENTRO_Y = game.ALTURA / 2

    sky:setScaleX(game.LARGURA / sky.image:getWidth())
    sky:setScaleY(game.ALTURA / sky.image:getHeight())
end

function love.load()
    bigFont = love.graphics.newFont(30)
    defaultFont = love.graphics.newFont(20)

    game = GAME_C:new()

    game.LARGURA = love.graphics.getWidth()
    game.ALTURA = love.graphics.getHeight()
    game.CENTRO_X = game.LARGURA / 2
    game.CENTRO_Y = game.ALTURA / 2
    game.TEMPORIZADOR = 15
    game.SCORE = 0
    game:setBackgroundSound("assets/audio/musica-fundo.mp3")

    -- TARGET
    target = TARGET_C:new(math.random(50, game.LARGURA - 50), math.random(50, game.ALTURA - 50), 50)
    target:setImage("assets/images/target.png")

    -- SKY
    sky = SKY_C:new()
    sky:setImage("assets/images/sky.png")
    sky:setScaleX(game.LARGURA / sky.image:getWidth())
    sky:setScaleY(game.ALTURA / sky.image:getHeight())

    -- POINTER
    pointer = POINTER_C:new(love.mouse.getX(), love.mouse.getY())
    pointer:setImage("assets/images/crosshairs.png")
    pointer:setShotSound("assets/audio/tiro-pistola.mp3")

    -- SET FONT
    love.graphics.setFont(love.graphics.newFont(20))
end

function love.update(dt)
    if game.TEMPORIZADOR <= 0 and not GameStateManager:is(GameStateManager.STATES.GAMEOVER) then
        GameStateManager:set(GameStateManager.STATES.GAMEOVER)
        game:saveScore()
        listPlayersScore = game:loadScores()
    end
    if GameStateManager:is(GameStateManager.STATES.PLAYING) then
        pointer.x, pointer.y = mousePosition()

        game.TEMPORIZADOR = math.max(0, game.TEMPORIZADOR - dt)
        target.scale = 1 + (target.scale - 1) * math.exp(-10 * dt)
    end
end

function love.mousepressed(x, y, button)
    if GameStateManager:is(GameStateManager.STATES.PLAYING) then
        if button == 1 and game.TEMPORIZADOR > 0 then
            pointer.shotSound:stop()
            pointer.shotSound:seek(0)
            pointer.shotSound:play()

            if checkClickOnTarget(x, y) then
                game.SCORE = game.SCORE + 1
                target:setScaleX(1.4)
                target.x = math.random(50, game.LARGURA - 50)
                target.y = math.random(50, game.ALTURA - 50)
            end
        end
    end
end

function love.keypressed(key)
    if GameStateManager:is(GameStateManager.STATES.START) then
        GameStateManager:set(GameStateManager.STATES.PLAYING)
    elseif GameStateManager:is(GameStateManager.STATES.PLAYING) and key == "p" then
        GameStateManager:set(GameStateManager.STATES.PAUSED)
    elseif GameStateManager:is(GameStateManager.STATES.PAUSED) and (key == "p" or key == "escape") then
        GameStateManager:set(GameStateManager.STATES.PLAYING)
    elseif GameStateManager:is(GameStateManager.STATES.GAMEOVER) and key == "r" then
        -- Reiniciar o jogo
        GameStateManager:set(GameStateManager.STATES.PLAYING)
        game.SCORE = 0
        game.TEMPORIZADOR = 15
        target.x = math.random(50, game.LARGURA - 50)
        target.y = math.random(50, game.ALTURA - 50)
    end
end

function love.draw()
    -- background
    love.graphics.draw(sky.image, 0, 0, 0, sky.scaleX, sky.scaleY)

    if GameStateManager:is(GameStateManager.STATES.START) then
        love.graphics.setFont(bigFont)
        local font = love.graphics.getFont()
        local text = "PRESS ANY KEY TO START"
        local y = game.CENTRO_Y - (font:getHeight() / 2)
        love.graphics.printf(text, 0, y, game.LARGURA, "center")
    elseif GameStateManager:is(GameStateManager.STATES.PLAYING) then
        if game.backgroundSound then
            if not game.backgroundSound:isPlaying() then
                game.backgroundSound:play()
            end
        end

        love.graphics.setColor(1, 1, 1)
        love.graphics.print("SCORE: " .. game.SCORE, 10, 10)

        -- colocar o TEMPORIZADOR com cor branca
        love.graphics.print("TIME: " .. string.format("%.2f", game.TEMPORIZADOR), 10, 40)

        -- desenhar o TARGET
        love.graphics.draw(target.image, target.x, target.y, 0, target.scaleX, target.scaleY, target.radius,
            target.radius)

        -- desenhar o POINTER
        love.graphics.draw(pointer.image, pointer.x, pointer.y, 0, 1, 1, pointer.image:getWidth() / 2,
            pointer.image:getHeight() / 2)
    elseif GameStateManager:is(GameStateManager.STATES.PAUSED) then
        game.backgroundSound:pause()
        -- adicionar cor cinza claro
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.draw(sky.image, 0, 0, 0, sky.scaleX, sky.scaleY)

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(bigFont)
        local font = love.graphics.getFont()
        local textPaused1 = "PAUSED"
        local textPaused2 = "to return to the game press 'p' or 'escape'"
        local y = game.CENTRO_Y - (font:getHeight() / 2)
        love.graphics.printf(textPaused1, 0, y, game.LARGURA, "center")
        love.graphics.printf(textPaused2, 0, y + 50, game.LARGURA, "center")
    elseif GameStateManager:is(GameStateManager.STATES.GAMEOVER) then
        game.backgroundSound:stop()

        -- adicionar cor cinza claro
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.draw(sky.image, 0, 0, 0, sky.scaleX, sky.scaleY)

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(bigFont)
        love.graphics.print("GAME OVER", game.CENTRO_X - 60, game.CENTRO_Y - 10)
        love.graphics.print("SCORE: " .. game.SCORE, game.CENTRO_X - 60, game.CENTRO_Y + 20)

        love.graphics.setFont(defaultFont)
        love.graphics.print("Pressione 'R' para reiniciar", game.CENTRO_X - 100, game.CENTRO_Y + 80)

        love.graphics.print("GENERAL SCORE", 10, 10)
        love.graphics.setFont(defaultFont)
        love.graphics.print(listPlayersScore, 75, 40)
    end
end
