Blobs = {
    images = {},
    sounds = {},
    blobs = {},
    hgap = 400,
    v = 350,
    lowest_y = 300,
    closest = 1,
}

function Blobs:Init()
    for i = 1, 4 do
        table.insert(self.images, lg.newImage(tostring(i).."/small.png"))
        table.insert(self.sounds, la.newSource(tostring(i).."/sound.wav", "static"))
    end

    for i = 1, 10 do
        table.insert(self.blobs, {type = love.math.random(1, 4), x = i * self.hgap + self.hgap * 4, y = love.math.random(self.lowest_y, self.lowest_y + 400)})
    end

end

function Blobs:Draw()
    for i = 1, #self.blobs do
        local j = self.blobs[i]
        lg.draw(self.images[j.type], j.x, j.y)
    end
end

function Blobs:Update(dt)
    for i = 1, #self.blobs do
        self.blobs[i].x = self.blobs[i].x - self.v * dt
    end

    if playing then
        self.v = self.v + 60 * dt
    end

    if self.blobs[self.closest].x < -64 then
        self:MoveBlob()
        if playing then
            health = health - 1
            oof_sound:play()
        end
    end
end

function Blobs:MoveBlob()
    local furthest = self.closest - 1
    if furthest < 1 then furthest = #self.blobs end

    self.blobs[self.closest].x = self.blobs[furthest].x + self.hgap
    self.blobs[self.closest].y = love.math.random(self.lowest_y, self.lowest_y + 400)
    self.blobs[self.closest].type = love.math.random(1,4)

    self.closest = (self.closest % #self.blobs) + 1
end

function Blobs:KeyPressed(key)
    -- up, right, down, left
    local pressed_correct = false
    local num = self.blobs[self.closest].type
    if self.blobs[self.closest].x < game_width and ((key == "up" and num == 1) or (key == "right" and num == 2) or (key == "down" and num == 3) or (key == "left" and num == 4)) then
        pressed_correct = true
    end

    if playing then
        if pressed_correct then
            score = score + 1
            self.sounds[num]:play()
            self:MoveBlob()
        else
            health = health - 1
            oof_sound:play()
        end
    end
end

Blobs:Init()

return Blobs