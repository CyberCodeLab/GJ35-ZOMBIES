--[[
███████ ███    ██ ███████ ███    ███ ██    ██ 
██      ████   ██ ██      ████  ████  ██  ██  
█████   ██ ██  ██ █████   ██ ████ ██   ████   
██      ██  ██ ██ ██      ██  ██  ██    ██    
███████ ██   ████ ███████ ██      ██    ██    
]]

local enemy ={}
enemy.posX = 0
enemy.posY = 0
enemy.size = 16
enemy.speed = 200
enemy.img = love.graphics.newImage("assets/zombie_icon.png")

return enemy