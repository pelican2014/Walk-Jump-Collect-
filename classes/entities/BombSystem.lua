local BombSystem = {}

local function findIndexByID( _table, _ID )
  for i,v in ipairs(_table) do
    if v.ID == _ID then
	  return i
	end
  end
  return false
end

BombSystem = Class{ init = function( self, x, y )
	local x,y = (x-1) * Map.tileWidth + Map.tileWidth/2, (y-1) * Map.tileHeight + Map.tileHeight/2
    self.struct = Struct( 'x', 'y', 'ID' )
	self.struct_sF = Struct( 'sF', 'ID' )
    self.IDDispenser = 1
    self.bombTable = { self.struct( x, y, self.IDDispenser ) }
	self.detonateTable = {}
	self.explodeTable = {}
	self.half_range = Map.tileWidth * 2
	self.wait_time = .8
	self.explode_time = .2
	self.scaleFactor = {
	  bomb = 1;
	  explosion = {};
	}
	self.bombStrength = 50
  end;
  --define methods
  add = function( self, x, y )
    local x,y = (x-1) * Map.tileWidth + Map.tileWidth/2, (y-1) * Map.tileHeight + Map.tileHeight/2
    self.IDDispenser = self.IDDispenser + 1
    table.insert( self.bombTable, self.struct( x, y, self.IDDispenser ) )
  end;
  update = function( self )
    self:detect()
	if self.scaleFactor.bomb == 1 then
	  Timer.tween( 1, self.scaleFactor, { bomb = .5 }, _, function()
	      Timer.tween( 1, self.scaleFactor, { bomb = 1 } )
		end
	  )
	end
	for _,_explosion in ipairs( self.scaleFactor.explosion ) do
	  Timer.tween( self.explode_time/2, _explosion, { sF = 1 }, 'out-quad', function()
          Timer.tween( self.explode_time/2, _explosion, { sF = 0 }, 'quad' )
		end
	  )
	end
  end;
  detect = function( self )
    local player = Player
	for _, _bomb in ipairs( self.bombTable ) do
	  local _x, _y, _width, _height = _bomb.x-self.half_range, _bomb.y-self.half_range, 2 * self.half_range, 2* self.half_range
	  if _x < player.x + player.width and _x + _width > player.x and _y < player.y + player.height and _y + _height > player.y then
	    table.remove( self.bombTable, findIndexByID( self.bombTable, _bomb.ID ) )
		table.insert( self.detonateTable, self.struct( _bomb.x, _bomb.y, _bomb.ID ) )
	    self:detonate(_bomb.ID)
	  end
	end
  end;
  --[[detect = function( self )		--only function in update()
    if self:aabb() then
	  Timer.add( self.wait_time, function() self:detonate() end )
	end
  end;]]
  detonate = function( self, _ID )
    Timer.add( self.wait_time, function()
	    local _det_bomb_index = findIndexByID( self.detonateTable, _ID )
	    local _det_bomb = self.detonateTable[_det_bomb_index]
	    table.insert( self.explodeTable, self.struct( _det_bomb.x, _det_bomb.y, _ID ) )
		table.insert( self.scaleFactor.explosion, self.struct_sF( 0, _ID ) )
		table.remove( self.detonateTable, _det_bomb_index )
	    Timer.do_for( self.explode_time, function()
		    local _exp_bomb_index = findIndexByID( self.explodeTable, _ID )
		    if _exp_bomb_index then
	          local player = Player
		      local _x, _y, _width, _height = self.explodeTable[_exp_bomb_index].x-self.half_range, self.explodeTable[_exp_bomb_index].y-self.half_range, 2 * self.half_range, 2* self.half_range
		      if _x < player.x + player.width and _x + _width > player.x and _y < player.y + player.height and _y + _height > player.y then
		        Player:hurt(1)
		        local _vec_throw_dir = Vector( (player.x+player.width/2)-(_x+_width/2), (player.y+player.height/2)-(_y+_height/2) )
		        local _push_x, _push_y = _vec_throw_dir:normalize_inplace():unpack()
			    Player:setExtSpeed( self.bombStrength * _push_x, self.bombStrength * _push_y )
		        table.remove( self.explodeTable, _exp_bomb_index )
	            CameraShake:add(15,.3)
		      end
		    end
		  end,
		  --run after explode
		  function()
		    local _exp_bomb_index = findIndexByID( self.explodeTable, _ID )
		    if _exp_bomb_index then
			  table.remove( self.explodeTable, _exp_bomb_index )
	          CameraShake:add(5,.3)
			end
		  end
		)
	  end
	)
  end;
  draw = function( self )
    local player = Player
    for _, _bomb in ipairs( self.bombTable ) do
	  local vec_eye_player = Vector( player.x + player.width/2 - _bomb.x, player.y + player.height/8 - _bomb.y )
	  local _eye_dx, _eye_dy = (3*vec_eye_player:normalize_inplace()):unpack()
	  love.graphics.setColor( 255,255,255,255 )
	  --bomb
	  love.graphics.draw( Images.bomb, _bomb.x, _bomb.y, 0, self.scaleFactor.bomb, self.scaleFactor.bomb, Images.bomb:getWidth()/2, Images.bomb:getHeight()/2 )
	  --eye white
	  love.graphics.circle( 'fill', _bomb.x+1-10*self.scaleFactor.bomb, _bomb.y+2-10*self.scaleFactor.bomb, 10*self.scaleFactor.bomb )
	  love.graphics.circle( 'fill', _bomb.x+1+10*self.scaleFactor.bomb, _bomb.y+2-10*self.scaleFactor.bomb, 10*self.scaleFactor.bomb )
	  love.graphics.setColor(0,0,0,255)
	  --eyeball
	  love.graphics.circle( 'fill', _bomb.x+1-10*self.scaleFactor.bomb+_eye_dx, _bomb.y+2-10*self.scaleFactor.bomb+_eye_dy, 4*self.scaleFactor.bomb )
	  love.graphics.circle( 'fill', _bomb.x+1+10*self.scaleFactor.bomb+_eye_dx, _bomb.y+2-10*self.scaleFactor.bomb+_eye_dy, 4*self.scaleFactor.bomb )
	  love.graphics.setColor( 255,255,255,255 )
	end
	for _, _bomb in ipairs( self.detonateTable ) do
	  local vec_eye_player = Vector( player.x + player.width/2 - _bomb.x, player.y + player.height/8 - _bomb.y )
	  local _eye_dx, _eye_dy = (3*vec_eye_player:normalize_inplace()):unpack()
	  love.graphics.setColor( 255,255,255,255 )
	  love.graphics.draw( Images.bomb_bef_det, _bomb.x, _bomb.y, 0, 1, 1, Images.bomb_bef_det:getWidth()/2, Images.bomb_bef_det:getHeight()/2 )
	  --eye white
	  love.graphics.circle( 'fill', _bomb.x+1-10, _bomb.y+2-10, 10 )
	  love.graphics.circle( 'fill', _bomb.x+1+10, _bomb.y+2-10, 10 )
	  love.graphics.setColor(0,0,0,255)
	  --eyeball
	  love.graphics.circle( 'fill', _bomb.x+1-10+_eye_dx, _bomb.y+2-10+_eye_dy, 4 )
	  love.graphics.circle( 'fill', _bomb.x+1+10+_eye_dx, _bomb.y+2-10+_eye_dy, 4 )
	  love.graphics.setColor( 255,255,255,255 )
	end
	for _, _bomb in ipairs( self.explodeTable ) do
	  --local vec_eye_player = Vector( player.x + player.width/2 - _bomb.x, player.y + player.height/8 - _bomb.y )
	  --local _eye_dx, _eye_dy = (3*vec_eye_player:normalize_inplace()):unpack()
	  local _sF_index = findIndexByID( self.scaleFactor.explosion, _bomb.ID )
	  love.graphics.setColor( 255,255,255,255 )
	  if _sF_index then
	    love.graphics.draw( Images.explosion, _bomb.x, _bomb.y, 0, self.scaleFactor.explosion[_sF_index].sF, self.scaleFactor.explosion[_sF_index].sF, Images.explosion:getWidth()/2, Images.explosion:getHeight()/2 )
	  else
	    table.remove( self.scaleFactor.explosion, i )
	  end
	end
  end;
}

return BombSystem