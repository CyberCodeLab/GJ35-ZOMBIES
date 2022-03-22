--[[
███████╗███╗   ██╗██╗   ██╗███╗   ███╗    ███████╗████████╗ █████╗ ████████╗███████╗███████╗
██╔════╝████╗  ██║██║   ██║████╗ ████║    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██╔════╝██╔════╝
█████╗  ██╔██╗ ██║██║   ██║██╔████╔██║    ███████╗   ██║   ███████║   ██║   █████╗  ███████╗
██╔══╝  ██║╚██╗██║██║   ██║██║╚██╔╝██║    ╚════██║   ██║   ██╔══██║   ██║   ██╔══╝  ╚════██║
███████╗██║ ╚████║╚██████╔╝██║ ╚═╝ ██║    ███████║   ██║   ██║  ██║   ██║   ███████╗███████║
╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝
]]

local ZOMBIES_STATES = {}

ZOMBIES_STATES = {}
ZOMBIES_STATES.NONE = ""
ZOMBIES_STATES.WALK = "walk" -- it walking around
ZOMBIES_STATES.ATTACK = "track" -- it tracking the target
ZOMBIES_STATES.BITE = "attack" -- it bite its targets
ZOMBIES_STATES.CHANGE_DIRRECTION = "change" -- it follow a random path

return ZOMBIES_STATES