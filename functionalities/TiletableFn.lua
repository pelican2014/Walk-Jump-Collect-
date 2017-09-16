local TiletableFn = {}

function TiletableFn.renew(string)
  local table = {}
  local width = #(string:match('[^\n]+'))
  for x = 1,width,1 do table[x] = {} end
  
  local rowIndex,columnIndex = 1,1
  for row in string:gmatch('[^\n]+') do
    assert( #row == width, 'map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row) )
	columnIndex = 1
	for character in row:gmatch('.') do
	  table[columnIndex][rowIndex] = character
	  columnIndex = columnIndex + 1
	end
  rowIndex = rowIndex + 1
  end
  return table
end
-------------------------------------------------------------------------------------------------------------------

return TiletableFn