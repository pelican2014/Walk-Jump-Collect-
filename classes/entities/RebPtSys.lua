local RebPtSys = Class{ init = function(self)	--instantiated atenter stage
    local tiletable = Entities.tiletable
    local _reb_t = {}
    ------------------------------record reborn pts positions---------------------------------
      for columnIndex,column in ipairs(tiletable) do
        for rowIndex, character in ipairs(column) do
	      if     character == '@' then
		    _reb_t[#_reb_t+1] = {columnIndex,rowIndex}
		  end
	    end
      end
    ----------------------------------------------
	self.reb_table = _reb_t
	self.actv_rbPt = nil
	self.alpha = 0
  end;
  --define methods
  checkNRet = function(self)
    local player = Player
    for _, _rebPt in ipairs(self.reb_table) do
      local x,y = player.gridX,player.gridY
      if x == _rebPt[1] and y == _rebPt[2]
      or x == _rebPt[1] and y+1 == _rebPt[2]
      or x == _rebPt[1] and y-1 == _rebPt[2] then
	    if not self.actv_rbPt or self.actv_rbPt[1] ~= _rebPt[1] or self.actv_rbPt[2] ~= _rebPt[2] then
	      self.actv_rbPt = _rebPt
		  self.alpha = 0
		  Timer.tween( .2, self, {alpha = 255} )
	      return _rebPt
		end
	  end
	end
	return false
  end;
  draw = function(self)
    love.graphics.setColor(255,255,255,255)
    for _, _rebPt in ipairs(self.reb_table) do
	  local x,y = (_rebPt[1]-1)*Map.tileWidth, (_rebPt[2]-1)*Map.tileHeight
	  love.graphics.draw( Images.rbpt_inacvt, x, y )
	end
	if self.actv_rbPt then
      love.graphics.setColor(255,255,255,self.alpha)
	  local x,y = (self.actv_rbPt[1]-1)*Map.tileWidth, (self.actv_rbPt[2]-1)*Map.tileHeight
	  love.graphics.draw( Images.rbpt_acvt, x, y )
	end
    love.graphics.setColor(255,255,255,255)
  end;
}

return RebPtSys