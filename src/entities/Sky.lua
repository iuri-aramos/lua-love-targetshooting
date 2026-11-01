Sky = {}

function Sky:new()
    local sky = {}
    setmetatable(sky, self)
    self.__index = self
    self.image = nil

    return sky
end

function Sky:setImage(image)
    self.image = love.graphics.newImage(image)
end

function Sky:setScaleX(scaleX)
    self.scaleX = scaleX
end

function Sky:setScaleY(scaleY)
    self.scaleY = scaleY
end

return Sky