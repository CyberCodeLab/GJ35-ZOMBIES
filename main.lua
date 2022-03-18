----------------------------
-- Create by CyberCodeLab --
----------- For ------------
----- Game Codeur Scool ----
----------------------------

-- Filtering images for pixel perfect. (The FilterMode is Linear by default)
love.graphics.setDefaultFilter("nearest")

function love.load()

end

function love.update(dt)

    -- limited deltatime
    dt = math.min(dt, 1/60)

    print(dt)
end

function love.draw()
    love.graphics.print("Hello World", 25, 25)
end

function love.keypressed(key)

end
