local graphics = {}

function Init()
	graphics.logoImg = love.graphics.newImage("resources/image/hamster.png")
	graphics.sweetImg = love.graphics.newImage("resources/image/sweet.png")
	graphics.gameEndImg = love.graphics.newImage("resources/image/game_end.png")
	graphics.startGameImg = love.graphics.newImage("resources/image/game_start.png")
end

graphics.Init = Init

return graphics