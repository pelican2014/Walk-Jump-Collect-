local TestCircle = {}

function TestCircle.isIn( x, y, box_x, box_y, box_side )	--the box that contains the circle
  local v_center = Vector.new( box_x, box_y )
  local v_testPt = Vector.new( x    , y     )
  local radius = box_side/2
  -------------------------------------------
  local dist = v_center:dist( v_testPt)
  if dist < radius then return true end
end

--[[function TestCircle()

function TestCircle()

function TestCircle()]]

return TestCircle