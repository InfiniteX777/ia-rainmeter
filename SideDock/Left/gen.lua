local insert,sort = table.insert,table.sort
local floor,min,max = math.floor,math.min,math.max

local games = {}
local games_installed = {}
local games_index = {}
local bannerIndex = 1
local rows
local steam
local id

function queueBanner()
	if bannerIndex <= #games_installed then
		local v = games_index[games_installed[bannerIndex]]
		local file = io.open(SKIN:MakePathAbsolute("DownloadFile\\"..v..".jpg"),"r")

		if file then
			file:close()
			parseBanner(-1)
		else SKIN:Bang("!SetVariable","banner",v)
			SKIN:Bang("!SetOption","BannerParser","Disabled",0)
			SKIN:Bang("!CommandMeasure","BannerParser","Update")
			SKIN:Bang("!UpdateMeasure","BannerParser")
		end
	else SKIN:Bang("!Update")
		SKIN:Bang("!Redraw")
	end
end

function parseBanner(status)
	--[[
		-1 = Skip
		0 = Success
		1 = Retry
		2 = Error+Skip
	]]
	if status ~= 1 then
		bannerIndex = bannerIndex+1
	end

	queueBanner()
end

function wheel(n)
	local prev = SKIN:GetVariable("scroll")
	local next = max(0,min(#games_installed-rows,prev+n))
	SKIN:Bang("!SetVariable","scroll",next)

	if next ~= prev then
		for i=1,rows do
			SKIN:Bang("!SetVariable","Game"..(i-1).."Banner",games_index[games_installed[i+next]])
		end

		SKIN:Bang("!UpdateMeterGroup","SteamGames")
		SKIN:Bang("!Redraw")
	end
end

function Initialize()
	rows = SKIN:GetVariable("rows")
	steam = SKIN:GetVariable("steam")
	id = SKIN:GetVariable("id")

	local spacing = SKIN:GetVariable("spacing")
	local ratio = SKIN:GetVariable("width")/SKIN:GetVariable("height")
	local h = floor((1200-40)/rows)-spacing-spacing/rows

	-- Collect all games played by this user.
	local file = io.open(steam.."\\userdata\\"..id.."\\config\\localconfig.vdf", "r")

	for k,v in file:read("*all"):match('"Apps"%s-{.-}%s-"LastPlayedTimesSyncTime"'):gmatch('"(%d-)"%s-{%s-"LastPlayed"%s-"(%d-)"') do
		games[k] = v
	end

	file:close()

	-- Collect all installed games in this PC based on the user's library.
	for k,_ in pairs(games) do
		file = io.open(steam.."\\steamapps\\appmanifest_"..k..".acf", "r")

		if file then
			local v = file:read("*all"):match('"name"%s-"(.-)"')

			insert(games_installed,v)
			games_index[v] = k

			file:close()
		end
	end
	sort(games_installed)

	-- Check if the same.
	file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "r")
	if file then
		local v = file:read("*all"):match("meterID=(.-)\n")
		file:close()

		if v and v == tostring(rows).."/"..tostring(spacing) then
			return
		end
	end

	-- Setup
	local variables = "[Variables]\nmeterID="..tostring(rows).."/"..tostring(spacing).."\n"
	local meters = ""
	rows = min(#games_installed,rows)

	for i=0,rows-1 do
		local v = games_index[games_installed[i+1]]

		variables = variables.."Game"..i.."Banner="..v.."\n"
		meters = meters..[[
[Game]]..i..[[]
Meter=Image
ImageName=DownloadFile/#Game]]..i..[[Banner#.jpg
H=]]..h..[[

X=]]..spacing..[[

Y=]]..((h+spacing)*i+spacing)..[[

Greyscale=1
LeftMouseUpAction=["steam://rungameid/#Game]]..i..[[Banner#"]
MouseOverAction=[!SetOption Game]]..i..[[ Greyscale 0][!UpdateMeter Game]]..i..[[][!Redraw]
MouseLeaveAction=[!SetOption Game]]..i..[[ Greyscale 1][!UpdateMeter Game]]..i..[[][!Redraw]
DynamicVariables=1
Group=SteamGames

]]
	end

	file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "w")
	file:write(variables.."\n"..meters)
	file:close()

	queueBanner()

	SKIN:Bang("!Refresh")
end
