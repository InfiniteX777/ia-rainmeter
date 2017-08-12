local floor,min,max = math.floor,math.min,math.max
local index = 0
local total = 0

--[[{
	image_name=String, -- required
		-- Image to be used (this should be located in the same folder).
		-- This is also used as the meter's name.
	tooltip_name=String, -- required
		-- Shown when hovering on the button.
		-- UNUSED.
	leftexecution=Bang, -- optional (leave nil to disregard.)
		-- Command executed when clicking on the button with LMB.
	rightexecution=Bang, -- optional (leave nil to disregard.)
		-- Command executed when clicking on the button with RMB.
	process_name=String, -- optional (leave nil to disregard.)
		-- Detects if the given process name is active.
		-- Changes the color if it does.
	active_color=Color, -- optional (will only be used and required if process_name is supplied.)
		-- The color state of the button when the process is active.
	custom_code=String -- optional (leave nil to disregard.)
		-- Additional code to add.
}]]

local list = {
	--[[{
		"github",
		"GitHub",
		'["C:\\Users\\Infin\\AppData\\Local\\GitHubDesktop\\GitHubDesktop.exe"]',
		"",
		'"GitHubDesktop.exe"',
		"255,255,255"
	},
	{
		"atom",
		"Atom",
		'["C:\\Users\\Infin\\AppData\\Local\\atom\\atom.exe"]',
		"",
		"atom.exe",
		"255,255,255"
	},
	{
		"notepadplusplus",
		"Notepad++",
		'["F:\\Program Files\\Notepad++\\notepad++.exe"]',
		"",
		"notepad++.exe",
		"94,182,84"
	},
	{
		"firefox",
		"Firefox",
		'["C:\\Program Files\\Nightly\\firefox.exe"]',
		"",
		"firefox.exe",
		"255,106,0"
	},
	{
		"edge",
		"Edge",
		"[shell:Appsfolder\\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge]",
		"",
		"MicrosoftEdge.exe",
		"25,118,210"
	},]]
	{
		"offline",
		"Offline Games",
		'["I:\\Shortcuts\\Offline Game"]'
	},
	{
		"online",
		"Online Games",
		'["I:\\Shortcuts\\Online Game"]'
	},
	{
		"social",
		"Social",
		'["I:\\Shortcuts\\Social"]'
	},
	{
		"audio",
		"Audio",
		'["I:\\Audio"]'
	},
	{
		"media",
		"Media",
		'["I:\\Media"]'
	},
	{
		"workspace",
		"Workspace",
		'["I:\\Workspace"]'
	},
	{
		"downloads",
		"Downloads",
		'["I:\\Downloads"]'
	},
	{
		"technical",
		"Technical",
		'["I:\\Shortcuts\\Technical"]'
	}
}

local list_static = {
	{
		"recyclebin",
		"Recycle Bin",
		'[!CommandMeasure recyclebin_process "OpenBin"]',
		'[!CommandMeasure recyclebin_process "EmptyBin"]',
		nil,
		nil,
		[[
[recyclebin_process]
Measure=Plugin
Plugin=RecycleManager
RecycleType=Count

[recyclebin_calc]
Measure=Calc
Formula=recyclebin_process > 0 ? Clamp((1-recyclebin_process/10)*70,0,60) : 70

[recyclebin_y]
Measure=Calc
Formula=recyclebin_calc+%x%

[recyclebin_full]
Meter=Image
ImageName=recyclebin
ImageTint=255,0,0
ImageCrop=0,[recyclebin_calc],70,70
X=Calc<%WinX%-70-%spacing%>
Y=[recyclebin_y]
DynamicVariables=1]]
	},
	--[[{
		"power",
		"Power",
		""
	},]]
	{
		"search",
		"Search",
		'[!CommandMeasure search_input "ExecuteBatch 1"]',
		nil,
		nil,
		nil,
		[[
[search_input]
Measure=Plugin
Plugin=InputText
W=480
H=45
X=Calc<%WinX%/2-240>
Y=Calc<%WinY%-125>
Padding=10,10,10,10
StringAlign=Center
SolidColor=54,49,56
FontColor=242,206,218
FontFace=Segoe UI
FontSize=24
AntiAlias=1
Search=
Command1=[!SetOption search_input Search "$UserInput$"][!CommandMeasure Script search()] ]]
	},
	{
		"note",
		"Note",
		'["notepad.exe" "#ROOTCONFIGPATH#\\Notes\\note.txt"]',
		'[!ToggleConfig "ia-rainmeter\\Notes" "main.ini"]'
	}
}
local spacing = 20

local search_tag = "firefox/github/atom/notepad++/microsoft edge/offline games/online games/social/technical/recycle bin/paint.net/gimp 2/rainmeter/refresh/steam/"
local search_index = {
	firefox = '"C:\\Program Files\\Nightly\\firefox.exe"',
	github = '"C:\\Users\\Infin\\AppData\\Local\\GitHubDesktop\\GitHubDesktop.exe"',
	atom = '"C:\\ProgramData\\Infin\\atom\\atom.exe"',
	["notepad++"] = '"F:\\Program Files\\Notepad++\\notepad++.exe"',
	edge = "shell:Appsfolder\\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge",
	["offline games"] = '"I:\\Shortcuts\\Offline Game"',
	["online games"] = '"I:\\Shortcuts\\Online Game"',
	social = '"I:\\Shortcuts\\Social"',
	technical = '"I:\\Shortcuts\\Technical"',
	["recycle bin"] = '"::{645FF040-5081-101B-9F08-00AA002F954E}"',
	["paint.net"] = '"F:\\Program Files\\paint.net\\PaintDotNet.exe"',
	["gimp 2"] = '"F:\\Program Files\\GIMP 2\\bin\\gimp-2.8.exe"',
	rainmeter = "!Manage",
	refresh = "!RefreshApp",
	steam = '"F:\\Program Files (x86)\\Steam\\steam.exe"'
}

function search()
	local v = SKIN:GetMeasure("search_input"):GetOption("Search")

	if v:len() == 0 then return end

	if v:lower():match("^google ") then
		SKIN:Bang("http://www.google.com/search?q="..v:sub(8):gsub("%s","+"))
		return
	elseif v:lower():match("^search ") then
		SKIN:Bang('"search-ms:query='..v:sub(8)..'"')
		return
	elseif v:lower():match("^define ") then
		SKIN:Bang("http://www.dictionary.com/browse/"..v:sub(8):gsub("'","-"))
	end

	if v then
		v = search_tag:match("([^/]-"..v..".-)/")
		if v and search_index[v] then
			local t = type(search_index[v])
			if t == "string" then
				SKIN:Bang(search_index[v])
			elseif t == "function" then
				search_index[v]()
			end
		end
	end
end

function write(v,x,variables,meters)
	variables = variables..v[1].."_color="..SKIN:GetVariable("IdleColor").."\n"
	meters = meters.."["..v[1].."]"..
		"\nMeter=Image"..
		"\nImageName="..v[1]..
		"\nX=#X#"..
		"\nY="..x..
		"\nImageTint=#"..v[1].."_color#"..
		"\nDynamicVariables=1"..
		"\nUpdateDivider=-1"..
		"\nMouseOverAction=[!SetOption "..v[1].." ImageTint #HoverColor#][!UpdateMeter "..v[1].."][!Redraw]"..
		"\nMouseLeaveAction=[!SetOption "..v[1].." ImageTint #"..v[1].."_color#][!UpdateMeter "..v[1].."][!Redraw]"..
		"\nRightMouseUpAction="..(v[4] or "")..
		"\nLeftMouseUpAction="..(v[3] or "")

	if v[5] then
		local process = v[1].."_process"
		local open = v[1].."_open"

		meters = meters.."[!SetVariable "..v[1].."_color "..v[6].."][!UpdateMeter "..v[1].."][!Redraw]"..
			"\n\n["..process.."]"..
			"\nMeasure=Plugin"..
			"\nPlugin=Process"..
			"\nProcessName="..v[5]..
			"\nIfCondition="..process.." = 1"..
			"\nIfTrueAction=[!SetVariable "..v[1].."_color "..v[6].."][!SetOption "..v[1].." ImageTint "..v[6].."][!UpdateMeter "..v[1].."][!Redraw]"..
			"\nIfFalseAction=[!SetVariable "..v[1].."_color #IdleColor#][!SetOption "..v[1].." ImageTint #IdleColor#][!UpdateMeter "..v[1].."][!Redraw]"..
			"\nDynamicVariables=1"
	end

	if v[7] then
		meters = meters.."\n\n"..
			v[7]:gsub("%%(.-)%%",{
				x = x,
				WinX = SELF:GetOption("WinX"),
				WinY = SELF:GetOption("WinY"),
				spacing = spacing
			}):gsub("Calc<(.-)>",function(v) return loadstring("return "..v)() end)
	end

	meters = meters.."\n\n"

	return variables,meters
end

function reload(a,b)
	local i = a
	local n = i+index

	if a == -1 then
		i = b-index
		n = b
	end

	if i >= 1 and i <= total then
		local v = list[n]

		if v then
			local hover = SKIN:GetVariable("hover"..i)
			local process = SKIN:GetMeasure(v[1].."_process")
			process = process and process:GetValue() or -1

			SKIN:Bang(
				"!SetOption",
				"meter"..i,
				"ImageTint",
				hover == "1" and "#HoverColor#" or
				process == 1 and v[6] or
				"#IdleColor#"
			)

			if a == -1 then
				SKIN:Bang("!UpdateMeter","meter"..i)
				SKIN:Bang("!Redraw")
			end
		end
	end
end

function wheel(step)
	index = max(0,min(index+step,min(#list-total)))

	for i=1,total do
		local n = i+index
		local v = list[n]
		local d = SKIN:GetMeasure(v and v[1].."_process" or "")

		reload(i)
		SKIN:Bang("!SetOption","meter"..i,"ImageName",v and v[1] or "")
		SKIN:Bang("!UpdateMeter","meter"..i)
	end

	SKIN:Bang("!Redraw")
end

function meterBang(lmb,i)
	local v = list[i+index]

	SKIN:Bang(lmb == 1 and (v[3] or "") or (v[4] or ""))
end

function Initialize()
	local variables = "[Variables]\nmeterID="
	local meters = ""
	local id = ""
	local distance = (SELF:GetOption("WinY")-40)/(70+spacing)
	total = floor(distance)
	distance = ((distance-total)*90-spacing)/(total+1)+spacing
	total = total-#list_static

	-- Generate ID and compare to pre-existing meter.

	for _,v in pairs(list) do
		id = id..v[1].."/"
	end

	for _,v in pairs(list_static) do
		id = id..v[1].."/"
	end

	variables = variables..id..
		"\nS=(#SCREENAREAHEIGHT#/"..SELF:GetOption("WinY")..")"..
		"\nX=(#SCREENAREAWIDTH# - 70 - "..spacing..")\n"

	local file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "r")
	if file then
		local v = file:read("*all"):match("meterID=(.-)\n")

		if v and v == id then
			return
		end
	end

	-- Scrollable List (Top)

	for i=1,total do
		variables = variables..
			"hover"..i.."=0".."\n"

		meters = meters..
			"[meter"..i.."]"..
			"\nMeter=Image"..
			"\nImageName="..(list[i] and list[i][1] or "")..
			"\nH=(70*#S#)"..
			"\nX=#X#"..
			"\nY=("..((i-1)*(70+distance)+distance).."*#S#)"..
			"\nImageTint=#IdleColor#"..
			"\nDynamicVariables=1"..
			"\nUpdateDivider=-1"..
			"\nMouseOverAction=[!SetVariable hover"..i.." 1][!CommandMeasure Script reload("..i..")][!UpdateMeter meter"..i.."][!Redraw]"..
			"\nMouseLeaveAction=[!SetVariable hover"..i.." 0][!CommandMeasure Script reload("..i..")][!UpdateMeter meter"..i.."][!Redraw]"..
			"\nRightMouseUpAction=[!CommandMeasure Script meterBang(0,"..i..")]"..
			"\nLeftMouseUpAction=[!CommandMeasure Script meterBang(1,"..i..")]\n\n"
	end

	-- Processes

	for i,v in pairs(list) do
		if v[5] then
			meters = meters..
				"["..v[1].."_process]"..
				"\nMeasure=Plugin"..
				"\nPlugin=Process"..
				"\nProcessName="..v[5]..
				"\nIfCondition="..v[1].."_process".." = 1"..
				"\nIfTrueAction=[!CommandMeasure Script reload(-1,"..i..")]"..
				"\nIfFalseAction=[!CommandMeasure Script reload(-1,"..i..")]"..
				"\nDynamicVariables=1\n\n"
		end

		if v[7] then
			meters = meters..
				v[7]:gsub("%%(.-)%%",{
					x = x,
					WinX = SELF:GetOption("WinX"),
					WinY = SELF:GetOption("WinY"),
					spacing = spacing
				}):gsub("Calc<(.-)>",function(v) return loadstring("return "..v)() end)..
				"\n\n"
		end
	end

	-- Static List (Bottom)

	for i,v in pairs(list_static) do
		local x = (total-i+#list_static)*(70+distance)+distance

		variables,meters = write(v,x,variables,meters)
	end

	file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "w")
	file:write(variables.."\n"..meters)
	file:close()

	SKIN:Bang("!Refresh")
end
