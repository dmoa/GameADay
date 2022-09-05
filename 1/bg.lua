local bg = {
    image = lg.newImage("bg.png"),
    x = 0,
    y = 0,
}

function bg:Draw()
    lg.draw(self.image, self.x, self.y)
    lg.draw(self.image, self.x + self.image:getWidth(), self.y)
end

function bg:Update(dt)
    self.x = self.x - scroll_speed * dt
    if self.x < - self.image:getWidth() then
        self.x = 0
    end
end

return bg