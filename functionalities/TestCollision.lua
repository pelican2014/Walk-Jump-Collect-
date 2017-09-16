local TestCollision = {}

function TestCollision.up(x,y,tiletable,...)
  ------------------------------------
  for _,v in ipairs{...} do
      if tiletable[x  ][y-1] == v and Player.incrementY <= 0 then
	    return true
      ------------------------------------------------------------------------------------------------------
      elseif tiletable[x-1][y-1] == v and Player.incrementY <= 0 and Player.incrementX < 0 
	  --player in the grid on the right of colliding block but still under the block
	  and tiletable[x-1][y  ] == ' ' then
	 --the grid on the player's left is empty -->overlapping issues
	    return true
	  ------------------------------------------------------------------------------------------------------
      elseif tiletable[x+1][y-1] == v and Player.incrementY <= 0 and Player.incrementX > 0
	  and tiletable[x+1][y  ] == ' ' then
	    return true
	  end
  end
  return false
end

function TestCollision.down(x,y,tiletable,...)
  --if Player.yVel >= 0 then		--upward movement is not disrupted by downward collision
    for _,v in ipairs{...} do
        if tiletable[x  ][y+2] == v and Player.incrementY >= 0 then
	      return true
        -------------below------------------------------------------------------------------------------------
        elseif tiletable[x-1][y+2] == v and Player.incrementY >= 0 and Player.incrementX < 0
	    and tiletable[x-1][y+1] == ' '
	    and tiletable[x-1][y  ] == ' ' then
	      return true
	    -------------bottom left while left empty-------------------------------------------------------------
        elseif tiletable[x+1][y+2] == v and Player.incrementY >= 0 and Player.incrementX > 0
	    and tiletable[x+1][y+1] == ' '
	    and tiletable[x+1][y  ] == ' ' then
	      return true
        --------------bottom right while right empty-----------------------------------------------------------
		end
	end
  --end
  return false
end

function TestCollision.left(x,y,tiletable,...)
  for _,v in ipairs{...} do
      if tiletable[x-1][y  ] == v and Player.incrementX <= 0 then
	      return true
	  elseif tiletable[x-1][y+1] == v and Player.incrementX <= 0 then
	      return true
      ------------------------------------------------------------------------------------------------------
      elseif tiletable[x-1][y-1] == v and Player.incrementX <= 0 and Player.incrementY < 0
	  and tiletable[x  ][y-1] == ' ' then
	      return true
	  ------------------------------------------------------------------------------------------------------
      elseif tiletable[x-1][y+2] == v and Player.incrementX <= 0 and Player.incrementY > 0
	  and tiletable[x  ][y+2] == ' ' then
	      return true
	  end
  end
  return false
end

function TestCollision.right(x,y,tiletable,...)
  for _,v in ipairs{...} do
      if tiletable[x+1][y  ] == v and Player.incrementX >= 0 then
	      return true
	  elseif tiletable[x+1][y+1] == v and Player.incrementX >= 0 then
	      return true
      ------------------------------------------------------------------------------------------------------
      elseif tiletable[x+1][y-1] == v and Player.incrementX >= 0 and Player.incrementY < 0
	  and tiletable[x  ][y-1] == ' ' then
	      return true
	  ------------------------------------------------------------------------------------------------------
      elseif tiletable[x+1][y+2] == v and Player.incrementX >= 0 and Player.incrementY > 0
	  and tiletable[x  ][y+2] == ' ' then
	      return true
	 end
  end
  return false
end

function TestCollision.center(x,y,tiletable,...)
  for _,v in ipairs{...} do
    if tiletable[x][y] == v or tiletable[x][y+1] == v
	then return true end
  end
  return false
end

setmetatable (TestCollision, {__call = function(self,...)
                                         if self.up(...) or self.down(...) or self.left(...) or self.right(...) or self.center(...) then
							               return true
							             end
									   end
							 } )

return TestCollision