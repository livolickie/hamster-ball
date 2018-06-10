 local gameplay = {}

rainbowCol = {{255,0,0},{255,127,0},{127,255,0},{0,255,0},{0,255,127},{0,255,255},{0,127,255},{0,0,255},{127,0,255},{255,0,255},{255,0,127}}
tempCol = 1
 
function Init(utility)
	gameplay.pulseLvl = 0.5
	gameplay.timer = 5.0
	gameplay.score = 5
	gameplay.isInter = false
	gameplay.isActive = 0
	gameplay.hard = 0.01
	gameplay.timeStart = 0
	gameplay.time = 0
	gameplay.bestScore = 0
	updateScoreFile(utility,true)
end

function updateScoreFile(utility, r)
	if (utility.file_exists("config.dat") and r) then
		file = io.open("config.dat","r")
		gameplay.bestScore = tonumber(file:read())
		file:close()
	else
		file = io.open("config.dat","w")
		file:write(gameplay.bestScore)
		file:close()
	end
end

function gameStart(audio)
	gameplay.isActive = 1
	gameplay.timeStart = love.timer.getTime()
	gameplay.score = 5
	gameplay.isInter = false
	gameplay.hard = 0.01
	audio.sndMainTheme:play()
end

function gameEnd(audio)
	audio.sndMainTheme:stop()
	gameplay.isActive = 2
	audio.sndGameEnd:play()
end

function SweetInit(world)
	x = love.math.random(70,love.graphics.getWidth()-70)
	y = love.math.random(70,love.graphics.getHeight()-70)
	gameplay.sweet = {}
	gameplay.sweet.b = love.physics.newBody(world,x,y,"static")
	gameplay.sweet.s = love.physics.newRectangleShape(70,70)
	gameplay.sweet.f = love.physics.newFixture(gameplay.sweet.b,gameplay.sweet.s)
	gameplay.sweet.f:setUserData("Sweet")
end

function SweetUpdate()
	x = love.math.random(70,love.graphics.getWidth()-70)
	y = love.math.random(70,love.graphics.getHeight()-70)
	gameplay.sweet.b:setX(x)
	gameplay.sweet.b:setY(y)
end

function timerUpdate()
	gameplay.timer = 5.0
	gameplay.hard = gameplay.hard + 0.01
	gameplay.isInter = false
	SweetUpdate()
	collectgarbage('collect')
end

gameplay.updateScoreFile = updateScoreFile
gameplay.SweetInit = SweetInit
gameplay.SweetUpdate = SweetUpdate
gameplay.timerUpdate = timerUpdate
gameplay.gameStart = gameStart
gameplay.gameEnd = gameEnd
gameplay.Init = Init
gameplay.rainbowCol = rainbowCol
gameplay.tempCol = tempCol

return gameplay