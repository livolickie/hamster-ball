local player = {}

function playerInit(world, pulseLvl)
	player.b = love.physics.newBody(world,400,200,"dynamic")
	player.b:setMass(10)
	player.s = love.physics.newCircleShape(20)
	player.f = love.physics.newFixture(player.b,player.s)
	player.f:setRestitution(pulseLvl)
	player.f:setUserData("Player")
end

player.playerInit = playerInit

function Draw(gameplay)
	love.graphics.setColor(gameplay.rainbowCol[gameplay.tempCol][1], gameplay.rainbowCol[gameplay.tempCol][2], gameplay.rainbowCol[gameplay.tempCol][3], 255)
	love.graphics.circle("fill", player.b:getX(), player.b:getY(),20,100)
end

player.Draw = Draw

return player