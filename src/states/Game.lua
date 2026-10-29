local StateManager = require("src.systems.StateManager")
local Collision = require("src.systems.Collision")
local Enemy = require("src.entities.Enemy")
local Player = require("src.entities.Player")

local Game = {}

function Game:enter()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    self.player = Player:new(width / 2, height - 60)
    self.enemies = {}
    self.projectiles = {}
    self.spawnTimer = 0
    self.score = 0
    self.gameOver = false
end

function Game:update(dt)
    if self.gameOver then
        return
    end

    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    local projectile = self.player:update(dt, width, height)

    if projectile then
        table.insert(self.projectiles, projectile)
    end

    self.spawnTimer = self.spawnTimer + dt
    if self.spawnTimer >= 1 then
        self.spawnTimer = self.spawnTimer - 1
        local x = love.math.random(20, width - 20)
        local speed = love.math.random(80, 150)
        table.insert(self.enemies, Enemy:new(x, -20, speed))
    end

    for index = #self.projectiles, 1, -1 do
        self.projectiles[index]:update(dt)
        if self.projectiles[index].y < -self.projectiles[index].radius then
            table.remove(self.projectiles, index)
        end
    end

    for index = #self.enemies, 1, -1 do
        local enemy = self.enemies[index]
        enemy:update(dt)

        if Collision.circlesOverlap(self.player, enemy) then
            table.remove(self.enemies, index)
            self.player.lives = self.player.lives - 1
            if self.player.lives <= 0 then
                self.gameOver = true
            end
        elseif enemy.y - enemy.radius > height then
            table.remove(self.enemies, index)
        end
    end

    for projectileIndex = #self.projectiles, 1, -1 do
        local projectile = self.projectiles[projectileIndex]
        for enemyIndex = #self.enemies, 1, -1 do
            if Collision.circlesOverlap(projectile, self.enemies[enemyIndex]) then
                table.remove(self.projectiles, projectileIndex)
                table.remove(self.enemies, enemyIndex)
                self.score = self.score + 1
                break
            end
        end
    end
end

function Game:draw()
    for _, projectile in ipairs(self.projectiles) do
        projectile:draw()
    end
    for _, enemy in ipairs(self.enemies) do
        enemy:draw()
    end
    self.player:draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Pontos: " .. self.score, 16, 16)
    love.graphics.print("Vidas: " .. self.player.lives, 16, 38)

    if self.gameOver then
        local width = love.graphics.getWidth()
        love.graphics.printf("FIM DE JOGO", 0, love.graphics.getHeight() * 0.42, width, "center")
        love.graphics.printf("Enter para reiniciar  |  Esc para sair", 0,
            love.graphics.getHeight() * 0.5, width, "center")
    end
end

function Game:keypressed(key)
    if self.gameOver and (key == "return" or key == "kpenter") then
        StateManager.switch(require("src.states.Game"))
    elseif key == "backspace" then
        StateManager.switch(require("src.states.Menu"))
    end
end

return Game
