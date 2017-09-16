local NumThrow = {}

NumThrow._pre = nil
---------------------------
NumThrow.duration = 0.6
---------------------------
---------------------------
NumThrow.allNumTable = {}
---------------------------
---------------------------
local function structNum( NumTable, dNum )
  local camPx, camPy = Camera:cameraCoords(Player.x, Player.y)
  -------------------------------------------------------------
  local struct = { 'scale', 'angle', 'x', 'y', 'color', 'alpha', 'dNum' }
  local defaultValue = { 1, math.pi/6, camPx, camPy, { 0, 0, 255 }, 0, dNum }
  for i,key in ipairs(struct) do
    NumTable[key] = defaultValue[i]
  end
  return NumTable
end
---------------------------
local function addNum( allNumTable, dNo )
  table.insert( allNumTable, {} )
  allNumTable[#allNumTable] = structNum( allNumTable[#allNumTable], dNo )
  return allNumTable
end

local function removeNum( allNumTable )
  table.remove( allNumTable, 1 )
  return allNumTable
end
---------------------------

function NumThrow:update()
    if self._pre then
      if self._pre ~= Diamond.num then
		  self.allNumTable = addNum( self.allNumTable, Diamond.num )
		  Timer.add( self.duration, function() self.allNumTable = removeNum( self.allNumTable ) end )
		  ----------------------------------------------------------------------------------------------------
		  local _num = self.allNumTable[#self.allNumTable]
	      Timer.tween( self.duration   , _num, { x = Map.tileWidth * 2 } )
		  Timer.tween( self.duration/2 , _num, { y = love.window.getHeight()   /2 } , 'out-quad', function() 
		      Timer.tween( self.duration/2, _num, { y = Map.tileHeight * 2 } , 'quad' )
		    end
		  )
		  Timer.tween( self.duration/2 , _num, { scale = 1.8 }, _, function()
		      Timer.tween( self.duration/2, _num, { scale = 0.4 } )
		    end
		  )
		  Timer.tween( self.duration, _num, { angle = 0 }, _ )
		  Timer.tween( self.duration/2, _num, { alpha = 130 }, 'out-quad', function()
		      Timer.tween( self.duration/2, _num, { alpha = 0 }, 'quad' )
		    end
		  )
		  Timer.tween( self.duration/2, _num.color, { 0, 0, 255 }, _, function()
		      Timer.tween( self.duration/2, _num.color, { 255, 0, 0 } )
		    end
		  )
		  ----------------------------------------------------------------------------------------------------
	  end
    end
  if Diamond.num <= 1 then
    self._pre = nil
  else
    self._pre = Diamond.num
  end
end

function NumThrow:draw()
    for _,num in ipairs(self.allNumTable) do
      love.graphics.setFont( Fonts.TCM144 )
      love.graphics.setColor( num.color[1], num.color[2], num.color[3] , num.alpha )
      love.graphics.print( num.dNum, num.x, num.y, num.angle, num.scale, num.scale,
                           Fonts.TCM144:getWidth( tostring( num.dNo ) ) / 2 , Fonts.TCM144:getHeight() / 2 )
      love.graphics.setColor( 255, 255, 255, 255)
	end
end

function NumThrow:reset()
  self._pre = nil
end

return NumThrow