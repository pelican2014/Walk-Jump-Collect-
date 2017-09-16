local MouseFn = {}

MouseFn.isArrow = true
---------------------------
function MouseFn:toHand()
  self.isArrow = false
end

function MouseFn:toArrow()
  self.isArrow = true
end

function MouseFn:drawCursor()
  love.graphics.setColor( 255,255,255,255 )
  if self.isArrow then
    love.graphics.draw( Images.cursor_arrow, love.mouse.getX(), love.mouse.getY() )
  else
    local finger_pixelPos = 6
    love.graphics.draw( Images.cursor_hand, love.mouse.getX() - finger_pixelPos, love.mouse.getY() )
  end
  self:toArrow()
end

----------------------------------------------------------
--As such drawCursor() may be invoked twice in one frame
--but the one that has been set up will effect
function MouseFn:register_layer_1()
  Signal.register( 'drawCursor_layer_1', function() self:drawCursor() end )
end

function MouseFn:clear_layer_1()
  Signal.clear( 'drawCursor_layer_1' )
end

function MouseFn:register_layer_2()
  Signal.register( 'drawCursor_layer_2', function() self:drawCursor() end )
end

function MouseFn:clear_layer_2()
  Signal.clear( 'drawCursor_layer_2' )
end
-----------------------------------------------------------
function MouseFn:setup_layer_1()
  self:clear_layer_2()
  self:register_layer_1()
end

function MouseFn:setup_layer_2()
  self:clear_layer_1()
  self:register_layer_2()
end
-----------------------------------------------------------
function MouseFn:drawCursor_layer_1()
  Signal.emit( 'drawCursor_layer_1' )
end

function MouseFn:drawCursor_layer_2()
  Signal.emit( 'drawCursor_layer_2' )
end

return MouseFn