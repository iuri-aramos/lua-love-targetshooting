Game = {}

function Game:new()
    local game = {}
    setmetatable(game, self)
    self.__index = self
    self.backgroundSound = nil

    return game
end

function Game:setBackgroundSound(sound)
    self.backgroundSound = love.audio.newSource(sound, "static")
    self.backgroundSound:setVolume(0.2)
    self.backgroundSound:setLooping(true)
end

return Game