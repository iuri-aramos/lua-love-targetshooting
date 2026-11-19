---@class Target
---@field x number
---@field y number
---@field scale number
---@field scaleX number
---@field scaleY number
---@field radius number
---@field image any
local Target = {}
Target.__index = Target

---@return Target
function Target:new(x, y, radius)
    local target = setmetatable({}, self)

    target.x = x or 0
    target.y = y or 0
    target.scale = 1
    target.scaleX = 1
    target.scaleY = 1
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

function Target:setScaleX(scaleX)
    self.scale = scaleX
end

return Target
