local StateManager = require("src.systems.StateManager")

function love.load()
    love.graphics.setBackgroundColor(0.055, 0.07, 0.11)
    StateManager.switch(require("src.states.Menu"))
end

function love.update(dt)
    StateManager.update(dt)
end

function love.draw()
    StateManager.draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
        return
    end

    StateManager.keypressed(key, scancode, isrepeat)
end
