local LvSelect = {}
local lw = love.window
local _table = {}
local btMenu = nil
------------------------------------------
local function _insert_table( lvNum, _skin_name, func )
  local x = (lvNum - 1) % 8
  local y = math.floor( (lvNum - 1) / 8 )
  local func = func or function()
    RectButton.isAllDisabled = true
    LvSelect.isEscDisabled = true
    LvSelect.fadeOut:tween(.3)
    Timer.add(.3, function() Gamestate.switch( _G[ 'Level' .. tostring(lvNum)] ); RectButton.isAllDisabled = false end )
  end
  table.insert( _table, RectButton( lw.getWidth() * ( ( 2 + x ) /11 ) , lw.getHeight() * ( ( .85 + y ) /4 ) , Fonts.TCB32 , func , 'center' , tostring(lvNum) ,_,_,64,64,_skin_name) )
end

local function addLevel( currentLv )
  _table = {}
  if Slib.isFirstSave( 'star' ) then
    for lvNum = 1,currentLv do
    --local x = lvNum - 1
--    local y = 0
--    while x >= 8 do
--      x = x - 8
--	  y = y + 1
--    end
      _insert_table( lvNum, 'lv_0star' )
    end
  else
    local Stable = Slib:load( 'star' )
    for lvNum = 1,currentLv do
	  _insert_table( lvNum, 'lv_' .. tostring( Stable[lvNum] ) .. 'star' )
	end
  end
end
------------------------------------------
------------------------------------------
------------------------------------------
function LvSelect:init_GS()
  local function func()
    RectButton.isAllDisabled = true
    Gamestate.current().isEscDisabled = true		--will be set to false at enter stage
    self.fadeOut:tween(.3)
    Timer.add(.3, function() Gamestate.switch( Menu ); RectButton.isAllDisabled = false end )
  end
  btMenu = RectButton( 0,0 , Fonts.TCB32 , func , 'left' , 'Menu' ,Colors.lightBlue)
end

function LvSelect:enter()
  self.shownMaxLv = 1
  if Slib.isFirstSave( 'currentLv' ) then
    addLevel( 1 )
  else
    local table = Slib:load( 'currentLv' )
    addLevel( table.currentLv )
	self.shownMaxLv = table.currentLv
  end
  ---------add locked levels--------------
  if self.shownMaxLv < MaxLvNum then
    for lvNum = self.shownMaxLv+1,MaxLvNum do
      _insert_table( lvNum, 'lv_locked', function() end )
	end
  end
  ----------------------------------------
  self.fadeIn = Transition.fadeIn()
  self.fadeIn:tween(.3)
  self.fadeOut = Transition.fadeOut()
  self.isEscDisabled = false
  
  if Slib.isFirstSave( 'OCD' ) then
    self.OCDTb = {}
	for i = 1, MaxLvNum do
	  self.OCDTb[i] = false
	end
  else
    self.OCDTb = Slib:load( 'OCD' )
  end
end


function LvSelect:update(dt)
  love.window.setTitle( 'Walk!Jump!Collect! (FPS:' .. love.timer.getFPS() .. ')' )
  for _,v in ipairs(_table) do
    v:update()
  end
  btMenu:update()
  Timer.update(dt)
end

function LvSelect:draw()
  for lvNum,v in ipairs(_table) do
    v:draw()
    if self.OCDTb[lvNum] then
      local lw = love.window
      local x = (lvNum - 1) % 8
      local y = math.floor( (lvNum - 1) / 8 )
	  love.graphics.draw( Images.OCD_small , lw.getWidth() * ( ( 2 + x ) /11 ) - Images.OCD_small:getWidth()/2 , lw.getHeight() * ( ( .85 + y ) /4 ) - Images.OCD_small:getHeight()/2 - 30 )
	end
  end
  btMenu:draw()
  MouseFn:drawCursor()
  self.fadeIn:draw()
  self.fadeOut:draw()
end

function LvSelect:keypressed( key )
  if not self.isEscDisabled then
    if key == 'escape' then
      RectButton.isAllDisabled = true
      Gamestate.current().isEscDisabled = true
      self.fadeOut:tween(.3)
      Timer.add(.3, function() Gamestate.switch( Menu ); RectButton.isAllDisabled = false end )
    end
  end
end

function LvSelect:mousepressed(_,_,button)
  for _,v in ipairs(_table) do
    v:response(button)
  end
  btMenu:response(button)
end

return LvSelect