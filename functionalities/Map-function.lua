local Map = {}
-------------------------------------------------------------------------------------------------------------------
function Map:load()
  Map.tileWidth,Map.tileHeight = 32,32
  Map.tiletable = {}
  Map.SB = love.graphics.newSpriteBatch( Images.map_tileset, 1024 )
end
--------------------
local Map_quads = {}

function Map:loadQuad()
  local tilesetWidth, tilesetHeight = Images.map_tileset:getWidth(), Images.map_tileset:getHeight()
  local quadInfo = {
    { ' ', 1, 4 },		--empty space		TAKE NOTE
	{ '~', 1, 4 },		--marker(empty space)
	{ '-', 2, 2 },		--centre of long platform
	{[[\]],1, 2 },		--left of long platform
	{ '/', 3, 2 },		--right of long platform
	{ 'i', 4, 2 },		--individual platform
	{ '=', 5, 1 },		--groundcover
	{ '$', 5, 2 },		--soil
	{ '*', 1, 1 },		--flowers
	{ '^', 2, 1 },		--rocks
	{ '!', 3, 1 },		--spikes
	{ 'm', 4, 1 },		--spring
	{ '?', 4, 5 },      --inverted spikes
	{ 'q', 5, 3 },		--soil and top left grass (platform)
	{ 'a', 5, 4 },		--soil and left grass     (platform)
	{ 'z', 5, 5 },		--soil and top left corner grass (platform)
	{ 'p', 6, 3 },		--soil and top right grass       (platform)
	{ 'l', 6, 4 },		--soil and right grass           (platform)
	{ ',', 6, 5 },		--soil and top right corner grass(platform)
	{ '_', 6, 2 },		--bottom soil in the air with curls (platform)
	{ 's', 3, 3 },		--soil and top left grass
	{ 'x', 3, 4 },		--soil and top left corner grass
	{ 'o', 4, 3 },		--soil and right grass
	{ 'k', 4, 4 },		--soil and top right corner grass
	{ 'w', 1, 3 },		--grass+soil
	{ 'e', 2, 3 }		--grass+soil
  }	
  for _,info in ipairs(quadInfo) do
    --info[1] = character, info[2] = x , info[3] = y
	local _padded_tile_width, _padded_tile_height = self.tileWidth + 2, self.tileHeight + 2
    Map_quads[info[1]] = love.graphics.newQuad( 1 + (info[2]-1) * _padded_tile_width, 1 + (info[3]-1) * _padded_tile_height , self.tileWidth, self.tileHeight, tilesetWidth, tilesetHeight )
  end
end
-------------------------------------------------------------------------------------------------------------------
function Map:updateSB()
  self.SB:bind()
  self.SB:clear()
  
  for columnIndex, column in ipairs(self.tiletable) do
      for rowIndex, character in ipairs(column) do
	    local x,y = (columnIndex-1) * self.tileWidth, (rowIndex-1)* self.tileHeight
		local _cull_x_min, _cull_y_min = Camera:worldCoords( 0, 0 )
		local _cull_x_max, _cull_y_max = Camera:worldCoords( love.window.getWidth() , love.window.getHeight() )
		
		if  x + self.tileWidth  >= _cull_x_min and x <= _cull_x_max
		and y + self.tileHeight >= _cull_y_min and y <= _cull_y_max then
	      self.SB:add( Map_quads[character] , x , y )
		end
		
	  end
    end
  
  self.SB:unbind()
end
-------------------------------------------------------------------------------------------------------------------
function Map:draw()
    --[[for columnIndex, column in ipairs(self.tiletable) do
      for rowIndex, character in ipairs(column) do
	    local x,y = (columnIndex-1) * self.tileWidth, (rowIndex-1)* self.tileHeight
		local _cull_x_min, _cull_y_min = Camera:worldCoords( 0, 0 )
		local _cull_x_max, _cull_y_max = Camera:worldCoords( love.window.getWidth() , love.window.getHeight() )
		
		if  x + self.tileWidth  >= _cull_x_min and x <= _cull_x_max
		and y + self.tileHeight >= _cull_y_min and y <= _cull_y_max then
	      love.graphics.draw( Images.map_tileset , Map_quads[character] , x , y )
		end
		
	  end
    end]]
	love.graphics.draw( self.SB )
end

return Map