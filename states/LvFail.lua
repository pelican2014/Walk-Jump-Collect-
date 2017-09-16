local LvFail = {}
-----------------------------------------------------------------
function LvFail:enter(from)
  self._from = from
  self._table = { 'toLvSelect', 'restart' }
  -------------------------------------------------------
  self.fadeOut = Transition.fadeOut()
  ------------Register functions to Signals----------
  --for emitting functions bound to signals when buttons are pressed
  Signals.register.restart_noPop(self._from)
  Signals.register.toLvSelect_noPop()
  -------------------------------------
  self.aFactor = 0
  Timer.tween( .3, self, { aFactor = 1 }, _, _ )
  
  self.isSwitching = false
  -------------------------------------
  MouseFn:setup_layer_2()
end

function LvFail:keypressed( key )
  if not self.isSwitching then
    if key == ' ' then
	  self.isSwitching = true
      Signal.emit( 'restart' )
    end
  end
end

Class.include( LvFail, Mixin._interimFn )

return LvFail