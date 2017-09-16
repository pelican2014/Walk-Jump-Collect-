local LvPassedTween = {}

function LvPassedTween:load()
  self.life         = nil		--registered		--printed
  self.reading      = nil		--registered		--printed
  self.printedScore = 0			--not registered	--printed
  -----------------------
  self.lifeScore    = nil		--registered		--not printed
  self.totScore     = nil		--registered		--not printed
  ------tweening vars----
  self.delay    = 0.2
  self.duration = 0.2
  self.interval = 0.1
  self.isOCD    = false
  self.color        = {
    life         = { 255, 255, 255, 255};
	reading      = { 255, 255, 255, 255};
	printedScore = { 255, 255, 255, 255};
  }
  self.star = {
    num = 0;
	shown_num = 0;
    scaleFactors = {
	  A = 1;
	  B = 1;
	  C = 1;
	};
    to_scaleFactors = {
	  A = 1.5;
	  B = 1.8;
	  C = 2.1;
	};
	half_time = .1;
  }
  self.OCD = {
    alpha = 0;
	scaleFactor = 1;
	toScaleFactor = 2.1;
  }
end

function LvPassedTween:reset()
  self.printedScore = 0
  self.star.shown_num = 0
  self.isOCD    = false
  self.OCD.alpha = 0
end

function LvPassedTween:register()
  local calScore = CalScore
  self:reset()
  self.life      = calScore.inputTb.life
  self.reading   = calScore.inputTb.reading
  self.lifeScore = calScore.lifeScore
  self.totScore  = calScore.totScore
  self.star.num  = math.floor(self.totScore+.5) < 3000 and math.floor(self.totScore/1000) or 3
  self.isOCD     = self.totScore >= calScore.OCDScore and true or false
end

function LvPassedTween:tween()
  local star_tween_method_a = nil
  local star_tween_method_b = nil
  local OCD_tween_method_a = 'out-expo'
  local OCD_tween_method_b = 'expo'
  
  if self.isOCD then
    Signal.emit( 'OCD_sound' )
    Timer.tween( self.duration*3, self.OCD, {alpha = 255}, OCD_tween_method_a, function()
        Timer.tween( self.duration*3, self.OCD, {scaleFactor = self.OCD.toScaleFactor}, OCD_tween_method_a, function()
		    Timer.tween( self.duration*3, self.OCD, {scaleFactor = 1}, OCD_tween_method_b )
		  end
		)
	  end
	)
  end
  
  Timer.add( self.delay, function()
      Timer.tween( self.duration, self, { life = 0 } )
	  Timer.tween( self.duration, self, { printedScore = self.lifeScore }, _, function()
	      Timer.add( self.interval, function()
		      Timer.tween( self.duration, self, { reading = 0 } )
			  Timer.tween( self.duration, self, { printedScore = self.totScore }, _, function()
                  Timer.add( self.interval, function()
				      if self.star.num >= 1 then
					    Signal.emit('star1_sound')
					    self.star.shown_num = 1
				        Timer.tween( self.star.half_time, self.star.scaleFactors, { A = self.star.to_scaleFactors.A }, star_tween_method_a, function()
					        Timer.tween( self.star.half_time, self.star.scaleFactors, { A = 1 }, star_tween_method_b, function()
                                if self.star.num >= 2 then
								  Signal.emit('star2_sound')
								  self.star.shown_num = 2
								  Timer.tween( self.star.half_time, self.star.scaleFactors, { B = self.star.to_scaleFactors.B }, star_tween_method_a, function()
								      Timer.tween( self.star.half_time, self.star.scaleFactors, { B = 1 }, star_tween_method_b, function()
									      if self.star.num == 3 then
										    Signal.emit('star3_sound')
										    self.star.shown_num = 3
										    Timer.tween( self.star.half_time, self.star.scaleFactors, { C = self.star.to_scaleFactors.C }, star_tween_method_a, function()
											    Timer.tween( self.star.half_time, self.star.scaleFactors, { C = 1 } )
											  end
											)
										  end
										end
									  )
								    end
								  )
								end
							  end
							)
						  end
					    )
					  end
					end
				  )
				end
			  )
			end
		  )
	    end
	  )
	end
  )
end

function LvPassedTween:draw()
  local wW, wH = love.window.getWidth(), love.window.getHeight()
  local bty, bby = InterimBox.y, InterimBox.bottomY
  local blx, brx = InterimBox.x, InterimBox.rightX
  -- box top y; box bottom y; box left x; box right x; (InterimBox)
  local bm = InterimBox.margin
  ----------------------------------------------------------------------------
  local life = math.floor( self.life + .5 )
  love.graphics.setFont( Fonts.TCM64 )
  love.graphics.setColor( self.color.life )
  love.graphics.print( life      , blx + bm + 128, wH / 2 - 5 * bm )
  ----------------------------------------------------------------------------
  local reading = math.floor( self.reading * 100 + .5 ) / 100
  love.graphics.setColor( self.color.reading )
  love.graphics.print( reading   , blx + bm + 128, wH / 2          )
  ----------------------------------------------------------------------------
  local printedScore = math.floor( self.printedScore + .5 )
  local textW, textH = Fonts.TCM144:getWidth( printedScore ), Fonts.TCM144:getHeight()
  love.graphics.setFont( Fonts.TCM144 )
  love.graphics.setColor( self.color.printedScore )
  love.graphics.print( printedScore , brx - bm , wH/2 , 0, 1, 1, textW, textH/2 )
  ----------------------------------------------------------------------------
  love.graphics.setColor( 255, 255, 255, 255)
  local star_w, star_h = Images.star:getWidth(), Images.star_dent:getHeight()
  local star_x, star_y = wW/2 + bm * (-1) + star_w * (-1), bty + bm + star_h/2
  if self.star.shown_num >= 1 then
    love.graphics.draw( Images.star, star_x, star_y, 0, self.star.scaleFactors.A, self.star.scaleFactors.A, star_w/2, star_h/2 )
  end
  star_x = star_x + bm + star_w
  if self.star.shown_num >= 2 then
	love.graphics.draw( Images.star, star_x, star_y, 0, self.star.scaleFactors.B, self.star.scaleFactors.B, star_w/2, star_h/2 )
  end
  star_x = star_x + bm + star_w
  if self.star.shown_num == 3 then
	love.graphics.draw( Images.star, star_x, star_y, 0, self.star.scaleFactors.C, self.star.scaleFactors.C, star_w/2, star_h/2 )
  end
  love.graphics.setColor( 255,255,255,self.OCD.alpha)
  if self.isOCD then
    love.graphics.draw( Images.OCD_large, blx, bty,0,self.OCD.scaleFactor,self.OCD.scaleFactor)
  end
  ----------------------------------------------------------------------------
  love.graphics.setColor( 255, 255, 255, 255)
end

return LvPassedTween