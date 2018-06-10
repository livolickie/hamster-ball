local world
local player = require("player")
local gameplay = require("gameplay")
local utility = require("utility")
local ball = require("ball")
local audio = require("audio")
local graphics = require("graphics")

local t, shakeDuration, shakeMagnitude = 0, -1, 0
function startShake(duration, magnitude)
    t, shakeDuration, shakeMagnitude = 0, duration or 1, magnitude or 5
end

function love.load()
	audio.Init()
	graphics.Init()
	gameplay.Init(utility)
	world = love.physics.newWorld(0,200,true)
	gameplay.SweetInit(world)
	world:setCallbacks(beginContact,endContact,preSolve,postSolve)
	utility.WindowInit("Hamster Ball")
	player.playerInit(world, gameplay.pulseLvl)
	ball.Init(utility,world)
end

function love.update(dt)
	if (gameplay.isActive == 1) then
		if t < shakeDuration then
	        t = t + dt
	    end
		if (love.timer.getTime() - gameplay.timeStart >= 0.1) then
			gameplay.timer = gameplay.timer - gameplay.hard
			if (gameplay.timer <= 0.1) then
				if (gameplay.isInter) then 
					gameplay.score = gameplay.score + 1
					if (gameplay.score > gameplay.bestScore) then gameplay.bestScore = gameplay.score gameplay.updateScoreFile(utility, false) end
					if (gameplay.score % 25 == 0) then
						gameplay.hard = gameplay.hard - 0.15
					end
				else gameplay.score = gameplay.score - 1 end
				timerUpdate()
			end
			gameplay.timeStart = love.timer.getTime()
		end
		if (gameplay.score <= 0) then
			gameplay.gameEnd(audio)
		end
		if (love.keyboard.isDown("w")) then
			player.b:applyForce(0,-1500)
		end
		if (love.keyboard.isDown("a")) then
			player.b:applyForce(-1500,0)
		end
		if (love.keyboard.isDown("s")) then
			player.b:applyForce(0,1500)
		end
		if (love.keyboard.isDown("d")) then
			player.b:applyForce(1500,0)
		end
		world:update(dt)
	end
	if (gameplay.isActive == 2) then
		gameplay.time = gameplay.time + dt
		if (gameplay.time >= 2.7) then
			gameplay.isActive = 0
			gameplay.time = 0
		end
	end
	if (gameplay.isActive == 0) then
		if (love.keyboard.isDown("return")) then
			gameplay.gameStart(audio)
		end
	end
end

--Physics
function beginContact(a,b,coll)
	startShake(0.25,3)
	audio.sndCollision:play()
	if (gameplay.tempCol < utility.tableLength(gameplay.rainbowCol)) then gameplay.tempCol = gameplay.tempCol + 1
	else gameplay.tempCol = 1 end
	if (a:getUserData() == "Sweet" and b:getUserData() == "Player") then
		gameplay.isInter = true
		gameplay.timer = 0.1
		--audio.sndSweet:play()
	end
end

function endContact(a,b,coll)

end

function preSolve(a,b,coll)

end

function postSolve(a,b,coll,normalimpulse,tangentimpulse)

end
--Physics

function love.mousepressed(x,y,button,printy)
	if (button  == 1) then
		--ball.createBall(x,y,utility,world)
	end
end

function love.wheelmoved(x,y)
	if y > 0 then
		if (gameplay.pulseLvl < 0.9) then gameplay.pulseLvl = gameplay.pulseLvl + 0.1 end
	else
		if (gameplay.pulseLvl > 0.2) then gameplay.pulseLvl = gameplay.pulseLvl - 0.1 end
	end
	player.f:setRestitution(gameplay.pulseLvl)
end

function love.draw()
	love.graphics.setBackgroundColor(255,255,255)
	if (gameplay.isActive == 1) then
		love.graphics.setColor(gameplay.rainbowCol[gameplay.tempCol][1], gameplay.rainbowCol[gameplay.tempCol][2], gameplay.rainbowCol[gameplay.tempCol][3], 75)
		love.graphics.draw(graphics.logoImg,love.graphics.getWidth() / 2 - graphics.logoImg:getWidth() / 2, love.graphics.getHeight() / 2 - graphics.logoImg:getHeight() / 2)
		if t < shakeDuration then
	        local dx = love.math.random(-shakeMagnitude, shakeMagnitude)
	        local dy = love.math.random(-shakeMagnitude, shakeMagnitude)
	        love.graphics.translate(dx, dy)
	    end
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw(graphics.sweetImg,gameplay.sweet.b:getX() - graphics.sweetImg:getWidth() / 2,gameplay.sweet.b:getY() - graphics.sweetImg:getHeight() / 2)
		player.Draw(gameplay)
		love.graphics.setColor(gameplay.rainbowCol[gameplay.tempCol][1], gameplay.rainbowCol[gameplay.tempCol][2], gameplay.rainbowCol[gameplay.tempCol][3], 75)
		love.graphics.setFont(utility.timerFont)
		love.graphics.print("Score : "..gameplay.score,20,5)
		love.graphics.print("Timer : "..gameplay.timer,love.graphics.getWidth() / 2 - 75,5)
		love.graphics.print("Pulse : "..gameplay.pulseLvl,love.graphics.getWidth() - 150,5)
		love.graphics.setColor(0,0,0,255)
		love.graphics.setFont(utility.generalFont)
		ball.Draw(gameplay)
	end
	if (gameplay.isActive == 2) then
		love.graphics.setColor(255,255,255,255)
		for i = 0, love.graphics.getWidth() / 180 do
			for j = 0, love.graphics.getHeight() / 180 do
				if (i < 4 and j < 3) then
					love.graphics.draw(graphics.logoImg,i*180,j*180) end
			end
		end
		love.graphics.draw(graphics.gameEndImg,love.graphics.getWidth() / 2 - graphics.gameEndImg:getWidth() / 2, love.graphics.getHeight() / 2 - graphics.gameEndImg:getHeight() / 2)
	end
	if (gameplay.isActive == 0) then
		love.graphics.setColor(255,255,255,255)
		for i = 0, love.graphics.getWidth() / 180 do
			for j = 0, love.graphics.getHeight() / 180 do
				if (i < 4 and j < 3) then
					love.graphics.draw(graphics.logoImg,i*180,j*180) end
			end
		end
		love.graphics.draw(graphics.startGameImg,love.graphics.getWidth() / 2 - graphics.startGameImg:getWidth() / 2, love.graphics.getHeight() / 2 - graphics.startGameImg:getHeight() / 2)
		love.graphics.setColor(255,0,0,255)
		love.graphics.setFont(utility.timerFont)
		love.graphics.print("Your best score : "..gameplay.bestScore,love.graphics.getWidth() / 2 - 100,150)
	end
end