local Filter = {}

Filter = Class{ init = function(self,color,alpha,toAlpha,duration)		--only color is compulsory 
    self.color = color
    self.alpha = alpha or 0
	self.fromAlpha = alpha or 0
	self.toAlpha = toAlpha or 255
	self.duration = duration or 0
  end;
  --define method(s)
  draw = function(self, _alpha_factor)		--_alpha_factor is for changing of alpha of several components together
    local _a = _alpha_factor or 1
    love.graphics.setColor{ self.color[1], self.color[2], self.color[3] , self.alpha * _a }
    love.graphics.rectangle( 'fill', 0, 0, love.window.getWidth(), love.window.getHeight())
    love.graphics.setColor( 255, 255, 255, 255)
  end;
  blink = function(self)
    Timer.tween( self.duration/2, self, { alpha = self.toAlpha }, _, function()
        Timer.tween( self.duration/2, self, { alpha = self.fromAlpha } )
      end
    )
  end
}

return Filter
