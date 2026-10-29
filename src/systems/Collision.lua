local Collision = {}

function Collision.circlesOverlap(first, second)
    local dx = first.x - second.x
    local dy = first.y - second.y
    local radii = first.radius + second.radius

    return dx * dx + dy * dy <= radii * radii
end

return Collision
