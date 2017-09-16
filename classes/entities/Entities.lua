local Entities = {}

--------------------------------------------------------------------------------------------------------------------
Entities.tiletable = {}

--  " "	 empty space
--  "_"  blocks that player collides with when moving up
--  "-"  blocks that player collides with when moving down
-- [[\]] blocks that player collides with when moving left or down
--  "/"  blocks that player collides with when moving right or down
--  "I"  blocks that player collides with when moving left, right or down
--  "="  blocks that player collides when moving up or down
--  "*"  blocks that player collides when moving left, right, up or down
--	'V'  empty space that serves as markers for drawing diamond  -> entity
--  "X"  empty space that serves as markers for drawing doorTop  -> entity
--	'O'  empty space that serves as markers for drawing doorTop  -> entity
--  "v"  empty space that serves as markers for drawing doorBottom/reborn point bottom->entity
--  '^'  player is reborn when colliding with this block				 -> entity
--  '!'  player is hurt and becomes invincible for some time when colliding with this block				 -> entity
--  'm'  spring
--  '@'  reborn point

--------------------------------------------------------------------------------------------------------------------
function Entities.bottomOfTheCliff_update(r,tiletable)		--r:reborn point
  local player = Player
  local c = '^'
  if TestCollision(player.gridX,player.gridY,tiletable,c) then
    if player.life >= 1 then
      Player:tweenLife(player.life)
      Player:minusLife(1)
	end
	if player.life >= 1 then
      Signal.emit( 'hurt_sound' )
      Player:reborn(r)
	elseif player.life == 0 then
      if not player.isInvincible then
	    Player:invincibleUntilReset()
	    Player:immobilize()
	    Player:scale(0,0)
	    --CameraShake:add(15,.3)
	  end
	end
  end
end

function Entities.spike_update(r,tiletable)		--r:reborn point
  local player = Player
  local c = '!'
  if TestCollision(player.gridX,player.gridY,tiletable,c) then
    Player:hurt(1)
  end
end

function Entities.spring_update(tiletable)
  local player = Player
  local c = 'm'
  if TestCollision.down(player.gridX,player.gridY,tiletable,c) then
    Player:springJump(-36)
	Signal.emit('jump_spring')
  end
end

setmetatable( Entities, {__call = function(self,r,tiletable)
								    self.bottomOfTheCliff_update(r,tiletable)
									self.spike_update(r,tiletable)
									self.spring_update(tiletable)
								  end
						})

return Entities