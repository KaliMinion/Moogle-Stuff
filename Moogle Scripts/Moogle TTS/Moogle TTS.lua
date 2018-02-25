MoogleTTS = {}

MoogleTTS.Info = {
	Creator = "Kali",
	Version = "1.1.6",
	StartDate = "09/24/17",
	ReleaseDate = "09/24/17",
	LastUpdate = "09/24/17",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Updated for MoogleLib",
		["1.1.1"] = "Updated Initialize Function",
		["1.1.2"] = "Tweaks and MiniButton support",
		["1.1.3"] = "Pushed Locals"
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
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = MoogleTTS.GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "A Text-to-Speech module for narrating NPC dialog."
}

MoogleTTS.Settings = {
	enable = true,
	ReadToggle = true,
	ReadHotkey = {},
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
local self = "MoogleTTS"

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

local API, Lua, General, Debug, IO, Math, OS, String, Table, Gui, MinionPath, LuaPath, MooglePath, ImageFolder, ScriptsFolder, ACRFolder, SenseProfiles, SenseTriggers, Initialize, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, RecordKeybinds, Error, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, Size, Empty, NotEmpty, d2, DrawDebugInfo, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, MoogleCMDQueue, MoogleDownloadBuffer, CMDTable, CMD, DownloadString, DownloadTable, DownloadFile, VersionCheck, Ping, Split, starts, ends, StrToTable, Valid, NotValid, pairs, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables

local function UpdateLocals1()
	API = MoogleLib.API Lua = MoogleLib.Lua General = Lua.general Debug = Lua.debug IO = Lua.io Math = Lua.math OS = Lua.os String = Lua.string Table = Lua.table Gui = MoogleLib.Gui MinionPath = API.MinionPath LuaPath = API.LuaPath MooglePath = API.MooglePath ImageFolder = API.ImageFolder ScriptsFolder = API.ScriptsFolder ACRFolder = API.ACRFolder SenseProfiles = API.SenseProfiles SenseTriggers = API.SenseTriggers Initialize = API.Initialize Vars = API.Vars Distance2D = API.Distance2D Distance3D = API.Distance3D CurrentTarget = API.CurrentTarget MovePlayer = API.MovePlayer SetTarget = API.SetTarget ConvertCID = API.ConvertCID Entities = API.Entities Entities2 = API.Entities2 EntitiesUpdateInterval = API.EntitiesUpdateInterval EntitiesLastUpdate = API.EntitiesLastUpdate UpdateEntities = API.UpdateEntities CMDKeyPress = API.CMDKeyPress SendKey = API.SendKey RecordKeybinds = API.RecordKeybinds Error = General.Error IsNil = General.IsNil NotNil = General.NotNil Is = General.Is IsAll = General.IsAll Not = General.Not NotAll = General.NotAll Type = General.Type NotType = General.NotType Size = General.Size Empty = General.Empty NotEmpty = General.NotEmpty d2 = Debug.d2 DrawDebugInfo = Debug.DrawDebugInfo Sign = Math.Sign Round = Math.Round Convert4Bytes = Math.Convert4Bytes PowerShell = OS.PowerShell CreateFolder = OS.CreateFolder DeleteFile = OS.DeleteFile MoogleCMDQueue = OS.MoogleCMDQueue MoogleDownloadBuffer = OS.MoogleDownloadBuffer CMDTable = OS.CMDTable CMD = OS.CMD DownloadString = OS.DownloadString DownloadTable = OS.DownloadTable
end

local function UpdateLocals2()
	DownloadFile = OS.DownloadFile VersionCheck = OS.VersionCheck Ping = OS.Ping Split = String.Split starts = String.starts ends = String.ends StrToTable = String.ToTable Valid = Table.Valid NotValid = Table.NotValid pairs = Table.pairs InsertIfNil = Table.InsertIfNil RemoveIfNil = Table.RemoveIfNil UpdateIfChanged = Table.UpdateIfChanged RemoveExpired = Table.RemoveExpired Unpack = Table.Unpack Print = Table.Print WindowStyle = Gui.WindowStyle WindowStyleClose = Gui.WindowStyleClose ColorConv = Gui.ColorConv SameLine = Gui.SameLine Indent = Gui.Indent Unindent = Gui.Unindent Space = Gui.Space Text = Gui.Text Checkbox = Gui.Checkbox Tooltip = Gui.Tooltip GetRemaining = Gui.GetRemaining VirtualKeys = Gui.VirtualKeys OrderedKeys = Gui.OrderedKeys IndexToDecimal = Gui.IndexToDecimal HotKey = Gui.HotKey DrawTables = Gui.DrawTables
end

function MoogleTTS.ModuleInit()
	if MoogleLib ~= nil then
		UpdateLocals1() UpdateLocals2()
		Initialize(MoogleTTS.GUI)
		-- MoogleLoad("MoogleTTS.Settings.ReadHotkey",true)



		MoogleLoad({
			["MoogleTTS.enable"] = "MoogleTTS.Settings.enable",
			["MoogleTTS.ReadToggle"] = "MoogleTTS.Settings.ReadToggle",
			["MoogleTTS.ReadHotkey"] = "MoogleTTS.Settings.ReadHotkey",
			["MoogleTTS.Reading"] = "MoogleTTS.Settings.Reading",
			["MoogleTTS.NPCTTS"] = "MoogleTTS.Settings.NPCTTS",
			["MoogleTTS.NPCTalk"] = "MoogleTTS.Settings.NPCTalk",
			["MoogleTTS.NPCBattleTalk"] = "MoogleTTS.Settings.NPCBattleTalk",
			["MoogleTTS.NPCWideText"] = "MoogleTTS.Settings.NPCWideText"
		})
	end
	if not FileExists(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS.vbs]]) then
		FileWrite(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS.vbs]],MoogleTTS.VBS)
	end
	if not FileExists(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]]) then
		FileWrite(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]],"")
	end
end

function MoogleTTS.Draw()
	if MoogleLib and NotNil(MoogleTTS) then
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
				GUI:Text("TTL HotKey Toggle: ") GUI:SameLine(0,0)
				local ReadHotkey = MoogleTTS.Settings.ReadHotkey
				local ReturnedTable = ReadHotkey
				ReturnedTable = HotKey(ReturnedTable)
				if table.deepcompare(ReadHotkey,ReturnedTable) == false then
					MoogleTTS.Settings.ReadHotkey = table.deepcopy(ReturnedTable)
					MoogleSave("_G.MoogleTTS[Settings][ReadHotkey]")
				end
			end
		end
	end
end

local toggled = false
function MoogleTTS.OnUpdate( event, tickcount )
	if MoogleLib then
		MoogleSave({
			["MoogleTTS.enable"] = "MoogleTTS.Settings.enable",
			["MoogleTTS.ReadToggle"] = "MoogleTTS.Settings.ReadToggle",
			["MoogleTTS.ReadHotkey"] = "MoogleTTS.Settings.ReadHotkey",
			["MoogleTTS.Reading"] = "MoogleTTS.Settings.Reading",
			["MoogleTTS.NPCTTS"] = "MoogleTTS.Settings.NPCTTS",
			["MoogleTTS.NPCTalk"] = "MoogleTTS.Settings.NPCTalk",
			["MoogleTTS.NPCBattleTalk"] = "MoogleTTS.Settings.NPCBattleTalk",
			["MoogleTTS.NPCWideText"] = "MoogleTTS.Settings.NPCWideText"
		})
	end
	if MoogleLib and NotNil(MoogleTTS) and MoogleTTS.Settings.enable then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleTTS.Settings

		if table.find(nav.Menu,MoogleTTS.GUI.NavName) == nil then
			table.insert(nav.Menu,MoogleTTS.GUI.NavName)
		end
		local ReadHotkey = MoogleTTS.Settings.ReadHotkey
		if table.valid(ReadHotkey) then
			local keyspressed = true
			for k,v in pairs(ReadHotkey) do
				v = IndexToDecimal[v]
				if keyspressed then
					if not GUI:IsKeyDown(v) then keyspressed = false end
				end
			end
			if keyspressed then
				if toggled ~= true then toggled = true end
			else
				if toggled then
					settings.NPCTTS = not settings.NPCTTS
					if toggled ~= false then toggled = false end
				end
			end
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
			for line in io.lines(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]]) do 
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
				CurrentRead = io.popen([[cscript /nologo "]]..LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\tts.vbs" -timestamp ]]..lowk..[[ "]]..settings.ReadTable[lowk]..[["]])
				Reading = true
			end
		end
	end
end

RegisterEventHandler("Module.Initalize", MoogleTTS.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleTTS.Draw)
RegisterEventHandler("Gameloop.Update", MoogleTTS.OnUpdate)
