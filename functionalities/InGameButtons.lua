local InGameButtons = {}
InGameButtons.buttons = {}

function InGameButtons:load()
  local wW,wH = love.window.getWidth(),love.window.getHeight()
  ------------------------------------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------------------------------------
  local function func()
    Gamestate.push( Pause )
  end
  local r = 30
  self.buttons.pauseBt = CircleButton( wW - r , r , r , _, func, _, _, _, true )
end

function InGameButtons:update()
  for _,_button in pairs( self.buttons ) do
    _button:update()
  end
end

--[[function InGameButtons:draw()
  for _,button in ipairs( self.buttons ) do
    button:draw()
  end
end]]

function InGameButtons:response(button)
  for _,_button in pairs( self.buttons ) do
    _button:response(button)
  end
end

return InGameButtons