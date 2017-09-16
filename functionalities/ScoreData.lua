local ScoreData = {}

function ScoreData:load()
  local lvStruct = Struct( 'blTime', 'OCDScore' )
  local blTimeTb = {}
  local OCDTb = {}
  for i = 1, MaxLvNum do
    blTimeTb[i] = 0
  end
  for i = 1, MaxLvNum do
    OCDTb[i] = 0
  end
  blTimeTb[1] = 67.32
  OCDTb[1] = 3308
  blTimeTb[2] = 70.4
  OCDTb[2] = 3409
  blTimeTb[3] = 103.31
  OCDTb[3] = 3904
  blTimeTb[4] = 81.21
  OCDTb[4] = 3562
  blTimeTb[5] = 96.47
  OCDTb[5] = 3916
  blTimeTb[6] = 82.29
  OCDTb[6] = 3610
  blTimeTb[7] = 85.87
  OCDTb[7] = 3514
  blTimeTb[8] = 68.83
  OCDTb[8] = 3395
  --blTime:bottomLineTime ->after which no time bonus score
  self.lvs = {}
  for i = 1, MaxLvNum do
    self.lvs[ i ] = lvStruct( blTimeTb[ i ], OCDTb[ i ] )
  end
end
--[[
function ScoreData()

function ScoreData()

function ScoreData()

function ScoreData()
]]

return ScoreData