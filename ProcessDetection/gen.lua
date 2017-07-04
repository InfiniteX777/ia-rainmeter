local list = {
	"dota2",
	"PaintDotNet",
	"explorer",
	"uTorrent"
}

local meter, process = {}, {}

function Initialize()
	local file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "w")

	for i,v in pairs(list) do
		file:write(
			"["..v.."]"..
			"\nMeter=Image"..
			"\nImageName="..v..
			"\nW=30"..
			"\nH=30"..
			"\nHidden=1\n"..
			"\n["..v.."Process]"..
			"\nMeasure=Plugin"..
			"\nPlugin=Process"..
			"\nProcessName="..v..".exe\n\n"
		)
	end
	file:close()

	for i,v in pairs(list) do
		meter[i] = SKIN:GetMeter(v)
		process[i] = SKIN:GetMeasure(v.."Process")
		SKIN:Bang("!SetOption", v, "ImageAlpha", 127)
		meter[i]:SetY(10)
	end
end

function Update()
	local n = 1
	for i,v in pairs(list) do
		if process[i]:GetValue() == 1 then
			meter[i]:SetX(1600-n*40)
			meter[i]:Show()
			n = n+1
		else meter[i]:Hide()
		end
		SKIN:Bang("!UpdateMeter", v)
	end
end