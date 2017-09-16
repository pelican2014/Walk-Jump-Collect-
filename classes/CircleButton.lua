local CircleButton = Class{
  isAllDisabled = false;
  init = function( self, x, y, radius, font, func, text, buttonColor, textColor, isHide ) -- text,buttonColor,textColor,isHide are optional
    self.x           = x
	self.y           = y
	self.radius      = radius
	self.font        = font
	self.func        = func
	self.text        = text or ''
	self.buttonColor = buttonColor or {255,255,255,255}
	self.textColor   = textColor   or {0,0,0,255}
	self.isHide      = isHide
  end;
  --define method(s)
  -------------------------------------
  draw = function(self,_alpha_factor)
    local _a = _alpha_factor or 1
	local _btC = self.buttonColor
	local _txC = self.textColor
    if not self.isHide then
	  love.graphics.setColor(_btC[1],_btC[2],_btC[3],_btC[4]*_a)
	  love.graphics.circle( 'fill', self.x, self.y, self.radius )
	  ------------------------------------
      love.graphics.setColor(_txC[1],_txC[2],_txC[3],_txC[4]*_a)
      love.graphics.setFont(self.font)
	  local textWidth  = self.font:getWidth( self.text )
	  local lines = 1
	  for _ in self.text:gmatch('\n') do
	    lines = lines + 1
	  end
	  local textHeight = self.font:getHeight() * lines
	  love.graphics.print( self.text , self.x , self.y , _ , _ , _ , textWidth / 2 , textHeight / 2 )
	  love.graphics.setColor(255,255,255,255)
	end
  end;
  -------------------------------------
  update = function(self)
    if self:isHovering() then
      MouseFn:toHand()
    end
  end;
  -------------------------------------
  response = function(self,button)
    if not self.isAllDisabled then
      local x,y = love.mouse.getPosition()
      if button == 'l' then
        if self:isHovering() then
          self.func()
        end
      end
	end
  end;
  -------------------------------------
  isHovering = function(self)
    local x,y = love.mouse.getPosition()
    if TestCircle.isIn( x, y, self.x, self.y, self.radius * 2 ) then
      return true
    end
  end;
}

return CircleButton