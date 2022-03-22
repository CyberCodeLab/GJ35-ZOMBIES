-- ███████ ███████ ████████ ██    ██ ██████  
-- ██      ██         ██    ██    ██ ██   ██ 
-- ███████ █████      ██    ██    ██ ██████  
--      ██ ██         ██    ██    ██ ██      
-- ███████ ███████    ██     ██████  ██      
                                          

-- Visual Studio Code debugger tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Switch off buffering mode for an output file.(The result of any output operation appears immediately) | They are two other mode: "full" or "line"
io.stdout:setvbuf('no')

-- Indicate my config
function love.conf(t)

    -- Windows settings
    t.window.title = "ZOMBIES 2022 by CyberCodeLab"
    t.window.icon = "assets/zombie_icon.png"
    t.window.width = 800
    t.window.height = 600
    t.window.resizable = false
    t.window.fullscreen = false
    t.window.vsync  = true
    t.window.minwidth = 800
    t.window.minheight = 600

    -- Log
    t.version = "11.4.0"
    t.console = false

end