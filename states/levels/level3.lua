local entities_tilestring = [[
________________________________________________________________________
\                                                                      /
\                                                                      /
\                                                                      /
\  *                                                                *  /
\  I                                                                I  /
\  I                                                                I  /
\  I                              V  V                              I  /
\  I     V                       VVVVVV                       V     I  /
\  I    ---                     VVVVVVVV                     ---    I  /
\  I            --               VVVVVV               --            I  /
\  I                   ----       VVVV       ----                   I  /
\  I                               VV                               I  /
\  I            --              --------              --            I  /
\  I  V                                                          V  I  /
\  I ---                                                        --- I  /
\  I                                                                I  /
\  I                -                              -                I  /
\  I                                                                I  /
\  I                                                                I  /
\  I     V                                                    V     I  /
\  I    ---  ---   ---   ---   *        *   ---   ---   ---  ---    I  /
\  I                           I   --   I                           I  /
\  I                           I        I                           I  /
\  I!!!!!!!!!!!!!!!!!!!!!!!!!!!I        I!!!!!!!!!!!!!!!!!!!!!!!!!!!I  /
\  *===========================*        *===========================*  /
\                                  --                                  /
\                                                                      /
\                                   O                                  /
\                                   v                                  /
\                             *----------*                             /
\                             I----------I                             /
\                             I----------I                             /
\----------------------------------------------------------------------/
\----------------------------------------------------------------------/
\----------------------------------------------------------------------/
\----------------------------------------------------------------------/
\----------------------------------------------------------------------/
]]

local map_tilestring = [[
iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
i                                                                      i
i                                                                      i
i                                                                      i
i  p                                                                q  i
i  l                                                                a  i
i  l                                                                a  i
i  l                                                                a  i
i  l                                                                a  i
i  l    \-/                                                  \-/    a  i
i  l            \/                                    \/            a  i
i  l                   \--/                  \--/                   a  i
i  l                                                                a  i
i  l            \/              \------/              \/            a  i
i  l                                                                a  i
i  l \-/                                                        \-/ a  i
i  l                                                                a  i
i  l                i                              i                a  i
i  l                                                                a  i
i  l                                                                a  i
i  l                                                                a  i
i  l    \-/  \-/   \-/   \-/   q        p   \-/   \-/   \-/  \-/    a  i
i  l                           a   \/   l                           a  i
i  l                           a        l                           a  i
i  l!!!!!!!!!!!!!!!!!!!!!!!!!!!a        l!!!!!!!!!!!!!!!!!!!!!!!!!!!a  i
i  ,---------------------------z        ,---------------------------z  i
i                                  \/                                  i
i                                                                      i
i                                                                      i
i                                                                      i
i                             s==========o                             i
i                             a$$$$$$$$$$l                             i
i                             a$$$$$$$$$$l                             i
==============================x$$$$$$$$$$k==============================
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
]]

local Level3 = LevelBluePrint( 3, {3,32}, {3,16}, entities_tilestring, map_tilestring, 'Level4' )

function Level3:init_GS()
  Level3:_init_GS()
end

return Level3