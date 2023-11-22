;menu Upload
#SingleInstance,Force
clipboard:=""
global settings,vversion,node,newwin,v
x:=Studio(),v:=x.get("v"),vversion:=x.get("vversion"),settings:=x.get("settings"),ControlList:={compile:"Button1",dir:"Edit2",upver:"Button3",versstyle:"Button4",upgithub:"Button5"}
newwin:=new GUIKeep("Upload"),newwin.add("Text,,&Versions:","TreeView,w360 h120 gtv AltSubmit,,w","Text,,Version &Information:","Edit,w360 h200 gedit vedit,,wh","Text,,Directory:,y","Edit,x+2 w200 vdir,,yw","Text,section xm,&FTP Server:,y","DDL,x+10 ys w200 vserver," lst ",yw","Checkbox,vcompile xm,Co&mpile,y","Checkbox,vgistversion xm Disabled,Update Gist Version,y","Checkbox,vupver,Upload &without progress bar (a bit more stable),y","Checkbox,vversstyle,&Remove (Version=) from the " chr(59) "auto_version,y","Checkbox,vupgithub,Update &GitHub,y","Button,w200 gupload xm Default,&Upload,y","Button,x+5 gverhelp -TabStop,&Help,y"),newwin.show("Upload"),node:=node()
for a,b in ControlList
	if(value:=ssn(node,"@" a).text)
		GuiControl,upload:,%b%,%value%
list:=settings.sn("//ftp/server/@name"),lst:="Choose a server...|"
while,ll:=list.item[A_Index-1]
	lst.="|" ll.text
if list.length=1
	lst:=list.item[0].text "||"
GuiControl,Upload:,ComboBox1,%lst%
GuiControl,Upload:ChooseString,ComboBox1,% node.selectsinglenode("@server").text
Hotkey,IfWinActive,% newwin.id
for a,b in {"^Down":"Arrows","^Up":"Arrows","~RButton":"RButton","~Delete":"Delete","F1":"compilever","F2":"clearver","F3":"wholelist"}
	Hotkey,%a%,%b%,On
PopVer()
ControlFocus,Edit1,% newwin.id
return
uploadclose(){
	global ControlList
	set:=newwin[],node:=node()
	newwin.savepos()
	for a,b in ControlList
		node.SetAttribute(a,set[a])
	ExitApp
}
uploadescape(){
	uploadclose()
}
upload(){
	global x
	info:=newwin[]
	ftp:=x.get("ftp"),f:=new ftp(info.server)
	if(f.Error)
		return
	r:=f.put(ssn(node(),"@file").text,info.dir,info.compile)
	if(r)
		m("Transfer complete")
	if(info.upgithub)
		Run,plugins\Github Repository.ahk
	uploadclose()
	return
}
tv(){
	if(A_GuiEvent="S"){
		default(),cn:=ssn(node(),"descendant::version[@tv='" TV_GetSelection() "']")
		GuiControl,upload:,Edit1,% text(cn.text)
	}
}
edit(){
	default(),info:=newwin[],cn:=ssn(node(),"descendant::version[@tv='" TV_GetSelection() "']"),cn.text:=info.edit
}
RButton(){
	MouseGetPos,,,whwnd,control
	if(whwnd!=newwin.hwnd&&control!="SysTreeView321")
		return
	default(),cn:=ssn(node(),"descendant::version[@tv='" TV_GetSelection() "']")
	InputBox,nv,Enter a new version number,New Version Number,,,,,,,,% ssn(cn,"@number").text
	if(ErrorLevel||nv="")
		return
	cn.SetAttribute("number",nv),PopVer()
}
node(){
	global x
	if(!node:=vversion.ssn("//info[@file='" x.current(2).file "']"))
		node:=vversion.under(vversion.ssn("//*"),"info"),node.SetAttribute("file",x.current(2).file),top:=vversion.under(node,"versions"),next:=vversion.under(top,"version"),next.SetAttribute("number",1)
	return node
}
default(){
	Gui,upload:Default
}
delete(){
	ControlGetFocus,Focus,% newwin.id
	if(Focus="SysTreeView321"){
		default(),cn:=ssn(node(),"descendant::version[@tv='" TV_GetSelection() "']")
		select:=cn.nextsibling?cn.nextsibling:cn.previoussibling?cn.previoussibling:""
		if(select)
			select.SetAttribute("select",1)
		cn.ParentNode.RemoveChild(cn),PopVer()
	}
}
PopVer(){
	GuiControl,upload:-Redraw,SysTreeView321
	all:=sn(mainnode:=node(),"descendant::version"),TV_Delete()
	while,aa:=all.item[A_Index-1]
		aa.SetAttribute("tv",TV_Add(ssn(aa,"@number").text))
	if(tv:=ssn(node(),"descendant::*[@select=1]/@tv").text){
		TV_Modify(tv,"Select Vis Focus")
		GuiControl,upload:+Redraw,SysTreeView321
		TV_Modify(tv,"Select Vis Focus")
	}
	else
		TV_Modify(TV_GetChild(0),"Select Vis Focus")
	while,rem:=ssn(mainnode,"descendant::*[@select=1]")
		rem.RemoveAttribute("select")
	GuiControl,upload:+Redraw,SysTreeView321
}
Arrows(){
	default(),TV_GetText(vers,TV_GetSelection()),ver:=StrSplit(vers,"."),version:="",current:=ssn(node(),"descendant::version[@number='" vers "']"),last:=ver[ver.MaxIndex()]
	for a,b in ver
		if(a!=ver.MaxIndex())
			build.=b "."
	if(A_ThisHotkey="^Up"){
		if(next:=current.previoussibling)
			return TV_Modify(next.SelectSingleNode("@tv").text,"Select Vis Focus")
		build.=last+1,parent:=current.ParentNode,new:=vversion.under(parent,"version"),new.SetAttribute("number",build),new.SetAttribute("select",1),parent.InsertBefore(new,current),PopVer()
	}else{
		if(next:=current.nextsibling)
			return TV_Modify(next.SelectSingleNode("@tv").text,"Select Vis Focus")
		if(last-1<0)
			return m("Minor versions can not go below 0","Right Click to change the major version")
		build.=last-1
		parent:=current.ParentNode,new:=vversion.under(parent,"version"),new.SetAttribute("number",build),new.SetAttribute("select",1),PopVer()
	}
}
Add(vers){
	if(nn:=ssn(node:=node(),"descendant::version[@number='" vers "']"))
		return nn
	list:=sn(node,"versions/version"),root:=ssn(node,"versions"),newnode:=vversion.under(root,"version"),newnode.SetAttribute("number",vers)
	while,ll:=list.item[A_Index-1],ea:=xml.ea(ll){
		if(vers>ea.number){
			root.insertbefore(newnode,ll),PopVer()
			Break
		}
	}
	return node
}
verhelp(){
	m("Right Click to change a version number`nCtrl+Up/Down to increment versions`nF1 to build a version list (will be copied to your Clipboard)`nF2 to clear the list`nF3 to copy your entire list to the Clipboard`nPress Delete to remove a version")
}
compilever:
if(!init)
	clipboard:="",init:=1
default(),TV_GetText(ver,TV_GetSelection())
WinGetPos,,,w,,% newwin.id
nn:=ssn(node(),"descendant::*[@number='" ver "']"),number:=settings.ea(nn).number,text:=text(nn.text),vertext:=number&&text?number "`r`n" text:""
if(vertext){
	Clipboard.=vertext "`r`n"
	ToolTip,%Clipboard%,%w%,0,2
}else
	m("Add some text")
return
clearver:
clipboard:=""
ToolTip,,,,2
return
wholelist:
list:=sn(node,"versions/version")
Clipboard:=""
while,ll:=list.item[A_Index-1]
	Clipboard.=ssn(ll,"@number").text "`r`n" text(Trim(ll.text,"`r`n")) "`r`n"
m("Version list copied to your clipboard.","","",Clipboard)
return
Text(text){
	return RegExReplace(text,"\x7f","`r`n")
}