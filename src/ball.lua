local ball = {}

local objects = {}
local c = 0

function Init(utility, world)
	for i = 0, love.graphics.getWidth() / 10 do
		createBall(i*10,0,utility,world)
		createBall(i*10,love.graphics.getHeight(),utility,world)
	end
	for i = 0, love.graphics.getHeight() / 10 do
		createBall(0,i*10,utility,world)
		createBall(love.graphics.getWidth(),i*10,utility,world)
	end
end

function createBall(x, y, utility, world)
	c = c + 1;
	if (utility.tableLength(objects) < c) then
		objects[c] = {}
	end
	objects[c].b = love.physics.newBody(world,x,y,"static")
	objects[c].s = love.physics.newCircleShape(10)
	objects[c].f = love.physics.newFixture(objects[c].b,objects[c].s)
	objects[c].f:setUserData("Ball")
	return objects[c]
end

function Draw(gameplay)
	for i = 1, c do
		love.graphics.setColor(gameplay.rainbowCol[gameplay.tempCol][1],gameplay.rainbowCol[gameplay.tempCol][2],gameplay.rainbowCol[gameplay.tempCol][3],255)
		love.graphics.circle("fill",objects[i].b:getX(),objects[i].b:getY(),10,100)
	end
end

ball.Init = Init
ball.Draw = Draw
ball.createBall = createBall
ball.objects = objects
ball.c = c

return ball