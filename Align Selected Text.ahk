;menu Align Selected Text
#SingleInstance,Force
x:=Studio(),settings:=x.get("settings"),sc:=x.sc()
if(!sel:=sc.getseltext()){
	x.m("You must first select text to align!")
	ExitApp
}
matchStr:=x.call["InputBox",sc.sc,"Align Text","Align text by:",settings.get("//CodeAlign/@last",":=")]
if(!matchStr)
	ExitApp
settings.ssn("//CodeAlign/@last").text:=matchStr,settings.save(1),i:=tpos:=sc.2166(sc.2143),pbot:=sc.2166(sc.2145),ind:=settings.get("//tab",5),hasInd:=0,sc.2025(sc.2143)
while (i<=pbot){
	if(found:=InStr(sc.getline(i),matchStr))
		hasInd:=hasInd?1:(lInd&&lInd!=sc.2127(i)?1:0), lInd:=sc.2127(i), found>maxPos?(maxPos:=found, maxPosL:=i):"", (lInd>maxInd||(lInd=maxInd&&i=maxPosL))?(maxInd:=lInd, maxIndL:=i):""
	i++
}
if(maxPos>1){
	i:=tpos
	sc.2078
	while (i<=pbot){
		if((lInd:=sc.2127(i))<maxInd && i!=maxPosL)
			Loop,% (((maxInd-lInd)//ind)*ind)-1
				str.=" "
		if(found:=InStr(sc.getline(i),matchStr)){
			Loop,% maxPos-found-(hasInd?(maxPosL!=maxIndL?ind-1:0):0)
				str.=" "
			sc.2190(cFound:=sc.2167(i)+found-1),sc.2192(cFound),len:=StrLen(str),sc.2194(len,str)
		}
		str:="",i++
	}
	sc.2079
}
else
	x.m("Alignment string not found...")
ExitApp





