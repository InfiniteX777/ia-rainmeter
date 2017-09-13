local insert,sort,concat = table.insert,table.sort,table.concat
local floor,min,max = math.floor,math.min,math.max

local games = {}
local games_installed = {}
local games_view = games_installed -- Point to games_installed to sort by name.
local games_index = {
	["NieR:Automata"] = {
		"524220",
		"I:\\Shortcuts\\Offline Game\\NieR;Automata.lnk"
	},
	["BlazBlue: Central Fiction"] = {
		"586140",
		"I:\\Shortcuts\\Offline Game\\BlazBlue Centralfiction.lnk"
	},
	["Dragon Nest"] = {
		"dragonnest",
		"I:\\Shortcuts\\Online Game\\Dragon Nest.lnk"
	},
	["Wrath of the Lich King"] = {
		"wotlk",
		"I:\\Shortcuts\\Online Game\\Wrath of the Lich King 3.3.5a.lnk"
	},
	["Tales of Berseria"] = {
		"429660",
		""
	},
	["The Legend of Heroes: Trails of Cold Steel"] = {
		"538680",
		""
	},
	["DJ Max: Trilogy"] = {
		"djmaxtrilogy",
		"I:\\DJMaxTrilogy\\TR1.exe"
	},
	["The End is Nigh"] = {
		"583470",
		"I:\\The End is Nigh\\LAUNCHER_x64.exe"
	},
	["Black Mesa"] = {
		"362890",
		"I:\\Black Mesa\\revloader.exe"
	},
	["Yonder: The Cloud Catcher Chronicles"] = {
		"580200",
		"I:\\Program Files\\Yonder The Cloud Catcher Chronicles\\YonderCCC.exe"
	}
}
local games_count = {}
local libraryID = ""
local bannerIndex = 1
local shouldParse = false
local shouldRewrite = false
local shouldRefresh = false
local bannerDone = false
local meterDone = false
local rows
local steam
local id
local unix = 0

function queueBanner()
	local v = games_index[games_installed[bannerIndex]]

	if bannerIndex <= #games_installed then
		local file = type(v) ~= "table" and io.open(SKIN:MakePathAbsolute("DownloadFile\\"..v..".jpg"),"r")

		if file then
			file:close()
			file = true
		end

		if type(v) == "table" or file and not shouldParse then
			parseBanner(-1)
		else SKIN:Bang("!SetVariable","banner",v)
			SKIN:Bang("!SetOption","BannerParser","Disabled",0)
			SKIN:Bang("!CommandMeasure","BannerParser","Update")
			SKIN:Bang("!UpdateMeasure","BannerParser")
		end
	else bannerDone = true
		SKIN:Bang("!UpdateMeterGroup","GameLibrary")
		SKIN:Bang("!Redraw")
		if meterDone and shouldRefresh then
			SKIN:Bang("!Refresh")
		end
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
	local next = max(0,min(#games_view-rows,prev+n))
	SKIN:Bang("!SetVariable","scroll",next)

	if next ~= prev then
		for i=1,rows do
			local v = games_index[games_view[i+next]] or "empty"
			SKIN:Bang("!SetVariable","Game"..(i-1).."Banner",type(v) == "table" and v[1] or v)
			SKIN:Bang(
				"!SetVariable","Game"..(i-1).."Launch",
				type(v) == "table" and v[2] or "steam://rungameid/"..v
			)
		end

		SKIN:Bang("!UpdateMeterGroup","GameLibrary")
		SKIN:Bang("!Redraw")
	end
end

function lmb(i)
	i = SKIN:GetVariable("scroll")+i+1
	local v = games_index[games_view[i]]

	if v then
		local k = type(v) == "table" and v[1] or v
		games_count[k] = (games_count[k] or 0)+1

		for k,v in pairs(games_count) do
			games_count[k] = v/2

			SKIN:Bang(
				"!WriteKeyValue",
				"Variables",
				k,
				v/2,
				SKIN:MakePathAbsolute("count.inc")
			)
		end

		SKIN:Bang('"'..(type(v) == "table" and v[2] or "steam://rungameid/"..v)..'"')
	end
end

function rmb(i)
	i = SKIN:GetVariable("scroll")+i+1
	local v = games_index[games_view[i]]

	if v then
		SKIN:Bang(
			'"'..(type(v) == "table" and v[2]:match("^.+\\") or "steam://nav/games/details/"..v)..'"'
		)
	end
end

function sortLib(i)
	if i == 0 then
		games_view = games_installed
	else local a,b,c = {},{},{}
		games_view = {}

		for k,v in pairs(games_count) do
			if not a[v] then
				a[v] = {}
			end

			insert(a[v],games[k])

			if not c[v] then
				c[v] = true

				insert(b,v)
			end
		end

		-- Reset hash to re-use.
		c = {}

		-- Sort alphabetically (multiple games with same click counts).
		for k,t in pairs(a) do
			if #t > 1 then
				sort(t)
			end
		end

		-- Sort highest to lowest click counts.
		sort(b,function(a,b) return a>b end)

		-- Insert games with click counters.
		for _,v in pairs(b) do
			for _,v in ipairs(a[v]) do
				-- Store to hash for debouncing.
				c[v] = true

				insert(games_view,v)
			end
		end

		-- Insert games without click counters.
		for _,v in pairs(games_installed) do
			if not c[v] then
				insert(games_view,v)
			end
		end
	end

	SKIN:Bang("!SetOption","SearchString","Text","Search")
	SKIN:Bang("!UpdateMeter","SearchString")
	SKIN:Bang("!SetVariable","scroll",0)
	wheel(0)
end

function search()
	local index = SKIN:GetMeasure("SearchMeasure"):GetOption("Search"):lower()

	if index:len() > 0 then
		games_view = {}

		for v in libraryID:gmatch("([^\\]-"..index..".-)\\") do
			insert(games_view,v)
		end

		SKIN:Bang("!SetOption","SearchString","Text",index)
		SKIN:Bang("!UpdateMeter","SearchString")
		SKIN:Bang("!SetVariable","scroll",0)
		wheel(0)
	else sortLib(0)
	end
end

function color(i,l,c,s)
	local l,c,s = l or 0,c or 1, s or 1
	local r,g,b = (1-s)*0.2125,(1-s)*0.7154,(1-s)*0.0721
	local rs,gs,bs = r+s,g+s,b+s
	local tl = (1-c)/2+l

	SKIN:Bang("!SetOption","Game"..i,"ColorMatrix1",(c*rs)..";"..(c*r)..";"..(c*r)..";0;0")
	SKIN:Bang("!SetOption","Game"..i,"ColorMatrix2",(c*g)..";"..(c*gs)..";"..(c*g)..";0;0")
	SKIN:Bang("!SetOption","Game"..i,"ColorMatrix3",(c*b)..";"..(c*b)..";"..(c*bs)..";0;0")
	SKIN:Bang("!SetOption","Game"..i,"ColorMatrix4","0;0;0;1;0")
	SKIN:Bang("!SetOption","Game"..i,"ColorMatrix5",tl..";"..tl..";"..tl..";0;1")
	SKIN:Bang("!UpdateMeter","Game"..i)
	SKIN:Bang("!Redraw")
end

function Initialize()
	rows = SKIN:GetVariable("rows")
	spacing = SKIN:GetVariable("spacing")
	steam = SKIN:GetVariable("steam")
	id = SKIN:GetVariable("id")

	local meterID = id..rows..spacing

	-- decode UNIX time.
	local h,m,s,y,d = SKIN:GetMeasure("UNIX"):GetStringValue():match("(%d+)\\(%d+)\\(%d+)\\(%d+)\\(%d+)")
	unix = ((y-1970)*365 + d + floor((y-1970-1)/4))*86400 + (h*60 + m)*60 + s - 17999

	-- Load counter.
	local file = io.open(SKIN:MakePathAbsolute("count.inc"),"r")
	file:read("*l") -- Skip first line.

	for l in file:lines(1) do
		local k,v = l:match("(.+)=(.+)")
		games_count[k] = tonumber(v) or 0
	end

	-- Setup non-steam games.
	local t = {}
	for k,v in pairs(games_index) do
		k = k:lower()
		meterID = meterID..v[1]
		games[v[1]] = k
		t[k] = v
	
		insert(games_installed,k)
	end

	-- Replace with a lower-case string for searching.
	games_index = t

	-- Collect all games played by this user.
	file = io.open(steam.."\\userdata\\"..id.."\\config\\localconfig.vdf", "r")
	local v = file:read("*all"):match('"Apps"%s-{.-}%s-"LastPlayedTimesSyncTime"')

	file:close()

	-- Collect all installed games in this PC based on the user's library.
	for k in v:gmatch('"(%d-)"%s-{%s-"LastPlayed"%s-"(%d-)"') do
		file = io.open(steam.."\\steamapps\\appmanifest_"..k..".acf", "r")

		if file then
			local v = file:read("*all"):match('"name"%s-"(.-)"'):lower()
			games[k] = v
			games_index[v] = k
			meterID = meterID..k

			insert(games_installed,v)
			file:close()
		end
	end
	
	sort(games_installed)

	-- Make an ordered list for searching.
	libraryID = concat(games_installed,"\\").."\\"

	-- Check if the same.

	file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "r")
	if file then
		local t,v = file:read("*all"):match("#(%d+)/(.-)\n")
		file:close()

		if not t or unix-t >= 86400/2 then
			-- Parse after 12 hours.
			shouldParse = true
			shouldRewrite = true
		else unix = t
		end

		if not v or v ~= meterID then
			shouldRewrite = true
			shouldRefresh = true
		end
	end

	queueBanner()

	-- Setup
	if shouldRewrite then
		local variables = "[Variables]\n"
		local meters = ""
		rows = min(#games_installed,rows)

		for i=0,rows-1 do
			local v = games_index[games_installed[i+1]]

			variables = variables..
				"Game"..i.."Banner="..(type(v) == "table" and v[1] or v).."\n"
			meters = meters..[[
[Game]]..i..[[]
Meter=Image
ImageName=DownloadFile/#Game]]..i..[[Banner#.jpg
MaskImageName=mask
H=(#meterH# - #spacing#)
X=#spacing#
Y=(#meterH#*]]..i..[[ + #spacing#*2 + 40)
LeftMouseUpAction=[!CommandMeasure Script lmb(]]..i..[[)]
RightMouseUpAction=[!CommandMeasure Script rmb(]]..i..[[)]
DynamicVariables=1
Group=GameLibrary

]]
		end

		file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "w")
		file:write("#"..unix.."/"..meterID.."\n\n"..variables.."\n"..meters)
		file:close()

		meterDone = true
		if bannerDone and shouldRefresh then
			SKIN:Bang("!Refresh")
		end
	end
end
