local Signals = {}								--signals are also registered elsewhere

function Signals.load()
    ---------------Sounds----------------
  Signal.register( 'finishCollecting', function()
      Audio.cheer:play()
    end
  )
  Signal.register( 'jump_platform', function()
      Audio.jump_platform:rewind()
	  Audio.jump_platform:play()
    end
  )
  Signal.register( 'jump_spring', function()
      Audio.jump_spring:rewind()
      Audio.jump_spring:play()
    end
  )
  Signal.register( 'diamondCollect', function()
      Audio.diamond:rewind()
	  Audio.diamond:play()
    end
  )
  Signal.register( 'completeLevel', function()
      Audio.Success:play()
    end
  )
  Signal.register( 'star1_sound', function()
      Audio.note1:play()
	end
  )
  Signal.register( 'star2_sound', function()
      Audio.note2:play()
	end
  )
  Signal.register( 'star3_sound', function()
      Audio.note3:play()
	end
  )
  Signal.register( 'OCD_sound', function()
      Audio.note4:play()
	end
  )
  Signal.register( 'hurt_sound', function()
      Audio.hurt:play()
	end
  )
  Signal.register( 'play_background_music', function()
      Audio.backgroundMusic:setLooping(true)
      Audio.backgroundMusic:play()
	end
  )
-----------------Layers----------------
  Signal.register( 'layer_2', function(addedHeight)			--layer_2 is at the back of layer_1
  --height is added to make the bottom of the background to align to the bottom of the tiletable
  --this way when player stands on the lowest part of the map, he will always see the trees
	  for n = -1,6 do
	    love.graphics.draw( Images.trees    , 120 + n * Images.trees:getWidth()    , 850-addedHeight )
	  end
    end
  )
  Signal.register( 'layer_3', function(addedHeight)
	  for n = -1,6 do
	    love.graphics.draw( Images.hill     , 120 + n * Images.hill:getWidth()     , 450-addedHeight )
      end
    end
  )
  Signal.register( 'layer_4', function(addedHeight)
	  for n = -1,6 do
	    love.graphics.draw( Images.mountain , 180 + n * Images.mountain:getWidth() , 390-addedHeight )
	  end
    end
  )
  Signal.register( 'layer_5', function(dx_clouds,addedHeight)
	  for n = -1,2 do
	    love.graphics.draw( Images.clouds   , ( 80  + dx_clouds ) + n * Images.clouds:getWidth() , 85-addedHeight  )
	  end
    end
  )
  Signal.register( 'layer_6', function(addedHeight)
	  love.graphics.draw( Images.sun        , 700             , -40-addedHeight )
	end
  )
end

Signals.register = {
  restart_pop = function( from )
    Signal.clear( 'restart' )
    Signal.register( 'restart', function()			--do not pass from in as an arg (not to be passed in when invoked but passed in when registered
	    Pause.isPopping = true
        Pause.fadeOut:tween(.3)
	    CircleButton.isAllDisabled = true
	    Timer.add( .3, function()
            Gamestate.pop()
	        Gamestate.switch( from )
			Pause.isPopping = false
			CircleButton.isAllDisabled = false
		  end
		)
      end
    )
  end;
  -----------------------------------------
  --[[restart_noPop_LvFail = function( from )
    Signal.clear( 'restart' )
    Signal.register( 'restart', function()			--do not pass from in as an arg (not to be passed in when invoked but passed in when registered
            LvFail.fadeOut:tween(.3)
	        CircleButton.isAllDisabled = true
	        Timer.add( .3, function()
	            Gamestate.switch( from )
			    CircleButton.isAllDisabled = false
			  end
			)
		  end
        )
  end;
  
  restart_noPop_LvPass = function( from )
    Signal.clear( 'restart' )
    Signal.register( 'restart', function()			--do not pass from in as an arg (not to be passed in when invoked but passed in when registered
            LvPass.fadeOut:tween(.3)
	        CircleButton.isAllDisabled = true
	        Timer.add( .3, function()
	            Gamestate.switch( from )
			    CircleButton.isAllDisabled = false
			  end
		    )
		  end
        )
  end;]]
  restart_noPop = function( from )
    Signal.clear( 'restart' )
    Signal.register( 'restart', function()			--do not pass from in as an arg (not to be passed in when invoked but passed in when registered
            Gamestate.current().fadeOut:tween(.3)
			Gamestate.current().isSwitching = true
	        CircleButton.isAllDisabled = true
	        Timer.add( .3, function()
	            Gamestate.switch( from )
			    CircleButton.isAllDisabled = false
			  end
		    )
		  end
        )
  end;
  -----------------------------------------
  resume = function()								--no var change so actually can do away with signal; but for uniformity's sake and simplicity's sake
    Signal.clear( 'resume' )
    Signal.register( 'resume', function()
	    Pause.isPopping = true
        Timer.tween( .3, Pause, { aFactor = 0 }, _, function() Pause.isPopping = false end )
	    CircleButton.isAllDisabled = true
	    Timer.add( .3, function()
            Gamestate.pop()
	        MouseFn:setup_layer_1()
			CircleButton.isAllDisabled = false
		  end
		)
	  end
	)
  end;
  -----------------------------------------
  toLvSelect_pop = function()							--same as above
    Signal.clear( 'toLvSelect' )
    Signal.register( 'toLvSelect', function()
        Pause.fadeOut:tween(.3)
	    CircleButton.isAllDisabled = true
	    Timer.add( .3, function()
		    Gamestate.pop()
	        Gamestate.switch( LvSelect )
			CircleButton.isAllDisabled = false
		  end
        )
	  end
    )
  end;
  -----------------------------------------
  toLvSelect_noPop = function()							--same as above
    Signal.clear( 'toLvSelect' )
    Signal.register( 'toLvSelect', function()
	    Gamestate.current().fadeOut:tween(.3)
	    CircleButton.isAllDisabled = true
	    Timer.add( .3, function()
	        Gamestate.switch( LvSelect )
			CircleButton.isAllDisabled = false
		  end
        )
	  end
    )
  end;
  -----------------------------------------
  toNextLv = function( from )
    Signal.clear( 'toNextLv' )
    Signal.register( 'toNextLv', function()
	        LvPass.fadeOut:tween(.3)
	        CircleButton.isAllDisabled = true
	        Timer.add( .3, function()
	            Gamestate.switch( _G[from.toLevel] )
			    CircleButton.isAllDisabled = false
			  end
		    )
	  end
    )
  end;
}

return Signals