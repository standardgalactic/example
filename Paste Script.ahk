;Menu Paste To p.ahkscript.org
;Menu Paste Clipboard,Clipboard
#NoTrayIcon
#SingleInstance,Force
x:=Studio(),x.autoclose(A_ScriptHwnd)
info=%1%
ea:=settings.ea("//GeekDude")
if(info="Scratch_Pad"){
	sc:=x.sc()
	clipboard:=MePaste(sc.gettext(),ea.name,0,"")
	x.TrayTip(clipboard " has been added to your Clipboard")
	ExitApp
}
if(info="Clipboard"){
	Clipboard:=MePaste(Clipboard,ea.name,"",""),x.TrayTip(Clipboard " has been copied to your clipboard.")
	ExitApp
}
newwin:=new GUIKeep("Paste"),newwin.Add("Edit,vuser w200","DDL,vchannel hwndddl,ahk|ahkscript","Checkbox,vannounce,Announce","Button,ggeekpost Default,Post","Button,x+5 gshowcur,Post Current Segment"),newwin.Show("Paste to ahk.to.us")
ea:=xml.ea(settings.ssn("//GeekDude"))
ControlSetText,Edit1,% ea.user?ea.user:username,% newwin.id
for a,b in {announce:["",ea.announce],channel:["Choose",ea.channel]}
	if(b.2)
		GuiControl,% b.1,%a%,% b.2
return
pasteEscape(){
	pasteClose()
}
pasteClose(){
	global
	Gui,Submit,Nohide
	settings:=x.get("settings")
	new:=settings.Add("GeekDude"),att(new,{user:user,channel:channel,announce:announce})
	ExitApp
	return
}
geekpost:
Gui,Submit,Nohide
Clipboard:=mepaste(x.publish(1),user,announce,channel)
x.TrayTip(Clipboard " Has been added to your Clipboard")
ExitApp
return
showcur:
Gui,Submit,Nohide
sc:=x.sc()
text:=sc.2008=sc.2009?sc.gettext():x.sc().getseltext()
Clipboard:=mepaste(text,user,announce,channel)
x.TrayTip(Clipboard " Has been added to your Clipboard")
ExitApp
return
MePaste(Content,Name:="",Announce:=0,channel:="ahkscript"){
	static URL:="https://p.ahkscript.org/"
	Post:="code=" UriEncode(Content),Post.=name?"&name=" UriEncode(Name):"",Post.=announce?"&announce=on":"",Post.="&channel=#" channel
	Pbin:=ComObjCreate("WinHttp.WinHttpRequest.5.1"),Pbin.Open("POST", URL, False),Pbin.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded"),Pbin.Send(POST)
	if pbin.Status()!=200
		return x.m("Something happened")
	return Pbin.Option(1)
}
UriEncode(Uri, RE="[0-9A-Za-z]"){
	VarSetCapacity(Var,StrPut(Uri,"UTF-8"),0),StrPut(Uri,&Var,"UTF-8")
	While Code:=NumGet(Var,A_Index-1,"UChar")
		Res.=(Chr:=Chr(Code))~=RE?Chr:Format("%{:02X}",Code)
	Return,Res
}
