local ResetData = {}
local _table = {}

local textboxWidth = 350

function ResetData:init_GS()
  local wW, wH = love.window.getWidth(), love.window.getHeight()
  self.textbox = Textbox(Fonts.TCM32,wW/2,wH/2,'center',textboxWidth,'Are you sure that you want to reset all levels?')
  ------------------------------------------------------------------------------------------------------------------------------
  local func = function()
    Slib:save( { currentLv = 1 }, 'currentLv' )
	
    local t = {}
	for index = 1, MaxLvNum do t[index] = 0 end
	Slib:save( t, 'star' )
	
    local t = {}
	for index = 1, MaxLvNum do t[index] = false end
	Slib:save( t, 'OCD' )
	
    MouseFn:setup_layer_1()
	Gamestate.pop()
  end
  local btYes         = RectButton(wW/2-125, wH/2 +100, Fonts.TCM32,func,'center','Yes',Colors.lightBlue)
  ------------------------------------------------------------------------------------------------------------------------------
  local func = function()
    MouseFn:setup_layer_1()
    Gamestate.pop()
  end
  local btNo         = RectButton(wW/2+125, wH/2 +100, Fonts.TCM32,func,'center','No',Colors.lightBlue)
  ------------------------------------------------------------------------------------------------------------------------------
  _table = { btYes, btNo }
end

function ResetData:enter(from)
  self._from = from

  self.aFactor = 1
  self.isClickDisabled = false
  self.isEscDisabled = false
  -------------------------------------
  MouseFn:setup_layer_2()
end

function ResetData:update(dt)
  love.window.setTitle( '行走！跳跃！收集！（帧数：' .. love.timer.getFPS() .. '）' )
  for _,v in ipairs(_table) do
    v:update()
  end
  Timer.update(dt)
end

function ResetData:draw()
  self._from:draw()
  Filters.grey:draw(self.aFactor)
  self.textbox:draw(Fonts.TCM32)
  for _,v in ipairs(_table) do
    v:draw()
  end
  love.graphics.setColor(255,255,255,255)
  MouseFn:drawCursor_layer_2()
end

function ResetData:mousepressed(_,_,button)
  for _,v in ipairs(_table) do
    v:response(button)
  end
end

function ResetData:keypressed(key)
  if key == 'escape' then
    MouseFn:setup_layer_1()
    Gamestate.pop()
  end
end

return ResetData