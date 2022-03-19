----------------------------
-- CREATE BY CYBERCODELAB --
----------- FOR ------------
----- GAMECODEUR SCHOOL ----
----------------------------

-- Filtering images for pixel perfect. (The FilterMode is Linear by default)
love.graphics.setDefaultFilter("nearest")

function love.load()

    print("load...")
	math.randomseed(os.time())

end

function love.update(dt)

    -- limited deltatime
    dt = math.min(dt, 1/60)

    print(dt)
end

-- Scale render
local sx,sy = 2,2

function love.draw()

    love.graphics.scale(sx, sy);
    love.graphics.print("Hello World", 25, 25)

end

function love.keypressed(key)

    print("Key pressed: "..key)
    
    if key == "escape" then
        love.event.quit()
        return
    end

end
