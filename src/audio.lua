local audio = {}

local sndMainTheme,sndCollision,sndGameEnd,sndSweet

function Init()
	sndMainTheme = love.audio.newSource("resources/music/main_theme.mp3","stream")
	sndMainTheme:setVolume(0.5)
	sndMainTheme:setLooping(true)
	sndCollision = love.audio.newSource("resources/music/ball.wav","static")
	sndSweet = love.audio.newSource("resources/music/sweet.wav","static")
	sndGameEnd = love.audio.newSource("resources/music/game_end.mp3","static")
	audio.sndMainTheme = sndMainTheme
	audio.sndCollision = sndCollision
	audio.sndGameEnd = sndGameEnd
	audio.sndSweet = sndSweet
end

audio.Init = Init

return audio