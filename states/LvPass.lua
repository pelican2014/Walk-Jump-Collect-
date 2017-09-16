local LvPass = {}
-----------------------------------------------------------------

function LvPass:enter(from)
  self._from = from
  self._table = { 'toNextLv', 'toLvSelect', 'restart' }
  ---------------------------------------------------
  self.fadeOut = Transition.fadeOut()
  ------------Register functions to Signals----------
  --for emitting functions bound to signals when buttons are pressed
  Signals.register.toNextLv(from)
  Signals.register.toLvSelect_noPop()
  Signals.register.restart_noPop(from)
  ---------calculate scores---------------
  CalScore:register( Player.life , from.stopWatch:returnReading() )
  CalScore:calculate( from.lvNum )
  LvPassedTween:register()				--register after CalScore calculate
  LvPassedTween:tween()
  -------------------------------------
  self.aFactor = 0
  Timer.tween( .3, self, { aFactor = 1 }, _, _ )
  
  self.isSwitching = false
  -------------------------------------
  -------------------(loading) and saving-------------------
    if Slib.isFirstSave( 'currentLv' ) then
	  if from.lvNum + 1 <= MaxLvNum then
        Slib:save( { currentLv = from.lvNum + 1 }, 'currentLv' )
	  else
        Slib:save( { currentLv = from.lvNum }, 'currentLv' )
	  end
	else
	  local table = Slib:load( 'currentLv' )
	  if from.lvNum + 1 > table.currentLv then
	    if from.lvNum + 1 <= MaxLvNum then
	      Slib:save( { currentLv = from.lvNum + 1 }, 'currentLv' )
		else
	      Slib:save( { currentLv = from.lvNum }, 'currentLv' )
		end
	  end
	end
  ----------------------------------------------------------
  if Slib.isFirstSave( 'star' ) then
    local t = {}
	for index = 1, MaxLvNum do t[index] = 0 end
	t[from.lvNum] = LvPassedTween.star.num
	Slib:save( t, 'star' )
  else
    local t = Slib:load( 'star' )
	if LvPassedTween.star.num > t[from.lvNum] then
	  t[from.lvNum] = LvPassedTween.star.num
	  Slib:save( t, 'star' )
	end
  end
  
  if Slib.isFirstSave( 'OCD' ) then
    local t = {}
	for index = 1, MaxLvNum do t[index] = false end
	t[from.lvNum] = LvPassedTween.isOCD
	Slib:save( t, 'OCD' )
  else
    local t = Slib:load( 'OCD' )
	if LvPassedTween.isOCD then t[from.lvNum] = LvPassedTween.isOCD end
	Slib:save( t, 'OCD' )
  end
  -------------------------------------
  MouseFn:setup_layer_2()
end

function LvPass:draw()
  self._from:draw()
  Filters.grey:draw(self.aFactor)
  InterimBox:draw(self.aFactor)
  Icons.lvPassed.draw()
  LvPassedTween:draw()
  ---------------------
  for _,v in ipairs(self._table) do
    InterimButtons[v]:draw(self.aFactor)
  end
  MouseFn:drawCursor_layer_2()
  self.fadeOut:draw()
end

function LvPass:keypressed( key )
  if not self.isSwitching then
    if key == ' ' then
	  self.isSwitching = true
      Signal.emit( 'toNextLv' )
    end
  end
end

Class.include( LvPass, Mixin._interimFn )

return LvPass