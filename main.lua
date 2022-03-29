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


local Game = require 'game'


--[[
██╗      ██████╗ ██╗   ██╗███████╗    ███╗   ███╗███████╗████████╗██╗  ██╗ ██████╗ ██████╗ ███████╗
██║     ██╔═══██╗██║   ██║██╔════╝    ████╗ ████║██╔════╝╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗██╔════╝
██║     ██║   ██║██║   ██║█████╗      ██╔████╔██║█████╗     ██║   ███████║██║   ██║██║  ██║███████╗
██║     ██║   ██║╚██╗ ██╔╝██╔══╝      ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║   ██║██║  ██║╚════██║
███████╗╚██████╔╝ ╚████╔╝ ███████╗    ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║╚██████╔╝██████╔╝███████║
╚══════╝ ╚═════╝   ╚═══╝  ╚══════╝    ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
]]


GameState = Game

local inputStart = false

function love.load()

    GameState.load()

end

function love.update(dt)

    if CurrentMenu == MENU_STATES.NONE then
        CurrentMenu = MENU_STATES.MAIN
    elseif CurrentMenu == MENU_STATES.GAME_OVER then
        -- To do show Game Over
    elseif CurrentMenu == MENU_STATES.GAME then
        GameState.update(dt)
    elseif CurrentMenu == MENU_STATES.MAIN then
        -- To do show main
        if inputStart then
            CurrentMenu = MENU_STATES.GAME
        end
    end

end

function love.draw()

    if CurrentMenu == MENU_STATES.NONE then
        CurrentMenu = MENU_STATES.MAIN
    elseif CurrentMenu == MENU_STATES.GAME_OVER then
        --DrawMenu(CreateMenu('game_over_menu'))
    elseif CurrentMenu == MENU_STATES.GAME then
        GameState.draw()
    elseif CurrentMenu == MENU_STATES.MAIN then
        DrawMenu(CreateMenu('main_menu'))
    end

end

function love.keypressed(key)

    local KEY_START_GAME = 'space'
    if key == KEY_START_GAME then
        inputStart = true
    end

    GameState.keypressed(key)
    
end

--[[

███╗   ███╗███████╗███╗   ██╗██╗   ██╗
████╗ ████║██╔════╝████╗  ██║██║   ██║
██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 
]]

MENU_STATES = require 'menuStates'
CurrentMenu = MENU_STATES.NONE

function CreateMenu(_fileName)
    local newMenu = {}
    newMenu.x = 0
    newMenu.y = 0

    newMenu.image = love.graphics.newImage(ASSETS_SOURCE.._fileName..FORMART.png)

    newMenu.width = newMenu.image:getWidth()
    newMenu.height = newMenu.image:getHeight()

    return newMenu
end

function DrawMenu(_sprite)
    love.graphics.draw(_sprite.image, _sprite.x, _sprite.y,0, 1, 1)
end
