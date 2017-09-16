local CameraMov = {}

local _gloc_isCrippled = false
local _gloc_preMousePos = nil
local _gloc_isMoving = false

------------------external function-----------------
function math.clamp(x, min, max)
    return x < min and min or (x > max and max or x)
end
-------------------setup----------------------------
function CameraMov:init()
  self.isOut = { left = false, right = false, up = false, down = false }		--is the player outside the imaginary box at the center of window where camera will not follow him?
  self.mouse_isOut = { left = false, right = false, up = false, down = false }
  self.twConst = 7		--tweening constant
  self.speed = 500		--speed of camera movement when mouse moves out its imaginary box
  self.range = 200		--range of camera movement when caused by mouse
end
CameraMov:init()
------------------define local vars----------------------------------------
local wW,wH = love.window.getWidth(), love.window.getHeight()
local _upperBoundary,_lowerBoundary = 3/8 * wH, 5/8 * wH
local _leftBoundary, _rightBoundary = 9/20 * wW, 11/20 * wW
local _half_box_width, _half_box_height = 1/20 * wW, 1/8 * wH
---------------------------------------------------------------------------

function CameraMov:isOut_update()
  local player = Player
  local pX_onScreen,pY_onScreen = Camera:cameraCoords(player.x,player.y)
  if pX_onScreen < _leftBoundary then
    self.isOut.left = true
  else
    self.isOut.left = false
  end
  -------------------------------
  if pX_onScreen > _rightBoundary then
    self.isOut.right = true
  else
    self.isOut.right = false
  end
  -------------------------------
  if pY_onScreen < _upperBoundary then
    self.isOut.up = true
  else
    self.isOut.up = false
  end
  -------------------------------
  if pY_onScreen > _lowerBoundary then
    self.isOut.down = true
  else
    self.isOut.down = false
  end
end

----------internal use--------------------------
--used in a function that is in an update loop--
function CameraMov:computeX_left(dt,x)
  local player = Player
  local targetX = player.x + _half_box_width
  local x = x + ( targetX - x ) * dt * self.twConst
  return x
end

function CameraMov:computeX_right(dt,x)
  local player = Player
  local targetX = player.x - _half_box_width
  local x = x + ( targetX - x ) * dt * self.twConst
  return x
end

function CameraMov:computeY_up(dt,y)
  local player = Player
  local targetY = player.y + _half_box_height
  local y = y + ( targetY - y ) * dt * self.twConst
  return y
end

function CameraMov:computeY_down(dt,y)
  local player = Player
  targetY = player.y - _half_box_height
  local y = y + ( targetY - y ) * dt * self.twConst
  return y
end
----------------------------------------
----------------------------------------
function CameraMov:implement(dt,camX,camY)
  if self.isOut.left then
    camX = CameraMov:computeX_left(dt,camX)
  elseif self.isOut.right then
    camX = CameraMov:computeX_right(dt,camX)
  end
  ------------------------------------
  if self.isOut.up then
    camY = CameraMov:computeY_up(dt,camY)
  elseif self.isOut.down then
    camY = CameraMov:computeY_down(dt,camY)
  end
  ------------------------------------
  return camX,camY
end
----------------------------------------
----------------------------------------
function CameraMov.clamp(camX,camY)
  local horTilesNo, verTilesNo  = wW/32, wH/32		--as per screen
  local tiletable = Entities.tiletable
  camX = math.clamp(camX, ( 1 + horTilesNo / 2 ) * Map.tileWidth,  ( #tiletable    - 1 - horTilesNo / 2 ) * Map.tileWidth  )
  camY = math.clamp(camY, ( 1 + verTilesNo / 2 ) * Map.tileHeight, ( #tiletable[1] - 2 - verTilesNo / 2 ) * Map.tileHeight )
  return camX,camY
end
----------------------------------------
----------------------------------------
function CameraMov:update(dt)
  local camX,camY = Camera.x, Camera.y
  local player = Player
  self:isOut_update()
  self:mouse_isOut_update()
  ---------------------------------------------
  local m_cam_x, m_cam_y = self:mouse_mov(dt,camX,camY)
  local p_cam_x, p_cam_y = self:implement(dt,camX,camY)
  local toLookAt_x, toLookAt_y = nil, nil
  if m_cam_x and m_cam_y then
    toLookAt_x, toLookAt_y = m_cam_x, m_cam_y
  else
    toLookAt_x, toLookAt_y = p_cam_x, p_cam_y
  end
  toLookAt_x, toLookAt_y = self.clamp( toLookAt_x + CameraShake.shake_dx, toLookAt_y + CameraShake.shake_dy )
  Camera:lookAt( toLookAt_x, toLookAt_y )
end
----------------------------------------
----------BELOW: MOUSE   ---------------
function CameraMov:mouse_isOut_update()
  --Imaginary box out of which mouse movement trigers camera movement--
  local _upperBoundary,_lowerBoundary = 1/8 * wH, 7/8 * wH
  local _leftBoundary, _rightBoundary = 1/20 * wW, 19/20 * wW
  local mX,mY = love.mouse.getPosition()
  if _gloc_preMousePos then
    _gloc_isMoving = mX ~= _gloc_preMousePos[1] and true or ( mY ~= _gloc_preMousePos[2] and true or false )
  end
  _gloc_preMousePos = {mX,mY}
  -------------------------------
  if mX < _leftBoundary then
    self.mouse_isOut.left = true
  else
    self.mouse_isOut.left = false
  end
  -------------------------------
  if mX > _rightBoundary then
    self.mouse_isOut.right = true
  else
    self.mouse_isOut.right = false
  end
  -------------------------------
  if mY < _upperBoundary then
    self.mouse_isOut.up = true
  else
    self.mouse_isOut.up = false
  end
  -------------------------------
  if mY > _lowerBoundary then
    self.mouse_isOut.down = true
  else
    self.mouse_isOut.down = false
  end
----------------
end
----------------------------------------
----------------------------------------
function CameraMov:mouse_mov(dt,camX,camY)
  local player = Player
  local _camX, _camY = camX, camY
  if self.mouse_isOut.left then
    camX = camX - self.speed * dt
  elseif self.mouse_isOut.right then
    camX = camX + self.speed * dt
  ------------------------------------
  elseif self.mouse_isOut.up then
    camY = camY - self.speed * dt
  elseif self.mouse_isOut.down then
    camY = camY + self.speed * dt
  end
  ------------------------------------
  local test = false
  if camX ~= _camX or camY ~= _camY then test = true end
  ------------------------------------
  camX = math.clamp( camX, player.x - self.range, player.x + self.range )
  camY = math.clamp( camY, player.y - self.range, player.y + self.range )
  ------------------------------------
  if _gloc_isMoving then _gloc_isCrippled = false end
  if test then
    if player.isMoving.hor == true or player.isMoving.vert == true then
	  _gloc_isCrippled = true
	else
      return not _gloc_isCrippled and camX,camY
	end
  end
end


return CameraMov