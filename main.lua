local GAME_C = require("src.entities.Game")
local TARGET_C = require("src.entities.Target")
local SKY_C = require("src.entities.Sky")
local POINTER_C = require("src.entities.Pointer")

local game
local target
local sky
local pointer

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

    game = GAME_C:new()

    game.LARGURA = love.graphics.getWidth()
    game.ALTURA = love.graphics.getHeight()
    game.CENTRO_X = game.LARGURA / 2
    game.CENTRO_Y = game.ALTURA / 2
    game.TEMPORIZADOR = 10
    game.SCORE = 0

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
    pointer.x, pointer.y = mousePosition()

    game.TEMPORIZADOR = math.max(0, game.TEMPORIZADOR - dt)

    target.scale = 1 + (target.scale - 1) * math.exp(-10 * dt)
end

function love.mousepressed(x, y, button)
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

function love.draw()
    -- background
    love.graphics.draw(sky.image, 0, 0, 0, sky.scaleX, sky.scaleY)

    love.graphics.print(string.format("TEMPORIZADOR: %.1f", game.TEMPORIZADOR), game.CENTRO_X - 90, 30)
    love.graphics.print("SCORE: " .. game.SCORE, 50, 30)

    love.graphics.draw(target.image, target.x, target.y, 0, target.scale, target.scale, target.radius, target.radius)

    love.graphics.draw(pointer.image, pointer.x, pointer.y, 0, 1, 1, pointer.image:getWidth() / 2,
        pointer.image:getHeight() / 2)
end
