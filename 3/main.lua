la = love.audio
ld = love.data
le = love.event
lfile = love.filesystem
lf = love.font
lg = love.graphics
li = love.image
lj = love.joystick
lk = love.keyboard
lm = love.math
lmouse = love.mouse
lp = love.physics
lsound = love.sound
lsys = love.system
lth = love.thread
lt = love.timer
ltouch = love.touch
lv = love.video
lw = love.window

lg.setDefaultFilter("nearest", "nearest", 1)
lg.setLineStyle('rough')
-- love.mouse.setGrabbed(true)
love.mouse.setRelativeMode(true)

splash = require "libs/splash"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 0, {}, function() --- CHANGE THIS BACK TO 2


push = require "libs/push"
game_width, game_height = 32, 32
window_width, window_height = 512, 512
lw.setMode(window_width, window_height, {borderless = false})
push:setupScreen(game_width, game_height, window_width, window_height, {fullscreen = false, resizable = true, borderless = false})
push:switchFullscreen() -- hack so that the cursor stuff works

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())


function AABB(x, y, w, h, x2, y2, w2, h2)
    return x + w > x2 and x < x2 + w2 and y + h > y2 and y < y2 + h2
end




--------------------------------------------------------------------------------------------------------------------------




player = require "Player"
xmoved = 0
ymoved = 0
lmouse.setPosition(lg.getWidth() / 2, lg.getHeight() / 2)

random_x = lm.random(0, game_width - 1) * player.square_length
random_y = lm.random(0, game_width - 1) * player.square_length

function love.draw()
    screen:apply()
    push:start()
    lg.setColor(0.5, 0.5, 0.5)
    lg.rectangle("fill", 0, 0, game_width, game_height)
    lg.setColor(1.0, 1.0, 1.0)

    player:Draw()
    lg.setColor(0.0, 1.0, 0.0)
    lg.rectangle("fill", random_x, random_y, player.square_length, player.square_length)
    lg.setColor(1.0, 1.0, 1.0)

    push:finish()
end

function love.update(dt)

    player:Update(dt)

    screen:update(dt)

end

function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
    if key == "space" then player:Clear() end
end

function love.resize(w, h)
  push:resize(w, h)
  lg.clear()
end

function love.mousemoved(_x, _y, dx, dy)
    xmoved = xmoved + dx / push._SCALE.x
    ymoved = ymoved + dy / push._SCALE.y


    -- xmoved ymoved reset in AddToQueue

    local s = player.shapes[#player.shapes]

    if xmoved > 1 and s.x ~= (game_width - player.square_length) then
        player:AddToQueue({x = s.x + player.square_length, y = s.y})
    elseif xmoved < -1 and s.x ~= 0 and xmoved < ymoved then
        player:AddToQueue({x = s.x - player.square_length, y = s.y})
    elseif ymoved > 1 and s.y ~= (game_height - player.square_length) and ymoved > xmoved then
        player:AddToQueue({x = s.x, y = s.y + player.square_length})
    elseif ymoved < -1 and s.y ~= 0 and ymoved < xmoved then
        player:AddToQueue({x = s.x, y = s.y - player.square_length})
    end

end

end)