MoogleTTS = {}
local self = MoogleTTS
local selfs = "MoogleTTS"

self.Info = {
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

self.GUI = {
	WindowName = "MoogleTTS##MoogleTTS",
	name = "MoogleTTS",
	NavName = "NPC Dialog TTS",
	MiniName = "MoogleTTS",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = self.GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "A Text-to-Speech module for narrating NPC dialog."
}

self.Settings = {
	enable = true,
	loaded = false,
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
local enable, loaded, ReadToggle, ReadHotkey, ReadToggleLast, LastTalkSpeaker, LastBattleTalkSpeaker, LastTalkString, LastBattleTalkString, LastWideTextStrings, ReadTable, ReadSize, Reading, CurrentRead, NPCTTS, NPCTalk, NPCBattleTalk, NPCWideText = settings.enable, settings.loaded, settings.ReadToggle, settings.ReadHotkey, settings.ReadToggleLast, settings.LastTalkSpeaker, settings.LastBattleTalkSpeaker, settings.LastTalkString, settings.LastBattleTalkString, settings.LastWideTextStrings, settings.ReadTable, settings.ReadSize, settings.Reading, settings.CurrentRead, settings.NPCTTS, settings.NPCTalk, settings.NPCBattleTalk, settings.NPCWideText

self.VBS = [[Dim objVoice : Set objVoice = CreateObject("SAPI.SpVoice")
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

function self.ModuleInit()
	Initialize(self.GUI)
	if not FileExists(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS.vbs]]) then
		FileWrite(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS.vbs]],self.VBS)
	end
	if not FileExists(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]]) then
		FileWrite(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]],"")
	end
end

function self.Draw()
	local main = KaliMainWindow.GUI
	local nav = KaliMainWindow.GUI.NavigationMenu
	local settings = self.Settings

	if nav.selected == self.GUI.NavName then
		main.Contents = function()
			settings.NPCTTS = GUI:Checkbox("NPC Dialog Text To Speech",settings.NPCTTS)
			Indent()
				settings.NPCTalk = GUI:Checkbox("Listen to normal NPC Dialog that isn't voice acted.",settings.NPCTalk)
				settings.NPCBattleTalk = GUI:Checkbox("Listen to NPC Dialog in battle.",settings.NPCBattleTalk)
				settings.NPCWideText = GUI:Checkbox("Listen to special notifications which might indicate what a boss is doing.",settings.NPCWideText)
			Unindent()

			local tbl = self.Settings.ReadTable
			local Xend,Yend = GUI:GetContentRegionAvail()
			local Ytrack = 0
			local ReadSize = self.Settings.ReadSize
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
				self.Settings.ReadSize = Yend
			else
				self.Settings.ReadSize = Ytrack
			end
			GUI:Text("TTL HotKey Toggle: ") GUI:SameLine(0,0)
			local ReadHotkey = self.Settings.ReadHotkey
			local ReturnedTable = ReadHotkey
			ReturnedTable = HotKey(ReturnedTable)
			if table.deepcompare(ReadHotkey,ReturnedTable) == false then
				self.Settings.ReadHotkey = table.deepcopy(ReturnedTable)
				MoogleSave("_G.MoogleTTS[Settings][ReadHotkey]")
			end
		end
	end
end

local toggled = false
function self.OnUpdate()
	if FinishedLoading then -- Initiate Locals --
		if loaded then -- Load User Saved Settings --
			if CheckVer then -- Do a version check --
				--local update, tbl = VersionCheck(selfs, self.Info.URL)
				--if update == true then
				--	FileWrite(MooglePath .. [[Moogle Updater.lua]], tbl)
				--	loadstring(tbl)()
				--	CheckVer = false
				--elseif update == false then
				--	CheckVer = false
				--end
			else -- We are running the current version, time for logic --
				if self.Settings.enable then
					local main = KaliMainWindow.GUI
					local nav = KaliMainWindow.GUI.NavigationMenu
					local settings = self.Settings

					if table.find(nav.Menu,self.GUI.NavName) == nil then
						table.insert(nav.Menu,self.GUI.NavName)
					end
					local ReadHotkey = self.Settings.ReadHotkey
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
									local ControlName = e.name
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
			MoogleSave({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.ReadToggle]]] = selfs .. [[.Settings.ReadToggle]],
				[selfs .. [[.ReadHotkey]]] = selfs .. [[.Settings.ReadHotkey]],
				[selfs .. [[.Reading]]] = selfs .. [[.Settings.Reading]],
				[selfs .. [[.NPCTTS]]] = selfs .. [[.Settings.NPCTTS]],
				[selfs .. [[.NPCTalk]]] = selfs .. [[.Settings.NPCTalk]],
				[selfs .. [[.NPCBattleTalk]]] = selfs .. [[.Settings.NPCBattleTalk]],
				[selfs .. [[.NPCWideText]]] = selfs .. [[.Settings.NPCWideText]]
			})
		else
			MoogleLoad({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.ReadToggle]]] = selfs .. [[.Settings.ReadToggle]],
				[selfs .. [[.ReadHotkey]]] = selfs .. [[.Settings.ReadHotkey]],
				[selfs .. [[.Reading]]] = selfs .. [[.Settings.Reading]],
				[selfs .. [[.NPCTTS]]] = selfs .. [[.Settings.NPCTTS]],
				[selfs .. [[.NPCTalk]]] = selfs .. [[.Settings.NPCTalk]],
				[selfs .. [[.NPCBattleTalk]]] = selfs .. [[.Settings.NPCBattleTalk]],
				[selfs .. [[.NPCWideText]]] = selfs .. [[.Settings.NPCWideText]]
			})
			loaded = true
		end
	else
		UpdateLocals()
		if FinishedLoading then
			Initialize(self.GUI)
		end
	end
end

local function RegisterInitFunction() if self.Init then self.Init() end end
local function RegisterDrawFunction() if self.Draw then self.Draw() end end
local function RegisterUpdateFunction() if self.OnUpdate then self.OnUpdate() end end

RegisterEventHandler("Module.Initalize", RegisterInitFunction)
RegisterEventHandler("Gameloop.Draw", RegisterDrawFunction)
RegisterEventHandler("Gameloop.Update", RegisterUpdateFunction)

_G.MoogleTTS = MoogleTTS
-- End of File --
