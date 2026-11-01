local Target = {}

function Target:new(x, y, radius)
    local target = {}
    setmetatable(target, self)
    self.__index = self

    target.x = x or 0
    target.y = y or 0
    target.radius = radius or 50
    target.image = nil

    return target
end

function Target:newPosition(x, y)
    self.x = x
    self.y = y

end

function Target:setImage(image)
    self.image = love.graphics.newImage(image)
end

return Target