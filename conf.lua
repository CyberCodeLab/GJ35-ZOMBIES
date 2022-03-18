-- ███████ ███████ ████████ ██    ██ ██████  
-- ██      ██         ██    ██    ██ ██   ██ 
-- ███████ █████      ██    ██    ██ ██████  
--      ██ ██         ██    ██    ██ ██      
-- ███████ ███████    ██     ██████  ██      
                                          

-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Switch off buffering mode for an output file.(The result of any output operation appears immediately) | They are two other mode: "full" or "line"
io.stdout:setvbuf("no")

-- Indicate my config
function love.conf(c)
    -- Windows settings
    c.window.title = "ZOMBIES 2022 by CyberCodeLab"
    c.window.width = 1280
    c.window.height = 720
end