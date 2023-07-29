Ball = {}

function Ball.new(x, y)
    local self = setmetatable({}, { __index = Ball })
    self.x = x
    self.y = y
    self.radius = 10
    self.dy = 100
    return self
end

function Ball:update(dt)
    self.y = self.y + self.dy * dt
end

function Ball:collidesWith(other)
    return self.y + self.radius > other.y and self.y < other.y + other.height and
           self.x + self.radius > other.x and self.x < other.x + other.width
end

function Ball:render()
    love.graphics.setColor(141/255, 182/255, 0, 1)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Ball:reset()
    self.x = math.random(0, WINDOW_WIDTH)
    self.y = -10
end

return Ball
