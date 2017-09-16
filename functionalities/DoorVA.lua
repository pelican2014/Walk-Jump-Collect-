local DoorVA = {}

function DoorVA:load()
  self.isOn = false
  self.r = 5
  self.x,self.y = nil,nil
  local collider = HC()
  self.rect = collider:addRectangle( 10,10, love.window.getWidth()-20, love.window.getHeight()-20 )
end

function DoorVA:update(doorFn)
  local gridWidth,gridHeight = 32,32
  local x,y = (doorFn.OCo[1] -1) * gridWidth, (doorFn.OCo[2]-1) * gridHeight
  local door_x,door_y = Camera:cameraCoords( x,y )
  local cam_x,cam_y = love.window.getWidth()/2, love.window.getHeight()/2
  if door_x < 0 or door_x > love.window.getWidth() or door_y < 0 or door_y > love.window.getHeight() then
    if doorFn.isRegenerated then
	  local intersecting,t = self.rect:intersectsRay( cam_x,cam_y, cam_x-door_x, cam_y-door_y )
	  self.x, self.y = cam_x + (cam_x-door_x)*t, cam_y + (cam_y-door_y)*t
	  self.isOn = true
	end
  else
	  self.isOn = false
  end
end

function DoorVA:draw()
  if self.isOn then
    love.graphics.setColor( 255,0,0,200 )
    love.graphics.circle( 'fill', self.x, self.y, self.r )
    love.graphics.setColor( 255,255,255,255 )
  end
end


return DoorVA