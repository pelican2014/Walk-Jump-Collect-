local Logo = {}

function Logo.draw()
  love.graphics.setFont(Fonts.TCB122)
  local margin_hor  = ( love.window.getWidth()      - Fonts.TCB122:getWidth( 'Walk Jump Collect' ) ) / 2
  local margin_vert = ( love.window.getHeight() / 2 - Fonts.TCB122:getHeight()                     ) / 2
  love.graphics.print( 'Walk Jump Collect', margin_hor, margin_vert )
end

return Logo