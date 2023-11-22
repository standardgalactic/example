#SingleInstance,Force
;menu Open Settings
x:=Studio()
File:=x.Current(2).file
SplitPath,file,,dir
for a,b in ["Settings.xml","Settings.ini"]
	loop,files,%dir%\%b%,R
	{
		Run,%A_LoopFileFullPath%
		Break,2
	}
ExitApp