local Player = {
    shapes = {{x = 0, y = 10}},
    square_length = 1,
    queue = {}
}

function Player:Draw()
    for i = 1, #self.shapes - 1 do
        lg.setColor(1.0, 1.0, 1.0)
        lg.rectangle("fill", self.shapes[i].x, self.shapes[i].y, self.square_length, self.square_length)
    end
    if #self.shapes > 1 then
        lg.setColor(0.0, 1.0, 1.0)
        lg.rectangle("fill", self.shapes[#self.shapes].x, self.shapes[#self.shapes].y, self.square_length, self.square_length)
        lg.setColor(1.0, 1.0, 1.0)
    end
end

function Player:Overlaps()
    for i = 1, #self.shapes do
        if random_x == self.shapes[i].x and random_y == self.shapes[i].y then
            return true
        end
    end
    return false
end

function Player:Update(dt)

    for i = #self.queue, 1, -1 do

        local q = self.queue[i]


        local can_add = true
        for i = 1, #self.shapes do
            if AABB(q.x, q.y, self.square_length, self.square_length, self.shapes[i].x, self.shapes[i].y, self.square_length, self.square_length) then
                can_add = false
                break
            end
        end

        if can_add then
            table.insert(self.shapes, {x = q.x, y = q.y})
            -- print("----------")
            -- print(q.x)
            -- print(q.y)
            if q.x == random_x and q.y == random_y then

                random_x = lm.random(0, game_width - 1) * player.square_length
                random_y = lm.random(0, game_width - 1) * player.square_length

                while self:Overlaps() do
                    random_x = lm.random(0, game_width - 1) * player.square_length
                    random_y = lm.random(0, game_width - 1) * player.square_length
                end
            end
        end


        table.remove(self.queue, i)
    end
end


function Player:AddToQueue(queue)
    -- print("oyy oyy")
    xmoved = 0
    ymoved = 0
    table.insert(self.queue, queue)
end

function Player:Clear()
    self.shapes = {self.shapes[#self.shapes]}
end

return Player