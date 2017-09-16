local CalScore = {}

function CalScore:load()
  self.scoreTb = {
    life = 250;
	timeDif = 40;		--I plan to leave 60s between best time and slowest time. Thus largest dif would be 2400 pts
  }
  self.inputTb = {
    life = nil;
	reading = nil;
  }
  self.lifeScore = nil
  self.totScore = nil
  self.OCDScore = nil
end

function CalScore:register(life,reading)
  self.inputTb.life = life
  self.inputTb.reading = reading
end

function CalScore:calculate(lvNum)
  local st,it = self.scoreTb, self.inputTb
  local blTime = ScoreData.lvs[lvNum].blTime		--gets ScoreData deep table values
  self.OCDScore = ScoreData.lvs[lvNum].OCDScore
  local timeDif = nil
  if it.reading < blTime then
    timeDif = blTime - it.reading
  else
    timeDif = 0
  end
  self.lifeScore = st.life * ( it.life - 1 )
  self.totScore = math.floor( self.lifeScore + st.timeDif * timeDif )
end

--[[function CalScore:draw()
  local wW, wH = love.window.getWidth(), love.window.getHeight()
  local textW, textH = Fonts.TCM144:getWidth( self.totScore ), Fonts.TCM144:getHeight()
  -------------------------------------------------------------------------------------
  local bty, bby = InterimBox.y, InterimBox.bottomY
  local blx, brx = InterimBox.x, InterimBox.rightX
  -- box top y; box bottom y; box left x; box right x; (InterimBox)
  local bm = InterimBox.margin
  -------------------------------------------------------------------------------------
  love.graphics.setFont( Fonts.TCM144 )
  love.graphics.setColor( 255, 255, 255, 255 )
  love.graphics.print( self.totScore, brx - bm , wH/2 + 2 * bm , 0, 1, 1, textW, textH/2 )
  --love.graphics.setColor
end]]

return CalScore