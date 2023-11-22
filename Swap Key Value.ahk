#SingleInstance,Force
;menu Swap Key Value
x:=Studio(),sc:=x.sc,text:=sc.getseltext()
if(!text){
	m("Select the text to swap first")
	ExitApp
}
for a,b in StrSplit(text,","){
	info:=StrSplit(b,":")
	first:=Trim(info.2,Chr(34) ", `t")
	second:=Trim(info.1,Chr(34)", `t")
	quote:=RegExMatch(first,"\W")?Chr(34):""
	list.=quote first quote ":" Chr(34) second Chr(34) ","
}
x.ReplaceSelected(Trim(list,","))
ExitApp