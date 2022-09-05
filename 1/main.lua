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
game_width, game_height = 512, 256
window_width, window_height = 1024, 512
lw.setMode(window_width, window_height, {borderless = false})
push:setupScreen(game_width, game_height, window_width, window_height, {fullscreen = false, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())

function AABB(x, y, w, h, x2, y2, w2, h2)
    return x + w > x2 and x < x2 + w2 and y + h > y2 and y < y2 + h2
end




----------------------------------------------------------------------------------------------------------




playing = false
has_started = false

scroll_speed = 50
bg = require "bg"
pipes = require "Pipes"
player = require "Player"

alphnum = "abcdefghijklmnopqrstuvwxyz0123456789"
lineup = {"a", "b", "c"}

score = 0
highscore = 0

jump_sound = la.newSource("jump.wav", "static")
die_sound = la.newSource("die.wav", "static")

function love.draw()
    screen:apply()
    push:start()

    bg:Draw()
    pipes:Draw()
    player:Draw()
    if not playing then
        lg.print(tostring(lineup[1]).." to Play")
    else
        lg.print("score: "..tostring(score).."\n".."highscore: "..tostring(highscore).."\n\n "..tostring(lineup[1]).."\n "..tostring(lineup[2]).."\n "..tostring(lineup[3]))
    end


    push:finish()
end

function love.update(dt)
    screen:update(dt)
    if playing then
        bg:Update(dt)
        pipes:Update(dt)
        player:Update(dt)
        scroll_speed = scroll_speed + dt / 5
    end

    if score > highscore then
        highscore = score
    end
end

function restart()
    playing = true
    player:Reset()
    pipes:Reset()
    scroll_speed = 50
end


function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
    if key == lineup[1] then

        local random = love.math.random(#alphnum)
        lineup = {lineup[2], lineup[3], alphnum:sub(random, random)}
        jump_sound:play()

        if playing then
            player:Jump()
        elseif not has_started then
            has_started = true
            playing = true
        else
            restart()
        end
    end
end


function love.resize(w, h)
  push:resize(w, h)
  lg.clear()
end

end)