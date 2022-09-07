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
lg.setBackgroundColor(1.0, 1.0, 1.0)
love.mouse.setGrabbed(true)

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
_oldX = game_width / 2
_oldY = game_height / 2
lmouse.setPosition(lg.getWidth() / 2, lg.getHeight() / 2)

random_x = lm.random(0, game_width - 1) * player.square_length
random_y = lm.random(0, game_width - 1) * player.square_length

function love.draw()
    screen:apply()
    push:start()

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

function love.mousemoved()
    local _x, _y = push:toGame(lmouse.getX(), lmouse.getY())
    _x, _y = math.floor(_x), math.floor(_y)

    if (_x ~= _oldX) or (_y ~= _oldY) then
        if #player.shapes > 0 and math.abs(_x - _oldX) > player.square_length or math.abs(_y - _oldY) > player.square_length then
            -- x, y = push:toReal(player.shapes[#player.shapes].x + player.square_length / 2, player.shapes[#player.shapes].y + player.square_length / 2)
            -- print(_oldX, _oldY, x, y)
            -- lmouse.setPosition(x, y)
        else
            player:AddToQueue({x = _x, y = _y, oldX = _oldX, oldY = _oldY})
        end
    end

    _oldX, _oldY = push:toGame(lmouse.getX(), lmouse.getY())
    _oldX, _oldY = math.floor(_oldX), math.floor(_oldY)
end

end)