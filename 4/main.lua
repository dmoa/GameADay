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
require "libs/slam"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 0, {}, function()


push = require "libs/push"
game_width, game_height = 9 * 16, 9 * 16
window_width, window_height = 9 * 16 * 4, 9 * 16 * 4
lw.setMode(window_width, window_height, {borderless = false})
push:setupScreen(game_width, game_height, window_width, window_height, {fullscreen = false, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())




-------------------------------------------------------------------



player = require "Player"

tiles = lg.newImage("tiles.png")
quads = {}
for i = 1, 5 do
    table.insert(quads, lg.newQuad((i - 1) * 16, 0, 16, 16, tiles:getWidth(), tiles:getHeight()))
end

objects = {}

local lines = love.filesystem.lines("1.txt")

for line in lines do
    table.insert(objects, {})
    for x = 1, #line do

        local value = line:sub(x,x)
        if value == "#" then
            value = love.math.random(1, 5)
        else
            value = 0
        end

        table.insert(objects[#objects], value)
    end
end

function love.draw()
    screen:apply()
    push:start()

    for y = 1, #objects do
        for x = 1, #(objects[y]) do
            if objects[y][x] <= 5 and objects[y][x] >= 1 then
                lg.draw(tiles, quads[objects[y][x]], (x - 1) * 16, (y - 1) * 16)
            end
        end
    end

    player:Draw()

    push:finish()
end

function love.update(dt)
    screen:update(dt)
    player:Update(dt)
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