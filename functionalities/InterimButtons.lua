local InterimButtons = {}

function InterimButtons:load()
  local wW,wH = love.window.getWidth(),love.window.getHeight()
  local radius = Map.tileWidth * 2
  local bty, bby = InterimBox.y, InterimBox.bottomY
  local blx, brx = InterimBox.x, InterimBox.rightX
  -- box top y; box bottom y; box left x; box right x; (InterimBox)
  local bm = InterimBox.margin
  local btCl, txCl = {0,0,0,50}, {0,0,0,255}
  ------------------------------------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------------------------------------
  local function func()
    --Timer.tween( .3, Pause, { aFactor = 0 }, _,_)
    Signal.emit( 'resume' )
  end
  self.resume = CircleButton( brx - bm - radius , bby - bm - radius , radius , Fonts.TCB32, func, 'Resume', btCl , txCl );
  ------------------------------------------------------------------------------------------------------------------
  local function func()
    Signal.emit( 'toLvSelect' )
  end
  self.toLvSelect = CircleButton( wW / 2 , bby - bm - radius , radius , Fonts.TCB32, func, 'Select\nLevels'  , btCl , txCl );
  ------------------------------------------------------------------------------------------------------------------
  local function func()
	Signal.emit( 'restart' )
  end
  self.restart = CircleButton( blx + bm + radius , bby - bm - radius , radius , Fonts.TCB32, func, 'Restart'  , btCl , txCl );
  ------------------------------------------------------------------------------------------------------------------
  local function func()
	Signal.emit( 'toNextLv' )
  end
  self.toNextLv = CircleButton( brx - bm - radius , bby - bm - radius , radius , Fonts.TCB32, func, 'Next\nLevel'  , btCl , txCl );
end

return InterimButtons