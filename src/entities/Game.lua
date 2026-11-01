Game = {}

function Game:new()
    local game = {}
    setmetatable(game, self)
    self.__index = self

    return game
end

return Game