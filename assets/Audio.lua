local Audio = {}

function Audio:load()
  self.cheer         	= love.audio.newSource('_assets/cheer.mp3', 'static');
  self.jump_platform 	= love.audio.newSource('_assets/jump_platform.wav', 'static');
  self.jump_spring   	= love.audio.newSource('_assets/jump_spring.wav', 'static');
  self.diamond       	= love.audio.newSource('_assets/diamond.wav', 'static');
  self.success       	= love.audio.newSource('_assets/success.wav', 'static');
  self.note1		 	= love.audio.newSource('_assets/note1.wav', 'static');
  self.note2		 	= love.audio.newSource('_assets/note2.wav', 'static');
  self.note3		 	= love.audio.newSource('_assets/note3.wav', 'static');
  self.note4		 	= love.audio.newSource('_assets/note4.wav', 'static');
  self.hurt			 	= love.audio.newSource('_assets/hurt.mp3', 'static');
  self.backgroundMusic	= love.audio.newSource('_assets/background.wav');
end

return Audio