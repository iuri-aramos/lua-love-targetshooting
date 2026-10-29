local StateManager = require("src.systems.StateManager")

local Menu = {}

function Menu:draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    love.graphics.setColor(0.3, 0.85, 1)
    love.graphics.printf("MEU JOGO", 0, height * 0.32, width, "center")
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Pressione Enter para jogar", 0, height * 0.48, width, "center")
    love.graphics.printf("WASD / setas: mover    Espaço: atirar", 0, height * 0.55, width, "center")
end

function Menu:keypressed(key)
    if key == "return" or key == "kpenter" then
        StateManager.switch(require("src.states.Game"))
    end
end

return Menu
