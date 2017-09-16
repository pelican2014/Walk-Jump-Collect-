MaxLvNum = 8
require 'assets/init'				--assets should stand alone
require 'libraries/init'			--libraries stand alone
Mixin = require 'mixin/init'		--mixin stands alone	
----------------------------
require 'classes/init'				--classes do not depend on functionalities; functionalities do not depend on class
require 'functionalities/init'
require 'states/init'				--states depend on both classes and functionalities

function love.load()
  gridWidth,gridHeight = 32,32
  Fonts:load()
  Audio:load()
  Images:load()
  FinishCollecting:load()
  DrawBackground:load()
  CalScore:load()
  LvPassedTween:load()
  DoorVA:load()
  LvVA:load()
  ----above nothing invoked from others-----
  --below sth may be invoked from others----
  DoorFn:load()			--need images
  Map:load()			--need images
  Map:loadQuad()
  require 'states/levels/init'	--need images
  ScoreData:load()
  InterimBox:load()
  InterimButtons:load()
  InGameButtons:load()
  Player:load()
  Diamond:load()
  GUI:load()
  Signals.load()
  Filters:load()
  ----------
  love.mouse.setVisible(false)
  love.window.setTitle( 'Walk!Jump!Collect' .. love.timer.getFPS() )
--------------------------------------------  
  love.graphics.setBackgroundColor(Colors.greyBlue)
  love.graphics.setScissor(0,0,love.window.getWidth(),love.window.getHeight())
--------------------------------------------
  Gamestate.registerEvents()
  Gamestate.switch(Menu)
------------------------
  Camera = Camera()
end