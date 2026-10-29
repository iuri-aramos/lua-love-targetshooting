local StateManager = {
    current = nil
}

function StateManager.switch(state)
    if StateManager.current and StateManager.current.leave then
        StateManager.current:leave()
    end

    StateManager.current = state

    if state.enter then
        state:enter()
    end
end

function StateManager.update(dt)
    local state = StateManager.current
    if state and state.update then
        state:update(dt)
    end
end

function StateManager.draw()
    local state = StateManager.current
    if state and state.draw then
        state:draw()
    end
end

function StateManager.keypressed(key, scancode, isrepeat)
    local state = StateManager.current
    if state and state.keypressed then
        state:keypressed(key, scancode, isrepeat)
    end
end

return StateManager
