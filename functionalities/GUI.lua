local GUI = {}

function GUI:load()
  --self.diamondNum = nil
end

function GUI.update()
  InGameButtons:update()
end

function GUI:draw()			--NOTE:this function uses a lot of global vars directly inside itself
  local lg = love.graphics
  local player = Player
  ---------------------------------------
  Player:drawLife()
  ---------------------------------------
  Icons.inGame.draw()
  ---------------------TO be removed-------------------
  lg.setFont( Fonts.AC32 )
  --lg.print(player.gridX .. ', ' .. player.gridY, 10,100)
  --lg.print( 'FPS = ' .. love.timer.getFPS(), 10, 110 )
  ---------------------TO be changed-------------------
  if type(Diamond.num) == 'number' then
    if Diamond.num == 0 then
      lg.setFont( Fonts.TCM32 )
	  lg.setColor{ 0, 0, 255, 100 }
      lg.print( 'Finished!', 18, 50 )
    else
      lg.setFont( Fonts.TCM64 )
      lg.print(Diamond.num, 35,50)
    end
    lg.setColor(255,255,255,255)
  end
end

function GUI.response( button )
  InGameButtons:response(button)
end

return GUI