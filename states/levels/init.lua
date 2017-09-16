LevelBluePrint, Generate_init_GS = require 'states/levels/LevelBluePrint'
local function reqLv(totalLvNo)
  for lvNo = 1,totalLvNo,1 do
    _G[ 'Level' .. tostring(lvNo) ] = require ('states/levels/level' .. tostring(lvNo))
  end
end

reqLv(MaxLvNum)

--Level1    = require 'states/levels/level1'
--Level2    = require 'states/levels/level2'
--Level3    = require 'states/levels/level3'
--Level4    = require 'states/levels/level4'