local Input = {}

function Input.isDown(...)
    for _, key in ipairs({ ... }) do
        if love.keyboard.isDown(key) then
            return true
        end
    end

    return false
end

function Input.movementVector()
    local x = 0
    local y = 0

    if Input.isDown("a", "left") then
        x = x - 1
    end
    if Input.isDown("d", "right") then
        x = x + 1
    end
    if Input.isDown("w", "up") then
        y = y - 1
    end
    if Input.isDown("s", "down") then
        y = y + 1
    end

    return x, y
end

return Input
