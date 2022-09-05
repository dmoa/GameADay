local Player = {
    image = lg.newImage("obama.png"),
    x = 100,
    y = 25,
    yv = 0,
    a = 450 -- 600
}

function Player:Draw()
    lg.draw(self.image, self.x, self.y)
end

function Player:Update(dt)
    self.yv = self.yv + self.a * dt
    self.y = self.y + self.yv * dt

    if self.y + self.image:getHeight() > game_height or self.y + self.image:getHeight() < 0 then
        playing = false
        die_sound:play()
    end
end

function Player:Jump(dt)
    self.yv = -200
end

function Player:Reset()
    self.y = 25
    self.yv = 0
end

return Player