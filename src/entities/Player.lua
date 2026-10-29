local class = require("lib.middleclass")
local Input = require("src.systems.Input")
local Projectile = require("src.entities.Projectile")

local Player = class("Player")

function Player:initialize(x, y)
    self.x = x
    self.y = y
    self.radius = 14
    self.speed = 260
    self.fireCooldown = 0
    self.lives = 3
end

function Player:update(dt, width, height)
    local moveX, moveY = Input.movementVector()
    local length = math.sqrt(moveX * moveX + moveY * moveY)

    if length > 0 then
        moveX = moveX / length
        moveY = moveY / length
        self.x = self.x + moveX * self.speed * dt
        self.y = self.y + moveY * self.speed * dt
    end

    self.x = math.max(self.radius, math.min(width - self.radius, self.x))
    self.y = math.max(self.radius, math.min(height - self.radius, self.y))
    self.fireCooldown = math.max(0, self.fireCooldown - dt)

    if Input.isDown("space") and self.fireCooldown == 0 then
        self.fireCooldown = 0.18
        return Projectile:new(self.x, self.y - self.radius)
    end
end

function Player:draw()
    love.graphics.setColor(0.6, 0.8, 0.2)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(1, 1, 1)
end

return Player
