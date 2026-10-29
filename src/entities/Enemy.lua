local class = require("lib.middleclass")

local Enemy = class("Enemy")

function Enemy:initialize(x, y, speed)
    self.x = x
    self.y = y
    self.radius = 13
    self.speed = speed
end

function Enemy:update(dt)
    self.y = self.y + self.speed * dt
end

function Enemy:draw()
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(1, 1, 1)
end

return Enemy
