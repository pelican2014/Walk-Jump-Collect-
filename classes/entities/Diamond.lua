local Diamond = {}

Diamond = Class{
  init = function(self,tiletable)
    local number = 0
    local coordTable = {}
    for columnIndex,column in ipairs(tiletable) do
      for rowIndex,character in ipairs(column) do
        if character == 'V' then
	      number = number + 1
	      table.insert( coordTable, { columnIndex, rowIndex } )
		end
      end
    end
    ------------------------------------------
    self.number = number
    self.coordTable = coordTable
  end;
  --define method(s)
  ---------------------------------------not intended to be invoked by the object------------------------------------
  load = function(self)
    local g = anim8.newGrid( 32, 32, Images.diamond_anim:getWidth(), Images.diamond_anim:getHeight(),0,0,1 )
    self.anim = anim8.newAnimation( g('1-4','1-2') , 0.1 )
  end;
  ------------------------------------------
  update = function(self,dt)
    self.anim:update(dt)
  end;
  ------------------------------------------
  eliminate = function(tiletable)
  --eliminate diamonds when local diamond in each level has been set to nil( after door is regenerated)
    for columnIndex,column in ipairs(tiletable) do
	  for rowIndex, character in ipairs(column) do
	    if character == 'V' then tiletable[columnIndex][rowIndex] = ' ' end
	  end
	end
	return tiletable
  end;
  -------------------------------------------------------------------------------------------------------------------
  collision = function(self,tiletable)
    local player = Player
    local x,y = player.gridX, player.gridY
    local tiletable = tiletable
    for dummyY = y, y+1, 1 do
      if tiletable[x][dummyY] == 'V' then
        tiletable[x][dummyY] = ' '
        self.number = self.number -1
  	  -----------delete from coordTable--------
	    for i,v in ipairs(self.coordTable) do		--traverse the table to find the door coordinates where the player is
	      if x == v[1] and dummyY == v[2] then
	        table.remove(self.coordTable,i)
	      end
        end
	  Signal.emit('diamondCollect')
	  ------------------------------------------
      end
    end
    return tiletable
  end;
  ------------------------------------------
  returnNum = function(self)
    return self.number
  end;
  ------------------------------------------
  draw = function(self)
    for _,v in ipairs(self.coordTable) do
      self.anim:draw( Images.diamond_anim, (v[1]-1) * gridWidth, (v[2]-1) * gridHeight )
    end
  end
}

Diamond:include( Mixin._num )

return Diamond