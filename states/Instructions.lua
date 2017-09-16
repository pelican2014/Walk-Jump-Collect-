local Instructions = {}
local fadeIn = nil
local fadeOut = nil
-------------------------
local lw = love.window
local textboxWidth = 500

function Instructions:init_GS()
  self.textbox = Textbox(Fonts.TCM32,lw.getWidth()/2,lw.getHeight()/2,'center',textboxWidth,'Use ARROWS or A/D/S/W to walk and jump.\nYou need to collect all diamonds to activate the door.\nPress SPACE in front of an activated door to pass the level.')
end

function Instructions:enter()
  fadeIn = Transition.fadeIn()
  fadeIn:tween(0.3)
  fadeOut = Transition.fadeOut()
  self.isClickDisabled = false
  self.isEscDisabled = false
end

function Instructions:update(dt)
  love.window.setTitle( 'Walk!Jump!Collect! (FPS:' .. love.timer.getFPS() .. ')' )
  Timer.update(dt)
end

function Instructions:draw()
  self.textbox:draw(Fonts.TCM32)
  fadeIn:draw()
  fadeOut:draw()
end

function Instructions:mousepressed()
  if not self.isClickDisabled then
    self.isEscDisabled = true
    self.isClickDisabled = true
    fadeOut:tween(.3)
    Timer.add(.3, function() Gamestate.switch(Menu);self.isClickDisabled = false;self.isEscDisabled = true end )
  end
end

function Instructions:keypressed(key)
  if not self.isEscDisabled then
    if key == 'escape' then
      self.isEscDisabled = true
      self.isClickDisabled = true
      fadeOut:tween(.3)
      Timer.add(.3, function() Gamestate.switch(Menu);self.isClickDisabled = false;self.isEscDisabled = true end )
	end
  end
end

return Instructions