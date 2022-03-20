----------------------------
-- CREATE BY CYBERCODELAB --
----------- FOR ------------
----- GAMECODEUR SCHOOL ----
----------------------------


--[[
██████  ███████  ██████  ██    ██ ██ ██████  ███████ ██████  
██   ██ ██      ██    ██ ██    ██ ██ ██   ██ ██      ██   ██ 
██████  █████   ██    ██ ██    ██ ██ ██████  █████   ██   ██ 
██   ██ ██      ██ ▄▄ ██ ██    ██ ██ ██   ██ ██      ██   ██ 
██   ██ ███████  ██████   ██████  ██ ██   ██ ███████ ██████  
]]


color = require 'colors'
player = require 'player'


--[[
██       ██████  ██    ██ ███████     ███████ ██    ██ ███    ██  ██████ 
██      ██    ██ ██    ██ ██          ██      ██    ██ ████   ██ ██      
██      ██    ██ ██    ██ █████       █████   ██    ██ ██ ██  ██ ██      
██      ██    ██  ██  ██  ██          ██      ██    ██ ██  ██ ██ ██      
███████  ██████    ████   ███████     ██       ██████  ██   ████  ██████ 
]]


function love.load()

    -- Filtering images for pixel perfect. (The FilterMode is Linear by default)
    love.graphics.setDefaultFilter("nearest")

    WIDTH = love.graphics.getWidth()
    HEIGHT = love.graphics.getHeight()

end



function love.update(dt)

    -- limited deltatime
    local fps = 60
    dt = math.min(dt, 1/fps)
    print(dt)

    CheckPlayerInputs(dt)

end



function love.draw()

    -- PARAMETERS
    local sxy = 2 -- scale
    love.graphics.scale(sxy, sxy)
    love.graphics.setBackgroundColor(RGBColor(color.green))

    -- PLAYER
    --love.graphics.draw(player.img, player.posX, player.posY, nil, 0.1)
    love.graphics.rectangle("fill", player.posX, player.posY, player.size, player.size)

    -- TEXT
    love.graphics.print("Score = 10", WIDTH/4, 5)
    DebugLoveVersionInfo()

end



function love.keypressed(key)

    print("Key pressed: "..key)
    
    if key == "escape" then
        love.event.quit()
        return
    end

end


--[[
██ ███    ██ ██████  ██    ██ ████████ 
██ ████   ██ ██   ██ ██    ██    ██    
██ ██ ██  ██ ██████  ██    ██    ██    
██ ██  ██ ██ ██      ██    ██    ██    
██ ██   ████ ██       ██████     ██    
]]


function CheckPlayerInputs(dt)
    if love.keyboard.isDown("right") then
        player.posX = player.posX + player.speed * dt
    elseif love.keyboard.isDown("left") then
        player.posX = player.posX - player.speed * dt
    elseif love.keyboard.isDown("up") then
        player.posY = player.posY - player.speed * dt
    elseif love.keyboard.isDown("down") then
        player.posY = player.posY + player.speed * dt
    end
end

--[[
██    ██ ████████ ██ ██      ██ ████████ ██ ███████ ███████ 
██    ██    ██    ██ ██      ██    ██    ██ ██      ██      
██    ██    ██    ██ ██      ██    ██    ██ █████   ███████ 
██    ██    ██    ██ ██      ██    ██    ██ ██           ██ 
 ██████     ██    ██ ███████ ██    ██    ██ ███████ ███████ 
]]

function RGBColor(rb,gb,bb)
    return love.math.colorFromBytes(rb, gb, bb)
end

--[[
██████  ███████ ██████  ██    ██  ██████  
██   ██ ██      ██   ██ ██    ██ ██       
██   ██ █████   ██████  ██    ██ ██   ███ 
██   ██ ██      ██   ██ ██    ██ ██    ██ 
██████  ███████ ██████   ██████   ██████  
]]


function DebugLoveVersionInfo()
    local major, minor, revision, codename = love.getVersion()
    local versionInfo = string.format("Version %d.%d.%d - %s", major, minor, revision, codename)
    local textX, textY = 5, HEIGHT/2.1
    love.graphics.print(versionInfo, textX, textY)
end