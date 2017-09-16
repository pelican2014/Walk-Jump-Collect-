local StopWatch = {}

StopWatch = Class{ init = function(self)
    local bm = 16 								--bm stands for box_margin which I conveniently use as a unit for drawing
	                                            --bm is in InterimBox module; bm is Map.tileWidth/2
    self.x, self.y = 0, Images.pauseBt:getHeight() + Images.clock:getHeight() + bm
	self.timing = 0
    self.reading  = 0
	self.color = { 255, 0, 0 }
	self.xRightLimit = love.window.getWidth() - Images.clock:getWidth()
--	self.handles = {}
  end;
  --------------------------
  --define method(s)
  initialize = function(self)
      local function reset()
	    local duration = 1.5
	    --[[self.handles( #self.handles + 1 ) =]] Timer.tween( duration, self.color, { 0, 0, 255 }, _, function()
		    --[[self.handles( #self.handles + 1 ) =]] Timer.tween( duration, self.color, { 0, 255, 0 }, _, function()
		        Timer.tween( duration, self.color, { 255, 0, 0 }, _, reset )
		      end
		    )
		  end
		)
	  end
	reset()
	end;
  --------------------------
  update = function(self,dt)
    self.timing = self.timing + dt
	self.reading = math.floor( self.timing * 100 ) / 100
	-----------------------------------------------------
	local width = nil
	if self.reading < 1 then
	  width = Fonts.TCB32:getWidth( tostring(100) .. '.' )			--consider '0.11'
	else
	  width = Fonts.TCB32:getWidth( tostring( self.reading * 100 ) .. '.' ) --consider '12.32'
	end
	self.x = self.xRightLimit - width
  end;
  --------------------------
  resetTiming = function(self)
    self.timing = 0
  end;
  --------------------------
  returnReading = function(self)
    return self.reading
  end;
  --------------------------
  draw = function(self)
    love.graphics.setFont( Fonts.TCB32 )
	love.graphics.setColor(self.color)
    love.graphics.print( self.reading, self.x, self.y, 0, 1, 1, 0, Fonts.TCB32:getHeight() )
	love.graphics.setColor( 255, 255, 255 )
  end;	
}

return StopWatch