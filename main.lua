TARGET = require("/src/entities/Target")
function love.load()
    LARGURA = love.graphics.getWidth()
    ALTURA = love.graphics.getHeight()
    CENTRO_X = LARGURA / 2
    TEMPORIZADOR = 0

    SEGUNDO_ANTERIOR = 0

    RAIO = 50
    TARGET_IMAGE = love.graphics.newImage("assets/images/target.png")
    TARGET = TARGET:new(math.random(RAIO, LARGURA - RAIO), math.random(RAIO, ALTURA - RAIO), RAIO)
    TARGET.image = TARGET_IMAGE
end

function love.update(dt)
    TEMPORIZADOR = TEMPORIZADOR + dt

    local segundoAtual = math.floor(TEMPORIZADOR)
    if segundoAtual > SEGUNDO_ANTERIOR then
        SEGUNDO_ANTERIOR = segundoAtual
        TARGET:newPosition(math.random(RAIO, LARGURA - RAIO), math.random(RAIO, ALTURA - RAIO))
    end
end

function love.draw()
    love.graphics.print("TEMPORIZADOR: " .. math.floor(TEMPORIZADOR), CENTRO_X - 50, 10)

    love.graphics.draw(TARGET.image, TARGET.x, TARGET.y, 0, 1, 1, TARGET.radius, TARGET.radius)
end

-- TODO, 
-- FIXME, 
-- BUG, 
-- HACK, 
-- XXX and 
-- NOTE
