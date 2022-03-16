-- Switch off buffering mode for an output file.(The result of any output operation appears immediately) | They are two other mode: "full" or "line"
io.stdout:setvbuf("no")

-- Filtering images for pixel perfect. (The FilterMode is Linear by default)
love.graphics.setDefaultFilter("nearest")

function love.load()
end

function love.update(dt)
end

function love.draw()
end