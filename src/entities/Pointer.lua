Pointer = {}

function Pointer:new(x, y)
    local pointer = {}
    setmetatable(pointer, self)
    self.__index = self

    pointer.x = x or 0
    pointer.y = y or 0
    pointer.image = nil
    pointer.shotSound = nil

    love.mouse.setVisible(false)

    return pointer
end

function Pointer:setImage(image)
    self.image = love.graphics.newImage(image)
end

function Pointer:setShotSound(sounds)
    self.shotSound = love.audio.newSource(sounds, "static")
    self.shotSound:setVolume(0.2)
    self.shotSound:setLooping(false)
end

return Pointer