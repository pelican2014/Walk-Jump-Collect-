local Icons = {}
--------------------------------------------------------------------
Icons.inGame = {}

function Icons.inGame.draw()
  local wW = love.window.getWidth()
  local bm = InterimBox.margin
  love.graphics.draw( Images.pauseBt , wW - Images.pauseBt:getWidth(), 0 )
  love.graphics.draw( Images.clock   , wW - Images.clock:getWidth()  , Images.pauseBt:getHeight() + bm )
end
--------------------------------------------------------------------
--------------------------------------------------------------------
Icons.lvPassed = {}

function Icons.lvPassed.draw()
  local wW, wH = love.window.getWidth(), love.window.getHeight()
  local bty, bby = InterimBox.y, InterimBox.bottomY
  local blx, brx = InterimBox.x, InterimBox.rightX
  -- box top y; box bottom y; box left x; box right x; (InterimBox)
  local bm = InterimBox.margin
  love.graphics.draw( Images.clock , blx + bm, wH / 2          )
  love.graphics.draw( Images.life  , blx + bm, wH / 2 - 5 * bm )
  for n = -1, 1 do
    local star_w, star_h = Images.star_dent:getWidth(), Images.star_dent:getHeight()
    love.graphics.draw( Images.star_dent, wW/2 - star_w/2 + bm * n + star_w * n, bty + bm )
  end
end
--------------------------------------------------------------------
return Icons