local Pause = {}
-----------------------------------------------------------------

function Pause:enter(from)
  self._from = from
  self._table = { 'resume', 'toLvSelect', 'restart' }
  self.isPopping = false
  ------------Register functions to Signals----------
  --for emitting functions bound to signals when buttons are pressed
  Signals.register.restart_pop(self._from)
  Signals.register.resume()
  Signals.register.toLvSelect_pop()
  -------------------------------------
  self.aFactor = 0
  Timer.tween( .3, self, { aFactor = 1 }, _, _ )
  
  self.fadeOut = Transition.fadeOut()
  -------------------------------------
  MouseFn:setup_layer_2()
end

function Pause:keypressed(key)
  if not self.isPopping then
    if key == 'escape' then
      Signal.emit( 'resume' )
    end
  end
end

Class.include( Pause, Mixin._interimFn )

return Pause