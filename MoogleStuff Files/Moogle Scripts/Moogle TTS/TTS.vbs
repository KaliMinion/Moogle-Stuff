Dim objVoice : Set objVoice = CreateObject("SAPI.SpVoice")
Dim args, arg : Set args = WScript.Arguments

Dim setrate : setrate = false
Dim setvolume : setvolume = false
Dim setvoice : setvoice = false
Dim settimestamp : settimestamp = false
Dim timestamp : timestamp = 0

for each arg in args
	if setrate then
		objVoice.Rate = arg : setrate = false
	elseif setvolume then
		objVoice.Volume = arg : setvolume = false
	elseif setvoice then
		Set objVoice.Voice = objVoice.GetVoices.Item(arg) : setvoice = false
	elseif settimestamp then
		timestamp = arg : settimestamp = false
	elseif arg = "-rate" then setrate = true
	elseif arg = "-volume" then setvolume = true
	elseif arg = "-voice" then setvoice = true
	elseif arg = "-timestamp" then settimestamp = true
	elseif arg = "-list" then
		Dim v
		for each v in objVoice.GetVoices
			WScript.Echo(v.GetDescription)
		next
	else
	Set objFSO=CreateObject("Scripting.FileSystemObject")
	strFolder = objFSO.GetParentFolderName(WScript.ScriptFullName)
	Set objFile = objFSO.CreateTextFile(strFolder & "\TTS Status.txt",True)
	objVoice.Speak(arg)
	objFile.Write timestamp & vbCrLf
	objFile.Close
	end if
next