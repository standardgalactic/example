;menu MsgBox Creator
MsgBox_Creator()
MsgBox_Creator(){
	static
	x:=Studio(),newwin:=new GUIKeep("MsgBox_Creator"),v:=x.get("v"),add:=v.options.add_margins_to_windows?10:0,msgbox:=newwin.hwnd
	Gui,-DPIScale
	newwin.add("Text,,Title:","Edit,w260","Text,,Message:","Edit,w260","ListView,w200 r7 -Multi,Style","ListView,x+0 w60 r7 -Multi Section,Icons","Checkbox,xm,Help","ListView,x" 260+add*2 " y" add " w140 r3 -Multi,Default Button","ListView,w140 r4 -Multi,Mode","Checkbox,,Right Justified","Checkbox,,Right-To-Left","Text,,Timeout:","Edit,x+0 w80 number","Button,xm gtest Default,&Test","Button,x+0 ginsert,Insert","Button,x+0 gclipboard,Copy To Clipboard","Button,x+0 greset,Reset")
	Gui,ListView,SysListView321
	for a,b in StrSplit("OK,OK/Cancel,Abort/Retry/Ignore,Yes/No/Cancel,Yes/No,Retry/Cancel,Cancel/Try Again/Continue",",")
		LV_Add("",b)
	LV_Modify(1,"Select Vis Focus")
	Gui,ListView,SysListView322
	il:=IL_Create(4,1)
	LV_SetImageList(il),LV_Add("icon0","None")
	for a,b in [4,3,2,5]
		LV_Add("Icon" IL_Add(il,"user32.dll",b),"")
	LV_ModifyCol(1,"AutoHDR"),LV_Modify(1,"Select Vis Focus")
	Gui,ListView,SysListView323
	Loop,3
		LV_Add("",A_Index)
	LV_Modify(1,"Select Vis Focus")
	Gui,ListView,SysListView324
	for a,b in ["None","System Modal","Task Modal","Always-On-Top"]
		LV_Add("",b)
	LV_Modify(1,"Select Vis Focus")
	newwin.show("MsgBox Creator")
	Sleep,500
	Gui,Show,AutoSize
	return
	clipboard:
	Clipboard:=CompileBox()
	x.TrayTip("Text coppied to the clipboard")
	return
	reset:
	Loop,3
		ControlSetText,Edit%A_Index%,,% newwin.id
	Loop,4
	{
		Gui,ListView,SysListView32%A_Index%
		LV_Modify(1,"Select Vis Focus")
	}
	Loop,3
		GuiControl,,Button%A_Index%,0
	return
	insert:
	sc:=x.sc(),x.InsertText(CompileBox())
	return
	test:
	obj:=StrSplit(CompileBox(),",")
	MsgBox,% obj.2,% obj.3, % obj.4,% obj.5
	return
}
CompileBox(win:=1){
	for a,b in ["Edit1","Edit2","Edit3"]
		ControlGetText,edit%a%,Edit%a%,A
	Gui,ListView,SysListView321
	total:=LV_GetNext()-1
	Gui,ListView,SysListView322
	icon:={1:0,2:16,3:32,4:48,5:64}
	total+=Icon[LV_GetNext()]
	Gui,ListView,SysListView323
	default:={1:0,2:256,3:512}
	total+=Default[LV_GetNext()]
	Gui,ListView,SysListView324
	mode:={1:0,2:4096,3:8192,4:262144}
	total+=mode[LV_GetNext()]
	other:={1:16384,2:524288,3:1048576}
	Loop,3
	{
		ControlGet,out,Checked,,Button%A_Index%,A
		if(out)
			total+=other[A_Index]
	}
	edit1:=edit1?edit1:"Testing"
	msg=MsgBox,%total%,%edit1%,%edit2%
	msg.=edit3?"," edit3:""
	return msg
}
