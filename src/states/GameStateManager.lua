local GameStateManager = {
    STATES = {
        START = "start",
        PLAYING = "playing",
        GAMEOVER = "gameover",
        PAUSED = "paused"
    },
    
    current = "start" -- Initial state
}

function GameStateManager:set(newState)
    if self.current == newState then return end
    
    local previousState = self.current
    self.current = newState
    
    -- Optional: Hook for state transition logic
    if self.onStateChange then
        self:onStateChange(previousState, newState)
    end
end

function GameStateManager:is(state)
    return self.current == state
end

function GameStateManager:get()
    return self.current
end

return GameStateManager