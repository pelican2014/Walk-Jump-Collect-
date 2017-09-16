local Images = {}

function Images:load()
  self.player      		 = love.graphics.newImage('_assets/player.png');
  self.map_tileset 		 = love.graphics.newImage('_assets/tileset.png');
  self.diamond_anim 	 = love.graphics.newImage('_assets/diamond.png');
  self.door_tileset 	 = love.graphics.newImage('_assets/door.png');
  self.laser_short  	 = love.graphics.newImage('_assets/laserRay_short.png');
  self.laser_medium 	 = love.graphics.newImage('_assets/laserRay_medium.png');
  self.laser_long   	 = love.graphics.newImage('_assets/laserRay_long.png');
  self.hazardSign   	 = love.graphics.newImage('_assets/hazardSign.png');
  self.cursor_arrow 	 = love.graphics.newImage('_assets/cursor_arrow.png');
  self.cursor_hand  	 = love.graphics.newImage('_assets/cursor_hand.png' );
  self.diamondIcon  	 = love.graphics.newImage('_assets/diamondIcon.png');
  self.life         	 = love.graphics.newImage('_assets/life.png');
  self.trees		     = love.graphics.newImage('_assets/trees.png');
  self.hill		  		 = love.graphics.newImage('_assets/hill.png');
  self.mountain	 	     = love.graphics.newImage('_assets/mountain.png');
  self.clouds	  	 	 = love.graphics.newImage('_assets/clouds.png');
  self.sun		   		 = love.graphics.newImage('_assets/sun.png');
  self.clock		     = love.graphics.newImage('_assets/clock.png');
  self.pauseBt	  	     = love.graphics.newImage('_assets/pauseBt.png');
  self.trail	  	     = love.graphics.newImage('_assets/trail.png');
  self.star	  	   		 = love.graphics.newImage('_assets/star.png');
  self.star_dent	     = love.graphics.newImage('_assets/star_dent.png');
  self.lv_0star	   		 = love.graphics.newImage('_assets/lv_0star.png');
  self.lv_1star	   		 = love.graphics.newImage('_assets/lv_1star.png');
  self.lv_2star	   		 = love.graphics.newImage('_assets/lv_2star.png');
  self.lv_3star	   		 = love.graphics.newImage('_assets/lv_3star.png');
  self.lv_locked	   	 = love.graphics.newImage('_assets/lv_locked.png');
  self.OCD_large		 = love.graphics.newImage('_assets/OCD_large.png');
  self.OCD_small		 = love.graphics.newImage('_assets/OCD_small.png');
  self.bomb				 = love.graphics.newImage('_assets/bomb.png');
  self.bomb_bef_det		 = love.graphics.newImage('_assets/bomb_bef_det.png');
  self.explosion		 = love.graphics.newImage('_assets/explosion.png');
  self.rbpt_acvt		 = love.graphics.newImage('_assets/rbpt_actv.png');
  self.rbpt_inacvt		 = love.graphics.newImage('_assets/rbpt_inactv.png');
end

return Images