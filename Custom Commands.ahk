#SingleInstance,Force
;menu Custom Commands
global commands,mwin,Studio,win,v:=[],Custom_Commands
Studio:=Studio(),Gui()
AddList(){
	Default("SysTreeView321"),tv:=TV_GetSelection()
	while,(tv!=0){
		if(tv)
			lasttv:=tv
		tv:=TV_GetParent(tv)
	}
	node:=commands.ssn("//*[@tv='" lasttv "']")
	if(!node.NodeName)
		return m("Please select an item in the treeview")
	InputBox,list,New List,This is the word that will trigger this list to show eg(Gui)
	if(ErrorLevel||list="")
		return
	if(ssn(node,"list[text()='" list "']"))
		return m("List already exists")
	commands.under(node,"list",{list:"",select:1},list),PopulateContext(),CloneNode(node)
}
AddListItem(){
	Default("SysTreeView321"),tv:=TV_GetSelection()
	node:=commands.ssn("//*[@tv='" tv "']")
	if(!node.NodeName)
		return m("Please select an item in the treeview")
	InputBox,list,New List Item,% "This is a space Delimited list of words that will pop up when " node.text " is typed",,,,,,,,% ssn(node,"@list").text
	if(ErrorLevel||list="")
		return
	node.SetAttribute("list",list),node.SetAttribute("select",1),CloneNode(node.ParentNode),PopulateContext()
}
AddSyntax(){
	Default("SysTreeView321"),tv:=TV_GetSelection()
	while,(tv!=0){
		if(tv)
			lasttv:=tv
		tv:=TV_GetParent(tv)
	}
	node:=commands.ssn("//*[@tv='" lasttv "']")
	if(!node.NodeName)
		return m("Please select an item in the treeview")
	InputBox,syntax,% "Enter A New syntax for " node.NodeName,% "Example: [,value,prompt] or (required,information)"
	if(ErrorLevel||syntax="")
		return
	commands.under(node,"syntax",{syntax:syntax,select:1})
	Sleep,200
	PopulateContext(),CloneNode(node)
}
CloneCommand(command){
	clone:=commands.ssn("//Commands/commands[text()='" command "']")
	if(!new:=Custom_Commands.ssn("//Commands"))
		new:=Custom_Commands.add("Commands")
	if(rem:=ssn(new,"commands[text()='" command "']"))
		rem.ParentNode.RemoveChild(rem)
	newnode:=clone.CloneNode(1),Custom_Commands.ssn("//Commands").AppendChild(newnode)
}
CloneNode(node){
	if(rem:=Custom_Commands.ssn("//Context/" node.nodename))
		rem.ParentNode.RemoveChild(rem)
	if(!new:=Custom_Commands.ssn("//Context"))
		new:=Custom_Commands.add("Context")
	newnode:=node.CloneNode(1)
	Custom_Commands.ssn("//Context").AppendChild(newnode)
}
ContextTV(x:=0){
	if(A_GuiEvent="S"||x=1){
		Default("SysTreeView321")
		current:=commands.ssn("//*[@tv='" TV_GetSelection() "']")
		if(current.NodeName="list"){
			ea:=xml.ea(current),Default("SysListView323"),LV_Delete()
			for a,b in StrSplit(ea.list," ")
				LV_Add("",b,ssn(current.ParentNode,"syntax[contains(text(),'" b "')]/@syntax").text)
			Loop,2
				LV_ModifyCol(A_Index,"AutoHDR")
		}
		if(current.NodeName="syntax"){
			ea:=xml.ea(current),Default("SysListView323"),LV_Delete()
			for a,b in StrSplit(current.text," ")
				LV_Add("",b,ssn(current.ParentNode,"syntax[contains(text(),'" b "')]/@syntax").text)
			Loop,2
				LV_ModifyCol(A_Index,"AutoHDR")
		}
	}
}
Default(control:="SysTreeView321",window:=""){
	window:=window?window:win
	type:=InStr(Control,"TreeView")?"TreeView":"ListView"
	Gui,%window%:Default
	Gui,%window%:%type%,%control%
}
Delete(){
	ControlGetFocus,Focus,% mwin.id
	if(Focus="SysTreeView321"){
		Default("SysTreeView321"),node:=commands.ssn("//*[@tv='" TV_GetSelection() "']"),TV_GetText(item,TV_GetSelection())
		parent:=node.ParentNode
		if(node.NodeName="syntax"){
			if(m("Are you sure?","btn:yn")="Yes")
				next:=node.NextSibling.nodename="syntax"?node.NextSibling:node.PreviousSibling.NodeName="syntax"?node.PreviousSibling:ssn(node.ParentNode,"syntax")?ssn(node.ParentNode,"syntax"):node.ParentNode,next.SetAttribute("select",1),copy:=node.ParentNode,node.ParentNode.RemoveChild(node),PopulateContext()
		}else if(node.NodeName="list"){
			if(m("Are you sure?","btn:yn")="Yes")
				next:=node.NextSibling.nodename="list"?node.NextSibling:node.PreviousSibling.NodeName="list"?node.PreviousSibling:ssn(node.ParentNode,"list")?ssn(node.ParentNode,"list"):node.ParentNode,next.SetAttribute("select",1),copy:=node.ParentNode,node.ParentNode.RemoveChild(node),PopulateContext()
		}
		CloneNode(parent)
	}if(Focus="SysListView321"){
		Default("SysListView321"),LV_GetText(item,LV_GetNext())
		if(!LV_GetNext())
			return
		if((rem:=Custom_Commands.ssn("//Commands/commands[text()='" item "']")))
			rem.ParentNode.RemoveChild(rem),LV_Delete(LV_GetNext())
	}
}
EditKeyword(){
	Default("SysListView322")
	if(!LV_GetNext())
		return
	if(!color:=Custom_Commands.ssn("//Color"))
		color:=Custom_Commands.add("Color")
	LV_GetText(header,LV_GetNext()),text:=mwin[].edit
	commands.ssn("//Color/" header).text:=text
	if(rem:=Custom_Commands.ssn("//Color/" header))
		rem.ParentNode.RemoveChild(rem)
	Custom_Commands.under(color,header,,text)
}
Enter(){
	ControlGetFocus,Focus,% mwin.id
	if(Focus="SysTreeView321"){
		Default("SysTreeView321"),node:=commands.ssn("//*[@tv='" TV_GetSelection() "']"),TV_GetText(item,TV_GetSelection())
		if(node.NodeName="syntax")
			LinkListSyntax()
		else if(node.nodename="list")
			AddListItem()
		else if(item="list")
			AddList()
		else if(item="syntax")
			AddSyntax()
		else if(node.ParentNode.NodeName="Context")
			AddContext()
		else
			TV_Modify(TV_GetSelection(),"+Expand")
	}else if(Focus="SysListView322")
		ControlFocus,Edit1,% mwin.id
	else if(Focus="SysListView321"){
		InputBox,NewCommand,New Command,Enter the name of a new command (Single Word _ can be used)
		if(ErrorLevel||NewCommand="")
			return
		if(exist:=commands.ssn("//Commands/commands[text()='" NewCommand "']"))
			return exist.SetAttribute("select",1),PopulateCommands()
		commands.under(commands.ssn("//Commands"),"commands",{syntax:"",select:1},NewCommand),PopulateCommands(),CloneCommand(NewCommand)
	}
	else{
		m("WIP")
	}
}
Gui(){
	DetectHiddenWindows,On
	win:="Custom_Commands",mwin:=new GUIKeep(win),mwin.Add("ListView,w500 h200,Command|Syntax,wh","ListView,w200 h200 AltSubmit gPopKW,Keywords,y","Edit,x+M w300 h200 vedit gEditKeyword,,yw","TreeView,xm w200 h300 AltSubmit gContextTV,,y","ListView,x+M w300 h300,List Item|Syntax,yw","Button,xm gHelp,&Help,y")
	commands:=new XML("commands"),CC:=Studio.get("Custom_Commands"),Custom_Commands:=new XML("CC"),Custom_Commands.xml.loadxml(CC[]),commands.xml.loadxml(Studio.get("commands")[]),PopulateCommands(),PopulateKeywords(),PopulateContext()
	mwin.Show("Custom Commands")
	Hotkey,IfWinActive,% mwin.id
	Hotkey,Enter,Enter,On
	Hotkey,Delete,Delete,On
	Hotkey,+Enter,Rename,On
	return
	Custom_Commandsescape:
	return
	Custom_Commandsclose:
	rem:=Custom_Commands.sn("//*[@tv]")
	while,rr:=rem.item[A_Index-1]
		rr.RemoveAttribute("tv")
	mwin.savepos(),CC:=Studio.get("Custom_Commands"),cc.xml.loadxml(Custom_Commands[]),cc.save(1),Studio.call("keywords"),Studio.call("RefreshThemes")
	ExitApp
	return
}
+Escape::
SetTimer,Custom_Commandsclose,-1
return
Help(){
	help=
(
When The Command Listview (Top Control) Has Focus:
	Pressing Enter will Add a new Command to the list
	Pressing Shift+Enter will edit the Syntax for the current Command
When The Treeview (Bottom Left Control) Has Focus:
	Pressing Enter with either the header List or Syntax
		-Will create a new List or Syntax
	Pressing Enter with a Syntax selected will prompt you with a list
		-of items to add to that Syntax
	Pressing Shift+Enter with a Syntax selected will allow you to
		-edit the text of that Syntax
Select an item from the Keywords list and edit the text that comes up:
	This will change the items in that list. Space Delimited!
)
	m(Help)
}
LinkListSyntax(){
	static node
	Default("SysTreeView321"),node:=commands.ssn("//*[@tv='" TV_GetSelection() "']")
	if(node.NodeName!="syntax")
		return m("Please select a syntax from the TreeView")
	list:=sn(node.ParentNode,"list")
	link:=new GUIKeep("Link"),link.add("ListView,w300 h500,Items,wh","Button,glink Default,Link Selected,y"),ex:=RegExReplace(node.text," ","|")
	while,ll:=list.item[A_Index-1],ea:=xml.ea(ll)
		if(node.xml!=ll.xml)
			for a,b in StrSplit(ea.list," ")
				if(b~="i)" ex=0||ex="")
					LV_Add("",b)
	LV_ModifyCol(1,"Sort")
	Hotkey,IfWinActive,% link.id
	Hotkey,Enter,link,On
	link.show("Link")
	return
	linkescape:
	linkclose:
	Gui,link:Destroy
	WinActivate,% mwin.id
	return
	link:
	Default("SysListView321","link"),list:=[]
	while,next:=LV_GetNext()
		LV_GetText(item,next),list.push(item),LV_Modify(next,"-Select")
	top:=node.ParentNode
	for a,b in list{
		remove:=sn(top,"syntax[contains(text(),'" b "')]")
		while,rr:=remove.item[A_Index-1],ea:=xml.ea(rr)
			rr.text:=RegExReplace(RegExReplace(rr.text,"\b" b "\b"),"\s\s"," ")
		node.text:=node.text " " b
	}ContextTV(1),CloneNode(top)
	WinActivate,% mwin.id
	return
}
PopKW(){
	if(A_GuiEvent~="i)I|Normal"){
		GuiControl,+g,Edit1
		Default("SysListView322"),LV_GetText(command,LV_GetNext())
		ControlSetText,Edit1,% commands.ssn("//Color/" command).text,% mwin.id
		GuiControl,+gEditKeyword,Edit1
	}
}
PopulateCommands(){
	Default("SysListView321"),cmd:=commands.sn("//Commands/commands"),LV_Delete()
	GuiControl,-Redraw,SysListView321
	while,cc:=cmd.item[A_Index-1],ea:=xml.ea(cc)
		index:=LV_Add("",cc.text,ea.syntax),select:=ea.select?Index:select
	Loop,2
		LV_ModifyCol(A_Index,"AutoHDR")
	LV_Modify(select?select:1,"Select Vis Focus")
	rem:=commands.sn("//Commands/commands[@select='1']")
	while,rr:=rem.item[A_Index-1]
		rr.RemoveAttribute("select")
	GuiControl,+Redraw,SysListView321
}
PopulateContext(){
	Default("SysTreeView321"),TV_Delete(),list:=commands.sn("//Context/descendant::*"),v.context:=[],syntax:=listtv:=""
	GuiControl,-Redraw,SysTreeView321
	while,ll:=list.item[A_Index-1],ea:=xml.ea(ll){
		if(ll.ParentNode.NodeName="Context")
			ll.SetAttribute("tv",last:=TV_Add(ll.NodeName)),listtv:=TV_Add("List",last),syntax:=TV_Add("Syntax",last)
		else if(ll.NodeName="list")
			ll.SetAttribute("tv",TV_Add(ll.text,listtv))
		else if(ll.NodeName="syntax")
			ll.SetAttribute("tv",TV_Add(ea.syntax,syntax))
	}ea:=xml.ea(node:=commands.ssn("//Context/descendant::*[@select='1']"))
	if(node){
		TV_Modify(ea.tv,"Select VisFirst Focus")
		ControlFocus,SysTreeView321,% mwin.id
	}else
		TV_Modify(TV_GetChild(0),"Select VisFirst Focus")
	sel:=commands.sn("//Context/descendant::*[@select='1']")
	while,ss:=sel.item[A_Index-1]
		ss.RemoveAttribute("select")
	GuiControl,+Redraw,SysTreeView321
	SetTimer,showitem,-200
	return
	showitem:
	Default("SysTreeView321"),TV_Modify(TV_GetSelection(),"Select VisFirst Focus")
	return
}
PopulateKeywords(){
	Default("SysListView322"),LV_Delete(),list:=commands.sn("//Color/*")
	while,ll:=list.item[A_Index-1]
		LV_Add("",ll.NodeName)
	LV_Modify(1,"Select Vis Focus")
}
Rename(){
	ControlGetFocus,Focus,% mwin.id
	if(Focus="SysTreeView321"){
		Default("SysTreeView321"),tv:=TV_GetSelection()
		node:=commands.ssn("//*[@tv='" tv "']")
		if(node.ParentNode.NodeName="Context")
			return AddContext()
		if(!node.NodeName)
			return m("Please select an item in the treeview")
		if(node.NodeName="syntax"){
			InputBox,syntax,New Syntax,Enter the text for the new syntax,,,,,,,,% ssn(node,"@syntax").text
			if(ErrorLevel||syntax="")
				return
			node.SetAttribute("select",1),node.SetAttribute("syntax",syntax),PopulateContext(),CloneNode(node.ParentNode)
		}
	}if(Focus="SysListView321"){
		Default(Focus)
		if(!LV_GetNext())
			return
		LV_GetText(command,LV_GetNext())
		if(node:=commands.ssn("//Commands/commands[text()='" command "']")){
			InputBox,syntax,New Syntax,% "Enter the new syntax for " node.text,,,,,,,,% ssn(node,"@syntax").text
			if(ErrorLevel)
				return
			if(syntax=""){
				if(m("Are you sure?","btn:yn")="Yes")
					node.RemoveAttribute("syntax")
			}else
				node.SetAttribute("syntax",syntax)
			node.SetAttribute("select",1),PopulateCommands(),CloneCommand(command)
		}
	}
}
AddContext(){
	InputBox,context,New Context Start,Enter a word that will start a new context list (2 letters minimum can not start with a number)
	context:=RegExReplace(RegExReplace(context,"\W","_"),"^\d*")
	if(ErrorLevel||StrLen(context)<2)
		return
	node:=commands.under(commands.ssn("//Context"),context),commands.under(node,"list",{list:"",select:1},context),PopulateContext(),CloneNode(node)
}