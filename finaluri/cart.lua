Cart = {}

function Cart.new(x, y)
    local self = setmetatable({}, { __index = Cart })
    self.x = x
    self.y = y
    self.width = 50
    self.height = 20
    return self
end

function Cart:update(dt)
    if love.keyboard.isDown("left") or love.keyboard.isDown('a') then
        self.x = self.x - SPEED * dt
    elseif love.keyboard.isDown("right") or love.keyboard.isDown('d') then
        self.x = self.x + SPEED * dt
    end

    self.x = math.max(0, math.min(WINDOW_WIDTH - self.width, self.x))
end

function Cart:render()
    love.graphics.setColor(106/255, 67/255, 28/255, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Cart
