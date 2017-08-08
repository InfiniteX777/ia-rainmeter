function Initialize()
	local v = SKIN:MakePathAbsolute("meter.inc")
	local file = io.open(v,"r")
	local data = file:read("*all")
	local id = data:match("^#r\n")
	file:close()

	if id then
		local file = io.open(v,"w")
		file:write(data:gsub("^#r\n",""))
		file:close()
		return
	end

	file = io.open(SKIN:MakePathAbsolute("note.txt"), "r")
	local form = file:read("*all")
	file:close()

	local meter = "#r\n"

	local n = 0
	local offset = 0
	for r,g,b,font,size,space,text in form:gmatch("<(%d-),(%d-),(%d-)|(.-)|(%d-)|(%d-)>(.-)\n") do
		meter = meter.."[Meter"..n.."]"..
			"\nMeter=String"..
			"\nText="..text..
			"\nX=(#alignRight# = 1 ? #SCREENAREAWIDTH# : 0)"..
			"\nY="..offset..
			"\nFontFace="..font..
			"\nFontSize="..size..
			"\nFontColor="..r..","..g..","..b..
			"\nStringAlign="..(SKIN:GetVariable("alignRight") == "1" and "Right" or "Left")..
			"\nAntiAlias=1"..
			"\nDynamicVariables=1\n\n"
		n = n+1
		offset = offset+size+6+space
	end

	file = io.open(SKIN:MakePathAbsolute("meter.inc"),"w")
	file:write(meter)
	file:close()

	SKIN:Bang("!Refresh")
end
