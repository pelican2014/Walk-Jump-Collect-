local PreTC = {}

function PreTC.oneSq(x,y,...)
  local tiletable = Entities.tiletable
  ------------------------------------
    for _,v in ipairs{...} do
        if tiletable[x  ][y+3] == v then
	      return true
        -------------below------------------------------------------------------------------------------------
        elseif tiletable[x-1][y+3] == v and Player.incrementX < 0
	    and tiletable[x-1][y+2] == ' '
	    and tiletable[x-1][y+1] == ' ' then
	      return true
	    -------------bottom left while left empty-------------------------------------------------------------
        elseif tiletable[x+1][y+3] == v and Player.incrementX > 0
	    and tiletable[x+1][y+2] == ' '
	    and tiletable[x+1][y+1] == ' ' then
	      return true
        --------------bottom right while right empty-----------------------------------------------------------
		end
	end
  return false
end

function PreTC.halfSq(x,y,...)
  local tiletable = Entities.tiletable
  ------------------------------------
    for _,v in ipairs{...} do
        if tiletable[x  ][y+2] == v and Player.incrementY <= 0 then
	      return true
        -------------below------------------------------------------------------------------------------------
        elseif tiletable[x-1][y+2] == v and Player.incrementY <= 0 and Player.incrementX < 0
	    and tiletable[x-1][y+1] == ' '
	    and tiletable[x-1][y  ] == ' ' then
	      return true
	    -------------bottom left while left empty-------------------------------------------------------------
        elseif tiletable[x+1][y+2] == v and Player.incrementY <= 0 and Player.incrementX > 0
	    and tiletable[x+1][y+1] == ' '
	    and tiletable[x+1][y  ] == ' ' then
	      return true
        --------------bottom right while right empty-----------------------------------------------------------
		end
	end
  return false
end

return PreTC