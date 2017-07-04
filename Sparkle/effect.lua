local meter, alpha = {}, {}

function Initialize()
	for i = 0, 9 do
		meter[i] = SKIN:GetMeter("Sparkle"..i)
		alpha[i] = math.random()*127
		SKIN:Bang("!SetOption", "Sparkle"..i, "ImageAlpha", alpha[i])
		SKIN:Bang("!SetOption", "Sparkle"..i, "ImageTint", (math.random()*255)..","..(math.random()*255)..","..(math.random()*255)..",255")
		--SKIN:Bang("!SetOption", "Sparkle"..i, "ImageTint", "242,206,218,235")
		v = math.random(10,100)
		SKIN:Bang("!SetOption", "Sparkle"..i, "W", v)
		SKIN:Bang("!SetOption", "Sparkle"..i, "H", v)
		meter[i]:SetX(math.random(0,1600))
		meter[i]:SetY(math.random(0,1200))
		SKIN:Bang("!UpdateMeter", meter[i])
	end
end

function Update()
	for i = 0, 9 do
		if alpha[i] <= 0 then
			alpha[i] = math.random()*127
			SKIN:Bang("!SetOption", "Sparkle"..i, "ImageAlpha", alpha[i])
			--SKIN:Bang("!SetOption", "Sparkle"..i, "ImageTint", (math.random()*255)..","..(math.random()*255)..","..(math.random()*255)..",255")
			v = math.random(10,1000)
			SKIN:Bang("!SetOption", "Sparkle"..i, "W", v)
			SKIN:Bang("!SetOption", "Sparkle"..i, "H", v)
			meter[i]:SetX(math.random(0,1600))
			meter[i]:SetY(math.random(0,1200))
			SKIN:Bang("!UpdateMeter", meter[i])
		else alpha[i] = alpha[i]-1
		end
		SKIN:Bang("!SetOption", "Sparkle"..i, "ImageAlpha", alpha[i]-0.01)
	end
end