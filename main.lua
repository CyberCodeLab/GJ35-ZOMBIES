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
local ZOMBIES_STATES = require 'zombieStates'


--[[
██╗      ██████╗ ██╗   ██╗███████╗    ███╗   ███╗███████╗████████╗██╗  ██╗ ██████╗ ██████╗ ███████╗
██║     ██╔═══██╗██║   ██║██╔════╝    ████╗ ████║██╔════╝╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗██╔════╝
██║     ██║   ██║██║   ██║█████╗      ██╔████╔██║█████╗     ██║   ███████║██║   ██║██║  ██║███████╗
██║     ██║   ██║╚██╗ ██╔╝██╔══╝      ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║   ██║██║  ██║╚════██║
███████╗╚██████╔╝ ╚████╔╝ ███████╗    ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║╚██████╔╝██████╔╝███████║
╚══════╝ ╚═════╝   ╚═══╝  ╚══════╝    ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
]]


local renderScaleXY = 3 -- scale in x and y
local showInfos = false
local fps = 60

LIST_SPRITES = {
    ANIMATION = 5
}

ALL_ZOMBIES = {
    TYPE = "zombie",
    SPRITE = "monster", -- the complet path is auto completed by the function CreateSprite(). E.g "assets/<namefile>_<numberframe>.png"
    SPRITE_ALERT = love.graphics.newImage("assets/alert.png"),
    TOTAL = 100,
    SPEED = 200,
    DAMAGE = 0.1
}

function love.load()

    -- Filtering images for pixel perfect. (The FilterMode is Linear by default)
    love.graphics.setDefaultFilter("nearest")

    -- Init Windows Params
    WINDOW_WIDTH = love.graphics.getWidth() / renderScaleXY
    WINDOW_HEIGHT = love.graphics.getHeight() / renderScaleXY

    -- Init Characters
    PLAYER = CreatePlayer()
    GenerateZombie(ALL_ZOMBIES.TOTAL)

end

function love.update(dt)

    -- limited deltatime
    dt = math.min(dt, 1/fps)
    --print(dt)

    CheckPlayerInputs(PLAYER, dt)
    LimitPlayerScreen(PLAYER)
    UpdateSprites(LIST_SPRITES, LIST_SPRITES.ANIMATION, dt)

end

function love.draw()

    love.graphics.push() -- save all graphics params

    -- DRAW PARAMS
    love.graphics.scale(renderScaleXY, renderScaleXY)
    love.graphics.setBackgroundColor(RGBColor(color.black))

    -- DRAW SPRITES
    DrawSprites(LIST_SPRITES)

    -- DRAW TEXT
    love.graphics.rectangle("line",0,0,82,16)
    love.graphics.print("Life = "..tostring(math.floor(PLAYER.life)).."%", 4, 1)

    love.graphics.pop()

end

function love.keypressed(_key)

    print("Key pressed: ".._key)
    
    local keypressedEsc = "escape"
    local keypressedInfos = "i"
    local keypressedReset = "r"

    if _key == keypressedEsc then
        love.event.quit()
        return
    end

    if _key == keypressedInfos then
       showInfos = showInfos ~= true
    end

    if _key == keypressedReset then
        -- To do: reset the game
    end
    
end

--[[
██████╗ ██╗      █████╗ ██╗   ██╗███████╗██████╗ 
██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝██╔════╝██╔══██╗
██████╔╝██║     ███████║ ╚████╔╝ █████╗  ██████╔╝
██╔═══╝ ██║     ██╔══██║  ╚██╔╝  ██╔══╝  ██╔══██╗
██║     ███████╗██║  ██║   ██║   ███████╗██║  ██║
╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
]]

function CreatePlayer()

    local newPlayer = {}
    newPlayer.frames = 4
    newPlayer.type = "human"
    newPlayer.sprite = "player" -- -- the complet path is auto completed by the function CreateSprite(). E.g "assets/<namefile>_<numberframe>.png"

    newPlayer = CreateSprite(LIST_SPRITES, newPlayer.type, newPlayer.sprite, newPlayer.frames)
    newPlayer.x = WINDOW_WIDTH / 2 -- center
    newPlayer.y = (WINDOW_HEIGHT / 6) * 5 -- Center down of 5/6 the screen
    newPlayer.speed = 200
    newPlayer.life = 100
    
    newPlayer.Hurt = 
    function ()
        newPlayer.life = newPlayer.life - ALL_ZOMBIES.DAMAGE
        --Game Over
        if newPlayer.life <=0 then
            newPlayer.life = 0
            newPlayer.visible = false
        end
    end

    return newPlayer
end

function LimitPlayerScreen(_player)
    if _player.x < 0 then
        _player.x = 0
    end

    if _player.x >= WINDOW_WIDTH then
        _player.x = WINDOW_WIDTH
    end

    if _player.y < 0 then
        _player.y = 0
    end

    if _player.y >= WINDOW_HEIGHT then
        _player.y = WINDOW_HEIGHT
    end
end


--[[
███████╗ ██████╗ ███╗   ███╗██████╗ ██╗███████╗███████╗
╚══███╔╝██╔═══██╗████╗ ████║██╔══██╗██║██╔════╝██╔════╝
  ███╔╝ ██║   ██║██╔████╔██║██████╔╝██║█████╗  ███████╗
 ███╔╝  ██║   ██║██║╚██╔╝██║██╔══██╗██║██╔══╝  ╚════██║
███████╗╚██████╔╝██║ ╚═╝ ██║██████╔╝██║███████╗███████║
╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚═════╝ ╚═╝╚══════╝╚══════╝
]]

function CreateZombie()
    local totalFrameZombie = 2

    local newZombie = {}
    newZombie = CreateSprite(LIST_SPRITES, ALL_ZOMBIES.TYPE , ALL_ZOMBIES.SPRITE, totalFrameZombie)
    newZombie.x = Random(10, WINDOW_WIDTH-10)
    newZombie.y = Random(10, (WINDOW_HEIGHT/2)-10)

    newZombie.speed = Random(5,50) / ALL_ZOMBIES.SPEED
    newZombie.range = Random(10,150)
    newZombie.target = nil
    newZombie.damage = ALL_ZOMBIES.DAMAGE

    newZombie.state = ZOMBIES_STATES.NONE

    return newZombie
end

function GenerateZombie(_totalZombie)
    local zombies = {}

    for i = 1, _totalZombie do
        zombies = CreateZombie()
    end

    return zombies
end

function UpdateZombieStates(_zombie, _entities)

    if _zombie.state == nil then
        print("****ERROR ZOMBIE STATE IS NIL****")
        os.exit()
    end


    if _zombie.state == ZOMBIES_STATES.NONE then

        _zombie.state = ZOMBIES_STATES.CHANGE_DIRRECTION

    elseif _zombie.state == ZOMBIES_STATES.WALK then

        LimitZombieScreen(_zombie, ZOMBIES_STATES.CHANGE_DIRRECTION)
        ZombieLookForPlayer(_zombie, _entities)

    elseif _zombie.state == ZOMBIES_STATES.ATTACK then

        ZombieTrackTheTarget(_zombie, 5, PLAYER.type)

    elseif _zombie.state == ZOMBIES_STATES.BITE then

        --print("BITE Player type: " .. PLAYER.TYPE)
        ZombieBiteTheTarget(_zombie, 5, PLAYER.type)
        
    elseif _zombie.state == ZOMBIES_STATES.CHANGE_DIRRECTION then
        
        RandomZombieMove(_zombie)

    end

end

function RandomZombieMove(_zombie)
    local angle = math.angle(_zombie.x,_zombie.y, Random(0, WINDOW_WIDTH), Random(0, WINDOW_HEIGHT))
    _zombie.speedX = _zombie.speed * fps * math.cos(angle)
    _zombie.speedY = _zombie.speed * fps * math.sin(angle)
    
    _zombie.state = ZOMBIES_STATES.WALK
end

function ZombieBiteTheTarget(_zombie, _rangeZone, _targetType)
    if DistanceBetweenTargetAndZombie(_zombie) > _rangeZone and _zombie.target.type == _targetType then
        _zombie.state = ZOMBIES_STATES.ATTACK
    else
        if _zombie.target.Hurt ~= nil then
            _zombie.target.Hurt()
        end
        if _zombie.target.visible == false then
            _zombie.state = ZOMBIES_STATES.CHANGE_DIRRECTION
        end
    end
end

function ZombieTrackTheTarget(_zombie, _rangeZone, _targetType)
    if _zombie.target == nil then
        _zombie.state = ZOMBIES_STATES.CHANGE_DIRRECTION
    elseif _zombie.target.visible == false then
        _zombie.state = ZOMBIES_STATES.CHANGE_DIRRECTION
    elseif DistanceBetweenTargetAndZombie(_zombie) > _zombie.range and _zombie.target.type == _targetType then
        _zombie.state = ZOMBIES_STATES.CHANGE_DIRRECTION
    elseif DistanceBetweenTargetAndZombie(_zombie) < _rangeZone and _zombie.target.type == _targetType then
        _zombie.state = ZOMBIES_STATES.BITE
        _zombie.speedX = 0
        _zombie.speedY = 0
    else
        local randomMove = 20
        local destX, destY
        destX = math.random(_zombie.target.x - randomMove, _zombie.target.x + randomMove)
        destY = math.random(_zombie.target.y - randomMove, _zombie.target.y + randomMove)

        local angle = math.angle(_zombie.x,_zombie.y, destX, destY)
        _zombie.speedX = _zombie.speed * 2 * fps * math.cos(angle)
        _zombie.speedY = _zombie.speed * 2 * fps * math.sin(angle)
    end
end

function ZombieLookForPlayer(_zombie, _entities)
    for i, sprite in ipairs(_entities) do
        if sprite.type == "human" and sprite.visible == true then
            local distance = math.dist(_zombie.x, _zombie.y, sprite.x, sprite.y)
            if distance < _zombie.range then
                _zombie.state = ZOMBIES_STATES.ATTACK
                _zombie.target = sprite
            end
        end
    end
end

function DistanceBetweenTargetAndZombie(_zombie)
    return math.dist(_zombie.x, _zombie.y, _zombie.target.x, _zombie.target.y)
end

function LimitZombieScreen(_zombie, _newState)
    local screenLimit = _zombie.x < 0 or _zombie.y < 0 or _zombie.x > WINDOW_WIDTH or _zombie.y > WINDOW_HEIGHT
    if screenLimit then
        _zombie.state = _newState
    end
end

function ZombieAlertIcon(_sprite)
    if _sprite.state == ZOMBIES_STATES.ATTACK then
        love.graphics.draw(ALL_ZOMBIES.SPRITE_ALERT, _sprite.x - ALL_ZOMBIES.SPRITE_ALERT:getWidth()/2, _sprite.y - _sprite.height - 2 )
    end
end


--[[
███████╗██████╗ ██████╗ ██╗████████╗███████╗███████╗
██╔════╝██╔══██╗██╔══██╗██║╚══██╔══╝██╔════╝██╔════╝
███████╗██████╔╝██████╔╝██║   ██║   █████╗  ███████╗
╚════██║██╔═══╝ ██╔══██╗██║   ██║   ██╔══╝  ╚════██║
███████║██║     ██║  ██║██║   ██║   ███████╗███████║
╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝╚══════╝
]]


function CreateSprite(_myList, _spriteType, _spriteImgFile, _numberFrames)
    local newSprite = {}
    newSprite.type = _spriteType
    newSprite.visible = true
    newSprite.life = 100

    -- loading sprite data
    newSprite.images = {}
    newSprite.currentFrame = 1 --default image selected

    for i=1, _numberFrames do
        local filename = "assets/".._spriteImgFile.."_"..tostring(i)..".png"
        newSprite.images[i] = love.graphics.newImage(filename)
         --print("Loading frame: "..filename)
    end

    -- Init Position
    newSprite.x = 0
    newSprite.y = 0
    newSprite.speedX = 0
    newSprite.speedY = 0

    -- Get data
    newSprite.width = newSprite.images[1]:getWidth()
    newSprite.height = newSprite.images[1]:getHeight()

    table.insert(_myList, newSprite)

    return newSprite
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
        if sprite.type == ALL_ZOMBIES.TYPE then
            UpdateZombieStates(sprite, _lstSprites)
        end

    end
end

function DrawSprites(_lstSprites)
    for i, sprite in ipairs(_lstSprites) do
        if sprite.visible == true then
            local frame = sprite.images[math.floor(sprite.currentFrame)]
            love.graphics.draw(frame, sprite.x - sprite.width / 2, sprite.y - sprite.height / 2)
            if sprite.type == ALL_ZOMBIES.TYPE then
                StateInfos(sprite)
                ZombieAlertIcon(sprite)
            end
        end
    end
end


--[[
██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗███████╗███████╗
██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝██║██╔════╝██╔════╝
██║   ██║   ██║   ██║██║     ██║   ██║   ██║█████╗  ███████╗
██║   ██║   ██║   ██║██║     ██║   ██║   ██║██╔══╝  ╚════██║
╚██████╔╝   ██║   ██║███████╗██║   ██║   ██║███████╗███████║
 ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝   ╚═╝╚══════╝╚══════╝
]]


function Random(_min, _max)
    return love.math.random(_min, _max)
end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(_x1,_y1, _x2,_y2)
    return math.atan2(_y2-_y1, _x2-_x1) --arc tangeante
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


function CheckPlayerInputs(_player, _dt)

    if _player.visible == false then
        do return end
    end

    if love.keyboard.isDown("left") then
    _player.x = _player.x - _player.speed * _dt
    end
    
    if love.keyboard.isDown("up") then
        _player.y = _player.y - _player.speed * _dt
    end

    if love.keyboard.isDown("right") then
        _player.x = _player.x + _player.speed * _dt
    end

    if love.keyboard.isDown("down") then
        _player.y = _player.y + _player.speed * _dt
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

function StateInfos(_sprite)
    if showInfos == true then
        love.graphics.print(_sprite.state, _sprite.x - 10, _sprite.y - _sprite.height - 10)
    end
end

function DebugTest()
    if love.keyboard.isDown("i") then
        love.graphics.print("ALLWAYS", WINDOW_WIDTH/2, WINDOW_HEIGHT/2)
        --do return end
        love.graphics.print("TEST", WINDOW_WIDTH/2-10, WINDOW_HEIGHT/2-10)
    end
end