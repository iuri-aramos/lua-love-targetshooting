---@class Sky
---@field image any
---@field scaleX number
---@field scaleY number
local Sky = {}
Sky.__index = Sky

---@return Sky
function Sky:new()
    local sky = setmetatable({}, self)
    sky.image = nil
    sky.scaleX = 1
    sky.scaleY = 1

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
