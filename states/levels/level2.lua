local entities_tilestring = [[
__________________________________
\                                /
\                                /
\                                /
\                                /
\                                /
\                              O /
\                              v /
\  --  ------------------------- /
\                                /
\                                /
\                                /
\  -     VVV                     /
\                                /
\                                /
\         !                      /
\ ------------------             /
\                     --   --    /
\                                /
\                                /
\            VV            --    /
\              V                 /
\                                /
\                                /
\----------*    *----------------/
\----------I    I----------------/
\----------I    I----------------/
\-----------^^^^-----------------/
\--------------------------------/
]]

local map_tilestring = [[
iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
i                                i
i                                i
i                                i
i                                i
i                                i
i                                i
i                                i
i  \/  \-----------------------/ i
i                                i
i                                i
i                                i
i  i                             i
i                                i
i                                i
i         !   *                  i
i \----------------/             i
i                     \/   \/    i
i                                i
i                                i
i                          \/    i
i                                i
i                                i
i                                i
============    ==================
$$$$$$$$$$$$    $$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$    $$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$    $$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
]]

local Level2 = LevelBluePrint( 2, {3,23}, {3,32}, entities_tilestring, map_tilestring, 'Level3' )

function Level2:init_GS()
  Level2:_init_GS()
end

return Level2