local meter, alpha, rotate = {}, {}, {}
local count = 3

function Initialize()
	local file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "w")

	for i=1,count do
		file:write(
			"[Gen"..i.."]"..
			"\nMeter=Image"..
			"\nImageName=img1"..
			"\nW=1"..
			"\nH=1"..
			"\nImageAlpha=0\n"
		)
	end
	file:close()

	for i=1,count do
		meter[i] = SKIN:GetMeter("Gen"..i)
		alpha[i] = 0
		rotate[i] = 0
	end
end

function Update()
	for i=1,count do
		if alpha[i] <= 0 then
			alpha[i] = math.random()*63
			rotate[i] = math.random()*90
			v = math.random(300,700)
			SKIN:Bang("!SetOption", "Gen"..i, "ImageName", math.random() >= 0.5 and "img1" or "img2")
			SKIN:Bang("!SetOption", "Gen"..i, "W", v)
			SKIN:Bang("!SetOption", "Gen"..i, "H", v)
			meter[i]:SetX(math.random(0,1600))
			meter[i]:SetY(math.random(0,1200))
		else alpha[i] = alpha[i]-1
			 rotate[i] = rotate[i]+0.1
		end
		SKIN:Bang("!SetOption", "Gen"..i, "ImageAlpha", alpha[i]-0.01)
		SKIN:Bang("!SetOption", "Gen"..i, "ImageRotate", rotate[i])
	end
end