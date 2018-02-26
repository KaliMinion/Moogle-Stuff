MoogleLib = {
	API = {},
	Lua = {
		debug = {}, 
		general = {}, 
		io = {}, 
		math = {}, 
		os = {}, 
		string = {}, 
		table = {}, 
	},
	Gui = {}, 
}

MoogleLib.Info = {
	Creator = "Kali",
	Version = "1.3.6",
	StartDate = "12/28/17",
	ReleaseDate = "12/30/17",
	LastUpdate = "01/04/18",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Rework for MoogleLib",
		["1.1.1"] = "Teaks",
		["1.1.2"] = "Download Overwrite Fix",
		["1.1.7"] = "Download Overwrite Fix 6...",
		["1.2.0"] = "File Delete Function",
		["1.2.2"] = "New Functions",
		["1.2.3"] = "Download Fixes...again",
		["1.2.4"] = "Download Tweaks and new Functions",
		["1.3.0"] = "Huge rework to fix locals and downloading",
		["1.3.6"] = "Added Save Settings Function"
	}
}

MoogleLib.Settings = {
	loaded = false,
	enable = true,
	MainMenuType = 2,
	MainMenuEntryCreated = false,
	DownloadThreads = 3
}
local loaded = MoogleLib.Settings.loaded
local self = "MoogleLib"

MoogleDebug = {}

local API, Lua, General, Debug, IO, Math, OS, String, Table, Gui, MinionPath, LuaPath, MooglePath, ImageFolder, ScriptsFolder, ACRFolder, SenseProfiles, SenseTriggers, Initialize, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, RecordKeybinds, Error, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, Size, Empty, NotEmpty, d2, DrawDebugInfo, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, MoogleCMDQueue, MoogleDownloadBuffer, CMDTable, CMD, DownloadString, DownloadTable, DownloadFile, VersionCheck, Ping, Split, starts, ends, StrToTable, Valid, NotValid, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables

local function UpdateLocals1()
	API = MoogleLib.API Lua = MoogleLib.Lua General = Lua.general Debug = Lua.debug IO = Lua.io Math = Lua.math OS = Lua.os String = Lua.string Table = Lua.table Gui = MoogleLib.Gui MinionPath = API.MinionPath LuaPath = API.LuaPath MooglePath = API.MooglePath ImageFolder = API.ImageFolder ScriptsFolder = API.ScriptsFolder ACRFolder = API.ACRFolder SenseProfiles = API.SenseProfiles SenseTriggers = API.SenseTriggers Initialize = API.Initialize Vars = API.Vars Distance2D = API.Distance2D Distance3D = API.Distance3D CurrentTarget = API.CurrentTarget MovePlayer = API.MovePlayer SetTarget = API.SetTarget ConvertCID = API.ConvertCID Entities = API.Entities Entities2 = API.Entities2 EntitiesUpdateInterval = API.EntitiesUpdateInterval EntitiesLastUpdate = API.EntitiesLastUpdate UpdateEntities = API.UpdateEntities CMDKeyPress = API.CMDKeyPress SendKey = API.SendKey RecordKeybinds = API.RecordKeybinds Error = General.Error IsNil = General.IsNil NotNil = General.NotNil Is = General.Is IsAll = General.IsAll Not = General.Not NotAll = General.NotAll Type = General.Type NotType = General.NotType Size = General.Size Empty = General.Empty NotEmpty = General.NotEmpty d2 = Debug.d2 DrawDebugInfo = Debug.DrawDebugInfo Sign = Math.Sign Round = Math.Round Convert4Bytes = Math.Convert4Bytes PowerShell = OS.PowerShell CreateFolder = OS.CreateFolder DeleteFile = OS.DeleteFile MoogleCMDQueue = OS.MoogleCMDQueue MoogleDownloadBuffer = OS.MoogleDownloadBuffer CMDTable = OS.CMDTable CMD = OS.CMD DownloadString = OS.DownloadString DownloadTable = OS.DownloadTable
end

local function UpdateLocals2()
	DownloadFile = OS.DownloadFile VersionCheck = OS.VersionCheck Ping = OS.Ping Split = String.Split starts = String.starts ends = String.ends StrToTable = String.ToTable Valid = Table.Valid NotValid = Table.NotValid InsertIfNil = Table.InsertIfNil RemoveIfNil = Table.RemoveIfNil UpdateIfChanged = Table.UpdateIfChanged RemoveExpired = Table.RemoveExpired Unpack = Table.Unpack Print = Table.Print WindowStyle = Gui.WindowStyle WindowStyleClose = Gui.WindowStyleClose ColorConv = Gui.ColorConv SameLine = Gui.SameLine Indent = Gui.Indent Unindent = Gui.Unindent Space = Gui.Space Text = Gui.Text Checkbox = Gui.Checkbox Tooltip = Gui.Tooltip GetRemaining = Gui.GetRemaining VirtualKeys = Gui.VirtualKeys OrderedKeys = Gui.OrderedKeys IndexToDecimal = Gui.IndexToDecimal HotKey = Gui.HotKey DrawTables = Gui.DrawTables
end

function MoogleLib.Init()
	UpdateLocals1() UpdateLocals2()
	MoogleLib.Settings.loaded = true loaded = true
	MoogleLoad({
		["MoogleTTS.enable"] = "MoogleTTS.Settings.enable",
		["MoogleTTS.MainMenuType"] = "MoogleTTS.Settings.MainMenuType",
		["MoogleTTS.DownloadThreads"] = "MoogleTTS.Settings.DownloadThreads",
	})
end
RegisterEventHandler("Module.Initalize", MoogleLib.Init)

-- Helper Variables --

	local API = MoogleLib.API
	local Lua = MoogleLib.Lua
	local Debug = Lua.debug
	local General = Lua.general
	local IO = Lua.io
	local Math = Lua.math
	local OS = Lua.os
	local String = Lua.string
	local Table = Lua.table
	local Gui = MoogleLib.Gui

	API.MinionPath = GetStartupPath()
	API.LuaPath = GetLuaModsPath()
	local LuaPath = API.LuaPath

	API.MooglePath = LuaPath..[[MoogleStuff Files\]]
	local MooglePath = API.MooglePath

	API.ImageFolder = MooglePath..[[Moogle Images\]]
	API.ScriptsFolder = MooglePath..[[Moogle Scripts\]]
	API.ACRFolder = LuaPath..[[ACR\CombatRoutines\]]
	API.SenseProfiles = LuaPath..[[Sense\profiles\]]
	API.SenseTriggers = LuaPath..[[Sense\triggers\]]

-- End Helper Variables --

-- Core Functions & Helper Functions --
	-- API Functions --
		function API.Initialize(ModuleTable)
			local MenuType = MoogleLib.Settings.MainMenuType
			local MainIcon = MoogleLib.API.ImageFolder..[[MoogleStuff.png]]
			local ModuleIcon = MoogleLib.API.ImageFolder..ModuleTable.name..[[.png]]
			local created = MoogleLib.Settings.MainMenuEntryCreated

			-- Create the Main Menu entry if it hasn't been created yet --
				if not created then
					local ImGuiIcon = GetStartupPath().."\\GUI\\UI_Textures\\ImGUI.png"
					local MetricsIcon = GetStartupPath().."\\GUI\\UI_Textures\\Metrics.png"
					local ImGuiToolTip = "ImGui Demo is an overview of what's possible with the UI."
					local MetricsToolTip = "ImGui Metrics shows every window's rendering information, visible or hidden."

					if MenuType == 1 then
						-- No Main Menu Entry --
						-- Adding the ImGUI Test Window as a Minion Menu entry
							ml_gui.ui_mgr:AddMember({ id = "ImGuiDemo", name = "ImGui Demo", onClick = function () ml_gui.showtestwindow = true end, tooltip = ImGuiToolTip, texture = ImGuiIcon}, "FFXIVMINION##MENU_HEADER")
						-- Adding the ImGUI Test Window as a Minion Menu entry
							ml_gui.ui_mgr:AddMember({ id = "ImGuiMetrics", name = "ImGuiMetrics", onClick = function () ml_gui.showmetricswindow = true end, tooltip = MetricsToolTip, texture = MetricsIcon}, "FFXIVMINION##MENU_HEADER")
					elseif MenuType == 2 then
						-- Expansion Submenu inside of Main Menu --
							ml_gui.ui_mgr:AddMember({ id = [[MOOGLESTUFF##MENU_HEADER]], name = "MoogleStuff", texture = MainIcon}, "FFXIVMINION##MENU_HEADER")
						-- Adding the ImGUI Test Window as a Minion Menu entry
							ml_gui.ui_mgr:AddSubMember({ id = "ImGuiDemo", name = "ImGui Demo", onClick = function () ml_gui.showtestwindow = not ml_gui.showtestwindow end, tooltip = ImGuiToolTip, texture = ImGuiIcon}, "FFXIVMINION##MENU_HEADER", "MOOGLESTUFF##MENU_HEADER")
						-- Adding the ImGUI Test Window as a Minion Menu entry
							ml_gui.ui_mgr:AddSubMember({ id = "ImGuiMetrics", name = "ImGuiMetrics", onClick = function () ml_gui.showmetricswindow = not ml_gui.showmetricswindow end, tooltip = MetricsToolTip, texture = MetricsIcon}, "FFXIVMINION##MENU_HEADER", "MOOGLESTUFF##MENU_HEADER")
					elseif MenuType == 3 then
						-- New Component Header that branches off to the right --
							ml_gui.ui_mgr:AddComponent({header = { id = [[MOOGLESTUFF##MENU_HEADER]], expanded = false, name = "MoogleStuff", texture = MainIcon}, members = {}})
						-- Adding the ImGUI Test Window as a Minion Menu entry
							ml_gui.ui_mgr:AddMember({ id = "ImGuiDemo", name = "ImGui Demo", onClick = function () ml_gui.showtestwindow = true end, tooltip = ImGuiToolTip, texture = ImGuiIcon}, "MOOGLESTUFF##MENU_HEADER")
						-- Adding the ImGUI Test Window as a Minion Menu entry
							ml_gui.ui_mgr:AddMember({ id = "ImGuiMetrics", name = "ImGuiMetrics", onClick = function () ml_gui.showmetricswindow = true end, tooltip = MetricsToolTip, texture = MetricsIcon}, "MOOGLESTUFF##MENU_HEADER")
					end

					MoogleLib.Settings.MainMenuEntryCreated = true
				end

			-- Creating Module Entry --
				if MenuType == 1 then
					ml_gui.ui_mgr:AddMember({ id = ModuleTable.WindowName, name = ModuleTable.name, onClick = function () ModuleTable.OnClick() end, tooltip = ModuleTable.ToolTip, texture = ModuleIcon}, "FFXIVMINION##MENU_HEADER")
				elseif MenuType == 2 then
					ml_gui.ui_mgr:AddSubMember({ id = ModuleTable.WindowName, name = ModuleTable.name, onClick = function () ModuleTable.OnClick() end, tooltip = ModuleTable.ToolTip, texture = ModuleIcon}, "FFXIVMINION##MENU_HEADER", "MOOGLESTUFF##MENU_HEADER")
				elseif MenuType == 3 then
					ml_gui.ui_mgr:AddMember({ id = ModuleTable.WindowName, name = ModuleTable.name, onClick = function () ModuleTable.OnClick() end, tooltip = ModuleTable.ToolTip, texture = ModuleIcon}, "MOOGLESTUFF##MENU_HEADER")
				end

			-- Mini Button --
				if ModuleTable.MiniButton then
					local MiniNameStr = ModuleTable.MiniName or ModuleTable.name
					table.insert(ml_global_information.menu.windows, {name = MiniNameStr, openWindow = function() ModuleTable.OnClick() end, isOpen = function() return ModuleTable.IsOpen() end})
				end
		end

		function API.Vars(Tbl,load)
			if In(varstr,"help","Help","?") then
				d([[Save Function Example: Save({["a.b.c[d][test]"] = "MoogleModule.tbl.var"})]])
			else

				local changed = false
				local Type = General.Type
				if Type(Tbl,"table") and table.valid(Tbl) then
					for k,v in pairs(Tbl) do
						local stop = false
						local SaveTable = Settings
						local savevar = ""
						local ModuleTable = _G
						local modvar = ""
						local t = {}
						local t2 = {}
						for w in tostring(k):gmatch("[%P/_/:]+") do
							t[#t+1] = w
						end
						for w in tostring(v):gmatch("[%P/_/:]+") do
							t2[#t2+1] = w
						end

						if Settings["MoogleStuff"] == nil then Settings["MoogleStuff"] = {} end
						SaveTable = Settings["MoogleStuff"]

						for i,e in pairs(t) do
							if i < #t then
								if SaveTable[e] == nil then SaveTable[e] = {} end
								SaveTable = SaveTable[e]
							else
								savevar = e
							end
						end

						for i,e in pairs(t2) do
							if i < #t2 then
								ModuleTable = ModuleTable[e]
							else
								modvar = e
							end
						end

						if load then
							if SaveTable[savevar] == nil then
								SaveTable[savevar] = ModuleTable[modvar]
								changed = true
							end
							ModuleTable[modvar] = SaveTable[savevar]
						else
							if SaveTable[savevar] ~= ModuleTable[modvar] then
								SaveTable[savevar] = ModuleTable[modvar]
								changed = true
							end
						end
					end
				end
				if changed then
					ml_settings_mgr:Save()
				end
			end
		end

		MoogleSave = API.Vars
		function MoogleLoad(Tbl)
			API.Vars(Tbl,true)
		end

		function API.Distance2D(table1,table2)
			if table2 == nil then
				table2 = table1
				table1 = Player
			end
			if table.valid(table1) and table.valid(table2) then
				return (math.sqrt(math.pow((table2.pos.x - table1.pos.x),2)+math.pow((table2.pos.z - table1.pos.z),2))) - (table1.hitradius + table2.hitradius)
			end
		end

		function API.Distance3D(table1,table2)
			if IsNil(table1.pos) then
				table1 = {["pos"] = table1}
				table1["hitradius"] = Player.hitradius
			end
			if IsNil(table2) then
				table2 = Player
			elseif IsNil(table2.pos) then
				table2 = {["pos"] = table2}
				table2["hitradius"] = Player.hitradius
			end

			if table.valid(table1) and table.valid(table2) then
				return (math.sqrt(math.pow((table2.pos.x - table1.pos.x),2)+math.pow((table2.pos.z - table1.pos.z),2)+math.pow((table2.pos.y - table1.pos.y),2))) - (table1.hitradius + table2.hitradius)
			end
		end

		function API.CurrentTarget(check)

			local target = Player:GetTarget()
			if NotNil(target) then
				if IsNil(check) then
					return true
				else
					local t = {};
					local changed = false
					for w in check:gmatch("[%P/_/:]+") do
						t[#t+1] = w
					end
					if table.size(t) == 1 then
						if t[1] == "table" then
							return target
						elseif In(t[1],"2D","Distance2D") then
							return Distance2D(Player, target)
						elseif In(t[1],"3D","Distance3D") then
							return Distance3D(Player, target)
						else
							return target[t[1]]
						end
					else
						local ctarget = target
						for k,v in pairs(t) do
							ctarget = ctarget[v]
						end
						return ctarget
					end
				end
			else
				return false
			end
		end

		local CanTeleport,TeleportTime = true,0
		function API.MovePlayer(pos,map,stopdist)
			local map = map or Player.localmapid
			local ppos = Player.pos
			local pmap = Player.localmapid
			local stopdist = stopdist or 3

			if pmap == map then
				CanTeleport = true
				if Distance3D(pos) <= stopdist then
					if MIsMoving() then Player:Stop() end
					return true
				else
					if not MIsLoading() and not MIsMoving() and NotValid(ml_navigation.path) then
						Player:MoveTo(pos.x, pos.y, pos.z, stopdist, true, true)
					end

					if MIsMoving() then
						local Sprint = ActionList:Get(1,3)

						if Sprint and Valid(ml_navigation.path) and Sprint.usable and Sprint:IsReady() then
							Sprint:Cast()
						end
					end
				end
			elseif CanTeleport then
				if MIsMoving() then Player:Stop() end
				if not MIsLoading() and not MIsCasting() and NotAll(Player.action,92,93,164) then
					Player:Teleport(GetAetheryteByMapID(map, pos).id)
					CanTeleport = false
					TeleportTime = Now()
				end
			elseif TimeSince(TeleportTime) > 5000 then
				CanTeleport = true
			end
			return false
		end

		local LastInteract = 0
		function API.SetTarget(targetid,act)
			local target = Player:GetTarget()
			local entity = EntityList:Get(id)

			if Type(targetid,"table") then
				targetid = targetid.id
			end

			if not target or target.id ~= targetid then
				Player:SetTarget(targetid)

				if act and TimeSince(LastInteract) > 500 then
					Player:Interact(targetid)
					LastInteract = Now()
				end
				return true
			elseif target and target.id == targetid then
				return true
			end
			return false
		end

		function API.ConvertCID(CID,returntable)
			local el = EntityList("contentid="..tostring(CID))
			if table.valid(el) then
				for k,v in pairs(el) do
					if returntable then
						return v
					else
						return v.id
					end
				end
			end
		end

		API.Entities,API.Entities2,API.EntitiesUpdateInterval,API.EntitiesLastUpdate = {},{},250,0
		function API.UpdateEntities()
			if TimeSince(API.EntitiesLastUpdate) >= API.EntitiesUpdateInterval then
				API.EntitiesLastUpdate = Now()
				API.Entities = EntityList("")
				if Valid(API.Entities) then
					table.insert(API.Entities,Player)
					for k,v in pairs(API.Entities) do
						InsertIfNil(API.Entities2,"zone",Player.localmapid)
						if API.Entities2.zone ~= Player.localmapid then
							API.Entities2 = {}
							API.Entities2.zone = Player.localmapid
						end
						InsertIfNil(API.Entities2,v.id,{})
						InsertIfNil(API.Entities2[v.id],"name",v.name)
						if v.incombat then
							InsertIfNil(API.Entities2[v.id],"combatstart",Now())
							InsertIfNil(API.Entities2[v.id],"starthp",v.hp.current)
							if API.Entities2[v.id].percent then
								if API.Entities2[v.id].percent < 75 and v.hp.percent > 75 then
									API.Entities2[v.id].combatstart = Now()
									API.Entities2[v.id].starthp = v.hp.current
									API.Entities2[v.id].combattime = nil
									API.Entities2[v.id].dps = nil
									API.Entities2[v.id].ttd = nil
								end
							end
							UpdateIfChanged(API.Entities2[v.id],"percent",(v.hp.current / v.hp.max) * 100)
							if API.Entities2[v.id].combatstart then
								API.Entities2[v.id].combattime = TimeSince(API.Entities2[v.id].combatstart) / 1000
								API.Entities2[v.id].dps = (API.Entities2[v.id].starthp - v.hp.current) / API.Entities2[v.id].combattime
								if API.Entities2[v.id].dps > 0 then
									API.Entities2[v.id].ttd = v.hp.current / API.Entities2[v.id].dps
								end
							end
						else
							API.Entities2[v.id].combatstart = nil
							API.Entities2[v.id].starthp = nil
							API.Entities2[v.id].percent = nil
							API.Entities2[v.id].combattime = nil
							API.Entities2[v.id].dps = nil
							API.Entities2[v.id].ttd = nil
						end

						if Valid(v.buffs) then
							
						end
					end
				end
			end
		end

		API.CMDKeyPress = ""
		local CMDKeyPress = API.CMDKeyPress
		function API.SendKey(key)
			local SendKeyPress = ScriptsFolder..[[SendKeyPress.exe]]
			if not FileExists(SendKeyPress) then
				FileWrite(SendKeyPress,[[ControlSend, , %1%, FINAL FANTASY XIV ]])
			end
			if Type(key,"string") then
				CMDKeyPress = io.popen([["]]..SendKeyPress..[[" {]]..key..[[}]])
			else
				Error("API.SendKey `key` was not a valid string")
			end
		end
		SendKey = API.SendKey

		API.Keybinds = {
			Movement = {},
			Targeting = {},
			Shortcuts = {},
			Chat = {},
			System = {},
			Hotbar = {},
			Gamepad = {}
		}
		local SendOpen = true
		local Keybinds = API.Keybinds
		function API.RecordKeybinds()
			if IsControlOpen("ConfigKeybind") then
				SendOpen = true
				local data = GetControl("ConfigKeybind"):GetRawData()
				if data then
					local TabCount = {
						Movement = 32,
						Targeting = 50,
						Shortcuts = 61,
						Chat = 41,
						System = 42,
						Hotbar = 133,
						Gamepad = 24
					}
					local page = 1
					for k,v in table.pairsbykeys(TabCount) do
						GetControl("ConfigKeybind"):PushButton(24,page)
						for i = 10, v*4, 4 do
							if GetControl("ConfigKeybind"):GetRawData()[i] and GetControl("ConfigKeybind"):GetRawData()[i+2] and GetControl("ConfigKeybind"):GetRawData()[i+3] then
								d(GetControl("ConfigKeybind"):GetRawData()[i].value)
								API.Keybinds[k][tostring(GetControl("ConfigKeybind"):GetRawData()[i].value)] = GetControl("ConfigKeybind"):GetRawData()[i+2].value
								API.Keybinds[k][tostring(GetControl("ConfigKeybind"):GetRawData()[i].value).."2"] = GetControl("ConfigKeybind"):GetRawData()[i+3].value
								
							end
						end
						page = page + 1
					end
					FileSave(MooglePath.."keybinds.lua",API.Keybinds)
				end
			elseif SendOpen then
				ActionList:Get(10,20):Cast()
				SendOpen = false
			end
		end

		function MoogleTime()
			GUI:SetClipboardText(os.time())
		end
	-- End API Functions --

	-- General Functions --

		function General.Error(string)
			ml_error(string)
		end

		function General.IsNil(check, alt, original)
			-- First check if "check" is nil --
			local x = check or "isnil"
			if x == "isnil" then
				-- "check" was nil, now return true or alternate value --
				if check ~= "" then
					return alt or true
				else
					return original or false
				end
			else
				-- "check" was not nil, return false or return original if not nil --
				return original or false
			end
		end

		function General.NotNil(check,alt)
			-- First check that "check" is nil --
			local x = check or "isnil"
			if x == "isnil" then
				return false
			else
				-- Isn't Nil, return alt if provided otherwise return true --
				if check ~= "" then
					return alt or true
				else
					return false
				end
			end
		end

		function General.Is(check, ...)

			local compare = {...}
			
			if Valid(compare) then
				for i = 1, #compare do
					if (check == compare[i] or (tonumber(check) ~= nil and tonumber(check) == tonumber(compare[i]))) then
						return true
					end
				end

				return false
			else
				if Type(check, "boolean") then
					if check == true then
						return true
					else
						return false
					end
				else
					return false
				end
			end
		end

		function General.IsAll(check, ...)

			local compare = {...}
			
			if Valid(compare) then
				local IsAllTrue = true
				for i = 1, #compare do
					if IsAllTrue then
						if (check ~= compare[i] or (tonumber(check) ~= nil and tonumber(check) ~= tonumber(compare[i]))) then
							return false
						end
					end
				end
				
				if IsAllTrue then
					return true
				else
					return false
				end
			else
				if Type(check, "boolean") then
					if check == true then
						return true
					else
						return false
					end
				else
					return false
				end
			end
		end

		function General.Is2(check, compare, altyes, altno)
			
			if Valid(compare) then
				if (check == compare or (tonumber(check) ~= nil and tonumber(check) == tonumber(compare))) then
					return altyes or true
				else
					return altno or false
				end
			else
				if Type(check, "boolean") then
					return check
				else
					return false
				end
			end
		end

		function General.Not(check, ...)

			local compare = {...}
			
			if Valid(compare) then
				for i = 1, #compare do
					if (check ~= compare[i] or (tonumber(check) ~= nil and tonumber(check) ~= tonumber(compare[i]))) then
						return true
					end
				end

				return false
			else
				if Type(check, "boolean") then
					if check == false then
						return true
					else
						return false
					end
				else
					return false
				end
			end
		end

		function General.NotAll(check, ...)

			local compare = {...}
			
			if Valid(compare) then
				local IsAllFalse = true
				if Type(check, "boolean") then
					if check == false then
						for i=1,#compare do
							if compare[i] then
								return false
							end
						end
					else
						return false
					end
				else
					for i = 1, #compare do
						if IsAllFalse then
							if (check == compare[i] or (tonumber(check) ~= nil and tonumber(check) == tonumber(compare[i]))) then
								return false
							end
						end
					end
				end
				
				if IsAllFalse then
					return true
				else
					return false
				end
			else
				if Type(check, "boolean") then
					if check == false then
						return true
					else
						return false
					end
				else
					return false
				end
			end
		end

		function General.Not2(check, compare, altyes, altno)
			if (check ~= compare or (tonumber(check) ~= nil and tonumber(check) ~= tonumber(compare))) then
				return altyes or true
			else
				return altno or false
			end
		end

		function General.Type(var, compare, altyes, altno)
			local NotNil = General.NotNil
			if NotNil(compare) then
				if type(compare) == "table" then
					for i = 1, #compare do
						if type(var) == compare[i] then
							return altyes or true
						end
					end
					return altno or false
				else
					if type(var) == compare then
						return altyes or true
					else
						return altno or false
					end
				end
			else
				return type(var)
			end
		end

		function General.NotType(var, compare, altyes, altno)

			if NotNil(compare) then
				if type(var) == compare then
					return altno or false
				else
					return altyes or true
				end
			else
				return false
			end
		end

		function General.Size(check, sign, value) -- Short version of table.size, but adds in the option to return only if it meets the requirements
			
			if sign == nil then
				local t = Type(check)
				if t == "table" then
					local count = 0
					for _ in pairs(check) do count = count + 1 end
					return count
				elseif t == "string" then
					if #check:gsub("%s","") == 0 then
						return 0
					else
						return #check
					end
				elseif t == "number" then
					if check ~= math.floor(check) then
						return #tostring(check):gsub("[^.]+$", "")-1
					else
						return #tostring(check)
					end
				else
					Error("Tried to find the size of a value that's not a Table, String, or Number, but was "..Type(check))
				end
			else
				check = check
				if Type(check,"table") then
					local count = 0
					for _ in pairs(check) do count = count + 1 end
					check = count
				elseif Type(check,"string") then -- if check is a table, then we are comparing the sizes of two tables
					check = #check
				end
				value = value
				if Type(value,"table") then
					local count = 0
					for _ in pairs(check) do count = count + 1 end
					value = count
				elseif Type(value,"string") then -- if value is a table, then we are comparing the sizes of two tables
					value = #value
				end
				if sign == "==" or sign == "=" then
					if check == value then
						return true
					else
						return false
					end
				elseif sign == "~=" or sign == "!=" then
					if check ~= value then
						return true
					else
						return false
					end
				elseif sign == ">" then
					if check > value then
						return true
					else
						return false
					end
				elseif sign == "<" then
					if check < value then
						return true
					else
						return false
					end
				elseif sign == ">=" then
					if check >= value then
						return true
					else
						return false
					end
				elseif sign == "<=" then
					if check <= value then
						return true
					else
						return false
					end
				end
			end
		end

		function General.Empty(check)
			
			if Size(check) == 0 then
				return true
			else
				return false
			end
		end

		function General.NotEmpty(check)
			
			if Size(check) == 0 then
				return false
			else
				return true
			end
		end

		
	-- End General Functions --

	-- Debug Functions --
		local D2History = {}
		function Debug.d2(str, traceback, var, str2, var2, str3, var3, str4, var4, str5, var5)
			if In(str,"help","Help","?") then
				d([[MoogleLib.API.Lua.debug.d2 Function Example: d2(]].."[["..[[Variable = ]].."]], [[ ".."[MoogleLib.lua][Debug.d2][Help Response] ]],variable)")
				d("Which would output something like:")
				d([[Variable = true]])
				d([[ [MoogleLib.lua][MoogleLib.API.Lua.debug.d2][Help Response] ]])
			else

				-- d2 outputs to the Minion console, while opening the console if closed --
				local var = var or ""
				local str2 = str2 or ""
				local var2 = var2 or ""
				local str3 = str3 or ""
				local var3 = var3 or ""
				local str4 = str4 or ""
				local var4 = var4 or ""
				local str5 = str5 or ""
				local var5 = var5 or ""


				ml_gui.showconsole = true
				-- Concatenating all strings and variables in case d2 was used to compare values --
				local string = str..var..str2..var2..str3..var3..str4..var4..str5..var5
				if IsNil(D2History[string]) or TimeSince(D2History[string]) > 5000 then
					D2History[string] = Now()
					d(string)
				end

				if type(traceback) == "string" then
					-- Traceback's should look similar to:

					-- [ffxiv_common_cne.lua][function: c_walktoentity:evaluate()][Note 4]
					d(traceback)
				end
			end
		end

		function Debug.DrawDebugInfo(ModuleName, ...)

			local tables = {...}

			if Valid(tables) then
				if GUI:CollapsingHeader(ModuleName.." Debug Info") then
					if GUI:SmallButton("MoogleTime") then MoogleTime() end
					for i = 1, #tables do
						if Type(tables[i],"table") then
							GUI:Separator()
							DrawTables(tables[i])
						end
						GUI:Separator()
					end
				end
			end
		end
	-- End Debug Functions --

	-- Input and Output (IO) Functions --
	-- End Input and Output (IO) Functions --

	-- Math Functions --
		function Math.Sign(value)
			return (value >= 0 and 1) or - 1
		end

		function Math.Round(value, bracket)
			bracket = bracket or 1
			local floor = math.floor
			return floor(value / bracket + Sign(value) * 0.5) * bracket
		end
		function Math.Convert4Bytes(tbl)
			if tbl.type and tbl.value then
				if tbl.type == "4bytes" then
					local val = tbl.value
					local A = val.A * math.pow(256,0)
					local B = val.B * math.pow(256,1)
					local C = val.C * math.pow(256,2)
					local D = val.D * math.pow(256,3)
					return A + B + C + D
				end
			end
		end
	-- End Math Functions --

	-- Operating System (OS) Functions --
		function OS.PowerShell(cmd)
			io.popen([[powershell -Command "]]..cmd..[["]])
		end

		function OS.CreateFolder(path)
			io.popen([[MKDIR  "]]..path..[["]])
		end

		function OS.DeleteFile(path)
			if FileExists(path) then
				io.popen([[del /f /q "]]..path..[["]])
			end
		end

		OS.MoogleCMDQueue = {} OS.MoogleDownloadBuffer = {} OS.CMDTable = {}
		function OS.CMD(cmd, PowerShell, url)
			local pass = true
			url = url or cmd
			if OS.MoogleDownloadBuffer[url] then
				if TimeSince(OS.MoogleDownloadBuffer[url]) < 5000 then
					pass = false
				end
			end
			if loaded and pass then
				local DownloadThreads = MoogleLib.Settings.DownloadThreads
				local freetable = 0
				if table.size(OS.CMDTable) > DownloadThreads then
					-- Too many tables --
					for k,v in ipairs(OS.CMDTable) do
						if k > DownloadThreads then
							if io.type(OS.CMDTable[k].CMD) ~= "file" then
								OS.CMDTable[k] = nil
							end
						end
					end
				end
				
				-- Create tables that are missing --
				if table.size(OS.CMDTable) < DownloadThreads then
					for i = 1, DownloadThreads do
						if OS.CMDTable[i] == nil then
							OS.CMDTable[i] = {}
						end
					end
				end

				for i=1, #OS.CMDTable do
					if freetable == 0 then
						if IsNil(OS.CMDTable[i].CMD) or io.type(OS.CMDTable[i].CMD) ~= "file" then
							freetable = i
						end
					end
				end

				MoogleDebug.cmd = cmd
				url = url or cmd
				if NotNil(OS.MoogleCMDQueue[url]) then -- Already in the queue, find which one
					local tblnumber
					for i=1, #OS.CMDTable do
						if OS.CMDTable[i].lasturl == url then
							tblnumber = i
						end
					end
					if tblnumber then
						local i = tblnumber
						local CMDtbl = OS.CMDTable[i]
						local lasturl = OS.CMDTable[i].lasturl
						local CMD = OS.CMDTable[i].CMD
						local ctype = io.type(OS.CMDTable[i].CMD)
						local outputfile = OS.CMDTable[i].outputfile
						local CommandSent = OS.CMDTable[i].CommandSent
						local filetimestart = OS.CMDTable[i].filetimestart

						if Is(ctype,"file") then -- File is open, check to see if CommandSent is true --
							if CommandSent then -- it better..
								if filetimestart == nil then
									CMDtbl.filetimestart = Now()
								end
								if FileExists(MooglePath.."output"..tostring(i)..".lua") then
									if IsNil(CMDtbl.outputfile) then
										CMDtbl.outputfile = io.open(MooglePath.."output"..tostring(i)..".lua","r")
									end
									if CMDtbl.outputfile then
										local text = CMDtbl.outputfile:read("*a")
										if #text > 0 then
											CMDtbl.outputfile:close()
											CMDtbl.filetimestart = nil
											CMDtbl.CommandSent = false
											CMDtbl.CMD:close()
											OS.MoogleCMDQueue[url] = nil
											CMDtbl.lasturl = nil
											OS.MoogleDownloadBuffer[url] = Now()
											OS.CMDTable[i] = {}
											return text
										end
									end
								end
							else
								ml_error("wtf, lasturl + cmd the same, file is open, but CommandSent is false?")
							end
						end
					end
				elseif freetable ~= 0 then -- Spots available to add additional downloads
					local i = freetable
					local CMDtbl = OS.CMDTable[i]
					local lasturl = OS.CMDTable[i].lasturl
					local CMD = OS.CMDTable[i].CMD
					local ctype = io.type(OS.CMDTable[i].CMD)
					local outputfile = OS.CMDTable[i].outputfile
					local CommandSent = OS.CMDTable[i].CommandSent
					local filetimestart = OS.CMDTable[i].filetimestart

						if not CommandSent then -- LastURL and CommandSent are nil/false, which means a new command
							if Not(ctype,"file") then
								local erase = io.open(MooglePath.."output"..tostring(i)..".lua","w+")
								if io.type(erase) == "file" then
									erase:close()
									local str
									if PowerShell then
										str = [[PowerShell -Command "]]..cmd..[["]]
									else
										str = cmd
									end
									OS.CMDTable[i].CMD = io.popen(str..[[ > "]]..MooglePath..[[output]]..tostring(i)..[[.lua"]])
									OS.CMDTable[i]["CommandSent"] = true
									OS.CMDTable[i]["lasturl"] = url
									OS.CMDTable[i]["lastcmd"] = cmd
									OS.CMDTable[i]["lastps"] = powershell
									InsertIfNil(OS.MoogleCMDQueue,url,PowerShell)
								end
							else
								ml_error("LastURL & CommandSent are both nil, but CMD is open")
							end
						else -- shouldn't ever happen
							ml_error("LastURL = nil but CommandSent = true")
						end
					-- end
				end
			end
		end

		local ToggleDownloadString,queue,lastpath,result = false,{}
		function OS.DownloadString(url, path)
			if path then
				lastpath = path
			else
				path = lastpath
			end
				MoogleDebug.lastpath = lastpath
			if url then
				if queue[url] ~= path then queue[url] = path end
			else
				url,path = next(queue)
			end
				MoogleDebug.DownloadStringqueue = queue
			if table.valid(queue) then table.print(queue) end
			local ctype = io.type(CMD)
			if ctype == "file" or result then
				if result then
					MoogleDebug.result = result
					if path then
						local file = io.open(path,"w")
							file:write(result)
							file:close()
						queue[url] = nil
							MoogleDebug.DownloadStringqueue = queue
						if NotValid(queue) then
							ToggleDownloadString = false
								MoogleDebug.ToggleDownloadString = ToggleDownloadString
						end
						lastpath = nil
							MoogleDebug.lastpath = lastpath
						result = nil
					else
						queue[url] = nil
							MoogleDebug.DownloadStringqueue = queue
						if NotValid(queue) then
							ToggleDownloadString = false
								MoogleDebug.ToggleDownloadString = ToggleDownloadString
						end
						lastpath = nil
						local temp = result
						result = nil
							MoogleDebug.result = result
						return temp
					end
				elseif url ~= nil then
					result = OS.CMD([[(New-Object System.Net.WebClient).DownloadString(']]..url..[[')]],true,url)
				end
			elseif url ~= nil then
				result = OS.CMD([[(New-Object System.Net.WebClient).DownloadString(']]..url..[[')]],true,url)
				ToggleDownloadString = true
					MoogleDebug.ToggleDownloadString = ToggleDownloadString
			end
		end

		local ToggleDownloadTable,queue,lasttbl,result = false,{}
		function OS.DownloadTable(url, TableName)
			if url then
				if queue[url] ~= TableName then queue[url] = TableName end
			else
				url, TableName = next(queue)
			end

			if lasttbl then TableName = lasttbl else lasttbl = TableName end

			if type(TableName) ~= "string" then
				ml_error("TableName is not a string but a "..type(TableName))
				return nil
			end
			local ctype = io.type(CMD)
			if ctype == "file" or result then
				if result then
					local tbl = loadstring(result)()
					if type(tbl) == "table" then
						ml_error("tbl is a table")
						local t = {};
						for w in TableName:gmatch("[%P/_/:]+") do
							t[#t+1] = w
						end
						local lastkey
						local Table = _G
						for k,v in pairs(t) do
							if k == #t then
								lastkey = v
							else
								Table = Table[v]
							end
						end
						Table[lastkey] = tbl

						queue[url] = nil
						if NotValid(queue) then
							ToggleDownloadTable = false
						end
						lasttbl = nil
						result = nil
					else
						ml_debug("'Table' is actually a : "..type(tbl).." URL: "..url, "gLogCNE", 1)
					end
				else
					result = OS.CMD([[(New-Object System.Net.WebClient).DownloadString(']]..url..[[')]],true,url)
				end
			else
				result = OS.CMD([[(New-Object System.Net.WebClient).DownloadString(']]..url..[[')]],true,url)
				ToggleDownloadTable = true
			end
		end

		local ToggleDownloadFile,queue,result = false,{}
		function OS.DownloadFile(url, path, NotExist)
			-- if result then
			-- 	if result then
			-- 		queue[url] = nil
			-- 		if NotValid(queue) then
			-- 			ToggleDownloadFile = false
			-- 		end
			-- 		result = nil
			-- 	else
			-- 		result = OS.CMD([[(New-Object System.Net.WebClient).DownloadFile(']]..url..[[',']]..path..[['); Write-Host 'MoogleDownload']],true,url)
			-- 	end
			-- else
			-- if NotExist then
			-- 	if FileExists(path) then
			-- 		return false
			-- 	end
			-- end
			result = OS.CMD([[(New-Object System.Net.WebClient).DownloadFile(']]..url..[[',']]..path..[['); Write-Host 'MoogleDownload']],true,url)
			-- 	ToggleDownloadFile = true
			-- end
		end

		local ToggleVersionCheck,queue,result = false,{}
		function OS.VersionCheck(url,TableName)
			if url then
				if queue[url] ~= TableName then queue[url] = TableName end
			else
				url,TableName = next(queue)
			end
			local ctype = io.type(CMD)
			if ctype == "file" or result then
				if result then
					local str = result:gsub("[^%d\.]","")
					local tbl = string.totable(str,"%p")
					local value = (tbl[1] * 1000000) + (tbl[2] * 1000) + tbl[3]
					result = nil
					queue[url] = nil
					if NotValid(queue) then
						ToggleVersionCheck = false
					end
					if TableName then
						local t = {};
						for w in TableName:gmatch("[%P/_/:]+") do
							t[#t+1] = w
						end
						local lastkey
						local Table = _G
						for k,v in pairs(t) do
							if k == #t then
								lastkey = v
							else
								Table = Table[v]
							end
						end
						Table[lastkey].Info.CurrentVersion = str
						Table[lastkey].Info.CurrentVersionValue = value
					else
						return str,value
					end
				else
					result = OS.CMD([[(New-Object System.Net.WebClient).DownloadString(']]..url..[[') -split '[\r\n|\r\n]' | Select-String -Pattern '(?<=\tVersion = ").*(?=",)']],true)
				end
			else
				result = OS.CMD([[(New-Object System.Net.WebClient).DownloadString(']]..url..[[') -split '[\r\n|\r\n]' | Select-String -Pattern '(?<=\tVersion = ").*(?=",)']],true)
				ToggleVersionCheck = true
			end
		end

		local TogglePing,result = false
		function OS.Ping(count, ...)

			local ctype = io.type(CMD)
			if ctype == "file" or result then
				if result then
					local tbl = loadstring(result)()
					if type(tbl) == "table" then
						table.print(tbl)
					else
						d("tbl is not table, but is "..type(tbl))
					end

					result = nil

					TogglePing = false
				else
					result = OS.CMD(nil,nil,lastCopy)
				end
			else
				local t = {}
				if Type(count,"number") then
					count = count
				else
					t[#t+1] = count
					count = 1
				end

				local IP = {...}

				if Valid(IP) then
					for i=1, #IP do
						t[#t+1] = IP[i]
					end
				end

				local IPstr = ""
				for i=1, #t do
					if i == 1 then
						IPstr = [[']]..t[i]..[[']]
					else
						IPstr = IPstr..[[,']]..t[i]..[[']]
					end
				end

				OS.CMD([[$lines = 'local tbl = {} '; $CompName = ]]..IPstr..[[; foreach ($comp in $CompName) { $result = (Test-Connection -ComputerName $comp -Count ]]..count..[[ | measure -property ResponseTime -Average).average; $lines += 'tbl[\"' + $comp + '\"] = ' + $result + '; ' } $lines += ' return tbl '; $lines]], true)

				TogglePing = true
			end
		end
	-- End Operating System (OS) Functions --

	-- String Functions --
		function String.Split(str,length)
			length = length or 150
			local tbl = {}
			for i = 1, #str, length do
				tbl[#tbl+1] = str:sub(i, i + length - 1)
			end
			return tbl
		end

		function String.starts(str, Start)
			return string.sub(str,1,string.len(Start))==Start
		end

		function String.ends(str, End)
			return End=='' or string.sub(str,-string.len(End))==End
		end

		function String.ToTable(str)
			local t = {}
			for w in str:gmatch("[%P/_/:]+") do
				t[#t+1] = w
			end
			return t
		end
	-- End String Functions --

	-- Table Functions --
		function Table.Valid(tbl,...) -- Short version of table.valid, expanded to check multiple tables at once

			local tbls = {...}

			if table.valid(tbl) then
				if table.valid(tbls) then
					for i = 1, #tbls do
						if Not(IsItValid,false) then
							if NotType(tbls[i], "table") and not table.valid(tbls[i]) then
								IsItValid = false
							end
						end
					end
					if IsItValid then
						return true
					else
						return false
					end
				else
					return true
				end
			else
				return false
			end
		end

		function Table.NotValid(tbl,...)

			local tbls = {...}

			if table.valid(tbl) then
				return false
			else
				if table.valid(tbls) then
					for i = 1, #tbls do
						if Not(IsItNotValid,false) then
							if Type(tbls[i], "table") and table.valid(tbls[i]) then
								IsItNotValid = false
							end
						end
					end
					if IsItNotValid then
						return true
					else
						return false
					end
				else
					return true
				end
			end
		end

		function Table.pairs(t, ...)
			local i, a, k, v = 1, {...}
			return function()
				repeat
					k, v = next(t, k)
					if k == nil then
						i, t = i + 1, a[i]
					end
				until k ~= nil or not t
				return k, v
			end
		end

		function Table.InsertIfNil(tbl, key, value, update)

			if Type(tbl,"table") then
				if NotNil(value) then
					if NotNil(key) then
						if IsNil(tbl[key]) then
							tbl[key] = value
						elseif update and Not(value, "") and Not(value, " ") then
							if tbl[key] ~= value then
								tbl[key] = value
							end
						end
					end
				elseif table.find(tbl, key) == nil then
					-- key is now treated as value --
					-- Value does not exist in table, add it to table --
					tbl[#tbl + 1] = key
				end
			elseif update and IsNil(value) then
				-- We're now checking to see if we should update a variable instead --
				if tbl ~= key then tbl = key end
			end
		end

		function Table.RemoveIfNil(tbl,CrossCheck)

			if table.valid(tbl) then
				for k,v in pairs(tbl) do
					if IsNil(CrossCheck(k)) then
						tbl[k] = nil
					end
				end
			else
				tbl = nil
			end
		end

		function Table.UpdateIfChanged(tbl, key, value)
			if tbl[key] ~= value then tbl[key] = value end
		end

		function Table.RemoveExpired(table1,table2)
			-- Removes entries from Table 1 if they don't exist in Table 2 --

			if Valid(table1) and Valid(table2) then

			else
				-- one of the tables isn't valid --
				if NotValid(table1) then
					-- Table 1 is not valid --
				else
					-- Table 2 is not valid --
				end
			end
		end

		function Table.Unpack(method,...)

			if NotAll(method,"print","d","return") then
				Table.Unpack("return",...)
			end
			local arg = {...}
			for i = 1, #arg do
				if Is(method,"print","d") then
					if type(arg[i]) == "table" then
						for k,v in table.pairsbykeys(arg[i]) do
							if type(v) ~= "table" then
								d(tostring(v))
							else
								Table.Unpack("print",v)
							end
						end
					else
						d(arg[i])
					end
				elseif method == "return" then
					if type(arg[i]) == "table" then
						for k,v in table.pairsbykeys(arg[i]) do
							if type(v) ~= "table" then
								return v
							else
								Table.Unpack("return",v)
							end
						end
					else
						return arg[i]
					end
				end
			end
		end

		Table.BannedKeys = {}
		local TempFunctionStrings = {}
		local PrintRunning = false
		local PrintTime = 0
		local PrintLastTbl
		local PrintLastName
		local PrintLastSearch
		local PrintLastDepth
		local PrintLastHistory
		local Printfilelocation
		local lasthistory
		local lastlasthistory
		local ResumePrinting = true
		local PrintToFile = false
		local PrintToFileTable = {}
		local PrintTables = {}
		function Table.Print(tbl,name,search,filelocation,depth,history)
			local max = 50
			if IsNil(name) then
				if Type(tbl,"string") then
					local t = {};
					for w in tbl:gmatch("[%P/_/:]+") do
						t[#t+1] = w
					end
					name = ""
					tbl = _G
					for k,v in pairs(t) do
						tbl = tbl[v]
						if t[k-1] then name = name.." [" end
						name = name..v
						if t[k+1] then name = name.."]" end
					end
				else
					name = name or ""
				end
			end
			search = search or ""
			depth = tonumber(depth) or 0
			history = history or ""
			if filelocation ~= nil then
				PrintToFile = true
				if filelocation == true then
					filelocation = MooglePath..[[output.lua]]
				end
			end

			if PrintRunning == false  then
				if NotAll(name,""," ",nil) then
					d(string.rep(" ",500))
					local str = ""
					if NotNil(name) then
						str = str.."Searching Table: ["..name.."]"
					end
					if NotNil(search) then
						str = str..", and searching for the string: ["..search.."]"
					end
					d(str)
					d(string.rep(" ",500))
				end
				PrintLastTbl = tbl
				PrintLastName = name
				PrintLastSearch = search
				PrintLastDepth = depth
				PrintLastHistory = history
				Printfilelocation = filelocation
				PrintRunning = true
			end

			for k,v in table.pairsbykeys(tbl) do
				local function d3(string)
					local allowed = true
					if search then
						allowed = false
						if NotAll(nil,k,v,search) then
							local search = search:lower()
							if tostring(k):lower():match(search) then
								allowed = true
							elseif type(v) ~= "table" and tostring(v):lower():match(search) then
								allowed = true
							end
						end
					end
					if allowed and ResumePrinting then
						if PrintToFile then
							PrintToFileTable[#PrintToFileTable + 1] = string
						else
							d(string)
						end
					end
				end
				PrintTime = Now()
				lasthistory = "["..name.."]"..history.." "..tostring(k)
				if Is(k,"_G","__index","BannedKeys","parent") then
					d3(string.rep("   ",depth).."["..name.."]"..history.." "..tostring(k).." is blocked table and will be skipped over.")
				else
					if type(v) == "table" then
						if depth < max then
							d3(string.rep("   ",depth).."["..name.."]"..history.." "..tostring(k).." = \{")
							Table.Print(v,name,search,filelocation,depth+1,history.." ["..k.."]")
							d3(string.rep("   ",depth).."["..name.."]"..history.." \}")
						else
							d3(string.rep("   ",depth).."["..name.."]"..history.." "..tostring(k).." has reached its limit at a depth of "..max.." and will not continue to print deeper.")
						end
					else
						local str
						if Type(v,"nil") then
							str = "nil"
						elseif Type(v,"string") then
							str = "'"..v.."'"
						elseif Type(v,"boolean") then
							str = tostring(v):upper()
						elseif Type(v,"function") then
							if Table.BannedKeys[lasthistory] then
								InsertIfNil(TempFunctionStrings,tostring(v),true)
								if lasthistory == lastlasthistory then
									ResumePrinting = true
								end
								str = tostring(v).. " (unable to dump function)"
							else
								local FunctionString = tostring(v)
								if TempFunctionStrings[FunctionString] then
									str = FunctionString.. " (unable to dump function)"
									Table.BannedKeys[lasthistory] = true
								else
									str = FunctionString.." : "..string.dump(v):gsub("[^ !#-~]", "."):gsub("(\n|\r)",""):gsub("[@|%%|%`|%$|%'|%?]",""):gsub("[.][,|!|@|#|$|^|&|*|(|)|_|=|>|<|%:|%;|~|`|\"|/|[| |a-z|A-Z|0-9|%]|%-|%+|%\|%/|?|%>|%<|%{|%}][.]",""):gsub("[.][A-Z]+[.]",""):gsub("[.][.]*[.]","..."):gsub("\.LuaQ\.\.\.","")
								end
							end
						else
							str = tostring(v)
						end

						if PrintToFile or str:len() < 150 then
							d3(string.rep("   ",depth).."["..name.."]"..history.." "..tostring(k).." = "..str)
						else
							str = string.rep("   ",depth).."["..name.."]"..history.." "..tostring(k).." = "..str
							local tbl = String.Split(str)
							if Valid(tbl) then
								local startlength = string.len(string.rep("   ",depth).."["..name.."]"..history.." "..tostring(k).." = ")
								for i,e in pairs(tbl) do
									if i == 1 then
										d3(e)
									else
										d3(string.rep(" ",startlength)..e)
									end
								end
							end
						end
					end
				end
			end

			if depth == 0 then
				PrintRunning = false
				ResumePrinting = true
				if PrintToFile then
					local file = io.open(filelocation,"w")
					for k,v in table.pairsbykeys(PrintToFileTable) do
						file:write(v.."\r\n")
					end
					file:close()
					
					PrintToFile = false
					table.clear(PrintToFileTable)
				end
			end
		end
		MoogleSearch = Table.Print
		MooglePrint = Table.Print
	-- End Table Functions --

	-- GUI Functions --
		function Gui.WindowStyle(table)
			local counter = 0
			if table["Text"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["Text"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_Text, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["TextDisabled"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["TextDisabled"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_TextDisabled, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["WindowBG"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["WindowBG"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_WindowBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ChildWindowBg"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ChildWindowBg"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ChildWindowBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["Border"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["Border"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_Border, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["BorderShadow"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["BorderShadow"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_BorderShadow, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["FrameBg"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["FrameBg"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_FrameBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["FrameBgHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["FrameBgHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_FrameBgHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["FrameBgActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["FrameBgActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_FrameBgActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["TitleBg"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["TitleBg"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_TitleBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["TitleBgCollapsed"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["TitleBgCollapsed"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_TitleBgCollapsed, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["TitleBgActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["TitleBgActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_TitleBgActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["MenuBarBg"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["MenuBarBg"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_MenuBarBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ScrollbarBg"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ScrollbarBg"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ScrollbarBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ScrollbarGrab"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ScrollbarGrab"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ScrollbarGrab, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ScrollbarGrabHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ScrollbarGrabHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ScrollbarGrabHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ScrollbarGrabActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ScrollbarGrabActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ScrollbarGrabActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ComboBg"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ComboBg"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ComboBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["CheckMark"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["CheckMark"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_CheckMark, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["SliderGrab"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["SliderGrab"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_SliderGrab, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["SliderGrabActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["SliderGrabActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_SliderGrabActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["Button"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["Button"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_Button, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ButtonHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ButtonHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ButtonHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ButtonActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ButtonActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ButtonActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["Header"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["Header"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_Header, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["HeaderHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["HeaderHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_HeaderHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["HeaderActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["HeaderActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_HeaderActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["Column"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["Column"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_Column, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ColumnHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ColumnHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ColumnHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ColumnActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ColumnActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ColumnActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ResizeGrip"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ResizeGrip"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ResizeGrip, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ResizeGripHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ResizeGripHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ResizeGripHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ResizeGripActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ResizeGripActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ResizeGripActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["CloseButton"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["CloseButton"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_CloseButton, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["CloseButtonHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["CloseButtonHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_CloseButtonHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["CloseButtonActive"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["CloseButtonActive"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_CloseButtonActive, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["PlotLines"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["PlotLines"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_PlotLines, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["PlotLinesHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["PlotLinesHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_PlotLinesHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["PlotHistogram"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["PlotHistogram"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_PlotHistogram, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["PlotHistogramHovered"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["PlotHistogramHovered"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_PlotHistogramHovered, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["TextSelectedBg"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["TextSelectedBg"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_TextSelectedBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["TooltipBg"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["TooltipBg"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_TooltipBg, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			if table["ModalWindowDarkening"][4] ~= 0 then
				counter = counter + 1
				local tbl = ColorConv(table["ModalWindowDarkening"], "sRBG", "Linear")
				GUI:PushStyleColor(GUI.Col_ModalWindowDarkening, tbl[1], tbl[2], tbl[3], tbl[4])
			end
			return counter
		end

		function Gui.WindowStyleClose(count)
			GUI:PopStyleColor(count)
		end

		function Gui.ColorConv(tbl, from, to)
			if tbl[4] == nil then tbl[4] = 1 end
			if In(from,"sRBG","RBG","rbg") then
				if In(to,"Linear","linear","LinearRBG") then
					local tbl2 = {
						[1] = tbl[1] / 255, 
						[2] = tbl[2] / 255, 
						[3] = tbl[3] / 255, 
						[4] = tbl[4]}
					return tbl2
				elseif to == "HSV" then
				elseif to == "HSL" then
				elseif to == "U32" then
				elseif to == "Hex" or "HEX" then
				end
			end
		end

		function Gui.SameLine(posX, spacingX)

			if NotNil(spacingX) then
				GUI:SameLine(posX, spacingX)
			else
				local x = posX or 0
				GUI:SameLine(0, posX)
			end
		end

		function Gui.Indent(spacing)

			if Type(spacing,"number") then
				GUI:PushStyleVar(GUI.StyleVar_IndentSpacing, spacing)
				GUI:Indent()
			else
				GUI:Indent()
			end
		end

		function Gui.Unindent(spacing)

			if Type(spacing,"number") then
				GUI:Unindent()
				GUI:PopStyleVar()
			else
				GUI:Unindent()
			end
		end

		function Gui.Space(spacing)
			spacing = spacing or 5
			GUI:SameLine(0, spacing)
		end

		function Gui.Text(string, RGB, SameLineSpacing, beforetext)
			local ColorText = false

			local RGB = RGB
			local SameLineSpacing = SameLineSpacing
			local beforetext = beforetext

			if type(RGB) ~= "table" then
				beforetext = SameLineSpacing
				SameLineSpacing = RGB
				RGB = nil
			else
				ColorText = true
			end

			if NotNil(SameLineSpacing) then
				if beforetext then
					if ColorText then
						SameLine(SameLineSpacing)
						GUI:AlignFirstTextHeightToWidgets()
						GUI:PushStyleColor(GUI.Col_Text,RGB[1],RGB[2],RGB[3],RGB[4])
							GUI:Text(string)
						GUI:PopStyleColor()
					else
						SameLine(SameLineSpacing)
						GUI:AlignFirstTextHeightToWidgets()
						GUI:Text(string)
					end
				else
					if ColorText then
						GUI:AlignFirstTextHeightToWidgets()
						GUI:PushStyleColor(GUI.Col_Text,RGB[1],RGB[2],RGB[3],RGB[4])
							GUI:Text(string)
						GUI:PopStyleColor()
						SameLine(SameLineSpacing)
					else
						GUI:AlignFirstTextHeightToWidgets()
						GUI:Text(string)
						SameLine(SameLineSpacing)
					end
				end
			else
				if ColorText then
					GUI:AlignFirstTextHeightToWidgets()
					GUI:PushStyleColor(GUI.Col_Text,RGB[1],RGB[2],RGB[3],RGB[4])
						GUI:Text(string)
					GUI:PopStyleColor()
				else
					GUI:AlignFirstTextHeightToWidgets()
					GUI:Text(string)
				end
			end
		end

		function Gui.Checkbox(string, varname, varstring, reverse, tooltip)
			local tbl
			local key = _G
			local value
			if Type(varname,"string") then
				tbl = StrToTable(varname)
				for i = 1, table.size(tbl) do
					if Not(i,table.size(tbl)) then
						key = key[tbl[i]]
					else
						value = tbl[i]
					end
				end
			end
			if reverse then
				c = Text(string)
				if tooltip ~= nil and GUI:IsItemHovered(c) then
					Tooltip(tooltip, 400)
				end
				Space()
				if tbl then
					key[value] = GUI:Checkbox("##"..varstring, key[value])
				else
					varname = GUI:Checkbox("##"..varstring, varname)
				end
				if tooltip ~= nil and GUI:IsItemHovered(c) then
					Tooltip(tooltip, 400)
				end
			else
				if tbl then
					key[value] = GUI:Checkbox("##"..varstring, key[value])
				else
					varname = GUI:Checkbox("##"..varstring, varname)
				end
				if tooltip ~= nil and GUI:IsItemHovered(c) then
					Tooltip(tooltip, 400)
				end
				Space()
				c = Text(string)
				if tooltip ~= nil and GUI:IsItemHovered(c) then
					Tooltip(tooltip, 400)
				end
			end
			if tbl then
				return key[value]
			else
				return varname
			end
		end

		-- function Gui.SliderInt(string, varname, varstring, min, max, width, reverse, tooltip)
		-- 	if reverse then
		-- 		GUI:AlignFirstTextHeightToWidgets(); c = GUI:Text(string); 
		-- 	if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- 	GUI:SameLine(0, 5) GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderInt("##"..varstring, varname, min, max), varstring) GUI:PopItemWidth()
		-- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- else
		-- GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderInt("##"..varstring, varname, min, max), varstring)
		-- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- GUI:PopItemWidth() c = GUI:SameLine(0, 5)
		-- GUI:SameLine(0, 5) c = GUI:Text(string)
		-- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- -- else
		-- -- GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderInt(string,varname,min,max),varstring) GUI:PopItemWidth()
		-- -- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- end
		-- end

		-- function Gui.SliderFloat(string, varname, varstring, min, max, float, width, reverse, tooltip)
		-- 	if reverse then
		-- 		GUI:AlignFirstTextHeightToWidgets(); c = GUI:Text(string); GUI:SameLine(0, 5); 
		-- 	if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- 	GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderFloat("##"..varstring, varname, min, max, "%."..float.."f"), varstring) GUI:PopItemWidth()
		-- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- else
		-- GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderFloat("##"..varstring, varname, min, max, "%."..float.."f"), varstring)
		-- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- GUI:PopItemWidth() GUI:SameLine(0, 5) c = GUI:Text(string)
		-- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- -- else
		-- -- GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderFloat(string,varname,min,max,"%."..float.."f"),varstring) GUI:PopItemWidth()
		-- -- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- end
		-- end

		-- function Gui.Combo(maintable, value, varstring, tooltip)
		-- 	local pos = 1
		-- 	local t = {}
		-- 	local t2 = {}
		-- 	local size = 0
		-- 	for k, v in table.pairsbykeys(maintable) do
		-- 		t[k] = pos
		-- 		t2[pos] = k
		-- 		if GUI:CalcTextSize(k) > size then size = GUI:CalcTextSize(k) end
		-- 		pos = pos + 1
		-- 	end
		-- 	GUI:PushItemWidth(size + 28)
		-- 	c = ACR.GUIVarUpdate(t2[GUI:Combo("##test", t[value], t2, table.size(t2))], varstring)
		-- if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip, 400) end end
		-- GUI:PopItemWidth()
		-- end

		function Gui.Tooltip(string, length)

			length = length or 400
			GUI:BeginTooltip()
			GUI:PushTextWrapPos(length)
			Text(string)
			GUI:PopTextWrapPos()
			GUI:EndTooltip()
		end

		function Gui.GetRemaining(which)

			if NotNil(which) then
				local x, y = GUI:GetContentRegionAvail()
				return Is(which, "x", x, y)
			else
				return GUI:GetContentRegionAvail()
			end
		end

		Gui.VirtualKeys = {
			[0] = [[None]],
			[1] = [[Left Mouse Button]],
			[2] = [[Right Mouse Button]],
			[3] = [[Middle Mouse Button]],
			[8] = [[Backspace]],
			[9] = [[Tab]],
			[12] = [[Numpad 5 w/o Num Lock]],
			[13] = [[Enter]],
			[16] = [[Shift]],
			[17] = [[Control]],
			--[18] = [[Alt]],
			[19] = [[Break/Pause]],
			[20] = [[Caps Lock]],
			--[21] = [[IME Kana/Hanguel/Hangul]],
			--[23] = [[IME Junja]],
			--[24] = [[IME Final]],
			--[25] = [[IME Hanja/Kanji]],
			[27] = [[Escape (Esc)]],
			[32] = [[Spacebar]],
			[33] = [[Page Up]],
			[34] = [[Page Down]],
			[35] = [[End]],
			[36] = [[Home]],
			[37] = [[Left Arrow]],
			[38] = [[Up Arrow]],
			[39] = [[Right Arrow]],
			[40] = [[Down Arrow]],
			--[44] = [[Print Screen]],
			[45] = [[Insert]],
			[46] = [[Delete]],
			[48] = [[0 )]],
			[49] = [[1 !]],
			[50] = [[2 @]],
			[51] = [[3 #]],
			[52] = [[4 $]],
			[53] = [[5 %]],
			[54] = [[6 ^]],
			[55] = [[7 &]],
			[56] = [[8 *]],
			[57] = [[9 (]],
			[65] = [[a A]],
			[66] = [[b B]],
			[67] = [[c C]],
			[68] = [[d D]],
			[69] = [[e E]],
			[70] = [[f F]],
			[71] = [[g G]],
			[72] = [[h H]],
			[73] = [[i I]],
			[74] = [[j J]],
			[75] = [[k K]],
			[76] = [[l L]],
			[77] = [[m M]],
			[78] = [[n N]],
			[79] = [[o O]],
			[80] = [[p P]],
			[81] = [[q Q]],
			[82] = [[r R]],
			[83] = [[s S]],
			[84] = [[t T]],
			[85] = [[u U]],
			[86] = [[v V]],
			[87] = [[w W]],
			[88] = [[x X]],
			[89] = [[y Y]],
			[90] = [[z Z]],
			[91] = [[Left Windows Key]],
			[92] = [[Right Windows Key]],
			[93] = [[Applications/Menu Key]],
			[96] = [[Numpad 0]],
			[97] = [[Numpad 1]],
			[98] = [[Numpad 2]],
			[99] = [[Numpad 3]],
			[100] = [[Numpad 4]],
			[101] = [[Numpad 5]],
			[102] = [[Numpad 6]],
			[103] = [[Numpad 7]],
			[104] = [[Numpad 8]],
			[105] = [[Numpad 9]],
			[106] = [[Numpad Multiply]],
			[107] = [[Numpad Add]],
			--[108] = [[Separator]],
			[109] = [[Numpad Subtract]],
			[110] = [[Numpad Decimal]],
			[111] = [[Numpad Devide]],
			[112] = [[F1]],
			[113] = [[F2]],
			[114] = [[F3]],
			[115] = [[F4]],
			[116] = [[F5]],
			[117] = [[F6]],
			[118] = [[F7]],
			[119] = [[F8]],
			[120] = [[F9]],
			--[121] = [[F10]],
			[122] = [[F11]],
			[123] = [[F12]],
			[144] = [[Num Lock]],
			[145] = [[Scroll Lock]],
			[166] = [[Browser Back Key]],
			[167] = [[Browser Forward Key]],
			[168] = [[Browser Refresh Key]],
			[169] = [[Browser Stop Key]],
			[170] = [[Browser Search Key]],
			[171] = [[Browser Favorites Key]],
			[172] = [[Browser Start Key]],
			[173] = [[Volume Mute Key]],
			[174] = [[Volume Down Key]],
			[175] = [[Volume Up Key]],
			[176] = [[Next Track Key]],
			[177] = [[Previous Track Key]],
			[178] = [[Stop Media Key]],
			[179] = [[Play/Pause Media Key]],
			[180] = [[Start Mail Key]],
			[181] = [[Select Media Key]],
			[182] = [[Start Application 1 Key]],
			[183] = [[Start Application 2 Key]],
			[186] = [[; :]],
			[187] = [[= +]],
			[188] = [[, <]],
			[189] = [[- _]],
			[190] = [[. >]],
			[191] = [[/ ?]],
			[192] = [[` ~]],
			[219] = [[[ {]],
			[220] = [[\ |]],
			[221] = [[] }]],
			[222] = [[" ']]
		}
		MoogleHotkeys = Gui.VirtualKeys
		Gui.OrderedKeys = {}
		Gui.IndexToDecimal = {}
		function Gui.HotKey(tbl)
			local tbl = tbl or {}
			if not table.valid(Gui.OrderedKeys) then
				for k,v in table.pairsbykeys(MoogleHotkeys) do
					Gui.OrderedKeys[#Gui.OrderedKeys+1] = v
					Gui.IndexToDecimal[#Gui.IndexToDecimal+1] = k
				end
			end
			for i = 1,(#tbl+1) do
				GUI:PushItemWidth(125)
				local index = tbl[i] or 1
				index,changed = GUI:Combo("##Key"..tostring(i),index,Gui.OrderedKeys,10)
				if changed then
					tbl[i] = index
					MoogleSave("tbl")
				end
				GUI:PopItemWidth()
				if i ~= (#tbl + 1) then
					GUI:SameLine(0,5)
				end
			end
			local changed = false
			if table.valid(tbl) then
				for k,v in table.pairsbykeys(tbl) do
					if changed or v == 1 then
						tbl[k] = nil
						changed = true
					end
				end
			end
			return tbl
		end

		local FunctionsRevealed = {}
		function Gui.DrawTables(tbl, depth)
			local depth = depth or 0
			if table.valid(tbl) then
				for k,v in table.pairsbykeys(tbl) do
					local c
					local depthtemp = 0
					if depth > 1 then depthtemp = 1 else depthtemp = depth end
					Indent(25*depthtemp)
					if Type(v,"table") then
						if table.valid(v) then
							if GUI:TreeNode(tostring(k)) then
								Gui.DrawTables(v,depth + 1)
								GUI:TreePop()
							end
						else
							if tonumber(k) ~= nil then
								Text("["..tostring(k).."] (",4)
							else
								Text(tostring(k).." (",4)
							end
							Text(type(v),{"0.169","0.286","1","1"},4) Text(") = ",4) Text("Empty Table",{"0.169","0.286","1","1"},4,true)
						end
					else
						if tonumber(k) ~= nil then
							Text("["..tostring(k).."] (",4)
						else
							Text(tostring(k).." (",4)
						end
						if Type(v,"nil") then
							Text(type(v),{"0","0.933","0","1"},4) Text(") = ",4) Text("nil",{"0","0.933","0","1"},4,true)
						elseif Type(v,"string") then
							Text(type(v),{"0","0.6","0.341","1"},4) Text(") = ",4) Text("\""..v.."\"",{"0","0.6","0.341","1"},4,true)
						elseif Type(v,"number") then
							Text(type(v),{"0","0.769","0.11","1"},4) Text(") = ",4) Text(tostring(v),{"0","0.769","0.11","1"},4,true)
						elseif Type(v,"boolean") then
							Text(type(v),{"0.933","0.4","0","1"},4) Text(") = ",4) Text(string.upper(tostring(v)),{"0.933","0.4","0","1"},4,true)
						elseif Type(v,"function") then
							local key = tostring(tbl)..tostring(depth)..tostring(k)..tostring(v)
							c = Text(type(v),{"0.322","0.718","0.953","1"},4) c = Text(") = ",4) c = Text(tostring(v),{"0.322","0.718","0.953","1"},4,true)
							if GUI:IsItemClicked(c) or FunctionsRevealed[key] then
								Text("Result: "..tostring(v()),{"1","1","0","1"},4,true)
								if FunctionsRevealed[key] then
									FunctionsRevealed[key] = not FunctionsRevealed[key]
								else
									FunctionsRevealed[key] = true
								end
							end
						elseif Type(v,"userdata") then
							Text(type(v),{"0.463","0.463","0.463","1"},4) Text(") = ",4) Text(tostring(v),{"0.463","0.463","0.463","1"},4,true)
						else
							Text(type(v),{"0.169","0.286","1","1"},4) Text(") = ",4) Text(tostring(v),{"0.169","0.286","1","1"},4,true)
						end
					end
					local depthtemp = 0
					if depth > 1 then depthtemp = 1 else depthtemp = depth end
					Unindent(25*depthtemp)
				end
			end
		end
	-- End GUI Functions --
-- End Core Functions & Helper Functions --

-- MoogleLib.API.ToggleGUI = false
-- function MoogleLib.Draw()
-- 	if GUI:IsKeyDown(17) then -- CTRL
-- 		if GUI:IsKeyReleased(192) then -- `
-- 			MoogleLib.API.ToggleGUI = not MoogleLib.API.ToggleGUI
-- 		end
-- 	end

-- 	if MoogleLib.API.ToggleGUI then
-- 		GUI:Begin("##MoogleGUIToggle",true)
-- 			GUI:BeginChild("##MoogleGUIToggle",0,0,GUI.WindowFlags_NoScrollbar)
-- 			GUI:EndChild()
-- 		GUI:End()
-- 		d("KaliMainWindow.GUI.open: "..tostring(KaliMainWindow.GUI.open))
-- 		d("KaliMainWindow.GUI.visible: "..tostring(KaliMainWindow.GUI.open))
-- 	end
-- end


local MarkerTable = {
	attack = {
		[1] = "empty",
		[2] = "empty",
		[3] = "empty",
		[4] = "empty",
		[5] = "empty"
	},
	bind = {
		[1] = "empty",
		[2] = "empty",
		[3] = "empty"
	},
	ignore = {
		[1] = "empty",
		[2] = "empty"
	},
	circle = "empty",
	cross = "empty",
	square = "empty",
	triangle = "empty"
}
local MarkerLogicDebug = false
local MarkerDelay = 0.5 -- Marker Delay in seconds, 0 = instant, 1 = 1 second, etc
local MarkerDelayLast = 0
local MarkerLastMark = 0
local EntitiesNeedMarked = {}
local EntitiesNeedRemoved = {}
local EntitiesHistory = {}
local EntitiesMarked = {}
local PreviousTarget = 0
local lastcheck = 0
local function MarkerLogic(MarkerType,filters,AddPlayer,buffids,time,ownerid,MissingBuffs) -- MissingBuffs is boolean (true/false), if false then HasBuffs
	if TimeSince(lastcheck) > 100 then
		lastcheck = Now()
		local el = EntityList(filters..[[,maxdistance=55]])
		if AddPlayer then
			table.insert(el, Player)
		end
		if table.valid(el) then
			for id,entity in pairs(el) do
				local pass = false
				if buffids then
					if MissingBuffs then
						if MissingBuffs(entity,buffids,time,ownerid) then
							pass = true
						end
					else
						if HasBuffs(entity,buffids,time,ownerid) then
							pass = true
						end
					end
				else
					pass = true
				end
				if pass then
					if EntitiesMarked[entity.id] == nil and EntitiesNeedMarked[entity.id] == nil then
						local NeedMarker = true
						if type(MarkerTable[MarkerType]) == "table" then
							for i,m in ipairs(MarkerTable[MarkerType]) do
								if NeedMarker and m == "empty" then
									MarkerTable[MarkerType][i] = entity.id
									EntitiesNeedMarked[entity.id] = MarkerType..tostring(i)
									NeedMarker = false
								end
							end
						else
							if MarkerTable[MarkerType] == "empty" then
								MarkerTable[MarkerType] = entity.id
								EntitiesNeedMarked[entity.id] = MarkerType
								NeedMarker = false
							end
						end
					end
					if EntitiesHistory[entity.id] == nil then
						EntitiesHistory[entity.id] = {}
						EntitiesHistory[entity.id]["MarkerType"] = MarkerType
						EntitiesHistory[entity.id]["buffids"] = buffids
						EntitiesHistory[entity.id]["time"] = time
						EntitiesHistory[entity.id]["ownerid"] = ownerid
						EntitiesHistory[entity.id]["MissingBuffs"] = Missingbuffs
					end
				else
					if EntitiesHistory[entity.id] then
						local pass = false
						if EntitiesHistory[entity.id]["MissingBuffs"] then
							if MissingBuffs(entity,EntitiesHistory[entity.id]["buffids"],EntitiesHistory[entity.id]["time"],EntitiesHistory[entity.id]["ownerid"]) then
								pass = true
							end
						else
							if HasBuffs(entity,EntitiesHistory[entity.id]["buffids"],EntitiesHistory[entity.id]["time"],EntitiesHistory[entity.id]["ownerid"]) then
								pass = true
							end
						end
						if not pass then
							if type(MarkerTable[EntitiesHistory[entity.id]["MarkerType"]]) == "table" then
								for k,v in pairs(MarkerTable[EntitiesHistory[entity.id]["MarkerType"]]) do
									if v == entity.id then
										EntitiesNeedRemoved[entity.id] = true
										EntitiesNeedMarked[entity.id] = nil
										EntitiesMarked[entity.id] = nil
										MarkerTable[EntitiesHistory[entity.id]["MarkerType"]][k] = nil
										EntitiesHistory[entity.id] = nil
									end
								end
							else
								EntitiesNeedRemoved[entity.id] = true
								EntitiesNeedMarked[entity.id] = nil
								EntitiesMarked[entity.id] = nil
								MarkerTable[EntitiesHistory[entity.id]["MarkerType"]][k] = nil
								EntitiesHistory[entity.id] = nil
							end
						end
					end
				end
			end
		end
		if table.valid(MarkerTable) then
			-- Check if you need to remove old entries --
			for k,v in pairs(MarkerTable) do
				if type(v) == "table" then
					for i,e in pairs(v) do
						if e ~= "empty" then
							if not EntityList:Get(e) then
								EntitiesNeedMarked[e] = nil
								EntitiesMarked[e] = nil
								MarkerTable[k][i] = "empty"
							end
						end
					end
				else
					if v ~= "empty" then
						if not EntityList:Get(v) then
							EntitiesNeedMarked[v] = nil
							EntitiesMarked[v] = nil
							MarkerTable[k] = "empty"
						end
					end
				end
			end
		end
		if table.valid(EntitiesNeedMarked) then
			for k,v in pairs(EntitiesNeedMarked) do
				local PlayerTarget = Player:GetTarget()
				if PreviousTarget == 0 then
					local entity = EntityList:Get(k)
					if entity then
						if PlayerTarget then
							PreviousTarget = PlayerTarget.id
						else
							PreviousTarget = Player.id
						end
						Player:SetTarget(k)
					end
				end
				if PreviousTarget ~= 0 then -- purposely ended w/o else to continue flow
					local PlayerTarget = Player:GetTarget()
					if PlayerTarget then
						if PlayerTarget.id == k then
							if EntitiesMarked[k] == nil then
								if MarkerDelayLast == 0 then
									MarkerDelayLast = k
								elseif MarkerDelayLast == k and TimeSince(MarkerLastMark) > (MarkerDelay * 1000) then
									SendTextCommand([[/marking ]]..v..[[ <t>]])
									EntitiesMarked[k] = v
									EntitiesNeedMarked[k] = nil
									MarkerLastMark = Now()
									MarkerDelayLast = 0
								end
							end
						else
							if MarkerDelayLast == 0 then
								local entity = EntityList:Get(k)
								if entity then
									Player:SetTarget(k)
								end
							end
						end
					else
						local entity = EntityList:Get(k)
						if entity then
							Player:SetTarget(k)
						end
					end
				end
			end
		else
			-- EntitiesNeedMarked is done, time to reset target back to original --
			if PreviousTarget ~= 0 then
				local CheckTarget = EntityList:Get(PreviousTarget)
				if CheckTarget and CheckTarget.targetable then
					-- Entity still exists, just need to set target again --
					Player:SetTarget(PreviousTarget)
				else
					-- Previous Target is not valid, time to improvise --
					if Player.role == 4 then
						-- You're a healer, so lets set your current target to lowest HP% party member --
						local el = EntityList:Get([[myparty,targetable,alive]])
						if table.valid(el) then
							local lowesthp = 0
							local hpp = 100
							for id, party in pairs(el) do
								if party.hp.percent < hpp then
									lowesthp = party.id
									hpp = party.hp.percent
								end
							end
							if lowesthp ~= 0 then
								Player:SetTarget(lowesthp)
							end
						end
					else
						-- You're either a DPS or a tank, so setting your target to nearest entity --
						local el = EntityList([[type=2,targetable,attackable,alive,nearest]])
						if table.valid(el) then
							for id,entity in pairs(el) do
								Player:SetTarget(entity.id)
							end
						end
					end
				end
				PreviousTarget = 0
			end
		end
		if table.valid(EntitiesNeedRemoved) and not table.valid(EntitiesNeedMarked) then
			for k,v in pairs(EntitiesNeedRemoved) do
				local PlayerTarget = Player:GetTarget()
				if PreviousTarget == 0 then
					local entity = EntityList:Get(k)
					if entity then
						if PlayerTarget then
							PreviousTarget = PlayerTarget.id
						else
							PreviousTarget = Player.id
						end
						Player:SetTarget(k)
					end
				end
				if PreviousTarget ~= 0 then -- purposely ended w/o else to continue flow
					local PlayerTarget = Player:GetTarget()
					if PlayerTarget then
						if PlayerTarget.id == k then
							if MarkerDelayLast == 0 then
								MarkerDelayLast = k
							elseif MarkerDelayLast == k and TimeSince(MarkerLastMark) > (MarkerDelay * 1000) then
								SendTextCommand([[/marking clear <t>]])
								EntitiesNeedRemoved[k] = nil
								MarkerLastMark = Now()
								MarkerDelayLast = 0
							end
						else
							if MarkerDelayLast == 0 then
								local entity = EntityList:Get(k)
								if entity then
									Player:SetTarget(k)
								end
							end
						end
					else
						local entity = EntityList:Get(k)
						if entity then
							Player:SetTarget(k)
						end
					end
				end
			end
		end
		if MarkerLogicDebug then
			ml_gui.showconsole = true
			d("filters: "..tostring(filters))
			d("MarkerTable:")
			table.print(MarkerTable)
			d("EntitiesNeedMarked:")
			table.print(EntitiesNeedMarked)
			d("EntitiesMarked:")
			table.print(EntitiesMarked)
			d("PreviousTarget: "..tostring(PreviousTarget))
		end
	end
end
function MoogleLib.OnUpdate()
	MoogleSave({
		["MoogleTTS.enable"] = "MoogleTTS.Settings.enable",
		["MoogleTTS.MainMenuType"] = "MoogleTTS.Settings.MainMenuType",
		["MoogleTTS.DownloadThreads"] = "MoogleTTS.Settings.DownloadThreads",
	})
	-- While executing Table.Print, if you hit a function you can't dump, it skips trying to --
	if PrintRunning then
		if TimeSince(PrintTime) > 100 then
			ResumePrinting = false
			PrintTime = Now()
			lastlasthistory = lasthistory
			Table.BannedKeys[lasthistory] = true
			Table.Print(PrintLastTbl,PrintLastName,PrintLastSearch,PrintLastDepth,PrintLastHistory,Printfilelocation)
		end
	end
	-- if ToggleCMD and NotAll(TogglePing,ToggleVersionCheck,ToggleDownloadString,ToggleDownloadTable,ToggleDownloadFile) then
	-- 	local str = OS.CMD(nil,nil,lastCopy)
	-- 	if str then d(str) end
	-- end
	-- if TogglePing then OS.Ping() end
	-- if ToggleDownloadFile then OS.DownloadFile() end
	-- if ToggleDownloadTable then OS.DownloadTable() end
	-- if ToggleVersionCheck then OS.VersionCheck() end
	-- if ToggleDownloadString then OS.DownloadString() end
	-- MarkerLogic("attack",[[type=1,targetable]],true,"48")
	MoogleDebug.lastCopy = lastCopy
	MoogleDebug.CMD = CMD
	MoogleDebug.outputfile = io.type(outputfile)
	MoogleDebug.CommandSent = CommandSent
	MoogleDebug.lastcmd = lastcmd
	if filetimestart then
		MoogleDebug.TimeSinceFileTimeStart = TimeSince(filetimestart)
	end
	MoogleDebug.writecomplete = writecomplete
	if MoogleDebug.LastSuccessfulUpdate then
		MoogleDebug.TimeSinceLastUpdate = TimeSince(MoogleDebug.LastSuccessfulUpdate)
	end
	if MoogleDebug.LastCMDUse then
		MoogleDebug.TimeSinceLastCMDUse = TimeSince(MoogleDebug.LastCMDUse)
	end
	API.UpdateEntities()

	-- if Valid(OS.CMDTable) then
	-- 	local CMD = OS.CMDTable
	-- 	local Threads = MoogleLib.Settings.DownloadThreads
	-- 	for i=1, Threads do
	-- 		if CMD[i] then
	-- 			OS.CMD(CMD[i].lastcmd,CMD[i].lastps,CMD[i].lasturl)
	-- 		end
	-- 	end
	-- end
end

-- RegisterEventHandler("Gameloop.Draw", MoogleLib.Draw)
RegisterEventHandler("Gameloop.Update", MoogleLib.OnUpdate)
