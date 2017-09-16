local CameraShake = {}
local shakeStruct = Struct( 'creation_time', 'ID', 'intensity', 'duration' )
local function findIndexByID( _table, _ID )
  for i,v in ipairs(_table) do
    if v.ID == _ID then
	  return i
	end
  end
end
CameraShake.shake_intensity = 0
CameraShake.each_shake_duration = .05
CameraShake.shake_dx = 0
CameraShake.shake_dy = 0
CameraShake.shakes = {}
CameraShake.IDDispenser = 0
CameraShake.isShaking = false

function CameraShake:add(_intensity,_duration)
  self.IDDispenser = self.IDDispenser + 1
  table.insert( self.shakes, shakeStruct(love.timer.getTime(),self.IDDispenser,_intensity,_duration) )
end

function CameraShake:remove(_ID)
  table.remove( self.shakes, findIndexByID( self.shakes, _ID ) )
end

function CameraShake:shakeIt()	--update
  local shake_dx, shake_dy = 0,0
  for _, _shake in ipairs(self.shakes) do
    if love.timer.getTime() > _shake.creation_time + _shake.duration then
      self:remove(_shake.ID)
    else
	  self.shake_intensity = self.shake_intensity + _shake.intensity
    end
  end
	
  if self.shake_intensity > 0 then
    if not self.isShaking then
	  self.isShaking = true
      Timer.tween( self.each_shake_duration, self, { shake_dx = math.random( -self.shake_intensity, self.shake_intensity), shake_dy = math.random( -self.shake_intensity, self.shake_intensity) }, _, function()
          self.isShaking = false
		end
	  )
	end
  else
    self.shake_dx, self.shake_dy = 0,0
  end
  self.shake_intensity = 0
end

return CameraShake