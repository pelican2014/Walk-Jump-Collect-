local Fonts = {}

function Fonts:load()
  self.TCB32    	= love.graphics.setNewFont('_assets/TCB_____.TTF'       ,32);
  self.TCB122    	= love.graphics.setNewFont('_assets/TCB_____.TTF'       ,122);
  -----------------------------------------------------------------------
  self.TCM12    	= love.graphics.setNewFont('_assets/TCM_____.TTF'       ,12);
  self.TCM32  	    = love.graphics.setNewFont('_assets/TCM_____.TTF'       ,32);
  self.TCM64    	= love.graphics.setNewFont('_assets/TCM_____.TTF'       ,64);
  self.TCM144   	= love.graphics.setNewFont('_assets/TCM_____.TTF'       ,144);
  -----------------------------------------------------------------------
  self.AC32     	= love.graphics.setNewFont('_assets/ACaslonPro-Bold.otf',32);
end

return Fonts