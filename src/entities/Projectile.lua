local class = require("lib.middleclass")

local Projectile = class("Projectile")

function Projectile:initialize(x, y)
    self.x = x
    self.y = y
    self.radius = 4
    self.speed = 520
end

function Projectile:update(dt)
    self.y = self.y - self.speed * dt
end

function Projectile:draw()
    love.graphics.setColor(0.2, 0.22, 0.22)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(1, 1, 1)
end

return Projectile
