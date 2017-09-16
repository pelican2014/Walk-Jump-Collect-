local LvVA = {}

function LvVA:load()
  self.isTweened = { false, false, false }
  --self.duration = 10
  self.alpha = {
    level1 = 255;
	level2 = 170;
	level8 = 0;
  }
end

function LvVA:draw()
  if Gamestate.current() == Level1 then
    if Level1.doorFn.isRegenerated then
      if not self.isTweened[1] then
        self.isTweened[1] = true
        Timer.tween( 10, self.alpha, {level1 = 0} )
      end
	  
	  if self.alpha.level1 > 0 then
        love.graphics.setColor(245,250,255,self.alpha.level1)
	    love.graphics.setFont( Fonts.TCB32 )
        love.graphics.print( 'Press SPACE in front of the door to complete the level', 25, 130 )
	  end
	end
  elseif Gamestate.current() == Level2 then
    if not self.isTweened[2] then
      self.isTweened[2] = true
      Timer.tween( 10, self.alpha, {level2 = 0} )
    end
    
	if self.alpha.level2 > 0 then
      local wW,wH = love.window.getWidth(), love.window.getHeight()
      local x,y = 1/20 * wW, 1/8 * wH
      local width, height = 9/10 * wW, 3/4 * wH
      local width_div19, height_div9 = width/19, height/9
      love.graphics.setColor(255,255,255,self.alpha.level2)
      love.graphics.setLineWidth( 8 )
      for n = 1,9,2 do
        love.graphics.line( x, y+(n-1)*height_div9, x, y+n*height_div9 )
        love.graphics.line( x+width, y+(n-1)*height_div9, x+width, y+n*height_div9 )
      end
      for n = 1,19,2 do
        love.graphics.line( x+(n-1)*width_div19, y, x+n*width_div19, y )
        love.graphics.line( x+(n-1)*width_div19, y+height, x+n*width_div19, y+height )
      end
	  
      love.graphics.setFont( Fonts.TCM64 )
      love.graphics.print( 'Move your mouse up to see more', 200, 150 )
    
      love.graphics.setColor(255,255,255,255)
      love.graphics.setLineWidth( 1 )
	end
  elseif Gamestate.current() == Level8 then
    local player = Player
	local camera = Camera
    if player.gridY <= 7 then
      if not self.isTweened[3] then
        self.isTweened[3] = true
		self.alpha.level8 = 255
        Timer.tween( 10, self.alpha, {level8 = 0}, 'quad' )
      end
    end
	love.graphics.setFont( Fonts.TCB32 )
	if self.alpha.level8 > 0 then
      love.graphics.setColor(0,0,0,self.alpha.level8)
      love.graphics.print( 'Huh, harmless little creatures.. or are they?', 52-(camera.x-love.window.getWidth()/2) , 150-(camera.y-love.window.getHeight()/2)  )
	end
    love.graphics.setColor(0,232,232,255)
	love.graphics.print( 'Ascend from the left', 1050 -(camera.x-love.window.getWidth()/2) , 31*30-(camera.y-love.window.getHeight()/2) )
  end
end

return LvVA