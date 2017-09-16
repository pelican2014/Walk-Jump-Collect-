local ImpHC = {}		--imp->implement

ImpHC = Class{ init = function(self, func , rayX, rayY, type, isRotate, rate )
    --func is the function to be executed when player collides with rectangle
    local rate = rate or 0
    --------------------
    local player = Player
    local function on_collision(dt, shape_a, shape_b)
    end

    local function collision_stop(dt, shape_a, shape_b)
      func()
    end

    local player_width,player_height = 32,64
    ---------------------------------------------------
    local collider = HC(100,on_collision,collision_stop)
    -----------------------------------------------------
    local angle = 0
    -------------------------------
    local width,thickness = nil,nil
    if     type == 'short'  then width,thickness =  (8)  * Map.tileWidth , 10
    elseif type == 'medium' then width,thickness =  (22) * Map.tileWidth , 10
    elseif type == 'long'   then width,thickness =  (40) * Map.tileWidth , 10 end
	rayX,rayY = rayX - width/2, rayY-thickness/2
    --------------------------------------------------------------------
    local laserRays = {}
    table.insert(laserRays, {collider:addRectangle( rayX, rayY, width, thickness), rayX, rayY, width,
                             thickness, type, angle, isRotate, rate } )
    --laserRays[1][1] = laser_1; laserRays[1][2] = rayX; laserRays[1][3] = rayY; laserRays[1][4] = width;
    --laserRays[1][5] = thickness; laserRays[1][6] = type; laserRays[1][7] = angle; laserRays[1][8] = isRotate
    --laserRays[9] = rate
    collider:setPassive(laserRays[#laserRays][1])
    --------------------------------------------------------------------------------------
    local pRect = collider:addRectangle( player.x, player.y, player_width, player_height )
    --------------------------------------------------------------------------------------
    self.collider = collider
	self.laserRays = laserRays
	self.pRect    = pRect
  end;
  --------------------------------
  --define method(s)
  add = function(self,rayX, rayY, type, isRotate, rate)
    local angle = 0
    -------------------------------
    local width,thickness = nil,nil
    if     type == 'short'  then width,thickness =  (8)  * Map.tileWidth , 10
    elseif type == 'medium' then width,thickness =  (22) * Map.tileWidth , 10
    elseif type == 'long'   then width,thickness =  (40) * Map.tileWidth , 10 end
	rayX,rayY = rayX - width/2, rayY-thickness/2
    --------------------------------------------------------------------
    table.insert(self.laserRays, { self.collider:addRectangle( rayX, rayY, width, thickness), rayX, rayY, width,
                             thickness, type, angle, isRotate, rate } )
    self.collider:setPassive(self.laserRays[#self.laserRays][1])
  end;
  -------------------------------------
  update = function(self,dt)
    local player = Player
    local player_width,player_height = 32,64
    local x,y = player.x + player_width/2 , player.y + player_height/2
    self.pRect:moveTo(x,y)
    ----------------------
    for _,v in ipairs(self.laserRays) do
      if v[8] then
	    v[1]:rotate( v[9] * dt )
	    v[7] = v[7] + v[9] * dt
	    v[7] = v[7] % (math.pi*2)
	  else
	    v[7] = 0
	  end
    end
    ---------------------------------------------
    self.collider:update(dt)
  end;
  ---------------------------------------------
  ---------------------------------------------
  draw = function(self)
    for _,v in ipairs(self.laserRays) do
      local image = nil
      if     v[6] == 'short'  then
        image = Images.laser_short
      elseif v[6] == 'medium' then
        image = Images.laser_medium
      elseif v[6] == 'long'   then
        image = Images.laser_long
      end
	  local half_width, half_thickness = v[4]/2,v[5]/2
      love.graphics.draw( image,      v[2] + half_width , v[3] + half_thickness, v[7], 1 , 1 , half_width,              half_thickness )
	  love.graphics.draw( Images.hazardSign, v[2] + half_width , v[3] + half_thickness, v[7], 1 , 1 , Images.hazardSign:getWidth()/2, Images.hazardSign:getHeight()/2 )
    end
  end
}

return ImpHC