--OVERGAME Studio | http://overgame-studio.ru/
--Author: Livolickie | https://github.com/livolickie/
--Discord: https://discord.gg/ER3DT29
local utility = {}

generalFont = love.graphics.newFont("resources/font/MBB.ttf",32)
timerFont = love.graphics.newFont("resources/font/MBB.ttf",50)

function tableLength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function ShowInfo(message, buttons)
	love.window.showMessageBox("Hamster Ball Inspector",message,buttons)
end

function WindowInit(title)
	love.window.setTitle(title)
end

function file_exists(fileName)
	local f = io.open(fileName,"r")
	if (f ~= nil) then io.close() return true else return false end
end


utility.tableLength = tableLength
utility.ShowInfo = ShowInfo
utility.WindowInit = WindowInit
utility.generalFont = generalFont
utility.timerFont = timerFont
utility.file_exists = file_exists

return utility