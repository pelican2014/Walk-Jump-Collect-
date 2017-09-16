local DrawBackground = {}


function DrawBackground:load()
  self.dx = {
    clouds = 0;
  }
  self.speed = {
    clouds = -10;
  }
end

function DrawBackground:update(dt)
  self.dx.clouds = ( self.dx.clouds + self.speed.clouds * dt ) % Images.clouds:getWidth()
end

function DrawBackground:draw(tiletableHeight)		--invokes and changes (and changes back) Camera modules extensively
  local scaleFactors = {
    { .8, .8 };
    { .5, .5 };
    { .4, .4 };
    { .1, .1 };
    { .03, .03 };
  }
  local _x, _y = Camera.x, Camera.y
  
  for i = 6,2,-1 do
    Camera.x, Camera.y = _x * scaleFactors[i-1][1] + love.window.getWidth()/2 , _y * scaleFactors[i-1][2] + love.window.getHeight()/2
    Camera:attach()
	  if i == 5 then
        Signal.emit( 'layer_5', self.dx.clouds, ((37-1)*32 - tiletableHeight)*scaleFactors[i-1][1] )	--added height is multiplied by scaleFactor to eliminate the effect of camera on displacement
	  else
        Signal.emit( 'layer_' .. i, ((37-1)*32 - tiletableHeight)*scaleFactors[i-1][1] )
		--minus a standard height to pad up the height of background
	  end
    Camera:detach()
  end
  
  Camera.x, Camera.y = _x, _y
end

return DrawBackground