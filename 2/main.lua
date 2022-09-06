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

require 'libs/slam'
splash = require "libs/splash"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 0, {}, function()


push = require "libs/push"
game_width, game_height = 1920, 1080
window_width, window_height = 1920, 1080
lw.setMode(window_width, window_height, {borderless = false})
push:setupScreen(game_width, game_height, window_width, window_height, {fullscreen = true, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())




---------------------------------------------------------------------------------------------------------




-- Sound 2 by Omar
-- Sound 3 by Shermern
-- Sound 4 by Andy




bg = lg.newImage("bg.png")
blobs = require "Blobs"

health = 10
health_img = lg.newImage("heart.png")

font = lg.newFont("font.ttf", 64)
lg.setFont(font)

restart_sound = la.newSource("restart.wav", "static")
oof_sound = la.newSource("oof.wav", "static")
death_sound = la.newSource("yousuck.wav", "static")

score = 0
highscore = 0

playing = true

function love.draw()
    screen:apply()
    push:start()

    lg.draw(bg)
    blobs:Draw()
    for i = 1, health do
        lg.draw(health_img, health_img:getWidth() * (i + 0.5), health_img:getHeight())
    end
    lg.print(tostring(score).."         highscore: "..tostring(highscore), 64, 1080 - 64 * 2)

    if not playing then
        lg.printf("Press Space to Try Again", 0, 1080 / 2, 1920, "center")
    end

    push:finish()
end

function love.update(dt)
    screen:update(dt)
    blobs:Update(dt)
    if health <= 0 and playing then
        playing = false
        death_sound:play()
    end
    if score > highscore then
        highscore = score
    end
end

function restart()
    playing = true
    health = 10
    blobs.blobs = {}
    blobs:Init()
    blobs.closest = 1
    blobs.v = 350
    score = 0
    restart_sound:play()
end

function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
    if playing then blobs:KeyPressed(key) end
    if key == "space" and (playing == false) then restart() end
end

function love.resize(w, h)
  push:resize(w, h)
  lg.clear()
end

end)