;Menu Remove Blank Lines
x:=Studio(),sc:=x.sc,text:=sc.getuni(),text:=RegExReplace(text,"\n\s*\n","`n"),x.SetText(text)
