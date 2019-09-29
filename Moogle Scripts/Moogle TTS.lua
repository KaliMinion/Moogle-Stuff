local MoogleTTS = {}
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
	name = "Moogle TTS",
	NavName = "NPC Dialog TTS",
	MiniName = "MoogleTTS",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = "..selfs..".GUI.NavName"),
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
local settings = self.Settings
local enable, loaded, ReadToggle, ReadHotkey, ReadToggleLast, LastTalkSpeaker, LastBattleTalkSpeaker, LastBattleTalkString, LastWideTextStrings, ReadTable, ReadSize, Reading, CurrentRead, NPCTTS, NPCTalk, NPCBattleTalk, NPCWideText = settings.enable, settings.loaded, settings.ReadToggle, settings.ReadHotkey, settings.ReadToggleLast, settings.LastTalkSpeaker, settings.LastBattleTalkSpeaker, settings.LastBattleTalkString, settings.LastWideTextStrings, settings.ReadTable, settings.ReadSize, settings.Reading, settings.CurrentRead, settings.NPCTTS, settings.NPCTalk, settings.NPCBattleTalk, settings.NPCWideText

self.Data = {
	Initialized = false,
	VoiceInfo = {},
	VoiceNames = {},
	Dialog = {
		Talk = {
			LastSpeaker = "",
			LastString = ""
		},
		BattleTalk = {
			LastSpeaker = "",
			LastString = ""
		},
		WideText = {}
	},
	Play = true
}
local data = self.Data

function self.ModuleInit()
	Initialize(self.GUI)
	--		if not FileExists(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS.vbs]]) then
	--			FileWrite(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS.vbs]],self.VBS)
	--	end
	--	if not FileExists(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]]) then
	--		FileWrite(LuaPath..[[MoogleStuff Files\Moogle Scripts\Moogle TTS\TTS Status.txt]],"")
	--	end
end

self.Filter = {
	["%\xe2%\x94%\x80"] = [[ = ]],
	["%\x02%\x10%\x01%\x03"] = "",
	["\xe2\x94\x80"] = "... - ",
	["%\x02%\x13%\x06%\xfe%\xff%`%\xb8%\xfa%\x03%\xee%\x81%\x91%\x02%\x13%\x02%\xec%\x03"] = "left mouse button",
	["%\r"] = " ",
	["%<"] = " - ",
	["%>"] = " - ",
	["\xe2\x80\x9c"] = [[']],
	["\xe2\x80\x9d"] = [[']],
	["\xee\x80\xb3"] = "itemset level "
	--	[ [[]] ] = "",
}
function self.ProcessString(str)
	for k,v in pairs(self.Filter) do
		str = str:gsub(k,v)
	end
	return str
end

local SpeechInitialized,LastVoice,LastRate,LastVolume
function self.Speak(str)
	if Type(str,"string") then
		str = self.ProcessString(str)
		if SpeechInitialized then
			if LastVoice ~= data.SelectedVoiceName then
				OS.CMDStream(selfs.."Data.CMD","Moogle TTS Voice",[[$speech.SelectVoice("]]..data.SelectedVoiceName..[[")]].."\r\n")
				LastVoice = data.SelectedVoiceName
			end
			if LastRate ~= data.Rate then
				OS.CMDStream(selfs.."Data.CMD","Moogle TTS Voice",[[$speech.Rate = ]]..data.Rate.."\r\n")
				LastRate = data.Rate
			end
			if LastVolume ~= data.Volume then
				OS.CMDStream(selfs.."Data.CMD","Moogle TTS Voice",[[$speech.Volume = ]]..data.Volume.."\r\n")
				LastVolume = data.Volume
			end
			OS.CMDStream(selfs.."Data.CMD","Moogle TTS Voice",[[$speech.SpeakAsync("]]..str..[[")]].."\r\n")
		end
	elseif not SpeechInitialized then
		local file = io.open(TempFolder..[[input\Moogle TTS Voice]], "w+") file:write("") file:close()
		OS.CMDStream(selfs.."Data.CMD","Moogle TTS Voice",[[Add-Type -AssemblyName System.speech]].."\r\n"..[[$speech = (New-Object System.Speech.Synthesis.SpeechSynthesizer)]].."\r\n"..[[$speech.SelectVoice("]]..data.SelectedVoiceName..[[")]].."\r\n"..[[$speech.Rate = ]]..data.Rate.."\r\n"..[[$speech.Volume = ]]..data.Volume.."\r\n")
		LastVoice = data.SelectedVoiceName
		LastRate = data.Rate
		LastVolume = data.Volume
		SpeechInitialized = true
	end
end

function self.PlayPause()
	data.Play = not data.Play
	local str
	if data.Play then str = "Resume" else str = "Pause" end
	OS.CMDStream(selfs.."Data.CMD","Moogle TTS Voice",[[$speech.]]..str.."()\r\n")
end

function self.Dispose()
	OS.CMDStream(selfs.."Data.CMD","Moogle TTS Voice",[[$speech.Dispose]].."()\r\n"..[[Add-Type -AssemblyName System.speech]].."\r\n"..[[$speech = (New-Object System.Speech.Synthesis.SpeechSynthesizer)]].."\r\n"..[[$speech.SelectVoice("]]..data.SelectedVoiceName..[[")]].."\r\n"..[[$speech.Rate = ]]..data.Rate.."\r\n"..[[$speech.Volume = ]]..data.Volume.."\r\n")
	data.Play = true
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
				if NotValid(data.VoiceInfo) then
					AddTree("Moogle TTS","Get Installed Voices")
					local result = OS.CMD([[PowerShell -Command "Add-Type -AssemblyName System.speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).GetInstalledVoices().VoiceInfo | ForEach-Object -Process {\"local tbl = { name = '$($_.Name)', age = '$($_.Age)', gender = '$($_.Gender)', description = '$($_.Description)' }; return tbl\"} | Set-Content -Path 'outputfile'"]])
					if result then
						AddTree("Moogle TTS.Get Installed Voices","Valid Result",true)
						for line in result:gmatch("[^\n]+") do
							data.VoiceInfo[#data.VoiceInfo+1] = loadstring(line)()
						end
					end
				else
					if NotValid(data.VoiceNames) then
						for i=1, #data.VoiceInfo do
							data.VoiceNames[#data.VoiceNames+1] = data.VoiceInfo[i].description
							local x,y = GUI:CalcTextSize(data.VoiceInfo[i].description)
							if IsNil(data.SelectedVoiceTextSize) or  x > data.SelectedVoiceTextSize then data.SelectedVoiceTextSize = x end
						end
					end
					if IsNil(data.SelectedVoice) then data.SelectedVoice = data.VoiceNames[1] end
					if IsNil(data.SelectedVoiceIndex) then data.SelectedVoiceIndex = 1 end
					if IsNil(data.SelectedVoiceName) then data.SelectedVoiceName = data.VoiceInfo[1].name end
					if IsNil(data.Rate) then data.Rate = 0 end
					if IsNil(data.Volume) then data.Volume = 100 end

					if ReadToggle then
						local Dialog = data.Dialog
						local Controls = GetControls()
						if Valid(Controls) then
							local c = 0
							for id,e in pairs(Controls) do
								local ControlName = e.name
								local IsOpen = e:IsOpen()
								if ControlName == "Talk" and IsOpen then
									local Talk, str, speaker, dialog = Dialog.Talk, e:GetStrings(), nil, nil
									if data.Initialized then
										if str[3] ~= Talk.LastString then
											Talk.LastString = str[3]
											speaker = str[2]
											if Is(speaker,[[""]],[[???]],[[ ]],[[]]) then speaker = "Unknown Speaker" end
											if Talk.LastSpeaker ~= speaker then
												Talk.LastSpeaker = speaker
												dialog = speaker.." says - "
											else
												dialog = ""
											end
											dialog = dialog..str[3]
											self.Speak(dialog)
										end
									else
										Talk.LastString = str[3]
									end
								end
--								if ControlName == "_BattleTalk" then
--									local BattleTalk, str, speaker, dialog = Dialog.BattleTalk, e:GetStrings(), nil, nil
--									if data.Initialized then
--										if str[5] ~= BattleTalk.LastString then
--											BattleTalk.LastString = str[5]
--											speaker = str[4]
--											if Is(speaker,[[""]],[[???]],[[ ]],[[]]) then speaker = "Unknown Speaker" end
--											if BattleTalk.LastSpeaker ~= speaker then
--												BattleTalk.LastSpeaker = speaker
--												dialog = speaker.." says - "
--											else
--												dialog = ""
--											end
--											dialog = dialog..str[5]
--											self.Speak(dialog)
--										end
--									else
--										BattleTalk.LastString = str[5]
--									end
--								end
								if ControlName == "_WideText" and IsOpen then
									c = c + 1
									local WideText, str = Dialog.WideText, e:GetStrings()[3]
									if data.Initialized then
										if e:IsOpen() then
											if WideText[c] ~= str then
												WideText[c] = str
												if not (str:match("equipped") or
														str:match("selling items") or
														str:match("FATE") or
														str:match("The location affects")
												) then
													self.Speak(str)
												end
											end
										else
											if WideText[c] ~= "" then WideText[c] = "" end
										end
									else
										WideText[c] = str
									end
								end
							end
							data.Initialized = true
						end
					end
				end
			end
			MoogleSave({
				[selfs .. [[.enable]]] = selfs .. [[.enable]],
				[selfs .. [[.ReadToggle]]] = selfs .. [[.ReadToggle]],
				[selfs .. [[.ReadHotkey]]] = selfs .. [[.ReadHotkey]],
				[selfs .. [[.Reading]]] = selfs .. [[.Reading]],
				[selfs .. [[.NPCTTS]]] = selfs .. [[.NPCTTS]],
				[selfs .. [[.NPCTalk]]] = selfs .. [[.NPCTalk]],
				[selfs .. [[.NPCBattleTalk]]] = selfs .. [[.NPCBattleTalk]],
				[selfs .. [[.NPCWideText]]] = selfs .. [[.NPCWideText]]
			})
			if data.SelectedVoice then MoogleSave({[selfs .. [[.SelectedVoice]]] = selfs .. [[.Data.SelectedVoice]]}) end
			if data.SelectedVoiceIndex then MoogleSave({[selfs .. [[.SelectedVoiceIndex]]] = selfs .. [[.Data.SelectedVoiceIndex]]}) end
			if data.SelectedVoiceName then MoogleSave({[selfs .. [[.SelectedVoiceName]]] = selfs .. [[.Data.SelectedVoiceName]]}) end
			if data.Rate then MoogleSave({[selfs .. [[.Rate]]] = selfs .. [[.Data.Rate]]}) end
			if data.Volume then MoogleSave({[selfs .. [[.Volume]]] = selfs .. [[.Data.Volume]]}) end
		else
			MoogleLoad({
				[selfs .. [[.enable]]] = selfs .. [[.enable]],
				[selfs .. [[.ReadToggle]]] = selfs .. [[.ReadToggle]],
				[selfs .. [[.ReadHotkey]]] = selfs .. [[.ReadHotkey]],
				[selfs .. [[.Reading]]] = selfs .. [[.Reading]],
				[selfs .. [[.NPCTTS]]] = selfs .. [[.NPCTTS]],
				[selfs .. [[.NPCTalk]]] = selfs .. [[.NPCTalk]],
				[selfs .. [[.NPCBattleTalk]]] = selfs .. [[.NPCBattleTalk]],
				[selfs .. [[.NPCWideText]]] = selfs .. [[.NPCWideText]],

				[selfs .. [[.SelectedVoice]]] = selfs .. [[.Data.SelectedVoice]],
				[selfs .. [[.SelectedVoiceIndex]]] = selfs .. [[.Data.SelectedVoiceIndex]],
				[selfs .. [[.SelectedVoiceName]]] = selfs .. [[.Data.SelectedVoiceName]],
				[selfs .. [[.Rate]]] = selfs .. [[.Data.Rate]],
				[selfs .. [[.Volume]]] = selfs .. [[.Data.Volume]]
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

function self.Draw()
	if FinishedLoading then
		if settings.enable then
			local main = KaliMainWindow.GUI
			local nav = main.NavigationMenu

			if table.find(nav.Menu,self.GUI.NavName) == nil then
				table.insert(nav.Menu,self.GUI.NavName)
			end
			if nav.selected == self.GUI.NavName then
				main.Contents = function()
					if data.SelectedVoiceIndex and data.SelectedVoiceTextSize then
						if not SpeechInitialized then self.Speak() end
						local h,label,x = GUI:GetTextLineHeightWithSpacing(),nil,nil
						GUI:PushItemWidth(data.SelectedVoiceTextSize + 28)
						local index, changed = GUI:Combo("##SelectVoice",data.SelectedVoiceIndex,data.VoiceNames,#data.VoiceNames)
						if changed then
							data.SelectedVoiceIndex = index
							data.SelectedVoice = data.VoiceNames[index]
							data.SelectedVoiceName = data.VoiceInfo[index].name
						end
						GUI:PopItemWidth() Space()
						if GUI:IsItemClicked(GUI:Image(ImageFolder.."Speaker.png", h * 0.95588235294117647059, h)) then
							self.Speak("You have selected "..data.SelectedVoiceName.." as Moogle Manager's default voice.")
						end
						if data.Play then label = "Pause" x = h * 0.74545454545454545455 else label = "Play" x = h * 0.75438596491228070175 end
						if GUI:IsItemClicked(GUI:Image(ImageFolder..label.."Button.png", x, h)) then
							self.PlayPause()
						end Space()
						GUI:PushItemWidth(100)
						Text("Volume: ",0)
						local value, changed = GUI:SliderInt("##Volume",data.Volume,0,100)
						if changed then
							data.Volume = value
						end
						Space(10)
						Text("Rate: ",0)
						local value,changed = GUI:SliderInt("##Rate",data.Rate,-10,10)
						if changed then
							data.Rate = value
						end
						GUI:PopItemWidth() Space()
						if GUI:IsItemClicked(GUI:Image(ImageFolder.."Trash.png", h, h)) then
							self.Dispose()
						end
					else
						local time = os.clock()
						local c = math.floor(math.floor((time - math.floor(time)) * 10) / 2)
						Text("Loading"..string.rep(".",c))
					end

						--number UV0_x, number UV0_y, number UV1_x, number UV1_y, number framepadding,number bg_col_R, number bg_col_G, number bg_col_B, number bg_col_A, number tint_col_R, number tint_col_G, number tint_col_B, number tint_col_A )






















					--				NPCTTS = GUI:Checkbox("NPC Dialog Text To Speech",NPCTTS)
					--				Indent()
					--				NPCTalk = GUI:Checkbox("Listen to normal NPC Dialog that isn't voice acted.",NPCTalk)
					--				NPCBattleTalk = GUI:Checkbox("Listen to NPC Dialog in battle.",NPCBattleTalk)
					--				NPCWideText = GUI:Checkbox("Listen to special notifications which might indicate what a boss is doing.",NPCWideText)
					--				Unindent()
					--
					--				local tbl = self.ReadTable
					--				local Xend,Yend = GUI:GetContentRegionAvail()
					--				local Ytrack = 0
					--				local ReadSize = self.ReadSize
					--				local Yspace = ml_gui.style.original.itemspacing["y"]
					--				if In(ReadSize,0,1) then ReadSize = 1 else GUI:PushStyleColor(GUI.Col_ChildWindowBg,0,0,0,0.50) end
					--				GUI:BeginChild("#ChatLines",0,ReadSize,false)
					--				GUI:PushTextWrapPos(0)
					--				GUI:PushItemWidth(-1)
					--				if table.valid(tbl) then
					--					local x,y = GUI:GetItemRectSize(GUI:Separator())
					--					Ytrack = Ytrack + y
					--					for k,v in table.pairsbykeys(tbl) do
					--						Ytrack = Ytrack + Yspace
					--						local x1,y1 = GUI:GetItemRectSize(Text(v.."\n"))
					--						Ytrack = Ytrack + Yspace
					--						local x2,y2 = GUI:GetItemRectSize(GUI:Separator())
					--						Ytrack = (Ytrack + y1 + y2) - 1
					--					end
					--				end
					--				GUI:PopItemWidth()
					--				GUI:PopTextWrapPos()
					--				GUI:EndChild()
					--				if not In(ReadSize,0,1) then GUI:PopStyleColor() end
					--				if Ytrack > Yend then
					--					self.ReadSize = Yend
					--				else
					--					self.ReadSize = Ytrack
					--				end
					--				GUI:Text("TTL HotKey Toggle: ") GUI:SameLine(0,0)
					--				local ReadHotkey = self.ReadHotkey
					--				local ReturnedTable = ReadHotkey
					--				ReturnedTable = HotKey(ReturnedTable)
					--				if table.deepcompare(ReadHotkey,ReturnedTable) == false then
					--					self.ReadHotkey = table.deepcopy(ReturnedTable)
					--					MoogleSave("_G.MoogleTTS[Settings][ReadHotkey]")
					--				end
				end
			end
		else
			local main = KaliMainWindow.GUI
			local nav = main.NavigationMenu
			if NotNil(nav.Menu[table.find(nav.Menu,self.GUI.NavName)]) then nav.Menu[table.find(nav.Menu,self.GUI.NavName)] = nil end
		end
	end
end

API.Event("Gameloop.Initalize",selfs,"Initialize",self.Init)
API.Event("Gameloop.Update",selfs,"Update",self.OnUpdate)
API.Event("Gameloop.Draw",selfs,"Draw",self.Draw)

_G.MoogleTTS = MoogleTTS
-- End of File --
