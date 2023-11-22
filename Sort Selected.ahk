#SingleInstance,Force
;menu Sort Selected
x:=Studio(),sc:=x.sc()
if(sc.2008=sc.2009)
	sc.2160(sc.2128(line:=sc.2166(sc.2008)),sc.2136(line))
text:=sc.getseltext(),del:=x.call["InputBox",x.hwnd(1),"Sort Selection","Enter a delimiter to sort by. \ will sort by ``n","\"]
if(del=""||ErrorLevel)
	return
del:=del="\"?"":del
Sort,text,D%del%
StringReplace,text,text,`n,`r`n,all
x.ReplaceSelected(RegExReplace(text,"\R","`n"))
ExitApp