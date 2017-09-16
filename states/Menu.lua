local Menu ={}
------------------------------------------
local lw = love.window
local _table = nil

function Menu:init_GS()
  Signal.emit( 'play_background_music' )

  local func = function()
    RectButton.isAllDisabled = true
    Gamestate.current().isEscDisabled = true
    self.fadeOut:tween(.3)
    Timer.add(.3, function() Gamestate.switch(LvSelect); RectButton.isAllDisabled = false end )
  end
  local btLvSelect        = RectButton(lw.getWidth()/2, lw.getHeight() * 3/6, Fonts.TCB32,func,'center','Start',Colors.lightBlue)
  ------------------------------------------------------------------------------------------------------------------------------
  local func = function()
    RectButton.isAllDisabled = true
    Gamestate.current().isEscDisabled = true
    self.fadeOut:tween(.3)
    Timer.add(.3, function() Gamestate.switch(Instructions); RectButton.isAllDisabled = false end )
  end
  local btInstructions = RectButton(lw.getWidth()/2, lw.getHeight() * 4/6, Fonts.TCB32,func,'center','Instructions',Colors.lightBlue)
  ------------------------------------------------------------------------------------------------------------------------------
  local func = function()
    RectButton.isAllDisabled = true
    Gamestate.current().isEscDisabled = true
    self.fadeOut:tween(.3)
    Timer.add(.3, function() love.event.quit() end )
  end
  local btQuit         = RectButton(lw.getWidth()/2, lw.getHeight() * 5/6, Fonts.TCB32,func,'center','Quit',Colors.lightBlue)
  ------------------------------------------------------------------------------------------------------------------------------
  local func = function()
    Gamestate.push(ResetData)
  end
  local btResetData         = RectButton(lw.getWidth()-128, lw.getHeight() -64, Fonts.TCB32,func,'center','Reset Levels',Colors.lightBlue)
  ------------------------------------------------------------------------------------------------------------------------------
  _table = {btLvSelect,btInstructions,btQuit,btResetData}
end

function Menu:enter()
  self.fadeIn = Transition.fadeIn()
  self.fadeIn:tween(.3)
  self.fadeOut = Transition.fadeOut()
  self.isEscDisabled = false
  MouseFn:setup_layer_1()
end

function Menu:update(dt)
  love.window.setTitle( 'Walk!Jump!Collect! (FPS:' .. love.timer.getFPS() .. ')' )
  for _,v in ipairs(_table) do
    v:update()
  end
  Timer.update(dt)
end

function Menu:draw()
  for _,v in ipairs(_table) do
    v:draw()
  end
  Logo.draw()
  -----------------------------
  MouseFn:drawCursor_layer_1()
  -----------------------------
  self.fadeIn:draw()
  self.fadeOut:draw()
end

function Menu:keypressed(key)
  if not self.isEscDisabled then
    if key == 'escape' then
      RectButton.isAllDisabled = true
      Gamestate.current().isEscDisabled = true
      self.fadeOut:tween(.3)
      Timer.add(.3, function() love.event.quit() end )
    end
  end
end

function Menu:mousepressed(_,_,button)
  for _,v in ipairs(_table) do
    v:response(button)
  end
end

return Menu