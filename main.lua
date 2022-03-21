--[[
$$$$$$$\                   $$$$$$\ $$\     $$\ $$$$$$$\  $$$$$$$$\ $$$$$$$\   $$$$$$\   $$$$$$\  $$$$$$$\  $$$$$$$$\ $$\        $$$$$$\  $$$$$$$\  
$$  __$$\                 $$  __$$\\$$\   $$  |$$  __$$\ $$  _____|$$  __$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  _____|$$ |      $$  __$$\ $$  __$$\ 
$$ |  $$ |$$\   $$\       $$ /  \__|\$$\ $$  / $$ |  $$ |$$ |      $$ |  $$ |$$ /  \__|$$ /  $$ |$$ |  $$ |$$ |      $$ |      $$ /  $$ |$$ |  $$ |
$$$$$$$\ |$$ |  $$ |      $$ |       \$$$$  /  $$$$$$$\ |$$$$$\    $$$$$$$  |$$ |      $$ |  $$ |$$ |  $$ |$$$$$\    $$ |      $$$$$$$$ |$$$$$$$\ |
$$  __$$\ $$ |  $$ |      $$ |        \$$  /   $$  __$$\ $$  __|   $$  __$$< $$ |      $$ |  $$ |$$ |  $$ |$$  __|   $$ |      $$  __$$ |$$  __$$\ 
$$ |  $$ |$$ |  $$ |      $$ |  $$\    $$ |    $$ |  $$ |$$ |      $$ |  $$ |$$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |      $$ |      $$ |  $$ |$$ |  $$ |
$$$$$$$  |\$$$$$$$ |      \$$$$$$  |   $$ |    $$$$$$$  |$$$$$$$$\ $$ |  $$ |\$$$$$$  | $$$$$$  |$$$$$$$  |$$$$$$$$\ $$$$$$$$\ $$ |  $$ |$$$$$$$  |
\_______/  \____$$ |       \______/    \__|    \_______/ \________|\__|  \__| \______/  \______/ \_______/ \________|\________|\__|  \__|\_______/ 
          $$\   $$ |                                                                                                                               
          \$$$$$$  |                                                                                                                               
           \______/                                                                                                           FOR GAMECODEUR SCHOOL
]]


--[[
██████╗ ███████╗ ██████╗ ██╗   ██╗██╗██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██║   ██║██║   ██║██║██████╔╝█████╗  ██║  ██║
██╔══██╗██╔══╝  ██║▄▄ ██║██║   ██║██║██╔══██╗██╔══╝  ██║  ██║
██║  ██║███████╗╚██████╔╝╚██████╔╝██║██║  ██║███████╗██████╔╝
╚═╝  ╚═╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝ 
]]


local color = require 'colors'


--[[
██╗      ██████╗ ██╗   ██╗███████╗    ███╗   ███╗███████╗████████╗██╗  ██╗ ██████╗ ██████╗ ███████╗
██║     ██╔═══██╗██║   ██║██╔════╝    ████╗ ████║██╔════╝╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗██╔════╝
██║     ██║   ██║██║   ██║█████╗      ██╔████╔██║█████╗     ██║   ███████║██║   ██║██║  ██║███████╗
██║     ██║   ██║╚██╗ ██╔╝██╔══╝      ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║   ██║██║  ██║╚════██║
███████╗╚██████╔╝ ╚████╔╝ ███████╗    ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║╚██████╔╝██████╔╝███████║
╚══════╝ ╚═════╝   ╚═══╝  ╚══════╝    ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
]]

local renderScaleXY = 3 -- scale in x and y

local lstSprites = {}
lstSprites.animation = 5

local totalZombie = 3
local speedZombie = 200
local fps = 60

function love.load()

    -- Filtering images for pixel perfect. (The FilterMode is Linear by default)
    love.graphics.setDefaultFilter("nearest")

    -- Windows
    WIDTH = love.graphics.getWidth() / renderScaleXY
    HEIGHT = love.graphics.getHeight() / renderScaleXY

    CreatePlayer()
    GenerateZombie(totalZombie)

end

function love.update(dt)

    -- limited deltatime
    dt = math.min(dt, 1/fps)
    --print(dt)

    CheckPlayerInputs(dt)
    UpdateSprites(lstSprites, lstSprites.animation, dt)

end

function love.draw()

    love.graphics.push() -- save all graphics params

    -- DRAW ARAMS
    love.graphics.scale(renderScaleXY, renderScaleXY)
    love.graphics.setBackgroundColor(RGBColor(color.black))

    -- SPRITES
    for i, sprite in ipairs(lstSprites) do
        local frame = sprite.images[math.floor(sprite.currentFrame)]
        love.graphics.draw(frame, sprite.x - sprite.width / 2, sprite.y - sprite.height / 2)
    end

    --love.graphics.draw(player.img, player.posX, player.posY, nil, 0.1)
    --love.graphics.rectangle("fill", player.posX, player.posY, player.size, player.size)

    -- TEXT
    love.graphics.print("Score = 10 \n"..PrintLoveVersionInfo(), 0, 0)

    love.graphics.pop()

end



function love.keypressed(_key)

    print("Key pressed: ".._key)
    
    if _key == "escape" then
        love.event.quit()
        return
    end

end

--[[
███████╗███╗   ██╗██╗   ██╗███╗   ███╗    ███████╗████████╗ █████╗ ████████╗███████╗███████╗
██╔════╝████╗  ██║██║   ██║████╗ ████║    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██╔════╝██╔════╝
█████╗  ██╔██╗ ██║██║   ██║██╔████╔██║    ███████╗   ██║   ███████║   ██║   █████╗  ███████╗
██╔══╝  ██║╚██╗██║██║   ██║██║╚██╔╝██║    ╚════██║   ██║   ██╔══██║   ██║   ██╔══╝  ╚════██║
███████╗██║ ╚████║╚██████╔╝██║ ╚═╝ ██║    ███████║   ██║   ██║  ██║   ██║   ███████╗███████║
╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝
]]

ZOMBIES_STATES = {}
ZOMBIES_STATES.NONE = ""
ZOMBIES_STATES.WALK = "walk"
ZOMBIES_STATES.ATTACK = "track" --TRACKING
ZOMBIES_STATES.BITE = "attack"
ZOMBIES_STATES.CHANGE_DIRRECTION = "change target"

--[[
██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗███████╗███████╗
██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝██║██╔════╝██╔════╝
██║   ██║   ██║   ██║██║     ██║   ██║   ██║█████╗  ███████╗
██║   ██║   ██║   ██║██║     ██║   ██║   ██║██╔══╝  ╚════██║
╚██████╔╝   ██║   ██║███████╗██║   ██║   ██║███████╗███████║
 ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝   ╚═╝╚══════╝╚══════╝
]]

function CreatePlayer()
    local totalFramePlayer = 4
    player = CreateSprite(lstSprites, "human", "player", totalFramePlayer)
    player.x = WIDTH / 2 -- center
    player.y = (HEIGHT / 6) * 5 -- Center down of 5/6 the screen
    player.speed = 200
end

function CreateZombie()
    local totalFrameZombie = 2
    local myZombie = CreateSprite(lstSprites, "zombie", "monster", totalFrameZombie)
    myZombie.x = Random(10, WIDTH-10)
    myZombie.y = Random(10, (HEIGHT/2)-10)
    myZombie.speed = math.random(5,50) / speedZombie

    local angle = math.angle(myZombie.x,myZombie.y, Random(0, WIDTH), Random(0, HEIGHT))
    myZombie.speedX = myZombie.speed * fps * math.cos(angle)
    myZombie.speedY = myZombie.speed * fps * math.sin(angle)
    
end

function GenerateZombie(_totalZombie)
    for nZombie = 1, _totalZombie do
        CreateZombie()
    end
end

function CreateSprite(_myList, _spriteType, _spriteImgFile, _numberFrames)
    local mySprite = {}
    mySprite.type = _spriteType

    -- loading sprite data
    mySprite.images = {}
    mySprite.currentFrame = 1 --default image selected

    for i=1, _numberFrames do
        local filename = "assets/".._spriteImgFile.."_"..tostring(i)..".png"
        print("Loading frame: "..filename)
        mySprite.images[i] = love.graphics.newImage(filename)
    end

    -- Init Position
    mySprite.x = 0
    mySprite.y = 0
    mySprite.speedX = 0
    mySprite.speedY = 0

    -- Get data
    mySprite.width = mySprite.images[1]:getWidth()
    mySprite.height = mySprite.images[1]:getHeight()


    table.insert(_myList, mySprite)

    return mySprite
end

function UpdateSprites(_lstSprites, _speedFrame, _dt)
    for i, sprite in ipairs(_lstSprites) do
        sprite.currentFrame = sprite.currentFrame + _speedFrame * _dt

        --Animation
        if sprite.currentFrame >= #sprite.images + 1  then
            sprite.currentFrame = 1
        end

        --Velocity
        sprite.x = sprite.x + sprite.speedX * _dt
        sprite.y = sprite.y + sprite.speedY * _dt

    end
end

function Random(_min, _max)
    return love.math.random(_min, _max)
end
-- Returns the angle between two vectors assuming the same origin.
function math.angle(_x1,_y1, _x2,_y2)
    return math.atan2(_y2-_y1, _x2-_x1)
end

-- Returns the distance between two points.
function math.dist(_x1,_y1, _x2,_y2) 
    return ((_x2-_x1)^2+(_y2-_y1)^2)^0.5
end

function RGBColor(_rb,_gb,_bb)
    return love.math.colorFromBytes(_rb, _gb, _bb)
end

--[[
██╗███╗   ██╗██████╗ ██╗   ██╗████████╗
██║████╗  ██║██╔══██╗██║   ██║╚══██╔══╝
██║██╔██╗ ██║██████╔╝██║   ██║   ██║   
██║██║╚██╗██║██╔═══╝ ██║   ██║   ██║   
██║██║ ╚████║██║     ╚██████╔╝   ██║   
╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝    ╚═╝   
]]


function CheckPlayerInputs(_dt)

    if love.keyboard.isDown("left") then
    player.x = player.x - player.speed * _dt
    end
    
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed * _dt
    end

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * _dt
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed * _dt
    end

end

--[[
██████╗ ███████╗██████╗ ██╗   ██╗ ██████╗ 
██╔══██╗██╔════╝██╔══██╗██║   ██║██╔════╝ 
██║  ██║█████╗  ██████╔╝██║   ██║██║  ███╗
██║  ██║██╔══╝  ██╔══██╗██║   ██║██║   ██║
██████╔╝███████╗██████╔╝╚██████╔╝╚██████╔╝
╚═════╝ ╚══════╝╚═════╝  ╚═════╝  ╚═════╝ 
]]


function PrintLoveVersionInfo()
    local major, minor, revision, codename = love.getVersion()
    local versionInfo = string.format("Version %d.%d.%d - %s", major, minor, revision, codename)
    return versionInfo
end