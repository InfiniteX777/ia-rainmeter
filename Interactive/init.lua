local char
local accel = 1
local maxSpeed = 20
local distance = 300
local proximity = 250
local angle = 0
local mouseX, mouseY
local pX, pY, speed = 0, 0, 0, 0, 0

function render()
	char:SetX(pX)
	char:SetY(pY)
	SKIN:Bang("!SetOption","Character","RotationAngle",angle)
	SKIN:Bang("!UpdateMeter","Character")
end

function magnitude(x,y)
	return (x^2+y^2)^0.5
end

function Initialize()
	char = SKIN:GetMeter("Character")
	mouseX = SKIN:GetMeasure("MouseX")
	mouseY = SKIN:GetMeasure("MouseY")
	pX = mouseX:GetValue()
	pY = mouseY:GetValue()
	render()
end

function Update()
	angle = (angle+math.pi/64)%(math.pi*2)
	local dis = magnitude(pX+100-mouseX:GetValue(),pY+100-mouseY:GetValue())
	local dX, dY = 0, 0
	if dis > 0 then
		dX = (pX+100-mouseX:GetValue())/dis
		dY = (pY+100-mouseY:GetValue())/dis
	end
	if dis > distance then
		speed = math.min(maxSpeed,speed+accel)
	elseif dis <= distance-proximity then
		speed = math.max(-maxSpeed,speed-accel)
	else if math.abs(speed) <= accel then
			speed = 0
		end
		if speed > 0 then
			speed = speed-accel
		elseif speed < 0 then
			speed = speed+accel
		end
	end
	pX = pX-dX*speed
	pY = pY-dY*speed
	pX = 135
	pY = 135
	render()
end