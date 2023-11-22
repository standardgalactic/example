#SingleInstance,Force
;menu Remove Comments
x:=Studio(),sc:=x.sc()
if ((sPos:=sc.2143)=(ePos:=sc.2145)){
	MsgBox 4148,, Are you sure you want to remove all comments from the current segment?
	IfMsgBox, No
		ExitApp
	sPos:=0, sc.2013
}
else
	sc.2160(sc.2167(sc.2166(sPos)),sc.2136(sc.2166(ePos)))
for c,v in StrSplit(sc.getseltext(),"`n"){
	twoChr:=SubStr(LTrim(v),1,2)
	if (twoChr="/*"){
		bkCom:=True
		continue
	} else if (twoChr="*/"){
		bkCom:=False,txt:=RegExReplace(v,"\*/\s*"),newTxt.=(Trim(txt)?txt:"")
		continue
	} if (bkCom)
		continue
	if (InStr(v,";")){
		txt:=RTrim(RegExReplace(v,"^;.*$|\s+;.*$")," `t`r`n"),newTxt.=Trim(txt)?txt "`n":""
		continue
	} newTxt.=v "`n"
}
sc.2078
sc.2170(0,Trim(newTxt,"`n")), sc.2025(sPos), sc.2079
ExitApp
