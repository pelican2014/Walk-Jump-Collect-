local Player = {}

function Player:load()
  self.width, self.height = 32, 64
  local g = anim8.newGrid( 32, 64, Images.player:getWidth(), Images.player:getHeight(), 0, 0, 1 )
  local animationWalkingSpeed = 0.25
  self.anim_walking = anim8.newAnimation( g('1-4',1),animationWalkingSpeed)
  self.anim_still   = anim8.newAnimation( g(  1  ,2), 1 )
  self.anim_jump    = anim8.newAnimation( g(  2  ,2), 1 )
  -----------------------------------------
  self.gridX,self.gridY = 2,2			--initial value
  ------------grid to actual--------------
  self.x = (self.gridX - 1)*gridWidth
  self.y = (self.gridY - 1)*gridHeight
  ----------------------------------------
  self.incrementX = 0
  self.incrementY = 0						--initial value / for smooth movement
  ---------------------
  self.xVel = 8							--constant
  self.yVel = 0							--variable
  self.maxyVel = 300
  ---------------------
  self.ext_xSpeed = 0
  self.ext_ySpeed = 0
  self.ext_speed_tween_const = 7
  ---------------------
  self.direction = ''
  ---------------------
  self.life = 5
  self.maxLife = 5
  --self.preLife = 3		--tweening
  self.isInvincible = false
  --self.isFlicker = false
  self.isOnGround = true
  self.isAPBU = true		--APBU stands for above platform before updating
  self.isTime = {			--solve the apparent gamestate-timer incompatible issue
    lvFail = false;
	isTimerSet = false;
  }
  self.isMoveable = true
  self.isMoving = { hor = false; vert = false }
  -------------------------
  self.scaleFactor = 1
  self.angle = 0
  self.color = {255,255,255}
  --Particle System--------
  self.PS = love.graphics.newParticleSystem( Images.trail )
  self.PS:setBufferSize(1000)
  self.PS:setSpread(360)
  self.PS:setSpeed(50)
  self.PS:setParticleLifetime(0.1)
  self.PS:setEmissionRate(1000)
  self.PS:setColors(255,255,255,5)
  ---------------------------------
  self.lifeScaleFactor = {
    life1 = 1;
	life2 = 1;
	life3 = 1;
	life4 = 1;
	life5 = 1;
  }
end

-------------------------------------------------------------------------------------------------------------------
function Player:update_anim(dt)
  if Gamestate:current() ~= Pause then
    self.anim_walking:update(dt)
  end
end
-------------------------
local isInversion = false				--for use in animation drawing
-------------------------------------------------------------------------------------------------------------------
function Player:drawPlayer(anim, isFlip)
  local pWidth,pHeight = 32,64
  if isFlip then anim:flipH() end
    love.graphics.setColor(self.color)
	anim:draw( Images.player, self.x + pWidth/2, self.y + pHeight ,
	           self.angle, self.scaleFactor, self.scaleFactor, pWidth/2, pHeight )
	love.graphics.setColor(255,255,255)
  if isFlip then anim:flipH() end
end

function Player:draw(tiletable)
  local collisionTableDown = {'-',[[\]],'/','I','=','*'}
  love.graphics.setColor(255,255,255)
  --if not self.isFlicker then
    if self.isOnGround then
      if self.direction == 'left' then
        self:drawPlayer(self.anim_walking, true)
		isInversion = true
      elseif self.direction == 'right' then
	    self:drawPlayer(self.anim_walking, false)
		isInversion = false
      else
	    if isInversion == true then
	      self:drawPlayer(self.anim_still, true)
        elseif isInversion == false then
		  self:drawPlayer(self.anim_still, false)
	    end
	  end
    else
      if self.direction == 'left' then
	    self:drawPlayer(self.anim_jump, true)
	    isInversion = true
	  elseif self.direction == 'right' then
	    self:drawPlayer(self.anim_jump, false)
	    isInversion = false
	  else
	    if isInversion == true then
	      self:drawPlayer(self.anim_jump, true)
        elseif isInversion == false then
	      self:drawPlayer(self.anim_jump, false)
	    end
	  end
	end
  --end
end

function Player:drawPS()
  love.graphics.draw(self.PS, 0,0)
end
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-----------------------------------|-PLAYER MOVEMENT-|-------------------------------------------------------------
-----------------------------------v-----------------v-------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

local pFM,pFMmin = 1,1					--pFM = pseudoFuelMeter
local function pFMreset() pFM = pFMmin end
local pFMplummetRate = 6					--referred to during sliding

function Player:update_horMove(dt,tiletable)					--tiletable:Entities_tiletable
  local collisionTableLeft = {[[\]],'I','*'}
  local collisionTableRight = {'/','I','*'}
-------------------------------------------------------------------------------------------------------------------
  if self.isMoveable then
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
      if pFM < pFMmin then pFMreset() end
	  if self.direction == 'right' then pFMreset() end
      if pFM < 1 then pFM = pFM + dt end		--charge pFM
      if not TestCollision.left( self.gridX, self.gridY, tiletable, unpack(collisionTableLeft)) then
        self.incrementX = self.incrementX - (gridWidth * self.xVel * dt) * pFM
	  else
	    self.incrementX = 0
	  end 
	  self.direction = 'left'
	  self.isMoving.hor = true
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
      if pFM < pFMmin then pFMreset() end
	  if self.direction == 'left' then pFMreset() end
      if pFM < 1 then pFM = pFM + dt end		--charge pFM
      if not TestCollision.right( self.gridX, self.gridY, tiletable, unpack(collisionTableRight)) then
        self.incrementX = self.incrementX + (gridWidth * self.xVel * dt) * pFM
	  else
	    self.incrementX = 0
	  end
	  self.direction = 'right'
	  self.isMoving.hor = true
    else
      self.direction = ''
	  self.isMoving.hor = false
------------------------------------------------------------------------------------
    --[[else 									--player sliding or still
      if self.direction == 'left' or love.keyboard.isDown('a') then
	    if pFM > 0.1 then pFM = pFM - dt * pFMplummetRate else pFM = 0; self.direction = '' end
	    if not TestCollision.left( self.gridX, self.gridY, tiletable, unpack(collisionTableLeft)) then
          self.incrementX = self.incrementX - (gridWidth * self.xVel * dt) * pFM
	    else
	      self.incrementX = 0
	    end
	  elseif self.direction == 'right' or love.keyboard.isDown('d') then
	    if pFM > 0.1 then pFM = pFM - dt * pFMplummetRate else pFM = 0; self.direction = '' end
        if not TestCollision.right( self.gridX, self.gridY, tiletable, unpack(collisionTableRight)) then
          self.incrementX = self.incrementX + (gridWidth * self.xVel * dt) * pFM
	    else
	      self.incrementX = 0
	    end
	  end]]
    end
  end
  if self.ext_xSpeed < 0 then
	if not TestCollision.left( self.gridX, self.gridY, tiletable, unpack(collisionTableLeft)) then
      self.incrementX = self.incrementX + self.ext_xSpeed * gridWidth * dt
    end
	self.isMoving.hor = true
  elseif self.ext_xSpeed > 0 then
    if not TestCollision.right( self.gridX, self.gridY, tiletable, unpack(collisionTableRight)) then
	  self.incrementX = self.incrementX + self.ext_xSpeed * gridWidth * dt
    end
	self.isMoving.hor = true
  end
-------------------------------------------------------------
--------------algorithm--------------------------------------
  self.x = (self.gridX - 1)*gridWidth + self.incrementX
  if self.incrementX > gridWidth / 2 then
    self.gridX = self.gridX + 1
    self.incrementX = -gridWidth / 2 + (math.abs( self.incrementX - (gridWidth / 2) ) )
	-- for smooth rendering of grid transition
  elseif self.incrementX < -gridWidth / 2 then
    self.gridX = self.gridX - 1
    self.incrementX =  gridWidth / 2 - (math.abs( self.incrementX - (-gridWidth / 2) ) )
  end
end

-----for jumping------
local isPressed = false
local isMaxTime = false
local handleJump = nil
local isUpwardCollision = false
local function isUpwardCollision_reset() isUpwardCollision = false end
----------------------
-------------------------------------------------------------------------------------------------------------------

function Player:update_vertMove(dt,tiletable,Timer)				--tiletable:Entities_tiletable
  local collisionTableUp = {'_','=','*'}
  local collisionTableDown = {'-',[[\]],'/','I','=','*'}
--------------------------test is above platform before updating-----------------------------------------------
  if PreTC.oneSq( self.gridX, self.gridY, tiletable, unpack(collisionTableDown)) then
    self.isAPBU = true
  elseif PreTC.halfSq( self.gridX, self.gridY, tiletable, unpack(collisionTableDown)) then
    self.isAPBU = true
  else
    self.isAPBU = false
  end
--------------algorithm for grid-actual yCoordinate relationship--------------------------------------
  self.y = (self.gridY - 1)*gridHeight + self.incrementY
  if self.incrementY > gridHeight / 2 then
    self.gridY = self.gridY + 1							--move 1 grid at a time
    self.incrementY = -gridHeight / 2 + (math.abs( self.incrementY - (gridHeight / 2) ) )
  elseif self.incrementY < -gridHeight / 2 then
    self.gridY = self.gridY - 1
    self.incrementY =  gridHeight / 2 - (math.abs( self.incrementY - (-gridHeight / 2) ) )
  end
--algorithm for gravity effecting on player.incrementY**MUST BE AFTER grid-actual relationship---------
---high vel--this ensures that incrementY is very large before collision detection---------------------
----------------------------think of it as a very long tail that grows in front------------------------
----------if you cut it short and move it one grid to the next it may jump the detection method--------
  local gravity = 70
  if not self.isOnGround then
  --and self.isAPBU then
    self.yVel = self.yVel + gravity * dt
    self.incrementY = self.incrementY + self.yVel * gridHeight * dt
  end
  self.incrementY = self.incrementY + self.ext_ySpeed * gridHeight * dt
---------------collision with ground**MUST BE AFTER GRID POS AND INCREMENTS ARE UPDATED----------------
---------------collision detection uses value of increment also so must update it first and check collision again---
  self.isOnGround = false
  if self.isAPBU then
	if TestCollision.down( self.gridX, self.gridY, tiletable, unpack(collisionTableDown)) then
      self.yVel = 0
	  self.incrementY = 0
	  self.isOnGround = true
	end
  end
  
--------------algorithm for upward movement collision------------------------------------
  if TestCollision.up( self.gridX, self.gridY, tiletable, unpack(collisionTableUp)) then
    self.yVel = 0
	self.incrementY = 0
	isUpwardCollision = true
  end

  if self.isMoveable then
    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
      if not self.isOnGround then
	    --if isPressed then
	      if not isMaxTime then
		    if not isUpwardCollision then
              self.yVel = - 16
		    end
		  end
	    --end
	  end
	  self.isMoving.vert = true
    else
      if handleJump then Timer.cancel(handleJump) end
	  handleJump = nil
	  isMaxTime = true
      isPressed = false
	  self.isMoving.vert = false
    end
  end
end


function Player:jump()
  local collisionTableDown = {'-',[[\]],'/','I','=','*'}
  if self.isOnGround and self.isMoveable then
    --self.isOnGround = false
    self.incrementY = -1		--since incY == 0 then TestCollisionDown(collisionTableDown) is true
    self.yVel = - 16
	isPressed = true
	handleJump = Timer.do_for(0.2, function() isMaxTime = false end, function() isMaxTime = true end )
	Signal.emit('jump_platform')
	isUpwardCollision_reset()
  end
end
-------------------------------------------------------------------------------------------------------------------
-----------------------------------^-----------------^-------------------------------------------------------------
-----------------------------------|-PLAYER MOVEMENT-|-------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
------------------------------------Particle System----------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
function Player:update_PS(dt)
  self.PS:update(dt)
  self.PS:pause()
  if self.life > 0 then
    if self.direction == 'left' or self.direction == 'right' or not self.isOnGround then
      self.PS:start()
    end
  end
  self.PS:setPosition (self.x + 16 , self.y + 32 )
end
-------------------------------------------------------------------------------------------------------------------
------------------------------------Particle System----------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

function Player:moveTo(x,y)
  self.incrementX,self.incrementY = 0,0
  self.gridX,self.gridY = x,y
end

function Player:minusLife(n)			--n indicates how many lives are lost
  self.life = math.clamp(self.life - n , 0 , self.maxLife )
end

function Player:reflex()
  local dx , yVelTo = 10, -6
  if     markerLeftOrRight == 'left'  then self.incrementX = self.incrementX + dx
  elseif markerLeftOrRight == 'right' then self.incrementX = self.incrementX - dx end
  self.yVel = yVelTo
  markerLeftOrRight = ''
end

-------------------------
-------------------------
function Player:flicker()			--t:the time interval of flickering
  local flickerTime = 0.15
  Timer.addPeriodic( flickerTime , function()
      self.isFlicker = not self.isFlicker
	  return self.isInvincible
    end)
end

function Player:scale(factor_a,factor_b,method)
  local t= 0.2
  Timer.tween( t/2 ,self, {scaleFactor = factor_a}, method , function()
      Timer.tween( t/2, self, {scaleFactor = factor_b} )
	end )
end

function Player:rotate()
  local _angle = ( math.pi/2 /4 )
  local rotateDuration = 0.1
  --local rotateRounds = 6
--local t = 0.6

  Timer.tween( rotateDuration, self, {angle = _angle }, 'linear', function()
	  Timer.tween( rotateDuration, self, {angle = -_angle*2/3 }, 'linear', function()
	      Timer.tween( rotateDuration, self, {angle = _angle/2}, 'linear', function()
			  Timer.tween( rotateDuration, self, {angle = -_angle/3}, 'linear', function()
			      Timer.tween( rotateDuration, self, {angle = _angle/4}, 'linear', function()
				      Timer.tween( rotateDuration, self, {angle = 0} )
					end
				  )
				end
			  )
			end
		  )
		end
	  )
	end
  )
  --[[Timer.addPeriodic( rotateDuration , function()
	  Timer.tween( rotateDuration, self, {angle = math.random( -_angle , _angle ) } )
    end,
  rotateRounds
  )
  Timer.add( ( rotateRounds + 1 + 1	) * rotateDuration, function()		--additional 1 for buffer time
      Timer.tween( rotateDuration, self, {angle = 0 } )
	end
  )]]
end

function Player:colorChange()
  local t = 0.6
  local toColor = {255,100,100}
  Timer.tween( t/2, self.color, toColor, 'linear', function()
      Timer.tween( t/2, self.color, {255,255,255} )
	end )
end

function Player:beInvincible(invinciblePeriod)
  Timer.do_for( invinciblePeriod, function() self.isInvincible = true end, function()
      self.isInvincible = false
	end)
end

function Player:invincibleUntilReset()
  self.isInvincible = true
end

function Player:resetInvincible()
  self.isInvincible = false
end
--------------------------
--------------------------
function Player:hurt(n)			--t:the time interval of flickering
  if not self.isInvincible then
    Signal.emit( 'hurt_sound' )
    self:tweenLife(self.life)	--before minus
    self:minusLife(n)
	if self.life >= 1 then
	  --self:flicker()
      --self:reflex()
	  self:scale(1.5,1,'out-elastic')
	  self:rotate()
	  CameraShake:add(15,.3)
	  --Filters.red:blink()
	  self:colorChange()
      self:beInvincible(.8)
	elseif self.life == 0 then
	  self:invincibleUntilReset()
	  self:immobilize()
	  self:scale(1.5,0)
	  self:rotate()
	  CameraShake:add(15,.3)
	  self:colorChange()
	end
  end
end
--------------------------
--------------------------
function Player:reborn(r)		--r is rebornPt
  if r then
    self.yVel = 0
    self.incrementX,self.incrementY = 0,0
	self:setExtSpeed(0,0)
	self.direction = ''
    self:moveTo(unpack(r))
  else
    self:moveTo(2,2)
  end
end

function Player:fullHealth()
  self.life = self.maxLife
  return self
end

function Player:update_miscellaneous(dt,r)
-------------die-----------
  if self.life == 0 then
    if not self.isTime.isTimerSet then
	  self.isTime.isTimerSet = true
      Timer.add( 1, function() self.isTime.lvFail = true end )
	end
    if self.isTime.lvFail then
	  Gamestate.switch( LvFail )
	end
  end
---not invincible not flicker--
  if not self.isInvincible then
    --self.isFlicker = false
	self.angle = 0
  end
---reduce ext_x and ySpeeds to zero---
  self.ext_xSpeed = math.abs(self.ext_xSpeed)>1 and self.ext_xSpeed + ( 0 - self.ext_xSpeed ) * dt * self.ext_speed_tween_const or 0
  self.ext_ySpeed = math.abs(self.ext_ySpeed)>1 and self.ext_ySpeed + ( 0 - self.ext_ySpeed ) * dt * self.ext_speed_tween_const or 0
end
-----------------------------
function Player:setExtSpeed( _xSpeed, _ySpeed )
  self.ext_xSpeed, self.ext_ySpeed = _xSpeed, _ySpeed
end
-----------------------------
function Player:springJump(v)
  self.yVel = v
end
-----------------------------
function Player:drawLife()
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(Images.life, 0 , 0              ,0, self.lifeScaleFactor.life1,self.lifeScaleFactor.life1)
  love.graphics.draw(Images.life, Map.tileWidth , 0  ,0, self.lifeScaleFactor.life2,self.lifeScaleFactor.life2)
  love.graphics.draw(Images.life, 2*Map.tileWidth , 0,0, self.lifeScaleFactor.life3,self.lifeScaleFactor.life3)
  love.graphics.draw(Images.life, 3*Map.tileWidth , 0,0, self.lifeScaleFactor.life3,self.lifeScaleFactor.life4)
  love.graphics.draw(Images.life, 4*Map.tileWidth , 0,0, self.lifeScaleFactor.life3,self.lifeScaleFactor.life5)
end

function Player:tweenLife(lifeNum)
  if lifeNum >= 1 then
    Timer.tween( .1, self.lifeScaleFactor, { ['life' .. lifeNum] = 1.2 } , _, function()
        Timer.tween( .1, self.lifeScaleFactor, { ['life' .. lifeNum] = 0 } )
	  end
    )
  end
end

-------------------------------------------------------------------------------------------------------------------

function Player:resetTweenLife()
  self.lifeScaleFactor = {
    life1 = 1;
	life2 = 1;
	life3 = 1;
	life4 = 1;
	life5 = 1;
  }
end

function Player:resetBools()
  self.isTime = {
    lvFail = false;
	isTimerSet = false;
  }
end

function Player:immobilize()
  self.isMoveable = false
end

function Player:setMoveable()
  self.isMoveable = true
end

function Player:resetScale()
  self.scaleFactor = 1
end

function Player:massReset()
  self:fullHealth()
  self:resetInvincible()
  self:resetTweenLife()
  self:setMoveable()
  self:resetBools()
  self:resetScale()
  self.angle = 0
  self.color = {255,255,255}
end

return Player