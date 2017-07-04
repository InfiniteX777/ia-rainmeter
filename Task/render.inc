[Rainmeter]
Update=1000
DynamicWindowSize=1

[technical]
Meter=Button
ButtonImage=technical
X=1025
Y=1080
LeftMouseUpAction=["I:\Shortcuts\Technical"]

[social]
Meter=Button
ButtonImage=social
X=935
Y=1080
LeftMouseUpAction=["I:\Shortcuts\Social"]

[online]
Meter=Button
ButtonImage=online
X=845
Y=1080
LeftMouseUpAction=["I:\Shortcuts\Online Game"]

[offline]
Meter=Button
ButtonImage=offline
X=755
Y=1080
LeftMouseUpAction=["I:\Shortcuts\Offline Game"]

[edge]
Meter=Button
ButtonImage=edge
X=665
Y=1080
LeftMouseUpAction=[shell:Appsfolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge][!SetOption edge_open ImageAlpha 255]
MouseOverAction=[!HideMeter edge_open]
MouseLeaveAction=[!ShowMeter edge_open]

[edge_process]
Measure=Plugin
Plugin=Process
ProcessName=MicrosoftEdge.exe
UpdateDivider=3
IfCondition=edge_process = 1
IfTrueAction=[!SetOption edge_open ImageAlpha 255]
IfFalseAction=[!SetOption edge_open ImageAlpha 0]

[edge_open]
Meter=Image
ImageName=edge_open
X=665
Y=1080
ImageAlpha=0

[firefox]
Meter=Button
ButtonImage=firefox
X=575
Y=1080
LeftMouseUpAction=["F:\Program Files (x86)\Mozilla Firefox\firefox.exe"][!SetOption firefox_open ImageAlpha 255]
MouseOverAction=[!HideMeter firefox_open]
MouseLeaveAction=[!ShowMeter firefox_open]

[firefox_process]
Measure=Plugin
Plugin=Process
ProcessName=firefox.exe
UpdateDivider=3
IfCondition=firefox_process = 1
IfTrueAction=[!SetOption firefox_open ImageAlpha 255]
IfFalseAction=[!SetOption firefox_open ImageAlpha 0]

[firefox_open]
Meter=Image
ImageName=firefox_open
X=575
Y=1080
ImageAlpha=0

[notepadplusplus]
Meter=Button
ButtonImage=notepadplusplus
X=485
Y=1080
LeftMouseUpAction=["F:\Program Files\Notepad++\notepad++.exe"][!SetOption notepadplusplus_open ImageAlpha 255]
MouseOverAction=[!HideMeter notepadplusplus_open]
MouseLeaveAction=[!ShowMeter notepadplusplus_open]

[notepadplusplus_process]
Measure=Plugin
Plugin=Process
ProcessName=notepad++.exe
UpdateDivider=3
IfCondition=notepadplusplus_process = 1
IfTrueAction=[!SetOption notepadplusplus_open ImageAlpha 255]
IfFalseAction=[!SetOption notepadplusplus_open ImageAlpha 0]

[notepadplusplus_open]
Meter=Image
ImageName=notepadplusplus_open
X=485
Y=1080
ImageAlpha=0

[atom]
Meter=Button
ButtonImage=atom
X=395
Y=1080
LeftMouseUpAction=[C:\Users\Infin\AppData\Local\atom\atom.exe][!SetOption atom_open ImageAlpha 255]
MouseOverAction=[!HideMeter atom_open]
MouseLeaveAction=[!ShowMeter atom_open]

[atom_process]
Measure=Plugin
Plugin=Process
ProcessName=atom.exe
UpdateDivider=3
IfCondition=atom_process = 1
IfTrueAction=[!SetOption atom_open ImageAlpha 255]
IfFalseAction=[!SetOption atom_open ImageAlpha 0]

[atom_open]
Meter=Image
ImageName=atom_open
X=395
Y=1080
ImageAlpha=0

[recyclebin_process]
Measure=Plugin
Plugin=RecycleManager.dll
RecycleType=Count
UpdateDivider=3

[recyclebin_calc]
Measure=Calc
Formula=(recyclebin_process > 0 ? Clamp((1-recyclebin_process/10)*70,0,60) : 70)+1080
[recyclebin]
Meter=Button
ButtonImage=recyclebin
X=1115
Y=1080
MouseOverAction=[!HideMeter recyclebin_full]
MouseLeaveAction=[!ShowMeter recyclebin_full]
LeftMouseUpAction=["::{645FF040-5081-101B-9F08-00AA002F954E}"]
ToolTipText=[recyclebin_process] Item(s)
DynamicVariables=1

[recyclebin_full]
Meter=Image
ImageName=full
ImageCrop=0,[recyclebin_calc],70,70,0
X=1115
Y=[recyclebin_calc]
DynamicVariables=1
