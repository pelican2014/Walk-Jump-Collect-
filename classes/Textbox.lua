local Textbox = {}

Textbox = Class{ init = function(self,font,x,y,position,width,text,boxColor,textColor)	--x,y,position,boxColor,textColor are optional
    local horspace,vertspace = 32, 16
    local width,lines = font:getWrap(text,width)
    local width,lines = font:getWrap(text,width)		--2nd parameter takes the value of actual width obtained from above. This returns the no. of lines when wrapping the text with actual width returned
    local height = font:getHeight() * lines
    local rectWidth,rectHeight = width + horspace, height + vertspace
    local x,y = x or 0, y or 0
    if     position == 'center' then x,y = x - rectWidth/2, y - rectHeight/2
    elseif position == 'right'  then x,y = x - rectWidth  , y                end
    ------------
    self.text = text
    self.textWidth = width
    self.rectWidth = rectWidth
    self.rectHeight = rectHeight
    self.x = x
    self.y = y
    self.textX = x + horspace/2
    self.textY = y + vertspace/2
    self.boxColor = boxColor or {255,255,255}
    self.textColor = textColor or {0,0,0}
  end;
  -------------------------------------
  --define method(s)
  draw = function(self,font)
    local lg = love.graphics
    --lg.setColor(self.boxColor)
    --lg.rectangle('fill', self.x, self.y, self.rectWidth, self.rectHeight)
	--------draw rounded rectangles 1---------
      love.graphics.setColor(Colors.deepBlue)
      love.graphics.rectangle('fill',self.x,self.y+self.rectHeight/10,self.rectWidth,self.rectHeight*4/5)
	  love.graphics.rectangle('fill',self.x+self.rectHeight/10,self.y,self.rectWidth-self.rectHeight/5,self.rectHeight)
	  love.graphics.circle(   'fill',self.x+self.rectHeight/10,self.y+self.rectHeight/10,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectHeight/10,self.y+self.rectHeight*9/10,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectWidth-self.rectHeight/10,self.y+self.rectHeight/10,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectWidth-self.rectHeight/10,self.y+self.rectHeight*9/10,self.rectHeight/10)
	  --------draw rounded rectangles 2---------
	  love.graphics.setColor(self.boxColor)
	  local margin = 8
      love.graphics.rectangle('fill',self.x+margin,self.y+self.rectHeight/10+margin,self.rectWidth-2*margin,self.rectHeight*4/5-2*margin)
	  love.graphics.rectangle('fill',self.x+self.rectHeight/10+margin,self.y+margin,self.rectWidth-self.rectHeight/5-2*margin,self.rectHeight-2*margin)
	  love.graphics.circle(   'fill',self.x+self.rectHeight/10+margin,self.y+self.rectHeight/10+margin,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectHeight/10+margin,self.y+self.rectHeight*9/10-margin,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectWidth-self.rectHeight/10-margin,self.y+self.rectHeight/10+margin,self.rectHeight/10)
	  love.graphics.circle(   'fill',self.x+self.rectWidth-self.rectHeight/10-margin,self.y+self.rectHeight*9/10-margin,self.rectHeight/10)
	--------------------------------------------------------------------------------------------------
	
    lg.setColor(self.textColor)
	lg.setFont(font)
    lg.printf( self.text, self.textX, self.textY, self.textWidth )
    lg.setColor{255,255,255}
  end;
}

return Textbox