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

local totalZombie = 10
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
    DrawSprites(lstSprites)

    -- TEXT
    love.graphics.rectangle("line",0,0,82,16)
    love.graphics.print("Life = "..tostring(player.life).."%", 4, 1)

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

function UpdateZombieStates(_zombie, _entities)

    if _zombie.state == nil then
        print("****ERROR ZOMBIE STATE IS NIL****")
        os.exit()
    end


    if _zombie.state == ZOMBIES_STATES.NONE then

        _zombie.state = ZOMBIES_STATES.CHANGE_DIRRECTION

    elseif _zombie.state == ZOMBIES_STATES.WALK then

        LimitZombieScreen(_zombie, ZOMBIES_STATES.CHANGE_DIRRECTION)
        LookForPlayer(_zombie, _entities)

    elseif _zombie.state == ZOMBIES_STATES.ATTACK then

        --local lostTargetPlayer = math.dist(_zombie.x, _zombie.y, _zombie.target.x, _zombie.target.y) > _zombie.range and _zombie.target.type == "human"
        --local lostTargetPlayerInverted = math.dist(_zombie.x, _zombie.y, _zombie.target.x, _zombie.target.y) < 5 and _zombie.target.type == "human"

        if _zombie.target == nil then
            _zombie.state = ZOMBIES_STATES.CHANGE_DIRRECTION
        elseif Distance(_zombie) > _zombie.range and _zombie.target.type == "human" then
            _zombie.state = ZOMBIES_STATES.CHANGE_DIRRECTION
        elseif Distance(_zombie) < 5 and _zombie.target.type == "human" then
            _zombie.state = ZOMBIES_STATES.BITE
            _zombie.speedX = 0
            _zombie.speedY = 0
        else
            -- Attack!!
            local randomMove = 20
            local destX, destY
            destX = math.random(_zombie.target.x - randomMove, _zombie.target.x + randomMove)
            destY = math.random(_zombie.target.y - randomMove, _zombie.target.y + randomMove)

            local angle = math.angle(_zombie.x,_zombie.y, destX, destY)
            _zombie.speedX = _zombie.speed * 2 * fps * math.cos(angle)
            _zombie.speedY = _zombie.speed * 2 * fps * math.sin(angle)
        end

    elseif _zombie.state == ZOMBIES_STATES.BITE then

        if Distance(_zombie) > 5 and _zombie.target.type == "human" then
            _zombie.state = ZOMBIES_STATES.ATTACK
        end
        
    elseif _zombie.state == ZOMBIES_STATES.CHANGE_DIRRECTION then
        
        local angle = math.angle(_zombie.x,_zombie.y, Random(0, WIDTH), Random(0, HEIGHT))
        _zombie.speedX = _zombie.speed * fps * math.cos(angle)
        _zombie.speedY = _zombie.speed * fps * math.sin(angle)
        
        _zombie.state = ZOMBIES_STATES.WALK

    end

end

function LimitZombieScreen(_zombie, _state)

    local checkCollision = false

    --Horizontal limit
    if _zombie.x < 0 then
        _zombie.x = 0
        checkCollision = true
    end

    if _zombie.x > WIDTH then
        _zombie.x = WIDTH
        checkCollision = true
    end

    --Vertical Limit
    if _zombie.y < 0 then
        _zombie.y = 0
        checkCollision = true
    end

    if _zombie.y > HEIGHT then
        _zombie.y = HEIGHT
        checkCollision = true
    end

    --Check and change state
    if checkCollision then
        _zombie.state = _state
    end

end

function LookForPlayer(_zombie, _entities)
    for i, sprite in ipairs(_entities) do
        if sprite.type == "human" then
            local distance = math.dist(_zombie.x, _zombie.y, sprite.x, sprite.y)
            if distance < _zombie.range then
                _zombie.state = ZOMBIES_STATES.ATTACK
                _zombie.target = sprite
            end
        end
    end
end

function Distance(_zombie)
    return math.dist(_zombie.x, _zombie.y, _zombie.target.x, _zombie.target.y)
end

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
    player.life = 100
end

function CreateZombie()
    local totalFrameZombie = 2
    local newZombie = CreateSprite(lstSprites, "zombie", "monster", totalFrameZombie)
    newZombie.x = Random(10, WIDTH-10)
    newZombie.y = Random(10, (HEIGHT/2)-10)

    newZombie.speed = Random(5,50) / speedZombie
    newZombie.range = Random(10,150)
    newZombie.target = nil

    newZombie.state = ZOMBIES_STATES.NONE
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
        mySprite.images[i] = love.graphics.newImage(filename)
         --print("Loading frame: "..filename)
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

        -- AI
        if sprite.type == "zombie" then
            UpdateZombieStates(sprite, _lstSprites)
        end

    end
end

function DrawSprites(_lstSprites)
    for i, sprite in ipairs(_lstSprites) do
        local frame = sprite.images[math.floor(sprite.currentFrame)]
        love.graphics.draw(frame, sprite.x - sprite.width / 2, sprite.y - sprite.height / 2)

        StateInfos(sprite)
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

function StateInfos(_sprites)
    local keypressed = "i"
    if _sprites.type == "zombie" then
        if love.keyboard.isDown(keypressed) then
            love.graphics.print(_sprites.state, _sprites.x - 10, _sprites.y - _sprites.height - 10)
        end
    end
end

--TEST
function Test()
    if love.keyboard.isDown("i") then
        love.graphics.print("ALLWAYS", WIDTH/2, HEIGHT/2)
        --do return end
        love.graphics.print("TEST", WIDTH/2-10, HEIGHT/2-10)
    end
end