local Pipes = {
    image_up = lg.newImage("pipeup.png"),
    image_down = lg.newImage("pipedown.png"),
    vgap = 150,
    hgap = 200,
    positions = {},
    buffer = 4
}

function Pipes:Draw()
    for i = 1, #self.positions do
        lg.draw(self.image_down, self.positions[i][1][1], self.positions[i][1][2])
        lg.draw(self.image_up, self.positions[i][2][1], self.positions[i][2][2])
    end
end

function Pipes:Update(dt)
    for i = 1, #self.positions do
        self.positions[i][1][1] = self.positions[i][1][1] - scroll_speed * dt
        self.positions[i][2][1] = self.positions[i][2][1] - scroll_speed * dt

        if self.positions[i][1][1] < - 50 then
            local random_number = love.math.random(10, 140)
            self.positions[i][1][1] = 15 * self.hgap
            self.positions[i][2][1] = 15 * self.hgap
            self.positions[i][1][2] = random_number - self.image_down:getHeight()
            self.positions[i][2][2] = random_number + Pipes.vgap
        end

        if AABB(self.positions[i][1][1] + self.buffer, self.positions[i][1][2], self.image_down:getWidth(), self.image_down:getHeight(), player.x, player.y, player.image:getWidth(), player.image:getHeight()) or AABB(self.positions[i][2][1] + self.buffer, self.positions[i][2][2], self.image_up:getWidth(), self.image_up:getHeight(), player.x, player.y, player.image:getWidth(), player.image:getHeight()) then
            playing = false
            die_sound:play()
        end

    end
end

function Pipes:Reset()
    self.positions = {}
    for i = 1, 10 do
        local random_number = love.math.random(10, 140)
        table.insert(self.positions, { {i * self.hgap, random_number - self.image_down:getHeight()}, {i * self.hgap, random_number + self.vgap} })
    end
end

Pipes:Reset()

return Pipes