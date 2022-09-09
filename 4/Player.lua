local Player = {
    image = lg.newImage("player.png"),
    quads = {lg.newQuad(0, 0, 9, 11, 27, 11), lg.newQuad(9, 0, 9, 11, 27, 11), lg.newQuad(18, 0, 9, 11, 27, 11)},
    frame = 1,
    tick = 0.1,
    length = 0.1
}

function Player:Draw()
    lg.draw(self.image, self.quads[self.frame], 100, 100)
end

function Player:Update(dt)
    self.tick = self.tick - dt
    if self.tick < 0 then
        self.frame = (self.frame % 3) + 1
        self.tick = self.length
    end
end

return Player