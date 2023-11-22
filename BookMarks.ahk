#SingleInstance,Force
;menu Add Bookmark,ab
;menu Delete Bookmark,db
;menu Jump To Next Bookmark,jtnb
;menu Jump To Previous Bookmark,jtpb
;menu Manage Bookmarks,mb
;menu Edit Custom Bookmark,ecb
i=%1%
x:=Studio(),settings:=x.get("settings"),sc:=x.sc(),line:=sc.2166(sc.2008),cexml:=x.get("cexml"),Code_Explorer:=x.get("Code_Explorer"),files:=x.get("files")
if(i="ab"){
	x.call("AddBookmark",line,["#"])
}if(i="db"){
	text:=Trim(sc.getline(line)),start:=sc.2128(line)
	if(RegExMatch(text,"OU)(\s*" Chr(59) "#\[.*\])",found))
		sc.2190(start),sc.2192(sc.2136(line)),pos:=sc.2197(StrLen(found.1),found.1),sc.2645(pos,StrLen(found.1))
}if(i~="jt.b"){
	top:=cexml.ssn("//main[@file='" x.current(2).file "']"),Code_Explorer.scan(x.current()),cur:=sc.2008,check:=cexml.ssn("//main[@file='" x.current(2).file "']/descendant::file[@file='" x.current(3).file "']"),sign:=i="jtnb"?">":"<"
	if(next:=sn(top,"descendant::file[@file='" x.current(3).file "']/descendant::*[@type='Bookmark' and @pos" sign "'" cur "']")){
		ea:=xml.ea((sign=">"?next.item[0]:next.item[next.length-1]))
		if(ea.pos)
			line:=sc.2166(ea.pos),(sign=">")?(start:=sc.2128(line),end:=sc.2136(line)):(start:=sc.2136(line),end:=sc.2128(line)),sc.2160(start,end)
		else{
			if(sign="<")
				count:=sn(top,"descendant::file[@file='" x.current(3).file "']/preceding::*[@type='Bookmark']")
			else
				count:=sn(top,"descendant::file[@file='" x.current(3).file "']/following::*[@type='Bookmark']")
			ea:=xml.ea(count.item[0].ParentNode),pos:=xml.ea(count.item[0])
			if(pos.pos!="")
				x.call("SetPos",{file:ea.file,start:pos.pos,end:pos.pos}),line:=sc.2166(sc.2008),(sign=">")?(start:=sc.2128(line),end:=sc.2136(line)):(start:=sc.2136(line),end:=sc.2128(line)),sc.2160(start,end)
	}}x.call("CenterSel")
	return
}if(i="ecb"){
	if(info:=x.call("InputBox",x.sc().sc,"Custom Bookmark","Enter:`n$project for the project name`n$file for the current file`n[M/dd/yyyy h:mm:sstt] DateTime format",settings.ssn("//bookmark").text))
		settings.add("bookmark").text:=info
}if(i="mb"){
	bookmarks:=cexml.sn("//*[@type='Bookmark']"),tv:=[]
	Gui,Add,TreeView,w500 h500 gtv AltSubmit
	Gui,Add,Button,gdelete Default,Delete
	while,bb:=bookmarks.item[A_Index-1],ea:=xml.ea(bb),pea:=xml.ea(bb.ParentNode){
		if(!tv[pea.file])
			top:=tv[pea.file]:=TV_Add(pea.file)
		tv[TV_Add(ea.text,top)]:={xml:bb,ea:ea,pea:pea}
	}
	Gui,Show
	return
	GuiClose:
	GuiEscape:
	ExitApp
	return
	tv:
	if(bb:=tv[A_EventInfo]){
		x.call("SetPos",{file:bb.pea.file,start:bb.ea.pos,end:bb.ea.pos})
		line:=sc.2166(sc.2008)
		Sleep,200
		sc.2160(sc.2128(line),sc.2136(line))
	}
	return
	delete:
	text:=Trim(sc.getline(line)),start:=sc.2128(line)
	if(RegExMatch(text,"OU)(\s*" Chr(59) "#\[.*\])",found))
		sc.2190(start),sc.2192(sc.2136(line)),pos:=sc.2197(StrLen(found.1),found.1),sc.2645(pos,StrLen(found.1)),TV_Delete(TV_GetSelection())
	return
}
ExitApp