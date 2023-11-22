#SingleInstance,Force
;menu OTB
x:=Studio(),sc:=x.sc,text:=sc.getuni(),settings:=x.get("settings"),pos:=1,list:=[],opos:=sc.2008
while,RegExMatch(text,"O)(\s}\s+(\w+))",found,pos),pos:=found.Pos(2)+found.len(2){
	line:=sc.2166(found.Pos(2)),linepos:=sc.2128(line)
	if(sc.2007(linepos)=125)
		linepos:=sc.2128(line+1)
	style:=sc.2010(linepos)
	if(style~="\b(5|58|57)\b"||found.2="else")
		list.push(found.Pos(1)-1)
}
for a,b in list
	text:=RegExReplace(text,"\s}\s*(\w)","}$1",,1,list[list.MaxIndex()-(A_Index-1)])
while,RegExMatch(text,"}\s+}")
	text:=RegExReplace(text,"\s}\s+}","}}")
text:=RegExReplace(text,"i)\b(else)\b\s+\{","$1{"),text:=RegExReplace(text,"OUi)\b(if\b\(.[^\r|\n]*\))\s+\{","$1{")
x.settext(text)
if(settings.ssn("//@Full_Auto").text)
	x.SetTimer("Fix_Indent")
Sleep,100
sc.2160(opos,opos)