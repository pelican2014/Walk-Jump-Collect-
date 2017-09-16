local LaserSystem = {}

LaserSystem = Class{ init = function(self,x,y,type,isRotate,rate)
  --deployed at level:enter() stage
  --rate is how many radians rotated per second
    -------------------
    local x,y = (x-1) * Map.tileWidth, (y-1) * Map.tileHeight
    local function func() Player:hurt(1) end
    local i = ImpHC(func,x,y,type,isRotate,rate)
    ---------------------
    self.i = i
  end;
  -----------------------------
  --define method(s)
  add = function(self,x,y,type,isRotate,rate)  --add more after :new(...)
    local x,y = (x-1) * Map.tileWidth, (y-1) * Map.tileHeight
    self.i:add(x,y,type,isRotate,rate)
  end;
  -----------------------------
  update = function(self,dt)
    self.i:update(dt)
  end;
  -----------------------------
  draw = function(self)
    self.i:draw()
  end
}

return LaserSystem