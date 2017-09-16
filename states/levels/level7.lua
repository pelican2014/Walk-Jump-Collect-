local entities_tilestring = [[
_________________________________________________________________________________
\                                                                               /
\                                                                               /
\                                                                               /
\                                                                               /
\                                                                               /
\                                                                               /
\                                                                               /
\                                                                               /
\                       ---   ---                                               /
\                      ~~                                                       /
\            ---                                                                /
\                   VVV              V                                          /
\                   ---             ---                                         /
\           V                           V                                       /
\       ---  VV                                                                 /
\             V                         V-                                      /
\             V                                                                 /
\                                       V                                       /
\           ---        **          ---   **                                     /
\            ~         II         ~     VII                                     /
\                      II                II  --                                 /
\           V          II               VII                              O      /
\       ---  V         II       ---      II                              v      /
\             V        II               VII--                          -----    /
\                      II                II                                     /
\                      II               VII                                     /
\            ---       II           ---  II  --                                 /
\                      II               VIIV                                    /
\                      II              VVIIVV                                   /
\                      II             VVVIIVVV     !!        !!      m          /
\----------------------**----------------**---------------------------          /
\---------------------------------------------------------------------          /
\---------------------------------------------------------------------          /
\---------------------------------------------------------------------^^^^^^^^^^/
\---------------------------------------------------------------------^^^^^^^^^^/
]]

local map_tilestring = [[
iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
i                                                                               i
i                                                                               i
i                                                                               i
i                                                                               i
i                                                                               i
i                                                                               i
i                                                                               i
i                                                                               i
i                       \-/   \-/                                               i
i                      ~~                                                       i
i            \-/                                                                i
i                                                                               i
i                   \-/             \-/                                         i
i                                                                               i
i       \-/                                                                     i
i                                        i                                      i
i                                                                               i
i                                                                               i
i           \-/        so          \-/   so                                     i
i            ~         al         ~      al                                     i
i                      al                al  \/                                 i
i                      al                al                                     i
i       \-/            al       \-/      al                                     i
i                      al                al\/           we             \---/    i
i                      al                al             __                      i
i                      al                al                                     i
i            \-/       al           \-/  al  \/                                 i
i                      al                al                                     i
i                      al                al                                     i
i                      al                al        !!        !!      m          i
=======================xk================xk===========================          =
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$          $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$          $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
]]

local laserData = {
                     { 25,21,'medium',true, math.pi };
                     { 58,26,'short',true, math.pi };
					}

local Level7 = LevelBluePrint( 7, {3,30}, {3,28}, entities_tilestring, map_tilestring, 'Level8', laserData )

function Level7:init_GS()
  Level7:_init_GS()
end

return Level7