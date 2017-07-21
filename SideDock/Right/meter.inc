[Variables]
meterID=github/atom/notepadplusplus/firefox/edge/offline/online/social/technical/recyclebin/power/search/
github_color=54,49,56
atom_color=54,49,56
notepadplusplus_color=54,49,56
firefox_color=54,49,56
edge_color=54,49,56
offline_color=54,49,56
online_color=54,49,56
social_color=54,49,56
technical_color=54,49,56
recyclebin_color=54,49,56
power_color=54,49,56
search_color=54,49,56

[github]
Meter=Image
ImageName=github
X=1510
Y=24.615384615385
ImageTint=#github_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption github ImageTint #HoverColor#][!UpdateMeter github][!Redraw]
MouseLeaveAction=[!SetOption github ImageTint #github_color#][!UpdateMeter github][!Redraw]
LeftMouseUpAction=["C:\Users\Infin\AppData\Local\GitHubDesktop\GitHub Desktop.exe"][!SetVariable github_color 255,255,255][!UpdateMeter github][!Redraw]

[github_process]
Measure=Plugin
Plugin=Process
ProcessName="GitHub Desktop.exe"
IfCondition=github_process = 1
IfTrueAction=[!SetVariable github_color 255,255,255][!SetOption github ImageTint 255,255,255][!UpdateMeter github][!Redraw]
IfFalseAction=[!SetVariable github_color #IdleColor#][!SetOption github ImageTint #IdleColor#][!UpdateMeter github][!Redraw]
DynamicVariables=1

[atom]
Meter=Image
ImageName=atom
X=1510
Y=119.23076923077
ImageTint=#atom_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption atom ImageTint #HoverColor#][!UpdateMeter atom][!Redraw]
MouseLeaveAction=[!SetOption atom ImageTint #atom_color#][!UpdateMeter atom][!Redraw]
LeftMouseUpAction=[C:\Users\Infin\AppData\Local\atom\atom.exe][!SetVariable atom_color 255,255,255][!UpdateMeter atom][!Redraw]

[atom_process]
Measure=Plugin
Plugin=Process
ProcessName=atom.exe
IfCondition=atom_process = 1
IfTrueAction=[!SetVariable atom_color 255,255,255][!SetOption atom ImageTint 255,255,255][!UpdateMeter atom][!Redraw]
IfFalseAction=[!SetVariable atom_color #IdleColor#][!SetOption atom ImageTint #IdleColor#][!UpdateMeter atom][!Redraw]
DynamicVariables=1

[notepadplusplus]
Meter=Image
ImageName=notepadplusplus
X=1510
Y=213.84615384615
ImageTint=#notepadplusplus_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption notepadplusplus ImageTint #HoverColor#][!UpdateMeter notepadplusplus][!Redraw]
MouseLeaveAction=[!SetOption notepadplusplus ImageTint #notepadplusplus_color#][!UpdateMeter notepadplusplus][!Redraw]
LeftMouseUpAction=["F:\Program Files\Notepad++\notepad++.exe"][!SetVariable notepadplusplus_color 94,182,84][!UpdateMeter notepadplusplus][!Redraw]

[notepadplusplus_process]
Measure=Plugin
Plugin=Process
ProcessName=notepad++.exe
IfCondition=notepadplusplus_process = 1
IfTrueAction=[!SetVariable notepadplusplus_color 94,182,84][!SetOption notepadplusplus ImageTint 94,182,84][!UpdateMeter notepadplusplus][!Redraw]
IfFalseAction=[!SetVariable notepadplusplus_color #IdleColor#][!SetOption notepadplusplus ImageTint #IdleColor#][!UpdateMeter notepadplusplus][!Redraw]
DynamicVariables=1

[firefox]
Meter=Image
ImageName=firefox
X=1510
Y=308.46153846154
ImageTint=#firefox_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption firefox ImageTint #HoverColor#][!UpdateMeter firefox][!Redraw]
MouseLeaveAction=[!SetOption firefox ImageTint #firefox_color#][!UpdateMeter firefox][!Redraw]
LeftMouseUpAction=["C:\Program Files\Nightly\firefox.exe"][!SetVariable firefox_color 255,106,0][!UpdateMeter firefox][!Redraw]

[firefox_process]
Measure=Plugin
Plugin=Process
ProcessName=firefox.exe
IfCondition=firefox_process = 1
IfTrueAction=[!SetVariable firefox_color 255,106,0][!SetOption firefox ImageTint 255,106,0][!UpdateMeter firefox][!Redraw]
IfFalseAction=[!SetVariable firefox_color #IdleColor#][!SetOption firefox ImageTint #IdleColor#][!UpdateMeter firefox][!Redraw]
DynamicVariables=1

[edge]
Meter=Image
ImageName=edge
X=1510
Y=403.07692307692
ImageTint=#edge_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption edge ImageTint #HoverColor#][!UpdateMeter edge][!Redraw]
MouseLeaveAction=[!SetOption edge ImageTint #edge_color#][!UpdateMeter edge][!Redraw]
LeftMouseUpAction=[shell:Appsfolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge][!SetVariable edge_color 25,118,210][!UpdateMeter edge][!Redraw]

[edge_process]
Measure=Plugin
Plugin=Process
ProcessName=MicrosoftEdge.exe
IfCondition=edge_process = 1
IfTrueAction=[!SetVariable edge_color 25,118,210][!SetOption edge ImageTint 25,118,210][!UpdateMeter edge][!Redraw]
IfFalseAction=[!SetVariable edge_color #IdleColor#][!SetOption edge ImageTint #IdleColor#][!UpdateMeter edge][!Redraw]
DynamicVariables=1

[offline]
Meter=Image
ImageName=offline
X=1510
Y=497.69230769231
ImageTint=#offline_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption offline ImageTint #HoverColor#][!UpdateMeter offline][!Redraw]
MouseLeaveAction=[!SetOption offline ImageTint #offline_color#][!UpdateMeter offline][!Redraw]
LeftMouseUpAction=["I:\Shortcuts\Offline Game"]

[online]
Meter=Image
ImageName=online
X=1510
Y=592.30769230769
ImageTint=#online_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption online ImageTint #HoverColor#][!UpdateMeter online][!Redraw]
MouseLeaveAction=[!SetOption online ImageTint #online_color#][!UpdateMeter online][!Redraw]
LeftMouseUpAction=["I:\Shortcuts\Online Game"]

[social]
Meter=Image
ImageName=social
X=1510
Y=686.92307692308
ImageTint=#social_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption social ImageTint #HoverColor#][!UpdateMeter social][!Redraw]
MouseLeaveAction=[!SetOption social ImageTint #social_color#][!UpdateMeter social][!Redraw]
LeftMouseUpAction=["I:\Shortcuts\Social"]

[technical]
Meter=Image
ImageName=technical
X=1510
Y=781.53846153846
ImageTint=#technical_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption technical ImageTint #HoverColor#][!UpdateMeter technical][!Redraw]
MouseLeaveAction=[!SetOption technical ImageTint #technical_color#][!UpdateMeter technical][!Redraw]
LeftMouseUpAction=["I:\Shortcuts\Technical"]

[recyclebin]
Meter=Image
ImageName=recyclebin
X=1510
Y=1065.3846153846
ImageTint=#recyclebin_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption recyclebin ImageTint #HoverColor#][!UpdateMeter recyclebin][!Redraw]
MouseLeaveAction=[!SetOption recyclebin ImageTint #recyclebin_color#][!UpdateMeter recyclebin][!Redraw]
LeftMouseUpAction=["::{645FF040-5081-101B-9F08-00AA002F954E}"]

[recyclebin_process]
Measure=Plugin
Plugin=RecycleManager.dll
RecycleType=Count

[recyclebin_calc]
Measure=Calc
Formula=recyclebin_process > 0 ? Clamp((1-recyclebin_process/10)*70,0,60) : 70

[recyclebin_y]
Measure=Calc
Formula=recyclebin_calc+1065.3846153846

[recyclebin_full]
Meter=Image
ImageName=recyclebin
ImageTint=255,0,0
ImageCrop=0,[recyclebin_calc],70,70
X=20
Y=[recyclebin_y]
DynamicVariables=1

[power]
Meter=Image
ImageName=power
X=1510
Y=970.76923076923
ImageTint=#power_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption power ImageTint #HoverColor#][!UpdateMeter power][!Redraw]
MouseLeaveAction=[!SetOption power ImageTint #power_color#][!UpdateMeter power][!Redraw]
LeftMouseUpAction=[]

[search]
Meter=Image
ImageName=search
X=1510
Y=876.15384615385
ImageTint=#search_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption search ImageTint #HoverColor#][!UpdateMeter search][!Redraw]
MouseLeaveAction=[!SetOption search ImageTint #search_color#][!UpdateMeter search][!Redraw]
LeftMouseUpAction=[!CommandMeasure search_input "ExecuteBatch 1"]

[search_input]
Measure=Plugin
Plugin=InputText
W=480
H=45
X=560
Y=1075
Padding=10,10,10,10
StringAlign=Center
SolidColor=54,49,56
FontColor=242,206,218
FontFace=Segoe UI
FontSize=24
AntiAlias=1
Search=
Command1=[!SetOption search_input Search "$UserInput$"][!CommandMeasure Script search()] 

