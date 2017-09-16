local Transition = {}

Transition.fadeIn = Class{ init = function(self) self.alpha = 255 end;
  -------------------------------------
  --define method(s)
  tween = function(self,t,method,func)
    local method = method or 'out-quad'
	local func = func or function() end
    Timer.tween( t, self, { alpha = 0 }, method, func() )
  end;
  -------------------------------------
  draw = function(self)
    love.graphics.setColor( 0, 0, 0, self.alpha )
    love.graphics.rectangle( 'fill', 0, 0, love.window.getWidth(), love.window.getHeight() )
    love.graphics.setColor( 255, 255, 255, 255 )
  end
}
-------------------------------------------------------------------------------------------------------------------
Transition.fadeOut = Class{ init = function(self) self.alpha = 0 end;
-------------------------------------
  tween = function(self,t,method,func)
    local method = method or 'quad'
	local func = func or function() end
    Timer.tween( t, self, { alpha = 255 }, method, func() )
  end;
  -------------------------------------
  draw = function(self)
    love.graphics.setColor( 0, 0, 0, self.alpha )
    love.graphics.rectangle( 'fill', 0, 0, love.window.getWidth(), love.window.getHeight() )
    love.graphics.setColor( 255, 255, 255, 255 )
  end
}

return Transition