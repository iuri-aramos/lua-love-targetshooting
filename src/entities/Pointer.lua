Pointer = {}

function Pointer:new()
    local pointer = {}
    setmetatable(pointer, self)
    self.__index = self

    pointer.x = x or 0
    pointer.y = y or 0
    pointer.image = nil

    love.mouse.setVisible(false)

    return pointer
end

function Pointer:setImage(image)
    self.image = love.graphics.newImage(image)
end

return Pointer