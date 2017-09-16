local LevelBluePrint = Class{ init = function(self, lvNum, rbPt, trsfPt, entities_tilestring, map_tilestring, toLevel, laserData, bombData)
-- laserSystem is supposed to be a table of table(s)
	self.lvNum = lvNum
    self.diamond = {}
	self.doorFn = {}
	self.fadeIn = Transition.fadeIn()
	self.rebornPt = rbPt
	self.ori_rebornPt = rbPt
	self.rebPtSys = nil
	self.transferPt = trsfPt
	self.entities_tilestring = entities_tilestring
	self.tiletableHeight = 0
	self.map_tilestring      = map_tilestring
	self.toLevel = toLevel
	self.stopWatch = StopWatch()
	self.laserData = laserData
	self.laserSystem = nil
	self.bombData = bombData
	self.bombSystem = nil
  end;
  --define method(s)
  _init_GS = function(self)
    self.stopWatch:initialize()
  end;
  enter = function(self)
	Player:massReset()
	self.rebornPt = self.ori_rebornPt
	Player:reborn(self.rebornPt)
    self.stopWatch:resetTiming()
	NumThrow:reset()
    Entities.tiletable = TiletableFn.renew(self.entities_tilestring)
	self.tiletableHeight = ( #Entities.tiletable[1] - 1 ) * 32
	self.diamond = Diamond(Entities.tiletable)
	-------------------------------------
	self.rebPtSys = RebPtSys()	--after entities.tiletable
    self.doorFn = DoorFn(Entities.tiletable)
	Entities.tiletable = self.doorFn:eliminate(Entities.tiletable)
	if self.laserData then 
	  self.laserSystem = LaserSystem( unpack( self.laserData[1] ) )
	  if #self.laserData >= 2 then
	    for i = 2, #self.laserData do
		  self.laserSystem:add( unpack( self.laserData[i] ) )
		end
	  end
	end
	if self.bombData then
	  self.bombSystem = BombSystem( unpack( self.bombData[1] ) )
	  if #self.bombData >= 2 then
	    for i = 2, #self.bombData do
		  self.bombSystem:add( unpack( self.bombData[i] ) )
		end
	  end
	end
    Map.tiletable = TiletableFn.renew(self.map_tilestring)
	MouseFn:setup_layer_1()
	self.fadeIn = Transition.fadeIn()
	self.fadeIn:tween(.3)
  end;
  ---------------------------------------------------
  ---------------------------------------------------
  update = function(self,dt)
    dt = 1/60
    love.window.setTitle( 'Walk!Jump!Collect! (FPS:' .. love.timer.getFPS() .. ')' )
    DrawBackground:update(dt)
	Player:update_PS(dt)
	local __rbPt = self.rebPtSys:checkNRet()
	if __rbPt then self.rebornPt = __rbPt end
	---------------------------------------------------
    self.stopWatch:update(dt)
    Timer.update(dt)
    Player:update_horMove(dt,Entities.tiletable)
    Player:update_vertMove(dt,Entities.tiletable,Timer)
    Player:update_anim(dt)
    Player:update_miscellaneous(dt,self.rebornPt)
    Diamond:update(dt)
    Entities(self.rebornPt,Entities.tiletable)
	CameraShake:shakeIt()
	CameraMov:update(dt)
	Map:updateSB() -- after CameraMov:update
    Entities.tiletable = self.diamond:collision(Entities.tiletable)
    Diamond.num = self.diamond:returnNum()
	if self.diamond:returnNum() == 0 then
	  self.doorFn:regenerate()
	end
	DoorVA:update(self.doorFn)
    FinishCollecting:update()	--after diamond return num
	GUI.update()				--after diamond return num
	NumThrow:update()		-- MUST be after updating of Diamond.num
	----------------------
	if self.laserSystem then
	  self.laserSystem:update(dt)
	end
	if self.bombSystem then
	  self.bombSystem:update()
	end
  end;
  ---------------------------------------------------
  ---------------------------------------------------
  draw = function(self)
    DrawBackground:draw(self.tiletableHeight)
    Camera:attach()
	  Map:draw()
	  if self.diamond then self.diamond:draw() end
	  if self.doorFn  then self.doorFn:draw() end
	  self.rebPtSys:draw()
	  if self.laserSystem then self.laserSystem:draw() end
	  if self.bombSystem then self.bombSystem:draw() end
    Camera:detach()
	DoorVA:draw()
	LvVA:draw()
    Camera:attach()
	  Player:drawPS()
      Player:draw(Entities.tiletable)
    Camera:detach()
    GUI:draw()
    MouseFn:drawCursor_layer_1()
    NumThrow:draw()
    Filters.red:draw()
	self.stopWatch:draw()
	self.fadeIn:draw()
  end;
  ---------------------------------------------------
  ---------------------------------------------------
  keypressed = function(self,key)
    local player = Player
    if player.isMoveable then
      if key == 'up' or key == 'w' then
        Player:jump()
	  end
    end
	if key == ' ' then
      self.doorFn.lvPassed()
	end
	----------------------------------------------------------------
	if key == 'escape' then
	  Gamestate.push( Pause )
	end
  end;
  ---------------------------------------------------
  ---------------------------------------------------
  mousepressed = function(self,_,_,button)
    GUI.response( button )
  end;
  ---------------------------------------------------
  ---------------------------------------------------
  --[[leave = function(self)
  end]]
}

return LevelBluePrint