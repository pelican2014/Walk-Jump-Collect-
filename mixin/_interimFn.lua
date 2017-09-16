local _interimFn = {
  update = function(self,dt)
  love.window.setTitle( 'Walk!Jump!Collect! (FPS:' .. love.timer.getFPS() .. ')' )
    Timer.update(dt)
    for _,v in ipairs(self._table) do
      InterimButtons[v]:update()
    end
  end;
  ------------------------------------
  draw = function(self)
    self._from:draw()
    love.graphics.setColor(255,255,255,0)
    Filters.grey:draw(self.aFactor)
    InterimBox:draw(self.aFactor)
    ---------------------
    for _,v in ipairs(self._table) do
      InterimButtons[v]:draw(self.aFactor)
    end
    love.graphics.setColor(255,255,255,255)
    MouseFn:drawCursor_layer_2()
	self.fadeOut:draw()
  end;
  ------------------------------------
  mousepressed = function(self,_,_,button)
    for _,v in ipairs(self._table) do
      InterimButtons[v]:response(button)
    end
  end;
  ------------------------------------
}

return _interimFn