local entities_tilestring = [[
__________________________________
\                                /
\                                /
\                                /
\  O                             /
\  v                             /
\ ------------------             /
\                     --   --    /
\                                /
\                                /
\                          --    /
\                                /
\                                /
\   V     VV    VVV      VVVVVVV /
\--------------------------------/
\--------------------------------/
\--------------------------------/
\--------------------------------/
\--------------------------------/
]]

local map_tilestring = [[
iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
i                                i
i                                i
i                                i
i                                i
i             *                  i
i \----------------/             i
i                     \/   \/    i
i                                i
i                                i
i                          \/    i
i                                i
i                                i
i                                i
==================================
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
]]

local Level1 = LevelBluePrint( 1, {3,13}, {3,23}, entities_tilestring, map_tilestring, 'Level2')

function Level1:init_GS()
  Level1:_init_GS()
end

return Level1