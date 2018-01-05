MoogleTTS = {}

MoogleTTS.Info = {
	Creator = "Kali",
	Version = "1.1.1",
	StartDate = "09/24/17",
	ReleaseDate = "09/24/17",
	LastUpdate = "09/24/17",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Updated for MoogleLib",
		["1.1.1"] = "Updated Initialize Function"
	}
}

MoogleTTS.GUI = {
	WindowName = "MoogleTTS##MoogleTTS",
	name = "MoogleTTS",
	NavName = "NPC Dialog TTS",
	MiniName = "MoogleTTS",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("MoogleTTS.GUI.open = not MoogleTTS.GUI.open"),
	IsOpen = loadstring("return MoogleTTS.GUI.open"),
	ToolTip = "A Text-to-Speech module for narrating NPC dialog."
}

MoogleTTS.Settings = {
	enable = true,
	ReadToggle = true,
	ReadToggleLast = 0,
	LastTalkSpeaker = "",
	LastBattleTalkSpeaker = "",

	LastTalkString = "",
	LastBattleTalkString = "",
	LastWideTextStrings = {},
	ReadTable = {},
	ReadSize = 1,

	Reading = false,
	CurrentRead = 0,

	NPCTTS = true,
	NPCTalk = true,
	NPCBattleTalk = true,
	NPCWideText = true
}

MoogleTTS.VBS = [[Dim objVoice : Set objVoice = CreateObject("SAPI.SpVoice")
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
next]]

function MoogleTTS.ModuleInit()
	MoogleLib.API.Initialize(MoogleTTS.GUI)
	if not FileExists(GetLuaModsPath()..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS.vbs]]) then
		FileWrite(GetLuaModsPath()..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS.vbs]],MoogleTTS.VBS)
	end
	if not FileExists(GetLuaModsPath()..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]]) then
		FileWrite(GetLuaModsPath()..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]],"")
	end
end

function MoogleTTS.Draw()
	local General = MoogleLib.Lua.general
	local Gui = MoogleLib.Gui
	local NotNil = General.NotNil
	local Indent = Gui.Indent
	local Unindent = Gui.Unindent
	local Text = Gui.Text

	if NotNil(MoogleTTS) and MoogleTTS.Settings.enable then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleTTS.Settings

		if nav.selected == MoogleTTS.GUI.NavName then
			main.Contents = function()
				settings.NPCTTS = GUI:Checkbox("NPC Dialog Text To Speech",settings.NPCTTS)
				Indent()
					settings.NPCTalk = GUI:Checkbox("Listen to normal NPC Dialog that isn't voice acted.",settings.NPCTalk)
					settings.NPCBattleTalk = GUI:Checkbox("Listen to NPC Dialog in battle.",settings.NPCBattleTalk)
					settings.NPCWideText = GUI:Checkbox("Listen to special notifications which might indicate what a boss is doing.",settings.NPCWideText)
				Unindent()

				local tbl = MoogleTTS.Settings.ReadTable
				local Xend,Yend = GUI:GetContentRegionAvail()
				local Ytrack = 0
				local ReadSize = MoogleTTS.Settings.ReadSize
				local Yspace = ml_gui.style.original.itemspacing["y"]
				if In(ReadSize,0,1) then ReadSize = 1 else GUI:PushStyleColor(GUI.Col_ChildWindowBg,0,0,0,0.50) end
				GUI:BeginChild("#ChatLines",0,ReadSize,false)
					GUI:PushTextWrapPos(0)
					GUI:PushItemWidth(-1)
					if table.valid(tbl) then
						local x,y = GUI:GetItemRectSize(GUI:Separator())
						Ytrack = Ytrack + y
						for k,v in table.pairsbykeys(tbl) do
							Ytrack = Ytrack + Yspace
							local x1,y1 = GUI:GetItemRectSize(Text(v.."\n"))
							Ytrack = Ytrack + Yspace
							local x2,y2 = GUI:GetItemRectSize(GUI:Separator())
							Ytrack = (Ytrack + y1 + y2) - 1
						end
					end
					GUI:PopItemWidth()
					GUI:PopTextWrapPos()
				GUI:EndChild()
				if not In(ReadSize,0,1) then GUI:PopStyleColor() end
				if Ytrack > Yend then
					MoogleTTS.Settings.ReadSize = Yend
				else
					MoogleTTS.Settings.ReadSize = Ytrack
				end
			end
		end
	end
end

function MoogleTTS.OnUpdate( event, tickcount )
	local General = MoogleLib.Lua.general
	local NotNil = General.NotNil

	if NotNil(MoogleTTS) and MoogleTTS.Settings.enable then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleTTS.Settings

		if table.find(nav.Menu,MoogleTTS.GUI.NavName) == nil then
			table.insert(nav.Menu,MoogleTTS.GUI.NavName)
		end

		if settings.NPCTTS then
			-- http://cherrytree.at/misc/vk.htm
			if (settings.ReadToggleLast == 0 or TimeSince(settings.ReadToggleLast) > 1000) and (GUI:IsKeyDown(17)) then -- CTRL
				if (GUI:IsKeyDown(16)) then -- SHIFT
					if (GUI:IsKeyDown(18)) then -- ALT
						settings.ReadToggleLast = Now()
						settings.ReadToggle = not ReadToggle
					end
				end
			end
			if settings.ReadToggle then
				for id,e in pairs(GetControls()) do
					if e:IsOpen() then
						ControlName = e.name
						local speaker = ""
						local text = ""

						-- Reduce Table WideText Strings
						if table.size(settings.LastWideTextStrings) >= 50 then
							settings.LastWideTextStrings[1] = nil
						end

						if ControlName == "Talk" and settings.NPCTalk then
							local str = e:GetStrings()
							if str[3] ~= settings.LastTalkString then
								if settings.LastTalkSpeaker ~= str[2] and not In(str[2],"\"\"","???","\?\?\?",""," ",nil) then
									speaker = str[2]
									settings.LastTalkSpeaker = str[2]
								end
								text = str[3]
								settings.LastTalkString = str[3]
							end
						elseif ControlName == "_BattleTalk" and settings.NPCBattleTalk then
							local str = e:GetStrings()
							if str[5] ~= settings.LastBattleTalkString then
								if settings.LastBattleTalkSpeaker ~= str[4] and not In(str[4],"\"\"",""," ",nil) then
									speaker = str[4]
									settings.LastBattleTalkSpeaker = str[4]
								end
								text = str[5]
								settings.LastBattleTalkString = str[5]
							end
						elseif ControlName == "_WideText" and settings.NPCWideText then
							local str = e:GetStrings()
							if not (str[3]:match("equipped") or
									str[3]:match("selling items") or
									str[3]:match("FATE") or
									str[3]:match("The location affects")
									) then -- Filter through unneded TTS Wide Texts
								if not table.contains(settings.LastWideTextStrings,str[3]) then
									text = str[3]
									table.insert(settings.LastWideTextStrings,str[3])
								end
							end
						end

						if text ~= "" then
							text = string.gsub( text, "%\xe2%\x94%\x80", " - ")
							text = string.gsub( text, "%\x02%\x10%\x01%\x03", "")
							text = string.gsub( text, "%\x02%\x13%\x06%\xfe%\xff%`%\xb8%\xfa%\x03%\xee%\x81%\x91%\x02%\x13%\x02%\xec%\x03", "left mouse button")
							text = string.gsub( text, "%\r", " ")
							text = string.gsub( text, "%<", " - ")
							text = string.gsub( text, "%>", " - ")
							text = string.gsub( text, "Kalila", "kahleela")
							-- text = string.gsub( text, "%c", "")

							if speaker ~= "" then
								if In(speaker,"???","\?\?\?") then
									settings.ReadTable[Now()] = "Unknown Speaker says - "..text
								else
									settings.ReadTable[Now()] = speaker.." says - "..text
								end
							else
								settings.ReadTable[Now()] = text
							end
						end
					end
				end
			end
		end
		if table.valid(settings.ReadTable) then
			-- We have lines in our table, first let's find out if we need to remove one --
			local lasttext = ""
			for line in io.lines(GetLuaModsPath()..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]]) do 
				lasttext = tonumber(line)
			end
			if settings.ReadTable[lasttext] ~= nil then
				-- Top line in the table has been read, time to remove it --
				settings.ReadTable[lasttext] = nil
				Reading = false
			end
			if not Reading and table.valid(settings.ReadTable) then
				local lowk = 9999999999
				for k,v in pairs(settings.ReadTable) do if k < lowk then lowk = k end end
				CurrentRead = io.popen([[cscript /nologo "]]..GetLuaModsPath()..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\tts.vbs" -timestamp ]]..lowk..[[ "]]..settings.ReadTable[lowk]..[["]])
				Reading = true
			end
		end
	end
end

RegisterEventHandler("Module.Initalize", MoogleTTS.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleTTS.Draw)
RegisterEventHandler("Gameloop.Update", MoogleTTS.OnUpdate)
