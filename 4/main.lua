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

splash = require "libs/splash"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 0, {}, function()


push = require "libs/push"
game_width, game_height = 512, 512
window_width, window_height = 512, 512
lw.setMode(window_width, window_height, {borderless = false})
push:setupScreen(game_width, game_height, window_width, window_height, {fullscreen = false, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())




-------------------------------------------------------------------




function love.draw()
    screen:apply()
    push:start()

    push:finish()
end

function love.update(dt)
    screen:update(dt)
end

function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
end

function love.resize(w, h)
  push:resize(w, h)
  lg.clear()
end

end)