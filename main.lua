local GAME_C  = require("src.entities.Game")
local TARGET_C = require("src.entities.Target")
local SKY_C = require("src.entities.Sky")
local POINTER_C = require("src.entities.Pointer")

local function checkClickOnTarget(x, y)
    local distance = math.sqrt((x - TARGET.x)^2 + (y - TARGET.y)^2)
    return distance <= TARGET.radius
end

local function mousePosition()
    return love.mouse.getX(), love.mouse.getY()
end

function love.resize(w, h)
    GAME.LARGURA = w
    GAME.ALTURA = h
    GAME.CENTRO_X = GAME.LARGURA / 2
    GAME.CENTRO_Y = GAME.ALTURA / 2

    SKY:setScaleX(GAME.LARGURA / SKY.image:getWidth())
    SKY:setScaleY(GAME.ALTURA / SKY.image:getHeight())
end

function love.load()

    GAME = GAME_C:new()

    GAME.LARGURA = love.graphics.getWidth()
    GAME.ALTURA = love.graphics.getHeight()
    GAME.CENTRO_X = GAME.LARGURA / 2
    GAME.CENTRO_Y = GAME.ALTURA / 2
    GAME.TEMPORIZADOR = 10
    GAME.SCORE = 0

    -- TARGET
    TARGET = TARGET_C:new(math.random(50, GAME.LARGURA - 50), math.random(50, GAME.ALTURA - 50), 50)
    TARGET:setImage("assets/images/target.png")

    -- SKY
    SKY = SKY_C:new()
    SKY:setImage("assets/images/sky.png")
    SKY:setScaleX(GAME.LARGURA / SKY.image:getWidth())
    SKY:setScaleY(GAME.ALTURA / SKY.image:getHeight())

    -- POINTER
    POINTER = POINTER_C:new(love.mouse.getX(), love.mouse.getY())
    POINTER:setImage("assets/images/crosshairs.png")

    -- SET FONT
    love.graphics.setFont(love.graphics.newFont(20))
end

function love.update(dt)
    POINTER.x, POINTER.y = mousePosition()

    if GAME.TEMPORIZADOR > 0 then
        GAME.TEMPORIZADOR = GAME.TEMPORIZADOR - dt
    end

    if GAME.TEMPORIZADOR < 0 then
        GAME.TEMPORIZADOR = 0
    end

end

function love.mousepressed(x, y, button)
    if button == 1 and GAME.TEMPORIZADOR > 0 and checkClickOnTarget(x, y) then
        GAME.SCORE = GAME.SCORE + 1
        TARGET.x = math.random(50, GAME.LARGURA - 50)
        TARGET.y = math.random(50, GAME.ALTURA - 50)
    end
end

function love.draw()
    -- background
    love.graphics.draw(SKY.image, 0, 0, 0, SKY.scaleX, SKY.scaleY)

    love.graphics.print("TEMPORIZADOR: " .. math.floor(GAME.TEMPORIZADOR), GAME.CENTRO_X - 90, 30)
    love.graphics.print("SCORE: " .. GAME.SCORE, 50, 30)

    love.graphics.draw(TARGET.image, TARGET.x, TARGET.y, 0, 1, 1, TARGET.radius, TARGET.radius)

    love.graphics.draw(POINTER.image, POINTER.x, POINTER.y, 0, 1, 1, POINTER.image:getWidth() / 2, POINTER.image:getHeight() / 2)
end