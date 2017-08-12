[Variables]
meterID=offline/online/social/audio/media/workspace/downloads/technical/recyclebin/search/note/
S=(#SCREENAREAHEIGHT#/1200)
X=(#SCREENAREAWIDTH# - 70 - 20)
hover1=0
hover2=0
hover3=0
hover4=0
hover5=0
hover6=0
hover7=0
hover8=0
hover9=0
recyclebin_color=54,49,56
search_color=54,49,56
note_color=54,49,56

[meter1]
Meter=Image
ImageName=offline
H=(70*#S#)
X=#X#
Y=(24.615384615385*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover1 1][!CommandMeasure Script reload(1)][!UpdateMeter meter1][!Redraw]
MouseLeaveAction=[!SetVariable hover1 0][!CommandMeasure Script reload(1)][!UpdateMeter meter1][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,1)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,1)]

[meter2]
Meter=Image
ImageName=online
H=(70*#S#)
X=#X#
Y=(119.23076923077*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover2 1][!CommandMeasure Script reload(2)][!UpdateMeter meter2][!Redraw]
MouseLeaveAction=[!SetVariable hover2 0][!CommandMeasure Script reload(2)][!UpdateMeter meter2][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,2)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,2)]

[meter3]
Meter=Image
ImageName=social
H=(70*#S#)
X=#X#
Y=(213.84615384615*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover3 1][!CommandMeasure Script reload(3)][!UpdateMeter meter3][!Redraw]
MouseLeaveAction=[!SetVariable hover3 0][!CommandMeasure Script reload(3)][!UpdateMeter meter3][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,3)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,3)]

[meter4]
Meter=Image
ImageName=audio
H=(70*#S#)
X=#X#
Y=(308.46153846154*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover4 1][!CommandMeasure Script reload(4)][!UpdateMeter meter4][!Redraw]
MouseLeaveAction=[!SetVariable hover4 0][!CommandMeasure Script reload(4)][!UpdateMeter meter4][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,4)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,4)]

[meter5]
Meter=Image
ImageName=media
H=(70*#S#)
X=#X#
Y=(403.07692307692*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover5 1][!CommandMeasure Script reload(5)][!UpdateMeter meter5][!Redraw]
MouseLeaveAction=[!SetVariable hover5 0][!CommandMeasure Script reload(5)][!UpdateMeter meter5][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,5)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,5)]

[meter6]
Meter=Image
ImageName=workspace
H=(70*#S#)
X=#X#
Y=(497.69230769231*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover6 1][!CommandMeasure Script reload(6)][!UpdateMeter meter6][!Redraw]
MouseLeaveAction=[!SetVariable hover6 0][!CommandMeasure Script reload(6)][!UpdateMeter meter6][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,6)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,6)]

[meter7]
Meter=Image
ImageName=downloads
H=(70*#S#)
X=#X#
Y=(592.30769230769*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover7 1][!CommandMeasure Script reload(7)][!UpdateMeter meter7][!Redraw]
MouseLeaveAction=[!SetVariable hover7 0][!CommandMeasure Script reload(7)][!UpdateMeter meter7][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,7)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,7)]

[meter8]
Meter=Image
ImageName=technical
H=(70*#S#)
X=#X#
Y=(686.92307692308*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover8 1][!CommandMeasure Script reload(8)][!UpdateMeter meter8][!Redraw]
MouseLeaveAction=[!SetVariable hover8 0][!CommandMeasure Script reload(8)][!UpdateMeter meter8][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,8)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,8)]

[meter9]
Meter=Image
ImageName=
H=(70*#S#)
X=#X#
Y=(781.53846153846*#S#)
ImageTint=#IdleColor#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetVariable hover9 1][!CommandMeasure Script reload(9)][!UpdateMeter meter9][!Redraw]
MouseLeaveAction=[!SetVariable hover9 0][!CommandMeasure Script reload(9)][!UpdateMeter meter9][!Redraw]
RightMouseUpAction=[!CommandMeasure Script meterBang(0,9)]
LeftMouseUpAction=[!CommandMeasure Script meterBang(1,9)]

[recyclebin]
Meter=Image
ImageName=recyclebin
X=#X#
Y=1065.3846153846
ImageTint=#recyclebin_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption recyclebin ImageTint #HoverColor#][!UpdateMeter recyclebin][!Redraw]
MouseLeaveAction=[!SetOption recyclebin ImageTint #recyclebin_color#][!UpdateMeter recyclebin][!Redraw]
RightMouseUpAction=[!CommandMeasure recyclebin_process "EmptyBin"]
LeftMouseUpAction=[!CommandMeasure recyclebin_process "OpenBin"]

[recyclebin_process]
Measure=Plugin
Plugin=RecycleManager
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
X=1510
Y=[recyclebin_y]
DynamicVariables=1

[search]
Meter=Image
ImageName=search
X=#X#
Y=970.76923076923
ImageTint=#search_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption search ImageTint #HoverColor#][!UpdateMeter search][!Redraw]
MouseLeaveAction=[!SetOption search ImageTint #search_color#][!UpdateMeter search][!Redraw]
RightMouseUpAction=
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

[note]
Meter=Image
ImageName=note
X=#X#
Y=876.15384615385
ImageTint=#note_color#
DynamicVariables=1
UpdateDivider=-1
MouseOverAction=[!SetOption note ImageTint #HoverColor#][!UpdateMeter note][!Redraw]
MouseLeaveAction=[!SetOption note ImageTint #note_color#][!UpdateMeter note][!Redraw]
RightMouseUpAction=[!ToggleConfig "ia-rainmeter\Notes" "main.ini"]
LeftMouseUpAction=["notepad.exe" "#ROOTCONFIGPATH#\Notes\note.txt"]

