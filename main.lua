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


local FORMART = {png = '.png', jpeg = '.jpeg'}
local ASSETS_SOURCE = 'assets/'
local FPS = 60

local LIST_SPRITES = { ANIMATION = 5 }

local ALL_ZOMBIES = {
    TYPE = 'zombie',
    SPRITE = 'zombie', -- the complet path is auto completed by the function CreateSprite(). E.g 'assets/<namefile>_<numberframe>.png'
    SPRITE_ALERT = love.graphics.newImage(ASSETS_SOURCE..'red_alert'..FORMART.png),
    SPRITE_BITE = love.graphics.newImage(ASSETS_SOURCE..'bite'..FORMART.png),
    RANDOM_BITE_POSITION = 5,
    TOTAL_SPAWN = 100,
    SPEED = 200,
    DAMAGE = 0.1
}

local renderScaleXY = 3 -- scale in x and y
local inputShowZombieStates = false
local inputResetDraw = false


function love.load()

    InitParams()
    InitGame()
    InitMenu()

end

function love.update(dt)

    -- limited deltatime
    local deltatime = math.min(dt, 1/FPS)

    CheckPlayerInputs(PLAYER, deltatime)
    LimitPlayerScreen(PLAYER)
    UpdateCharacterSprites(LIST_SPRITES, LIST_SPRITES.ANIMATION, deltatime)

end

function love.draw()

    love.graphics.push() -- save all graphics params
    
    -- DRAW PARAMS
    love.graphics.scale(renderScaleXY, renderScaleXY)
    love.graphics.setBackgroundColor(RGBColor(color.darkGrey))

    -- DRAW SPRITES
    DrawCharacterSprites(LIST_SPRITES)
    --DrawMenu(MAIN_MENU)

    -- DRAW TEXT
    love.graphics.rectangle('line',0,0,82,16)
    love.graphics.print('Life = '..tostring(math.floor(PLAYER.life))..'%', 4, 1)
    
    if inputResetDraw == true then
        love.graphics.clear()
        inputResetDraw = false
    end

    love.graphics.pop()

end

function love.keypressed(_key)

    print('Key pressed: '.._key)
    
    local KEY_ESC = 'escape'
    local KEY_ZOMBIE_STATE_INFOS = 'i'
    local KEY_RESTART_GAME = 'r'

    if _key == KEY_ESC then
        love.event.quit()
        return
    end

    if _key == KEY_ZOMBIE_STATE_INFOS then
       inputShowZombieStates = inputShowZombieStates ~= true
    end

    if _key == KEY_RESTART_GAME then
        -- To do: reset the game
        inputResetDraw = true
        InitGame()
    end
    
end


--[[
██╗███╗   ██╗██╗████████╗
██║████╗  ██║██║╚══██╔══╝
██║██╔██╗ ██║██║   ██║   
██║██║╚██╗██║██║   ██║   
██║██║ ╚████║██║   ██║   
╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   
]]


function InitParams()
    -- Filtering images for pixel perfect. (The FilterMode is Linear by default)
    love.graphics.setDefaultFilter('nearest')

    -- Init Windows Params
    WINDOW_WIDTH = love.graphics.getWidth() / renderScaleXY
    WINDOW_HEIGHT = love.graphics.getHeight() / renderScaleXY
end

function InitGame()
     PLAYER = CreatePlayer()
     GenerateZombie(ALL_ZOMBIES.TOTAL_SPAWN)
end

function InitMenu()
     MAIN_MENU = CreateMainMenu()
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
    newPlayer.type = 'human'
    newPlayer.sprite = 'human' -- -- the complet path is auto completed by the function CreateSprite(). E.g 'assets/<namefile>_<numberframe>.png'

    newPlayer = CreateCharacterSprite(LIST_SPRITES, newPlayer.type, newPlayer.sprite, newPlayer.frames)
    newPlayer.x = WINDOW_WIDTH / 2 -- center
    newPlayer.y = (WINDOW_HEIGHT / 6) * 5 -- Center down of 5/6 the screen
    newPlayer.speed = 200
    newPlayer.life = 100
    
    function newPlayer:Hurt()
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
    newZombie = CreateCharacterSprite(LIST_SPRITES, ALL_ZOMBIES.TYPE , ALL_ZOMBIES.SPRITE, totalFrameZombie)
    newZombie.x = Random(10, WINDOW_WIDTH-10)
    newZombie.y = Random(10, (WINDOW_HEIGHT/2)-10)

    newZombie.speed = Random(5,50) / ALL_ZOMBIES.SPEED
    newZombie.range = Random(10,150)
    newZombie.target = nil
    newZombie.damage = ALL_ZOMBIES.DAMAGE

    newZombie.state = ZOMBIES_STATES.NONE

    return newZombie
end

function GenerateZombie(_totalNumberZombie)
    local zombies = {}

    for i = 1, _totalNumberZombie do
        zombies = CreateZombie()
    end

    return zombies
end

function UpdateZombieStates(_zombie, _entities)

    if _zombie.state == nil then
        print('****ERROR ZOMBIE STATE IS NIL****')
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

        --print('BITE Player type: ' .. PLAYER.TYPE)
        ZombieBiteTheTarget(_zombie, 5, PLAYER.type)
        
    elseif _zombie.state == ZOMBIES_STATES.CHANGE_DIRRECTION then
        
        RandomZombieMove(_zombie)

    end

end

function RandomZombieMove(_zombie)
    local angle = math.angle(_zombie.x,_zombie.y, Random(0, WINDOW_WIDTH), Random(0, WINDOW_HEIGHT))
    _zombie.speedX = _zombie.speed * FPS * math.cos(angle)
    _zombie.speedY = _zombie.speed * FPS * math.sin(angle)
    
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
        _zombie.speedX = _zombie.speed * 2 * FPS * math.cos(angle)
        _zombie.speedY = _zombie.speed * 2 * FPS * math.sin(angle)
    end
end

function ZombieLookForPlayer(_zombie, _entities)
    for i, sprite in ipairs(_entities) do
        if sprite.type == 'human' and sprite.visible == true then
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

function ZombieBiteIcon(_sprite, _randomValue)
    if _sprite.state == ZOMBIES_STATES.BITE then
        local x, y
        x = math.random(-_randomValue, _randomValue)
        y = math.random(-_randomValue, _randomValue)
        love.graphics.draw(ALL_ZOMBIES.SPRITE_BITE,  x + _sprite.target.x - ALL_ZOMBIES.SPRITE_BITE:getWidth()/2, y + _sprite.target.y - 2 )
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


function CreateCharacterSprite(_myList, _spriteType, _spriteImgFile, _numberFrames)
    local newSprite = {}
    newSprite.type = _spriteType
    newSprite.visible = true
    newSprite.life = 100

    -- loading sprite data
    newSprite.images = {}
    newSprite.currentFrame = 1 --default image selected

    for i=1, _numberFrames do
        local PATH_NAME = ASSETS_SOURCE.._spriteImgFile..'_'..tostring(i)..FORMART.png
        newSprite.images[i] = love.graphics.newImage(PATH_NAME)
         --print('Loading frame: '..filename)
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

function UpdateCharacterSprites(_lstSprites, _speedFrame, _dt)
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

function DrawCharacterSprites(_lstSprites)
    for i, sprite in ipairs(_lstSprites) do
        if sprite.visible == true then
            local frame = sprite.images[math.floor(sprite.currentFrame)]
            love.graphics.draw(frame, sprite.x - sprite.width / 2, sprite.y - sprite.height / 2)

            if sprite.type == ALL_ZOMBIES.TYPE then
                StateInfos(sprite)
                ZombieAlertIcon(sprite)
                ZombieBiteIcon(sprite, ALL_ZOMBIES.RANDOM_BITE_POSITION)
            end

        end
    end
end


--[[

███╗   ███╗███████╗███╗   ██╗██╗   ██╗
████╗ ████║██╔════╝████╗  ██║██║   ██║
██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 
]]


local MENU_STATES = {
    NONE = '',
    MAIN = 'main',
    GAME = 'game',
    GAME_OVER = 'game over',
}

CurrentMenu = MENU_STATES.NONE

function CreateMainMenu()
    local FILENAME = 'main_menu'
    local newMainMenu = {}
    newMainMenu.x = 0
    newMainMenu.y = 0

    newMainMenu.image = love.graphics.newImage(ASSETS_SOURCE..FILENAME..FORMART.png)

    newMainMenu.width = newMainMenu.image:getWidth()
    newMainMenu.height = newMainMenu.image:getHeight()

    return newMainMenu
end

function UpdateMenuStates()
    if CurrentMenu == MENU_STATES.NONE then
        CurrentMenu = MENU_STATES.MAIN
    elseif CurrentMenu == MENU_STATES.GAME_OVER then
        -- To do show Game Over
    elseif CurrentMenu == MENU_STATES.GAME then
        -- To do show Game
    elseif CurrentMenu == MENU_STATES.MAIN then
        -- To do show main
    end
end

function DrawMenu(_sprite)
    love.graphics.draw(_sprite.image, _sprite.x, _sprite.y,0, 1/renderScaleXY, 1/renderScaleXY)
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

    if love.keyboard.isDown('left') then
    _player.x = _player.x - _player.speed * _dt
    end
    
    if love.keyboard.isDown('up') then
        _player.y = _player.y - _player.speed * _dt
    end

    if love.keyboard.isDown('right') then
        _player.x = _player.x + _player.speed * _dt
    end

    if love.keyboard.isDown('down') then
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
    local versionInfo = string.format('Version %d.%d.%d - %s', major, minor, revision, codename)
    return versionInfo
end

function StateInfos(_sprite)

    if inputShowZombieStates ~= true then
        do return end
    end

    love.graphics.print(_sprite.state, _sprite.x - 10, _sprite.y - _sprite.height - 10)

end