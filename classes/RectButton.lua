local RectButton = {}

RectButton = Class{
  isAllDisabled = false;
  ----------------------
  init = function(self,x,y,font,func,position,text,buttonColor,textColor,specified_w, specified_h, skin) -- text,buttonColor,textColor,specified w and h are optional
    local function __NULL__() end
    --------------------------------
    local horSpace,vertSpace = 32,16
    -------------------------------- 
    local rectWidth,rectHeight  = font:getWidth(text) + horSpace, font:getHeight() + vertSpace
    -------------------------------------------
    if     position == 'left'   then x,y = x,y
    elseif position == 'center' then x,y = x - rectWidth/2, y - rectHeight/2
    elseif position == 'right'  then x,y = x - rectWidth  , y               end
    -------------------------------------------------------------------------
    local textX,textY = x + horSpace/2 , y + vertSpace/2
    self.x = x
	self.y = y
	self.textX = textX
	self.textY = textY
	self.rectWidth = specified_w or rectWidth
	self.rectHeight = specified_h or rectHeight
	self.func = func or __NULL__
	self.text = text or ' '
	self.buttonColor = buttonColor or {255,255,255}
	self.textColor   = textColor   or {0,0,0}
	self.font = font
	self.skin = skin
	self._fadeOut = _fadeOut
	----------------
	--self.isDisabled = false
  end;
  -------------------------------------
  --define method(s)
  draw = function(self)
    if self.skin then
      love.graphics.setColor(255,255,255,255)
	  love.graphics.draw( Images[self.skin],self.x,self.y )
	else
	  --------draw rounded rectangles 1---------
      love.graphics.setColor(Colors.deepBlue)
      love.graphics.rectangle('fill',self.x,self.y+self.rectHeight/10,self.rectWidth,self.rectHeight*4/5)
	  love.graphics.rectangle('fill',self.x+self.rectHeight/10,self.y,self.rectWidth-self.rectHeight/5,self.rectHeight)
	  love.graphics.circle(   'fill',self.x+self.rectHeight/10,self.y+self.rectHeight/10,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectHeight/10,self.y+self.rectHeight*9/10,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectWidth-self.rectHeight/10,self.y+self.rectHeight/10,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectWidth-self.rectHeight/10,self.y+self.rectHeight*9/10,self.rectHeight/10)
	  --------draw rounded rectangles 2---------
	  love.graphics.setColor(self.buttonColor)
	  local margin = 8
      love.graphics.rectangle('fill',self.x+margin,self.y+self.rectHeight/10+margin,self.rectWidth-2*margin,self.rectHeight*4/5-2*margin)
	  love.graphics.rectangle('fill',self.x+self.rectHeight/10+margin,self.y+margin,self.rectWidth-self.rectHeight/5-2*margin,self.rectHeight-2*margin)
	  love.graphics.circle(   'fill',self.x+self.rectHeight/10+margin,self.y+self.rectHeight/10+margin,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectHeight/10+margin,self.y+self.rectHeight*9/10-margin,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectWidth-self.rectHeight/10-margin,self.y+self.rectHeight/10+margin,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectWidth-self.rectHeight/10-margin,self.y+self.rectHeight*9/10-margin,self.rectHeight/10)
	end
    --------------------------------------
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(self.text,self.textX,self.textY,self.rectWidth)
	-------------------------------------
    love.graphics.setColor(255,255,255,255)
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
          self.func(self)
        end
      end
	end
  end;
  -------------------------------------
  isHovering = function(self)
    local x,y = love.mouse.getPosition()
    if x > self.x and x < self.x + self.rectWidth and y > self.y and y < self.y + self.rectHeight then
      return true
    end
  end;
  -------------------------------------
  --[[disable = function(self)
    self.isDisabled = true
  end;
  -------------------------------------
  enable = function(self)
    self.isDisabled = false
  end;]]
}

return RectButton