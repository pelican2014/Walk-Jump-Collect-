local Filters = {}

function Filters:load()
  self.red   = Filter( {255,0,0}, 0  , 100, 0.6 )
  self.grey  = Filter( {0,0,0}  , 100, 100 )
end


return Filters