local floor,ceil,min,max = math.floor,math.ceil,math.min,math.max

function CubicInterpolate(y0,y1,y2,y3,mu)
	local a0 = y3-y2-y0+y1
	local a1 = y0-y1-a0

	return a0*(mu^3)+a1*(mu^2)+(y2-y0)*mu+y1
end

function wrap(v)
	return "[B"..v.."]"
end

function CubicTranslate(y0,y1,y2,y3,mu)
	local y0,y1,y2,y3 = wrap(y0),wrap(y1),wrap(y2),wrap(y3)
	local a0 = "("..y3.."-"..y2.."-"..y0.."+"..y1..")"
	local a1 = "("..y0.."-"..y1.."-"..a0..")"

	return "("..a0.."*"..mu.."**3+"..a1.."*"..mu.."**2+("..y2.."-"..y0..")*"..mu.."+"..y1..")"
		
end

function Initialize()
	local f = SKIN:MakePathAbsolute(SELF:GetOption("IncFile"))
	local file = io.open(f, "r")
	local Width,Height = SKIN:GetVariable("Width"),SKIN:GetVariable("Height")
	local Bands = SKIN:GetVariable("Bands")

	local id = Bands..Width..Height
	local v = file:read("*all"):match("^#(.-)\n")

	file:close()

	-- Check ID.
	if v and v == id then return end

	local variable,measure,meter = "[Variables]\n","",""
	file = io.open(f, "w")

	-- Write measures. 
	for i=0,Bands-1 do
		measure = measure..
			"[B"..i.."]\n"..
			"Measure=Plugin\n"..
			"Group=Bands\n"..
			"Plugin=AudioLevel\n"..
			"Parent=Audio\n"..
			"Type=Band\n"..
			"BandIdx="..i.."\n\n"
	end

	-- Write meter.

	meter = meter..
		"[Visualizer]\n"..
		"Meter=Shape\n"..
		"Group=Visualizer\n"..
		"UpdateDivider=1\n"..
		"DynamicVariables=1\n"..
		"Shape=Path MyPath | StrokeWidth 0 | Fill Color #Color#,(#OpacityAsBass# = 1 ? Max([B1],[B4])*(#Opacity# - #OpacityAsBass_IdleOpacity#) + #OpacityAsBass_IdleOpacity# : #Opacity#)\n"..
		"MyPath=0,#Height# | LineTo 0,((1 - [B0])*#Height#)"

	local length = 1/(Bands-1)
	for i=0,Bands-2 do
		local a = "[B"..i.."]" -- 1
		local b = "[B"..(i+1).."]" -- 2
		--local c = "[B"..max(0,i-1).."]" -- 0
		local d = "[B"..min(Bands-1,i+2).."]" -- 3

		variable = variable..
			"M"..i.."="..
			"("..(i+1).."/(#Bands# - 1)*#Width#)"..
			",((1 - "..b..")*#Height#)"..
			",("..(i+0.5).."/(#Bands# - 1)*#Width#)"..
			",((1 - "..b..")*#Height#)"..
			--",(("..i.." + 1/(#Smoothness# + 1) + Abs("..b.." - "..a..")*(0.5 - 1/(#Smoothness# + 1)))/(#Bands# - 1)*#Width#)"..
			--",((1 - "..a..")*#Height#)"..
			",("..(i+0.5).."/(#Bands# - 1)*#Width#)"..
			",((1 - ("..b.."*2 - "..d.."))*#Height#)\n"
			--",(("..(i+1).." - 1/(#Smoothness# + 1) - Abs("..b.." - "..a..")*(0.5 - 1/(#Smoothness# + 1)))/(#Bands# - 1)*#Width#)"..
			--",((1 - "..b..")*#Height#)\n"

		meter = meter.." | CurveTo #M"..i.."#"
	end

	meter = meter.." | LineTo #Width#,#Height#\n"

	file:write("#"..id.."\n\n"..measure..variable.."\n"..meter)
	file:close()
	SKIN:Bang("!Refresh")
end