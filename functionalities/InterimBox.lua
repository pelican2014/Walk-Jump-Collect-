local InterimBox = {}

function InterimBox:load()
  self.x, self.y            = love.window.getWidth() / 6     , love.window.getHeight() / 20
  self.width, self.height   = love.window.getWidth() * 2 / 3 , love.window.getHeight() * 9 / 10
  self.rightX, self.bottomY = self.x + self.width , self.y + self.height
  self.color                = { 0, 0, 0, 50 }
  self.margin               = Map.tileWidth / 2
end

function InterimBox:draw(_alpha_factor)
  local _a = _alpha_factor or 1
  local _c = self.color
  love.graphics.setColor( _c[1],_c[2],_c[3],_c[4]*_a )
  love.graphics.rectangle( 'fill', self.x, self.y, self.width, self.height )
  love.graphics.setColor{ 255, 255, 255, 255 }
end

--[[function InterimBox()

end

function InterimBox()

end]]

return InterimBox