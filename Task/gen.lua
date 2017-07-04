local list = {
	{
		"technical",
		'"I:\\Shortcuts\\Technical"'
	},
	{
		"social",
		'"I:\\Shortcuts\\Social"'
	},
	{
		"online",
		'"I:\\Shortcuts\\Online Game"'
	},
	{
		"offline",
		'"I:\\Shortcuts\\Offline Game"'
	},
	{
		"edge",
		"shell:Appsfolder\\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge",
		"MicrosoftEdge.exe"
	},
	{
		"firefox",
		'"F:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe"',
		"firefox.exe"
	},
	{
		"notepadplusplus",
		'"F:\\Program Files\\Notepad++\\notepad++.exe"',
		"notepad++.exe"
	},
	{
		"atom",
		"C:\\Users\\Infin\\AppData\\Local\\atom\\atom.exe",
		"atom.exe"
	},
	--[[{
		"github",
		'"C:\\Users\\Michael\\AppData\\Local\\GitHub\\GitHub.appref-ms"',
		"GitHub.exe"
	}]]
}
local y = 1080

function Initialize()
	local file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "w")

	file:write(
		"[Rainmeter]"..
		"\nUpdate=1000"..
		"\nDynamicWindowSize=1\n\n"
	)

	local dis = (#list*90-20+90)/2
	for i,v in pairs(list) do
		local x = (#list-i)*90+dis

		file:write(
			"["..v[1].."]"..
			"\nMeter=Button"..
			"\nButtonImage="..v[1]..
			"\nX="..x..
			"\nY="..y..
			"\nLeftMouseUpAction=["..v[2].."]"
		)

		if v[3] then
			local process = v[1].."_process"
			local open = v[1].."_open"

			file:write(
				"[!SetOption "..open.." ImageAlpha 255]"..
				"\nMouseOverAction=[!HideMeter "..open.."]"..
				"\nMouseLeaveAction=[!ShowMeter "..open.."]\n"..
				"\n["..process.."]"..
				"\nMeasure=Plugin"..
				"\nPlugin=Process"..
				"\nProcessName="..v[3]..
				"\nUpdateDivider=3"..
				"\nIfCondition="..process.." = 1"..
				"\nIfTrueAction=[!SetOption "..open.." ImageAlpha 255]"..
				"\nIfFalseAction=[!SetOption "..open.." ImageAlpha 0]\n"..
				"\n["..open.."]"..
				"\nMeter=Image"..
				"\nImageName="..open..
				"\nX="..x..
				"\nY="..y..
				"\nImageAlpha=0"
			)
		end

		file:write("\n\n")
	end

		local x = #list*90+dis
		file:write([[
[recyclebin_process]
Measure=Plugin
Plugin=RecycleManager.dll
RecycleType=Count
UpdateDivider=3

[recyclebin_calc]
Measure=Calc
Formula=(recyclebin_process > 0 ? Clamp((1-recyclebin_process/10)*70,0,60) : 70)+]]..y..[[

[recyclebin]
Meter=Button
ButtonImage=recyclebin
X=]]..x..[[

Y=]]..y..[[

MouseOverAction=[!HideMeter recyclebin_full]
MouseLeaveAction=[!ShowMeter recyclebin_full]
LeftMouseUpAction=["::{645FF040-5081-101B-9F08-00AA002F954E}"]
ToolTipText=[recyclebin_process] Item(s)
DynamicVariables=1

[recyclebin_full]
Meter=Image
ImageName=full
ImageCrop=0,[recyclebin_calc],70,70,0
X=]]..x..[[

Y=[recyclebin_calc]
DynamicVariables=1
]])
	file:close()
end