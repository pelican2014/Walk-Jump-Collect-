local DoorFn = {}

DoorFn = Class{
  load = function(self)
    local tilesetWidth, tilesetHeight = Images.door_tileset:getWidth(), Images.door_tileset:getHeight()
    local tileWidth,tileHeight = 32,64
    self.activated_door = love.graphics.newQuad( 0 , 0 , tileWidth, tileHeight, tilesetWidth, tilesetHeight )
    self.grey_door      = love.graphics.newQuad( 32, 0 , tileWidth, tileHeight, tilesetWidth, tilesetHeight )
  end;
  --------------------------above should not be invoked---------------------------------
  --------------------------------------------------------------------------------------
  init = function(self)
    local OCo = nil
	local tiletable = Entities.tiletable
    ------------------------------record door positions---------------------------------
      for columnIndex,column in ipairs(tiletable) do
        for rowIndex, character in ipairs(column) do
	      if     character == 'O' then OCo = {columnIndex,rowIndex} break end
	    --OCo records coordinates of the doors in tables
	    end
      end
    ----------------------------------------------
    self.OCo = OCo
    self.isRegenerated = false
  end;
  ---------------------------------------
  --define method(s)
  eliminate = function(self)
    local tiletable = Entities.tiletable
  --eliminate the door so as to prevent player from entering the next stage before door is regenerated
    tiletable[ self.OCo[1] ][ self.OCo[2]     ] = ' '
    tiletable[ self.OCo[1] ][ self.OCo[2] + 1 ] = ' '
	return tiletable
  end;
  ---------------------------------------
  regenerate = function(self)
    local tiletable = Entities.tiletable
    tiletable[ self.OCo[1] ][ self.OCo[2]     ] = 'O'
    tiletable[ self.OCo[1] ][ self.OCo[2] + 1 ] = 'v'
    self.isRegenerated = true
    Entities.tiletable = tiletable
  end;
  ---------------------------------------
  lvPassed = function()	-- t -> RefTransP
    local player = Player
	local tiletable = Entities.tiletable
    local x,y = player.gridX,player.gridY
    if tiletable[x][y  ] == 'O'
    or tiletable[x][y+1] == 'O'
    or tiletable[x][y-1] == 'O' then
      Gamestate.switch(LvPass)
    end
  end;
  ---------------------------------------
  draw = function(self)
    love.graphics.setColor( 255,255,255,255 )
    if self.isRegenerated == false then
	  local gridWidth,gridHeight = 32,32
	  local x,y = (self.OCo[1] -1) * gridWidth, (self.OCo[2]-1) * gridHeight
      love.graphics.draw( Images.door_tileset, self.grey_door, x,y )
    elseif self.isRegenerated == true then
	  local gridWidth,gridHeight = 32,32
	  local x,y = (self.OCo[1] -1) * gridWidth, (self.OCo[2]-1) * gridHeight
      love.graphics.draw( Images.door_tileset, self.activated_door, x,y )
    end
	--[[for _,v in ipairs(self.OCo) do
	  local gridWidth,gridHeight = 32,32
	  local x,y = (v[1] -1) * gridWidth, (v[2]-1) * gridHeight
	  love.graphics.setLineWidth(7)
	  love.graphics.setColor( 255,255,255,200 )
      love.graphics.circle('fill', x+8,y+20, 14 )
      love.graphics.setColor( Colors.fleshYellow )
	  love.graphics.circle('line', x+8,y+20, 14 )
      love.graphics.setColor( 255,255,255,200 )
      love.graphics.circle('fill', x+gridWidth-8,y+20, 14 )
      love.graphics.setColor( Colors.fleshYellow )
      love.graphics.circle('line', x+gridWidth-8,y+20, 14 )
	  -----------------------------------------------------
      love.graphics.setColor( 0,0,0,180 )
	  love.graphics.circle('fill', x+8,y+20, 6 )
      love.graphics.circle('fill', x+gridWidth-8,y+20, 6 )
	end
	love.graphics.setLineWidth(1)
    love.graphics.setColor( 255,255,255,255 )]]
  end
}

return DoorFn