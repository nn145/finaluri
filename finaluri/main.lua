WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

SPEED = 200

local Cart = require("cart")
local Ball = require("ball")

local cart
local ball
local score = 0
local gameState = 'start'

function love.load()
    love.window.setTitle('cart game')
    
    love.graphics.setDefaultFilter('nearest', 'nearest')
	
    smallFont = love.graphics.newFont('font.ttf', 20)
    
    love.graphics.setFont(smallFont)
    
    math.randomseed(os.time())
    
    sounds = {
		['hit'] = love.audio.newSource('game_over.wav', 'static'),
		['score'] = love.audio.newSource('pick_up.wav', 'static'),
        ['main'] = love.audio.newSource('marios_theme.wav', 'static'),
        ['game_over'] = love.audio.newSource('dd.wav', 'static')
    }
    
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    love.graphics.setBackgroundColor(152 / 255, 152 / 255, 176 / 255, 1)

    cart = Cart.new(WINDOW_WIDTH / 2 - 25, WINDOW_HEIGHT - 40)
    ball = Ball.new(math.random(0, WINDOW_WIDTH), -10)
end

function love.update(dt)
    if gameState == 'play' then
        sounds['main']:play()
        cart:update(dt)
        ball:update(dt)

        if ball.y > WINDOW_HEIGHT then
            ball:reset()
            sounds['hit']:play()
            sounds['main']:stop()
            sounds['game_over']:play()
            gameState = 'gameover'
        end

        if ball:collidesWith(cart) then
            sounds['score']:play()
            score = score + 1
            ball:reset()
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if gameState == 'start' then
        if key == 'return' then
            gameState = 'play'
            score = 0
        end
    elseif gameState == 'gameover' then
        if key == 'return' then
            gameState = 'start'
            ball:reset()
        end
    end
end

function love.draw()
    cart:render()
    ball:render()

    love.graphics.setColor(168/255, 255/255, 4, 1)
    love.graphics.print('Score: ' .. score, 10, 10)

    love.graphics.setColor(1, 1, 1, 1)
    if gameState == 'start' then
        love.graphics.printf('Press Enter to Start', 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
    elseif gameState == 'gameover' then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Game Over\nPress Enter to Play Again', 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
    end
end
