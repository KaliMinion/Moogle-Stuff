MoogleLib = {
	API = {},
	Lua = {
		Debug = {},
		General = {},
		IO = {},
		Math = {},
		OS = {},
		String = {},
		Table = {}
	},
	Gui = {},
	RegisteredFunctions = {}
}
local self = MoogleLib
local selfs = "MoogleLib"

self.Info = {
	Creator = "Kali",
	Version = "1.4.0",
	StartDate = "12/28/17",
	ReleaseDate = "12/30/17",
	LastUpdate = "01/04/18",
	URL = "https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleLib.lua",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Rework for self",
		["1.1.1"] = "Teaks",
		["1.1.2"] = "Download Overwrite Fix",
		["1.1.7"] = "Download Overwrite Fix 6...",
		["1.2.0"] = "File Delete Function",
		["1.2.2"] = "New Functions",
		["1.2.3"] = "Download Fixes...again",
		["1.2.4"] = "Download Tweaks and new Functions",
		["1.3.0"] = "Huge rework to fix locals and downloading",
		["1.3.6"] = "Added Save Settings Function",
		["1.4.0"] = "Complete rewrite."
	}
}
local Info = self.Info

self.GUI = {}

self.Settings = {
	enable = true,
	MainMenuType = 2,
	MainMenuEntryCreated = false,
}
local Settings = self.Settings

MoogleDebug, MoogleLog = {}, false
if not MoogleEvents then _G.MoogleEvents = {} end

-- Start Locals  --
local API = MoogleLib.API
local Lua = MoogleLib.Lua
local Debug = Lua.Debug
local General = Lua.General
local IO = Lua.IO
local Math = Lua.Math
local OS = Lua.OS
local String = Lua.String
local Table = Lua.Table
local Gui = MoogleLib.Gui

API.MinionPath = GetStartupPath() local MinionPath = API.MinionPath
API.LuaPath = GetLuaModsPath() local LuaPath = API.LuaPath

API.MooglePath = LuaPath .. [[MoogleStuff Files\]] local MooglePath = API.MooglePath
API.ImageFolder = MooglePath .. [[Moogle Images\]] local ImageFolder = API.ImageFolder
API.ScriptsFolder = MooglePath .. [[Moogle Scripts\]] local ScriptsFolder = API.ScriptsFolder
API.TempFolder = MooglePath .. [[Temp\]] local TempFolder = API.TempFolder

API.ACRFolder = LuaPath .. [[ACR\CombatRoutines\]] local ACRFolder = API.ACRFolder
API.SenseProfiles = LuaPath .. [[Sense\profiles\]] local SenseProfiles = API.SenseProfiles
API.SenseTriggers = LuaPath .. [[Sense\triggers\]] local SenseTriggers = API.SenseTriggers
API.GitURL = function(ModuleFileName, Branch) Branch = Branch or "master" return [[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/]] .. Branch .. [[/]] .. ModuleFileName .. [[.lua]] end local GitURL = API.GitURL

local function sec(val,ms) val = val ms = ms or true if ms then return val*1000 else return val end end
local function min(val,ms) val = val*60 ms = ms or true if ms then return val*1000 else return val end end
local function hr(val,ms) val = val*3600 ms = ms or true if ms then return val*1000 else return val end end
local function day(val,ms) val = val*86400 ms = ms or true if ms then return val*1000 else return val end end
local function week(val,ms) val = val*604800 ms = ms or true if ms then return val*1000 else return val end end
local function month(val,days,ms)
	if Type(days,"boolean") then ms = days; days = nil end
	days = days or 30; ms = ms or true; local val2 = 0
	if Type(days,"number") then val2 = day(days) else val2 = 2629744 end val = val * val2
	if ms then return val*1000 else return val end
end
local function year(val,days,ms)
	if Type(days,"boolean") then ms = days; days = nil end
	days = days or 365.24219907408; ms = ms or true; local val2 = 0
	if Type(days,"number") then val2 = day(days) else val2 = 31556926 end val = val * val2
	if ms then return val*1000 else return val end
end

--DownloadImages,MoogleLoad

local Initialize, LoadModule, VersionCheck, LastPush, GitFileText, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, Keybinds, RecordKeybinds, ToasterTable, ToasterTime, Toaster, Error, debug, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, TimeSince, Size, Empty, NotEmpty, d2, DrawDebugInfo, DrawTree, AddTree, RemoveTree, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, WriteToFile, WipeFile, Queue, CMD, DownloadString, DownloadTable, DownloadFile, Ping, Split, starts, ends, ToTable, ProperCase, Proper, Case, Title, TitleCase, IsURL, Valid, NotValid, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, BannedKeys, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Image, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables, FinishedLoading

local loaded = true
local function UpdateLocals4()
	if loaded and VirtualKeys == nil then if Gui.VirtualKeys then VirtualKeys = Gui.VirtualKeys else loaded = false end end
	if loaded and OrderedKeys == nil then if Gui.OrderedKeys then OrderedKeys = Gui.OrderedKeys else loaded = false end end
	if loaded and IndexToDecimal == nil then if Gui.IndexToDecimal then IndexToDecimal = Gui.IndexToDecimal else loaded = false end end
	if loaded and HotKey == nil then if Gui.HotKey then HotKey = Gui.HotKey else loaded = false end end
	if loaded and DrawTables == nil then if Gui.DrawTables then DrawTables = Gui.DrawTables else loaded = false end end
	if loaded then FinishedLoading = true end
end
local function UpdateLocals3()
	if loaded and ends == nil then if String.ends then ends = String.ends else loaded = false end end
	if loaded and ToTable == nil then if String.ToTable then ToTable = String.ToTable else loaded = false end end
	if loaded and ProperCase == nil then if String.ProperCase then ProperCase = String.ProperCase else loaded = false end end
	if loaded and Proper == nil then if String.Proper then Proper = String.Proper else loaded = false end end
	if loaded and Case == nil then if String.Case then Case = String.Case else loaded = false end end
	if loaded and Title == nil then if String.Title then Title = String.Title else loaded = false end end
	if loaded and TitleCase == nil then if String.TitleCase then TitleCase = String.TitleCase else loaded = false end end
	if loaded and IsURL == nil then if String.IsURL then IsURL = String.IsURL else loaded = false end end

	if loaded and Valid == nil then if Table.Valid then Valid = Table.Valid else loaded = false end end
	if loaded and NotValid == nil then if Table.NotValid then NotValid = Table.NotValid else loaded = false end end
	if loaded and InsertIfNil == nil then if Table.InsertIfNil then InsertIfNil = Table.InsertIfNil else loaded = false end end
	if loaded and RemoveIfNil == nil then if Table.RemoveIfNil then RemoveIfNil = Table.RemoveIfNil else loaded = false end end
	if loaded and UpdateIfChanged == nil then if Table.UpdateIfChanged then UpdateIfChanged = Table.UpdateIfChanged else loaded = false end end
	if loaded and RemoveExpired == nil then if Table.RemoveExpired then RemoveExpired = Table.RemoveExpired else loaded = false end end
	if loaded and Unpack == nil then if Table.Unpack then Unpack = Table.Unpack else loaded = false end end
	if loaded and BannedKeys == nil then if Table.BannedKeys then BannedKeys = Table.BannedKeys else loaded = false end end
	if loaded and Print == nil then if Table.Print then Print = Table.Print else loaded = false end end

	if loaded and WindowStyle == nil then if Gui.WindowStyle then WindowStyle = Gui.WindowStyle else loaded = false end end
	if loaded and WindowStyleClose == nil then if Gui.WindowStyleClose then WindowStyleClose = Gui.WindowStyleClose else loaded = false end end
	if loaded and ColorConv == nil then if Gui.ColorConv then ColorConv = Gui.ColorConv else loaded = false end end
	if loaded and SameLine == nil then if Gui.SameLine then SameLine = Gui.SameLine else loaded = false end end
	if loaded and Indent == nil then if Gui.Indent then Indent = Gui.Indent else loaded = false end end
	if loaded and Unindent == nil then if Gui.Unindent then Unindent = Gui.Unindent else loaded = false end end
	if loaded and Space == nil then if Gui.Space then Space = Gui.Space else loaded = false end end
	if loaded and Text == nil then if Gui.Text then Text = Gui.Text else loaded = false end end
	if loaded and Checkbox == nil then if Gui.Checkbox then Checkbox = Gui.Checkbox else loaded = false end end
	if loaded and Image == nil then if Gui.Image then Image = Gui.Image else loaded = false end end
	if loaded and Tooltip == nil then if Gui.Tooltip then Tooltip = Gui.Tooltip else loaded = false end end
	if loaded and GetRemaining == nil then if Gui.GetRemaining then GetRemaining = Gui.GetRemaining else loaded = false end end
	if loaded then UpdateLocals4() end
end

local loaded = true
local function UpdateLocals2()
	if loaded and IsAll == nil then if General.IsAll then IsAll = General.IsAll else loaded = false end end
	if loaded and Not == nil then if General.Not then Not = General.Not else loaded = false end end
	if loaded and NotAll == nil then if General.NotAll then NotAll = General.NotAll else loaded = false end end
	if loaded and Type == nil then if General.Type then Type = General.Type else loaded = false end end
	if loaded and NotType == nil then if General.NotType then NotType = General.NotType else loaded = false end end
	if loaded and TimeSince == nil then if General.TimeSince then TimeSince = General.TimeSince else loaded = false end end
	if loaded and Size == nil then if General.Size then Size = General.Size else loaded = false end end
	if loaded and Empty == nil then if General.Empty then Empty = General.Empty else loaded = false end end
	if loaded and NotEmpty == nil then if General.NotEmpty then NotEmpty = General.NotEmpty else loaded = false end end

	if loaded and d2 == nil then if Debug.d2 then d2 = Debug.d2 else loaded = false end end
	if loaded and DrawDebugInfo == nil then if Debug.DrawDebugInfo then DrawDebugInfo = Debug.DrawDebugInfo else loaded = false end end
	if loaded and DrawTree == nil then if Debug.DrawTree then DrawTree = Debug.DrawTree else loaded = false end end
	if loaded and AddTree == nil then if Debug.AddTree then AddTree = Debug.AddTree else loaded = false end end
	if loaded and RemoveTree == nil then if Debug.RemoveTree then RemoveTree = Debug.RemoveTree else loaded = false end end

	if loaded and Sign == nil then if Math.Sign then Sign = Math.Sign else loaded = false end end
	if loaded and Round == nil then if Math.Round then Round = Math.Round else loaded = false end end
	if loaded and Convert4Bytes == nil then if Math.Convert4Bytes then Convert4Bytes = Math.Convert4Bytes else loaded = false end end

	if loaded and PowerShell == nil then if OS.PowerShell then PowerShell = OS.PowerShell else loaded = false end end
	if loaded and CreateFolder == nil then if OS.CreateFolder then CreateFolder = OS.CreateFolder else loaded = false end end
	if loaded and DeleteFile == nil then if OS.DeleteFile then DeleteFile = OS.DeleteFile else loaded = false end end
	if loaded and WriteToFile == nil then if OS.WriteToFile then WriteToFile = OS.WriteToFile else loaded = false end end
	if loaded and WipeFile == nil then if OS.WipeFile then WipeFile = OS.WipeFile else loaded = false end end
	if loaded and Queue == nil then if OS.Queue then Queue = OS.Queue else loaded = false end end
	if loaded and CMD == nil then if OS.CMD then CMD = OS.CMD else loaded = false end end
	if loaded and DownloadString == nil then if OS.DownloadString then DownloadString = OS.DownloadString else loaded = false end end
	if loaded and DownloadFile == nil then if OS.DownloadFile then DownloadFile = OS.DownloadFile else loaded = false end end
	if loaded and Ping == nil then if OS.Ping then Ping = OS.Ping else loaded = false end end

	if loaded and Split == nil then if String.Split then Split = String.Split else loaded = false end end
	if loaded and starts == nil then if String.starts then starts = String.starts else loaded = false end end
	if loaded then UpdateLocals3() end
end

local loaded = true
local function UpdateLocals()
	if loaded and Initialize == nil then if API.Initialize then Initialize = API.Initialize else loaded = false end end
	if loaded and LoadModule == nil then if API.LoadModule then LoadModule = API.LoadModule else loaded = false end end
	if loaded and VersionCheck == nil then if API.VersionCheck then VersionCheck = API.VersionCheck else loaded = false end end
	if loaded and LastPush == nil then if API.LastPush then LastPush = API.LastPush else loaded = false end end
	if loaded and GitFileText == nil then if API.GitFileText then GitFileText = API.GitFileText else loaded = false end end
	if loaded and Vars == nil then if API.Vars then Vars = API.Vars else loaded = false end end
	if loaded and Distance2D == nil then if API.Distance2D then Distance2D = API.Distance2D else loaded = false end end
	if loaded and Distance3D == nil then if API.Distance3D then Distance3D = API.Distance3D else loaded = false end end
	if loaded and CurrentTarget == nil then if API.CurrentTarget then CurrentTarget = API.CurrentTarget else loaded = false end end
	if loaded and MovePlayer == nil then if API.MovePlayer then MovePlayer = API.MovePlayer else loaded = false end end
	if loaded and SetTarget == nil then if API.SetTarget then SetTarget = API.SetTarget else loaded = false end end
	if loaded and ConvertCID == nil then if API.ConvertCID then ConvertCID = API.ConvertCID else loaded = false end end
	if loaded and Entities == nil then if API.Entities then Entities = API.Entities else loaded = false end end
	if loaded and Entities2 == nil then if API.Entities2 then Entities2 = API.Entities2 else loaded = false end end
	if loaded and EntitiesUpdateInterval == nil then if API.EntitiesUpdateInterval then EntitiesUpdateInterval = API.EntitiesUpdateInterval else loaded = false end end
	if loaded and EntitiesLastUpdate == nil then if API.EntitiesLastUpdate then EntitiesLastUpdate = API.EntitiesLastUpdate else loaded = false end end
	if loaded and UpdateEntities == nil then if API.UpdateEntities then UpdateEntities = API.UpdateEntities else loaded = false end end
	if loaded and CMDKeyPress == nil then if API.CMDKeyPress then CMDKeyPress = API.CMDKeyPress else loaded = false end end
	if loaded and SendKey == nil then if API.SendKey then SendKey = API.SendKey else loaded = false end end
	if loaded and Keybinds == nil then if API.Keybinds then Keybinds = API.Keybinds else loaded = false end end
	if loaded and RecordKeybinds == nil then if API.RecordKeybinds then RecordKeybinds = API.RecordKeybinds else loaded = false end end
	if loaded and ToasterTable == nil then if API.ToasterTable then ToasterTable = API.ToasterTable else loaded = false end end
	if loaded and ToasterTime == nil then if API.ToasterTime then ToasterTime = API.ToasterTime else loaded = false end end
	if loaded and Toaster == nil then if API.Toaster then Toaster = API.Toaster else loaded = false end end

	if loaded and Error == nil then if General.Error then Error = General.Error else loaded = false end end
	if loaded and debug == nil then if General.Debug then debug = General.Debug else loaded = false end end
	if loaded and IsNil == nil then if General.IsNil then IsNil = General.IsNil else loaded = false end end
	if loaded and NotNil == nil then if General.NotNil then NotNil = General.NotNil else loaded = false end end
	if loaded and Is == nil then if General.Is then Is = General.Is else loaded = false end end
	if loaded then UpdateLocals2() end
end
-- End Locals  --

------------------------------------------------------------------------------------------------------------------------
function API.Initialize(ModuleTable)
	if ModuleTable and ModuleTable.name then
		local MenuType = Settings.MainMenuType
		local MainIcon = ImageFolder .. [[MoogleStuff.png]]
		local ModuleIcon = ImageFolder .. ModuleTable.name .. [[.png]]

		-- Create the Main Menu entry if it hasn't been created yet --
		if not Settings.MainMenuEntryCreated then
			local ImGUIIcon = GetStartupPath() .. "\\GUI\\UI_Textures\\ImGUI.png"
			local MetricsIcon = GetStartupPath() .. "\\GUI\\UI_Textures\\Metrics.png"
			local ImGUIToolTip = "ImGUI Demo is an overview of what's possible with the UI."
			local MetricsToolTip = "ImGUI Metrics shows every window's rendering information, visible or hidden."

			if MenuType == 1 then
				-- No Main Menu Entry --
				-- Adding the ImGUI Test Window as a Minion Menu entry
				ml_gui.ui_mgr:AddMember({ id = "ImGUIDemo", name = "ImGUI Demo", onClick = function() ml_gui.showtestwindow = true end, tooltip = ImGUIToolTip, texture = ImGUIIcon }, "FFXIVMINION##MENU_HEADER")
				-- Adding the ImGUI Test Window as a Minion Menu entry
				ml_gui.ui_mgr:AddMember({ id = "ImGUIMetrics", name = "ImGUIMetrics", onClick = function() ml_gui.showmetricswindow = true end, tooltip = MetricsToolTip, texture = MetricsIcon }, "FFXIVMINION##MENU_HEADER")
			elseif MenuType == 2 then
				-- Expansion Submenu inside of Main Menu --
				ml_gui.ui_mgr:AddMember({ id = [[MOOGLESTUFF##MENU_HEADER]], name = "MoogleStuff", texture = MainIcon }, "FFXIVMINION##MENU_HEADER")
				-- Adding the ImGUI Test Window as a Minion Menu entry
				ml_gui.ui_mgr:AddSubMember({ id = "ImGUIDemo", name = "ImGUI Demo", onClick = function() ml_gui.showtestwindow = not ml_gui.showtestwindow end, tooltip = ImGUIToolTip, texture = ImGUIIcon }, "FFXIVMINION##MENU_HEADER", "MOOGLESTUFF##MENU_HEADER")
				-- Adding the ImGUI Test Window as a Minion Menu entry
				ml_gui.ui_mgr:AddSubMember({ id = "ImGUIMetrics", name = "ImGUIMetrics", onClick = function() ml_gui.showmetricswindow = not ml_gui.showmetricswindow end, tooltip = MetricsToolTip, texture = MetricsIcon }, "FFXIVMINION##MENU_HEADER", "MOOGLESTUFF##MENU_HEADER")
			elseif MenuType == 3 then
				-- New Component Header that branches off to the right --
				ml_gui.ui_mgr:AddComponent({ header = { id = [[MOOGLESTUFF##MENU_HEADER]], expanded = false, name = "MoogleStuff", texture = MainIcon }, members = {} })
				-- Adding the ImGUI Test Window as a Minion Menu entry
				ml_gui.ui_mgr:AddMember({ id = "ImGUIDemo", name = "ImGUI Demo", onClick = function() ml_gui.showtestwindow = true end, tooltip = ImGUIToolTip, texture = ImGUIIcon }, "MOOGLESTUFF##MENU_HEADER")
				-- Adding the ImGUI Test Window as a Minion Menu entry
				ml_gui.ui_mgr:AddMember({ id = "ImGUIMetrics", name = "ImGUIMetrics", onClick = function() ml_gui.showmetricswindow = true end, tooltip = MetricsToolTip, texture = MetricsIcon }, "MOOGLESTUFF##MENU_HEADER")
			end
			Settings.MainMenuEntryCreated = true
		end

		-- Creating Module Entry --
		if MenuType == 1 then
			ml_gui.ui_mgr:AddMember({ id = ModuleTable.WindowName, name = ModuleTable.name, onClick = function() ModuleTable.OnClick() end, tooltip = ModuleTable.ToolTip, texture = ModuleIcon }, "FFXIVMINION##MENU_HEADER")
		elseif MenuType == 2 then
			ml_gui.ui_mgr:AddSubMember({ id = ModuleTable.WindowName, name = ModuleTable.name, onClick = function() ModuleTable.OnClick() end, tooltip = ModuleTable.ToolTip, texture = ModuleIcon }, "FFXIVMINION##MENU_HEADER", "MOOGLESTUFF##MENU_HEADER")
		elseif MenuType == 3 then
			ml_gui.ui_mgr:AddMember({ id = ModuleTable.WindowName, name = ModuleTable.name, onClick = function() ModuleTable.OnClick() end, tooltip = ModuleTable.ToolTip, texture = ModuleIcon }, "MOOGLESTUFF##MENU_HEADER")
		end

		-- Mini Button --
		if ModuleTable.MiniButton then
			local MiniNameStr = ModuleTable.MiniName or ModuleTable.name
			table.insert(ml_global_information.menu.windows, { name = MiniNameStr, openWindow = function() ModuleTable.OnClick() end, isOpen = function() return ModuleTable.IsOpen() end })
		end
		return Settings.MainMenuEntryCreated
	end
end

function API.Event(event,module,name,func)
	if func then
		if not MoogleEvents[module.." - "..event.." - "..name] then
			local function run()
				func()
			end
			RegisterEventHandler(event,run)
			MoogleEvents[module.." - "..event.." - "..name] = true
		end
	end
end

local LocalsStr
function API.LoadModule(filepath)
	AddTree("MoogleLib.API","Load Module")
	AddTree("MoogleLib.API.Load Module",filepath:gsub("%.","_"),true)
	if fileexist(filepath) then
		AddTree("MoogleLib.API.Load Module."..filepath:gsub("%.","_"),"Valid Result",true)
		local str,start,line = "",false,""
		if IsNil(LocalsStr) then
			local Lib = io.open(MooglePath..[[MoogleLib.lua]],"r")
			repeat line = Lib:read("*l")
				if line == "-- Start Locals  --" then start = true end
				if start then
					str = str..line.."\r\n"
				end
			until line:match([[-- End Locals  --]]) Lib:close()
			if start then
				LocalsStr = str
			end
		else
			str = LocalsStr
		end
		local file = io.open(filepath,"r")
		repeat line = file:read("*l") str = str..line.."\r\n" until line:match([[-- End of File --]]) file:close()

		local pos = 0
		loadstring(str)()
		local filename = filepath:match("[^\\]+$"):gsub("%..+$","") if filename then d("MoogleLib: Loading "..filename) end
	end
end

function API.VersionCheck(name, url, version)
	AddTree("MoogleLib.API","Version Check")
	AddTree("MoogleLib.API.Version Check",name,true)
	url = url or GitURL(name)

	local result, localversion = DownloadString(url), nil
	if Type(_G[name],"table") then localversion = _G[name].Info.Version end
	if Type(result,"string") and #result > 3 then
		AddTree("MoogleLib.API.Version Check."..name,"Valid Result",true)
		local str
		for s in result:gmatch("[^\r\n]+") do
			if IsNil(str) and s:match([[.*Version = "([^"]+)]]) then
				str = s:gsub("[^%d\.]", "")
			end
		end
		if str then
			if version and localversion then
				local str2 = version:gsub("[^%d\.]", "")
				local str3 = localversion:gsub("[^%d\.]", "")
				local tbl = str:totable("%p")
				local tbl2 = str2:totable("%p")
				local tbl3 = str3:totable("%p")
				local update = false
				if (tbl[1] > tbl2[1]) then update = true
				elseif tbl[1] == tbl2[1] and (tbl[2] > tbl2[2]) then update = true
				elseif tbl[1] == tbl2[1] and tbl[2] == tbl2[2] and (tbl[3] > tbl2[3]) then update = true
				elseif (tbl[1] > tbl3[1]) then update = true
				elseif tbl[1] == tbl3[1] and (tbl[2] > tbl3[2]) then update = true
				elseif tbl[1] == tbl3[1] and tbl[2] == tbl3[2] and (tbl[3] > tbl3[3]) then update = true
				end
				if update then AddTree("MoogleLib.API.Version Check."..name..".Valid Result","Update Available") end

				return update, str, result
			elseif localversion then
				local str2 = localversion:gsub("[^%d\.]", "")
				local tbl = str:totable("%p")
				local tbl2 = str2:totable("%p")
				local update = false
				if (tbl[1] > tbl2[1]) then update = true
				elseif tbl[1] == tbl2[1] and (tbl[2] > tbl2[2]) then update = true
				elseif tbl[1] == tbl2[1] and tbl[2] == tbl2[2] and (tbl[3] > tbl2[3]) then update = true
				end
				if update then AddTree("MoogleLib.API.Version Check."..name..".Valid Result","Update Available") end

				return update, str, result
			else
				return false, str, result
			end
		end
	end
end

function API.LastPush(GitFile, date)
	AddTree("MoogleLib.API","LastPush")
	AddTree("MoogleLib.API.LastPush",tostring(GitFile:gsub("%.lua",""):gsub("%/"," - ")),true)
	local tbl = {}
	local result = OS.CMD([[PowerShell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $content = (New-Object System.Net.WebClient).DownloadString('https://github.com/KaliMinion/Moogle-Stuff/commits/master/]] .. GitFile ..[['); $HTML = New-Object -Com 'HTMLFile'; $src = [System.Text.Encoding]::Unicode.GetBytes($content); $HTML.write($src); @($HTML.body.getElementsByTagName('relative-time'))[0].outerHTML | %{$_.split('"')[1]} | Set-Content -Path 'outputfile'"]])
	if result then
		AddTree("MoogleLib.API.LastPush."..tostring(GitFile:gsub("%.lua",""):gsub("%/"," - ")),"Valid Result",true)
		for s in (result:match("\"[^\"]+"):gsub("\"","")):gmatch("[%d]+") do
			tbl[#tbl+1] = s
		end
		if #tbl == 6 then
			if date then
				return os.date ("%x %X", os.time{ year = tbl[1], month = tbl[2], day = tbl[3], hour = tbl[4], min = tbl[5], sec = tbl[6]} - 21600)
			else
				return os.time{ year = tbl[1], month = tbl[2], day = tbl[3], hour = tbl[4], min = tbl[5], sec = tbl[6]} - 21600
			end
		end
	end
end

function API.GitFileText(GitFile)
	AddTree("MoogleLib.API","GitFile Text")
	AddTree("MoogleLib.API.GitFile Text", GitFile,true)
	local url; if IsURL(GitFile) then url = GitFile else url = [[https://github.com/KaliMinion/Moogle-Stuff/blob/master/]]..GitFile..[[.lua]] end
	return OS.CMD([[PowerShell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $content = (New-Object System.Net.WebClient).DownloadString(']]..url..[['); $HTML = New-Object -Com 'HTMLFile'; $src = [System.Text.Encoding]::Unicode.GetBytes($content); $HTML.write($src); @($HTML.body.getElementsByTagName('table'))[0].innerText | Set-Content -Path 'outputfile'"]])
end

local init = true
API.InputTable = {}
function API.Input(event, message, wParam, lParam)
	if table.size(API.InputTable) ~= 0 then API.InputTable = {} end
	if ml_input_mgr.InputHandler and init then
		ml_input_mgr.InputHandler = function(event, message, wParam, lParam)
			--			d(tostring(message).." "..tostring(wParam).." "..tostring(lParam)) -- all string values received.
			if (string.valid(message) and string.valid(wParam) and string.valid(lParam)) then
				-- scrolling zoom for btree, keep this for minion function
				if (message == "522") then
					BehaviorManager:ChangeZoom(tonumber(lParam))
				end
			end
			API.InputTable.message = message
			API.InputTable.wParam = wParam
			API.InputTable.lParam = lParam
		end
		init = false
		-- Unable to use my event function due to issues --
		if MoogleLib["MoogleLib - Gameloop.Input - Input"] == nil then
			RegisterEventHandler("Gameloop.Input", ml_input_mgr.InputHandler)
			MoogleLib["MoogleLib - Gameloop.Input - Input"] = true
		end
	end
end

function API.MouseWheel()
	if API.InputTable.message == "522" then
		return tonumber(API.InputTable.lParam) / 120
	end
end

-- Example Usage --
--local wheel = API.MouseWheel()
--if wheel then
--	local state = ""; if wheel > 0 then state = "Up" else state = "Down" end
--	local add = string.rep("!", math.abs(wheel))
--	Error("Scrolling "..state..add)
--end

function API.Vars(Tbl, load, UseJustSettings)
	for k, v in pairs(Tbl) do
		local SaveTable = _G.Settings
		if UseJustSettings == nil then
			if type(SaveTable.MoogleStuff) == "table" then
				SaveTable = SaveTable.MoogleStuff
			else
				SaveTable.MoogleStuff = {}
				SaveTable = SaveTable.MoogleStuff
			end
		end
		local savevar = ""
		local ModuleTable = _G
		local t = {}
		local t2 = {}
		for w in tostring(k):gmatch("[%P/_/:]+") do
			t[#t + 1] = w
		end
		for w in tostring(v):gmatch("[%P/_/:]+") do
			t2[#t2 + 1] = w
		end
		for i, e in pairs(t) do
			if i < #t then
				if type(SaveTable[e]) == "table" then
					SaveTable = SaveTable[e]
				else
					SaveTable[e] = {}
					SaveTable = SaveTable[e]
				end
			else
				savevar = e
			end
		end

		for i, e in pairs(t2) do
			if i < #t2 then
				if ModuleTable[e] ~= nil then
					ModuleTable = ModuleTable[e]
				else
					return
				end
			else
				if load then
--					if type(SaveTable[savevar]) == nil then
--						SaveTable[savevar] = ModuleTable[e]
--					end
--					ModuleTable[e] = SaveTable[savevar] or ModuleTable[e]
					if type(SaveTable[savevar]) ~= nil and SaveTable[savevar] ~= ModuleTable[e] then
						ModuleTable[e] = SaveTable[savevar] or ModuleTable[e]
					end
				else
					if type(SaveTable[savevar]) == nil or SaveTable[savevar] ~= ModuleTable[e] then
						SaveTable[savevar] = ModuleTable[e]
						ml_settings_mgr:SaveSettings()
					end
				end
			end
		end
	end
end

MoogleSave = API.Vars
function MoogleLoad(tbl)
	API.Vars(tbl, true)
end

API.ImageList, API.FinishedImages, API.ImageLastCheck = {},{},0
function API.DownloadImages(image,path)
	if FinishedLoading then
		if image == nil then
			if TimeSince(API.ImageLastCheck,min(1)) then
				AddTree("MoogleLib.API","Download Image")
				AddTree("MoogleLib.API.Download Image","Automated Check",true)
				path = path or ImageFolder
				API.ImageCMD = io.popen([[PowerShell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $path = ']]..path..[['; mkdir -Force $path | Out-Null; (Invoke-WebRequest -Uri 'https://github.com/KaliMinion/Moogle-Stuff/tree/master/Moogle%20Images').Links | Where-Object -Property class -EQ -Value 'js-navigation-open' | Select-Object -Skip 1 | ForEach-Object{$url = 'https://github.com' + ($_.href -replace 'blob/', 'raw/'); if(![System.IO.File]::Exists($path+$_.title)){try{Invoke-WebRequest $url -OutFile ($path+$_.title)} catch { $_.Exception.Response }}}"]])
				API.ImageLastCheck = Now()
			end
		else
			AddTree("MoogleLib.API","Download Image")
			AddTree("MoogleLib.API.Download Image",image,true)
			path = path or ImageFolder
		end
	end
end
API.Event("Gameloop.Update",selfs,"DownloadImages",API.DownloadImages)

function API.Distance2D(table1, table2)
	if table2 == nil then
		table2 = table1
		table1 = Player
	end
	if table.valid(table1) and table.valid(table2) then
		return (math.sqrt(math.pow((table2.pos.x - table1.pos.x), 2) + math.pow((table2.pos.z - table1.pos.z), 2))) - (table1.hitradius + table2.hitradius)
	end
end

function API.Distance3D(table1, table2)
	if IsNil(table1.pos) then
		table1 = { ["pos"] = table1 }
		table1["hitradius"] = Player.hitradius
	end
	if IsNil(table2) then
		table2 = Player
	elseif IsNil(table2.pos) then
		table2 = { ["pos"] = table2 }
		table2["hitradius"] = Player.hitradius
	end

	if table.valid(table1) and table.valid(table2) then
		return (math.sqrt(math.pow((table2.pos.x - table1.pos.x), 2) + math.pow((table2.pos.z - table1.pos.z), 2) + math.pow((table2.pos.y - table1.pos.y), 2))) - (table1.hitradius + table2.hitradius)
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
				t[#t + 1] = w
			end
			if table.size(t) == 1 then
				if t[1] == "table" then
					return target
				elseif In(t[1], "2D", "Distance2D") then
					return Distance2D(Player, target)
				elseif In(t[1], "3D", "Distance3D") then
					return Distance3D(Player, target)
				else
					return target[t[1]]
				end
			else
				local ctarget = target
				for k, v in pairs(t) do
					ctarget = ctarget[v]
				end
				return ctarget
			end
		end
	else
		return false
	end
end

local CanTeleport, TeleportTime = true, 0
function API.MovePlayer(pos, map, stopdist)
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
				local Sprint = ActionList:Get(1, 3)

				if Sprint and Valid(ml_navigation.path) and Sprint.usable and Sprint:IsReady() then
					Sprint:Cast()
				end
			end
		end
	elseif CanTeleport then
		if MIsMoving() then Player:Stop() end
		if not MIsLoading() and not MIsCasting() and NotAll(Player.action, 92, 93, 164) then
			Player:Teleport(GetAetheryteByMapID(map, pos).id)
			CanTeleport = false
			TeleportTime = Now()
		end
	elseif TimeSince(TeleportTime,5000) then
		CanTeleport = true
	end
	return false
end

local LastInteract = 0
function API.SetTarget(targetid, act)
	local target = Player:GetTarget()
	local entity = EntityList:Get(id)

	if Type(targetid, "table") then
		targetid = targetid.id
	end

	if not target or target.id ~= targetid then
		Player:SetTarget(targetid)

		if act and TimeSince(LastInteract,500) then
			Player:Interact(targetid)
			LastInteract = Now()
		end
		return true
	elseif target and target.id == targetid then
		return true
	end
	return false
end

function API.ConvertCID(CID, returntable)
	local el = EntityList("contentid=" .. tostring(CID))
	if table.valid(el) then
		for k, v in pairs(el) do
			if returntable then
				return v
			else
				return v.id
			end
		end
	end
end

API.Entities, API.Entities2, API.EntitiesUpdateInterval, API.EntitiesLastUpdate = {}, {}, 250, 0
function API.UpdateEntities()
	if Text and TimeSince(API.EntitiesLastUpdate, API.EntitiesUpdateInterval) then
		API.EntitiesLastUpdate = Now()
		API.Entities = EntityList("")
		if Valid(API.Entities) then
			table.insert(API.Entities, Player)
			for k, v in pairs(API.Entities) do
				InsertIfNil(API.Entities2, "zone", Player.localmapid)
				if API.Entities2.zone ~= Player.localmapid then
					API.Entities2 = {}
					API.Entities2.zone = Player.localmapid
				end
				InsertIfNil(API.Entities2, v.id, {})
				InsertIfNil(API.Entities2[v.id], "name", v.name)
				if v.incombat then
					InsertIfNil(API.Entities2[v.id], "combatstart", Now())
					InsertIfNil(API.Entities2[v.id], "starthp", v.hp.current)
					if API.Entities2[v.id].percent then
						if API.Entities2[v.id].percent < 75 and v.hp.percent > 75 then
							API.Entities2[v.id].combatstart = Now()
							API.Entities2[v.id].starthp = v.hp.current
							API.Entities2[v.id].combattime = nil
							API.Entities2[v.id].dps = nil
							API.Entities2[v.id].ttd = nil
						end
					end
					UpdateIfChanged(API.Entities2[v.id], "percent", (v.hp.current / v.hp.max) * 100)
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
	local SendKeyPress = ScriptsFolder .. [[SendKeyPress.exe]]
	if not FileExists(SendKeyPress) then
		FileWrite(SendKeyPress, [[ControlSend, , %1%, FINAL FANTASY XIV ]])
	end
	if Type(key, "string") then
		CMDKeyPress = io.popen([["]] .. SendKeyPress .. [[" {]] .. key .. [[}]])
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
			for k, v in table.pairsbykeys(TabCount) do
				GetControl("ConfigKeybind"):PushButton(24, page)
				for i = 10, v * 4, 4 do
					if GetControl("ConfigKeybind"):GetRawData()[i] and GetControl("ConfigKeybind"):GetRawData()[i + 2] and GetControl("ConfigKeybind"):GetRawData()[i + 3] then
						d(GetControl("ConfigKeybind"):GetRawData()[i].value)
						API.Keybinds[k][tostring(GetControl("ConfigKeybind"):GetRawData()[i].value)] = GetControl("ConfigKeybind"):GetRawData()[i + 2].value
						API.Keybinds[k][tostring(GetControl("ConfigKeybind"):GetRawData()[i].value) .. "2"] = GetControl("ConfigKeybind"):GetRawData()[i + 3].value
					end
				end
				page = page + 1
			end
			FileSave(MooglePath .. "keybinds.lua", API.Keybinds)
		end
	elseif SendOpen then
		ActionList:Get(10, 20):Cast()
		SendOpen = false
	end
end

function MoogleTime()
	GUI:SetClipboardText(os.time())
end

API.ToasterTable = {}
API.ToasterTime = 5000
local lastsize, lasttime = 0, 0
function API.Toaster(Title, Text, Time)
	local tbl = API.ToasterTable
	Time = Time or API.ToasterTime
	if NotNil(Title, Text, Time) then
		tbl[#tbl + 1] = {
			title = Title,
			text = Text,
			time = Time,
			start = Now()
		}
	end
	if table.valid(API.ToasterTime) then
		GUI:Begin("ToasterWindow" .. tostring())
	end
end

-- End API Functions --

-- General Functions --

function General.Error(string)
	ml_error(string)
end

function General.Debug(string,level)
	if MoogleLog then
		level = level or 1
		ml_debug("[MoogleLib]: "..string, "MoogleLog", level)
	end
end

function General.IsNil(...)
	local tbl = { ... }
	if #tbl > 0 then
		for i = 1, #tbl do
			local x = tbl[i]
			if x == nil or x == "" then
				return true
			end
		end
	else
		return true
	end
	return false
	--			-- First check if "check" is nil --
	--			local x = check or "isnil"
	--			if x == "isnil" then
	--				-- "check" was nil, now return true or alternate value --
	--				if check ~= "" then
	--					return alt or true
	--				else
	--					return original or false
	--				end
	--			else
	--				-- "check" was not nil, return false or return original if not nil --
	--				return original or false
	--			end
end

function General.NotNil(...)
	local tbl = { ... }
	if #tbl > 0 then
		for i = 1, #tbl do
			local x = tbl[i]
			if x == nil or x == "" then
				return false
			end
		end
	else
		return false
	end
	return true
	--			-- First check that "check" is nil --
	--			local x = check or "isnil"
	--			if x == "isnil" then
	--				return false
	--			else
	--				-- Isn't Nil, return alt if provided otherwise return true --
	--				if check ~= "" then
	--					return alt or true
	--				else
	--					return false
	--				end
	--			end
end

function General.Is(check, ...)
	if check == nil then return false end

	local compare = { ... }

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

	local compare = { ... }

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

	local compare = { ... }

	if Valid(compare) then
		for i = 1, #compare do
			if (check ~= compare[i] or (tonumber(check) ~= nil and tonumber(check) ~= tonumber(compare[i]))) then
				return true
			end
		end

		return false
	else
		if Type(check, "boolean") then
			return not check
		else
			return false
		end
	end
end

function General.NotAll(check, ...)
	local compare = { ... }
	if Valid(compare) then
		for i = 1, #compare do
			if (check == compare[i] or (tonumber(check) ~= nil and tonumber(check) == tonumber(compare[i]))) then
				return false
			end
		end

		return true
	else
		if Type(check, "boolean") then
			return not check
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

function General.TimeSince(check, sign, value)
	local TimeSince = _G.TimeSince
	if check then
		if sign then
			if IsNil(value) then value = sign sign = ">" end
			if Is(sign,">") then
				if TimeSince(check) > value then return true end
			elseif Is(sign,"<") then
				if TimeSince(check) < value then return true end
			elseif Is(sign,">=") then
				if TimeSince(check) >= value then return true end
			elseif Is(sign,"<=") then
				if TimeSince(check) <= value then return true end
			elseif Is(sign,"==","=") then
				if TimeSince(check) == value then return true end
			elseif Is(sign,"~=","!=") then
				if TimeSince(check) ~= value then return true end
			end
			return false
		else
			return TimeSince(check)
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
			if #check:gsub("%s", "") == 0 then
				return 0
			else
				return #check
			end
		elseif t == "number" then
			if check ~= math.floor(check) then
				return #tostring(check):gsub("[^.]+$", "") - 1
			else
				return #tostring(check)
			end
		else
			Error("Tried to find the size of a value that's not a Table, String, or Number, but was " .. Type(check))
		end
	else
		check = check
		if Type(check, "table") then
			local count = 0
			for _ in pairs(check) do count = count + 1 end
			check = count
		elseif Type(check, "string") then -- if check is a table, then we are comparing the sizes of two tables
			check = #check
		end
		value = value
		if Type(value, "table") then
			local count = 0
			for _ in pairs(check) do count = count + 1 end
			value = count
		elseif Type(value, "string") then -- if value is a table, then we are comparing the sizes of two tables
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
	if In(str, "help", "Help", "?") then
		d([[self.API.Lua.debug.d2 Function Example: d2(]] .. "[[" .. [[Variable = ]] .. "]], [[ " .. "[self.lua][Debug.d2][Help Response] ]],variable)")
		d("Which would output something like:")
		d([[Variable = true]])
		d([[ [self.lua][self.API.Lua.debug.d2][Help Response] ]])
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
		local string = str .. var .. str2 .. var2 .. str3 .. var3 .. str4 .. var4 .. str5 .. var5
		if IsNil(D2History[string]) or TimeSince(D2History[string], 5000) then
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

	local tables = { ... }

	if Valid(tables) then
		if GUI:CollapsingHeader(ModuleName .. " Debug Info") then
			if GUI:SmallButton("MoogleTime") then MoogleTime() end
			for i = 1, #tables do
				if Type(tables[i], "table") then
					GUI:Separator()
					DrawTables(tables[i])
				end
				GUI:Separator()
			end
		end
	end
end

Debug.Tree, Debug.TreeSettings = {},{}
function Debug.DrawTree()
	--	table.print(Debug.Tree)
	if FinishedLoading and KaliMainWindow then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu

		InsertIfNil(nav.Menu, "Moogle Debug Tree")

		if nav.selected == "Moogle Debug Tree" then
			main.Contents = function()
				local lowestY,widestX
				local function Draw(tbl,x,y,depth)
					local keypos = 0
					local LowestY
					depth = depth or 0
					local posx,posy = GUI:GetWindowPos()
					x,y = x or (posx+10)-GUI:GetScrollX(), y or (posy+25)-GUI:GetScrollY()
					if depth > 0 then x = x + 10 end
					if NotNil(lowestY,widestX) then
						if y > lowestY then lowestY = y else y = lowestY end
						--						if x > widestX then widestX = x else x = widestX end
					else
						lowestY = y
						widestX = x
					end
					local preY3 = 0
					local x2, y2 = 0, 0
					for k,v in table.pairsbykeys(tbl) do
						if not In(k,"time","expanded","color","value","destroy") then
							if v.destroy == false or TimeSince(v.time,"<",5000) then
								keypos = keypos + 1
								if LowestY and keypos > 1 then
									if LowestY > y then y = LowestY end
									y = y + 10
								end
								local TextX, TextY = GUI:CalcTextSize(k)
								local Padding, Padding2 = 5, 10
								x2, y2 = Padding2 + x + TextX, Padding2 + y + TextY

								if x2 > widestX then widestX = x2 end
								if y > lowestY then lowestY = y end
								if LowestY then
									if y2 > LowestY then LowestY = y2 end
								else
									LowestY = y2
								end
								local color, colorchange, textcolor
								if Type(v.color,"table") then
									color = v.color
									color[4] = color[4] or 1
								else
									color = ColorConv(v.color) or {1,1,0.4,1}
								end
								if TimeSince(v.time,"<=",500) then
									colorchange = color
								else
									colorchange = {0.337,0.337,0.337,1}
								end

								GUI:AddRectFilled(x,y,x2,y2,GUI:ColorConvertFloat4ToU32(colorchange[1],colorchange[2],colorchange[3],colorchange[4]),10)

								local MouseX,MouseY = GUI:GetMousePos()
								if MouseX > x and MouseX < x2 and MouseY > y and MouseY < y2 then
									if GUI:IsMouseClicked(0) then v.expanded = not v.expanded end
								end

								if Gui.ColorBrightness(colorchange) > 123 then
									-- Background is considered bright --
									textcolor = {0.149,0.098,0.078,1}
								else
									-- Background is considered dark --
									textcolor = {0.85,0.90,0.92,1}
								end
								GUI:AddText(x+Padding,y+Padding,GUI:ColorConvertFloat4ToU32(textcolor[1],textcolor[2],textcolor[3],textcolor[4]),k)

								local x3,y3
								if depth > 0 then
									local line = 0
									if keypos > 1 then line = 5 else line = 10 end
									x3 = x - line
									y3 = y + ((Padding2 + TextY) / 2)
									GUI:AddLine(x3,y3,x,y3,GUI:ColorConvertFloat4ToU32(colorchange[1],colorchange[2],colorchange[3],colorchange[4]),2)
								end
								if keypos > 1 then
									local x4 = x - 5
									GUI:AddLine(x4,preY3+1,x4,y3,GUI:ColorConvertFloat4ToU32(colorchange[1],colorchange[2],colorchange[3],colorchange[4]),2)
								end
								if Type(v,"table") and v.expanded then
									local resultX, resultY, resultY2 = Draw(v,x2,y,depth+1)
									--									if (resultX-10) > x then x = resultX-10 end
									if (resultY) > y then y = resultY end
									if LowestY then
										if resultY2 > LowestY then LowestY = resultY2 end
									else
										LowestY = resultY2
									end
								end
								preY3 = y3 or 0
							end
						end
					end
					return x, y+10, y2
				end
				Draw(Debug.Tree)
			end
		end
	end
end
API.Event("Gameloop.Draw",selfs,"Draw",Debug.DrawTree)

function Debug.AddTree(Parent, Name, Destroy, Color)
	Destroy = Destroy or false
	if Name then
		if Is(Parent,"Start","Begin","Home","Create") then
			InsertIfNil(Debug.Tree,Name,{})
			InsertIfNil(Debug.Tree[Name],"expanded",true)
			if Debug.Tree[Name].color == nil then
				Debug.Tree[Name].color = Color or {1,1,0.4,1}
			end
			Debug.Tree[Name].destroy = Destroy
			Debug.Tree[Name].time = Now()
		else
			local Branch = Debug.Tree
			for key in Parent:gmatch("[^/.]+") do
				if Branch[key] then
					Branch = Branch[key]
					Branch.time = Now()
				else
					Branch[key] = {}
					Branch = Branch[key]
					Branch.destroy = Destroy
					Branch.time = Now()
					Branch.expanded = true
					Branch.color = {1,1,0.4,1}
				end
			end
			if IsNil(Branch[Name]) then
				Branch[Name] = {}
				Branch[Name].destroy = Destroy
				Branch[Name].time = Now()
				Branch[Name].expanded = true
				Branch[Name].color = Color or {1,1,0.4,1 }
			else
				Branch[Name].time = Now()
			end
		end
	else
		InsertIfNil(Debug.Tree,Parent,{})
		InsertIfNil(Debug.Tree[Parent],"expanded",true)
		if Debug.Tree[Parent].color == nil then
			Debug.Tree[Parent].color = Color or {1,1,0.4,1}
		end
		Debug.Tree[Parent].destroy = Destroy
		Debug.Tree[Parent].time = Now()
	end
end

function Debug.RemoveTree(Parent, Name)
	if Name then
		if Is(Parent,"Start","Begin","Home","Create") then
			Debug.Tree[Name] = nil
		else
			local Branch = Debug.Tree
			for key in Parent:gmatch("[^/.]+") do
				if NotNil(Branch[key]) then Branch = Branch[key] end
			end
			if NotNil(Branch[Name]) then
				Branch[Name] = nil
			end
		end
	else
		Debug.Tree[Parent] = nil
	end
end
-- End Debug Functions --

-- Input and Output (IO) Functions --
-- End Input and Output (IO) Functions --

-- Math Functions --
function Math.Sign(value)
	return (value >= 0 and 1) or -1
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
			local A = val.A * math.pow(256, 0)
			local B = val.B * math.pow(256, 1)
			local C = val.C * math.pow(256, 2)
			local D = val.D * math.pow(256, 3)
			return A + B + C + D
		end
	end
end

-- End Math Functions --

-- Operating System (OS) Functions --
function OS.PowerShell(cmd)
	local PS = io.popen([[powershell -Command "]] .. cmd .. [["]])
	PS:close()
end

function OS.CreateFolder(path)
	local folder = io.popen([[MKDIR  "]] .. path .. [["]])
	folder:close()
end

local DeleteHistory = {}
function OS.DeleteFile(path)
	if DeleteHistory[path] == nil or TimeSince(DeleteHistory[path],500) then
		if FileExists(path) then
			DeleteHistory[path] = Now()
			local file = io.popen([[del /f /q "]] .. path .. [["]])
			file:close()
			return false
		end
		return true
	else
		return false
	end
end

function OS.WriteToFile(path, str)
	local str2 = ""
	if Type(str,"table") then
		for i=1, #str do
			if i < #str then
				str2 = str2.."'"..str[i].."',"
			else
				str2 = str2.."'"..str[i].."'"
			end
		end
	elseif Type(str,"string") then
		if str:sub(-1) == "\n" then str = str:sub(-str:len()+1) end
		str2 = "'"..str:gsub("\n","','").."'"
	end
	local cmd = io.popen([[PowerShell -Command "$stream = [System.IO.StreamWriter] ']] .. path .. [['; $a = ]] .. str2 .. [[; $a | ForEach-Object{ $stream.WriteLine( $_ ) }; $stream.close()"]])
	cmd:close()
end

function OS.WipeFile(path)
	OS.WriteToFile(path,"")
end

function OS.CMDStream(tblstr, filename, cmd) -- Global Tables Only, MUST BE STRING --
	if Type(tblstr,"string") then
		local input = TempFolder..[[input\]]..filename
		local output = TempFolder..[[output\]]..filename
		if io.type(_G[tblstr]) ~= "file" then
			_G[tblstr] = io.popen([[PowerShell -Command "Get-Content ']]..input..[[' -Wait -Tail 100 | Invoke-Expression -ErrorAction SilentlyContinue | Out-File -Encoding ascii ']]..output..[['"]])
		end
		local file = io.open(input, "a+") file:write(cmd) file:close()
	else
		Error("[CMDStream]: tblstr MUST be a STRING, not the actual table.")
	end
end

OS.Queue, OS.MaxConnections, OS.CurrentConnections, OS.Pulse, OS.LastCheck, OS.Trash = {}, 2, 0, 100, 0, {}
function OS.CMD(cmd)
	AddTree("MoogleLib.Lua.OS","CMD")
	--	if TimeSince(OS.LastCheck,OS.Pulse) then
	--		OS.LastCheck = Now()
	local q, new, k = OS.Queue, true, 0
	-- First, let's find the first open slot --
	AddTree("MoogleLib.Lua.OS.CMD","Checking Node",true)
	if Valid(q) then
		for key,v in pairs(q) do
			if Type(q[key],"table") and table.size(q[key]) > 0 then
				if Is(q[key].cmd, cmd:gsub("outputfile",TempFolder .. [[output]] .. key .. [[.txt]])) then
					if TimeSince(q[key].time,"<",OS.Pulse) then return end
					k = key
					AddTree("MoogleLib.Lua.OS.CMD.Checking Node."..key,"Existing Node",true)
					debug(cmd,3)
					debug("CMD: Found a matching cmd string, setting key to "..tostring(key),2)
					new = false
				end
			end
		end
		if new and OS.CurrentConnections < OS.MaxConnections then
			while true do
				k = k + 1
				if DeleteHistory and ((DeleteHistory[TempFolder .. [[output]] .. k .. [[.txt]]] == nil) or TimeSince(DeleteHistory[TempFolder .. [[output]] .. k .. [[.txt]]],500)) then
					if Type(q[k],"table") and table.size(q[k]) > 0 then
						if TimeSince(q[k].time,1000) then
							AddTree("MoogleLib.Lua.OS.CMD.Checking Node."..k,"New Node",true)
							debug(cmd,3)
							debug("CMD: Time has expired on this entry, clearing entry and setting k to "..tostring(k),2)
							if q[k].CMD then q[k].CMD:close() end
							q[k] = {}
							break
						end
					else
						AddTree("MoogleLib.Lua.OS.CMD.Checking Node."..k,"New Node",true)
						debug(cmd,3)
						debug("CMD: Not Valid/Empty table entry, setting k to "..tostring(k),2)
						q[k] = {}
						break
					end
				end
			end
		end
	else
		k = 1
		AddTree("MoogleLib.Lua.OS.CMD.Checking Node."..k,"New Node",true)
		debug(cmd,3)
		debug("CMD: Queue Table empty, starting new table and setting k to "..tostring(k))
	end

	local outputfile = TempFolder .. [[output]] .. k .. [[.txt]]
	cmd = cmd:gsub("outputfile",outputfile)
	--d(cmd)
	if new then
		if OS.CurrentConnections < OS.MaxConnections then
			if DeleteFile(outputfile) then
				AddTree("MoogleLib.Lua.OS.CMD.Checking Node."..k..".New Node","Sent CMD",true)
				debug("CMD: New Entry, creating table and setting variables, while executing the command.")
				q[k] = {}
				q[k].cmd = cmd
				q[k].timestart = Now()
				q[k].time = Now()
				q[k].CMD = io.popen(cmd)
				OS.CurrentConnections = OS.CurrentConnections + 1
			end
		end
	else
		q[k].time = Now()
		q[k].type = io.type(q[k].CMD)
		if q[k].type == "file" then
			if FileExists(outputfile) then
				AddTree("MoogleLib.Lua.OS.CMD.Checking Node."..k..".Existing Node","Output Exists",true)
				debug("CMD: Our CMD process is a file.",2)
				local str, file = nil, io.open(outputfile)
				if file then
					str = file:read("*a") file:close()
				end
				if Type(str,"string") and #str > 3 then
					AddTree("MoogleLib.Lua.OS.CMD.Checking Node."..k..".Existing Node.Output Exists","Valid Result",true)
					debug("CMD: We have a result and are sending it back, while also cleaning up our open files and table entry.",2)
					debug("CMD: First 100 characters of the string: "..str:sub(1,100),3)
					q[k].CMD:close()
					q[k] = nil
					DeleteFile(outputfile)
					OS.CurrentConnections = OS.CurrentConnections - 1
					--					RemoveTree("OS.CMD.Checking Node.",tostring(k))
					return str
				end
			else
				debug("CMD: Our output file doesn't exist. outputfile = "..outputfile,3)
			end
		else
			debug("CMD: Our Start Time is.."..tostring(q[k].timestart),3)
			debug("CMD: Our CMD process is not a file yet...",2)
			if TimeSince(q[k].timestart,10000) then q[k] = nil end
		end
	end
	--	end
end

function OS.DownloadString(url)
	AddTree("MoogleLib.Lua.OS","Download String")
	local result = OS.CMD([[PowerShell -Command "(New-Object System.Net.WebClient).DownloadString(']] .. url .. [[') | Set-Content -Path 'outputfile'"]])
	if result then
		AddTree("MoogleLib.Lua.OS.Download String","Valid Result",true)
		return result
	end
end

local tbl = {}
function OS.DownloadFile(url, path, overwrite)
	AddTree("MoogleLib.Lua.OS","Download File")
	local result
	Error(url)
	if overwrite then
		--		result = OS.CMD([[PowerShell -Command "Invoke-WebRequest ']]..url..[[' -OutFile ']]..path..[['; Set-Content -Path 'outputfile' -Value 'MoogleDownload Complete'"]])

		result = OS.CMD([[PowerShell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile(']] .. url .. [[',']] .. path .. [['); Set-Content -Path 'outputfile' -Value 'MoogleDownload Complete'"]])
	else
		--		result = OS.CMD([[PowerShell -Command "if(![System.IO.File]::Exists(']]..path..[[')){Invoke-WebRequest ']]..url..[[' -OutFile ']]..path..[['; Set-Content -Path 'outputfile' -Value 'MoogleDownload Complete'} Else{Set-Content -Path 'outputfile' -Value 'MoogleDownload Skipped'}"]])
		result = OS.CMD([[PowerShell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; if(![System.IO.File]::Exists(']]..path..[[')){(New-Object System.Net.WebClient).DownloadFile(']] .. url .. [[',']]..path..[['); Set-Content -Path 'outputfile' -Value 'MoogleDownload Complete'} Else{Set-Content -Path 'outputfile' -Value 'MoogleDownload Skipped'}"]])
	end
	if result then
		AddTree("MoogleLib.Lua.OS.Download File","Valid Result",true)
		return true
	end
	return false
end

local TogglePing, result = false, nil
function OS.Ping(count, ...)

	local ctype = io.type(CMD)
	if ctype == "file" or result then
		if result then
			local tbl = loadstring(result)()
			if type(tbl) == "table" then
				table.print(tbl)
			else
				d("tbl is not table, but is " .. type(tbl))
			end

			result = nil

			TogglePing = false
		else
			result = OS.CMD(nil, nil, lastCopy)
		end
	else
		local t = {}
		if Type(count, "number") then
			count = count
		else
			t[#t + 1] = count
			count = 1
		end

		local IP = { ... }

		if Valid(IP) then
			for i = 1, #IP do
				t[#t + 1] = IP[i]
			end
		end

		local IPstr = ""
		for i = 1, #t do
			if i == 1 then
				IPstr = [[']] .. t[i] .. [[']]
			else
				IPstr = IPstr .. [[,']] .. t[i] .. [[']]
			end
		end

		OS.CMD([[$lines = 'local tbl = {} '; $CompName = ]] .. IPstr .. [[; foreach ($comp in $CompName) { $result = (Test-Connection -ComputerName $comp -Count ]] .. count .. [[ | measure -property ResponseTime -Average).average; $lines += 'tbl[\"' + $comp + '\"] = ' + $result + '; ' } $lines += ' return tbl '; $lines]], true)

		TogglePing = true
	end
end

-- End Operating System (OS) Functions --

-- String Functions --
function String.Split(str, length)
	length = length or 150
	local tbl = {}
	for i = 1, #str, length do
		tbl[#tbl + 1] = str:sub(i, i + length - 1)
	end
	return tbl
end

function String.starts(str, Start)
	return string.sub(str, 1, string.len(Start)) == Start
end

function String.ends(str, End)
	return End == '' or string.sub(str, -string.len(End)) == End
end

function String.ToTable(str)
	local t = {}
	for w in str:gmatch("[%P/_/:]+") do
		t[#t + 1] = w
	end
	return t
end

function String.ProperCase(str)
	if Type(str,"string") then
		local tbl = {}
		for word in str:gmatch(" ") do
			tbl[#tbl+1] = word
		end
		local newstr = ""
		for i=1, #tbl do
			local word = tbl[i]
			if Is(i,1,#tbl) or #word:gsub("%W","") > 4 then
				word = word:gsub("^%l", string.upper)
			end
			newstr = newstr..word
		end
		return newstr
	else
		return str
	end
end
String.Proper, String.Case, String.Title, String.TitleCase = String.ProperCase, String.ProperCase, String.ProperCase, String.ProperCase

function String.IsURL(str)
	local tbl = {"http","https","www" }
	for i=1, #tbl do
		if str:match(tbl[i]) then return true end
	end
	return false
end
-- End String Functions --

-- Table Functions --
function Table.Valid(tbl, ...) -- Short version of table.valid, expanded to check multiple tables at once

	local tbls = { ... }

	if table.valid(tbl) then
		if table.valid(tbls) then
			local IsItValid
			for i = 1, #tbls do
				if Not(IsItValid, false) then
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

function Table.NotValid(tbl, ...)

	local tbls = { ... }

	if table.valid(tbl) then
		return false
	else
		if table.valid(tbls) then
			local IsItNotValid
			for i = 1, #tbls do
				if Not(IsItNotValid, false) then
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

--
--		function Table.pairs(t, ...)
--			local i, a, k, v = 1, {...}
--			return function()
--				repeat
--					k, v = next(t, k)
--					if k == nil then
--						i, t = i + 1, a[i]
--					end
--				until k ~= nil or not t
--				return k, v
--			end
--		end

function Table.InsertIfNil(tbl, key, value, update)

	if Type(tbl, "table") then
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

function Table.RemoveIfNil(tbl, CrossCheck)

	if table.valid(tbl) then
		for k, v in pairs(tbl) do
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

function Table.RemoveExpired(table1, table2)
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

function Table.Unpack(method, ...)

	if NotAll(method, "print", "d", "return") then
		Table.Unpack("return", ...)
	end
	local arg = { ... }
	for i = 1, #arg do
		if Is(method, "print", "d") then
			if type(arg[i]) == "table" then
				for k, v in table.pairsbykeys(arg[i]) do
					if type(v) ~= "table" then
						d(tostring(v))
					else
						Table.Unpack("print", v)
					end
				end
			else
				d(arg[i])
			end
		elseif method == "return" then
			if type(arg[i]) == "table" then
				for k, v in table.pairsbykeys(arg[i]) do
					if type(v) ~= "table" then
						return v
					else
						Table.Unpack("return", v)
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
function Table.Print(tbl, name, search, filelocation, depth, history)
	local max = 50
	if IsNil(name) then
		if Type(tbl, "string") then
			local t = {};
			for w in tbl:gmatch("[%P/_/:]+") do
				t[#t + 1] = w
			end
			name = ""
			tbl = _G
			for k, v in pairs(t) do
				tbl = tbl[v]
				if t[k - 1] then name = name .. " [" end
				name = name .. v
				if t[k + 1] then name = name .. "]" end
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
			filelocation = MooglePath .. [[output.lua]]
		end
	end

	if PrintRunning == false then
		if NotAll(name, "", " ", nil) then
			d(string.rep(" ", 500))
			local str = ""
			if NotNil(name) then
				str = str .. "Searching Table: [" .. name .. "]"
			end
			if NotNil(search) then
				str = str .. ", and searching for the string: [" .. search .. "]"
			end
			d(str)
			d(string.rep(" ", 500))
		end
		PrintLastTbl = tbl
		PrintLastName = name
		PrintLastSearch = search
		PrintLastDepth = depth
		PrintLastHistory = history
		Printfilelocation = filelocation
		PrintRunning = true
	end

	for k, v in table.pairsbykeys(tbl) do
		local function d3(string)
			local allowed = true
			if search then
				allowed = false
				if NotAll(nil, k, v, search) then
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
		lasthistory = "[" .. name .. "]" .. history .. " " .. tostring(k)
		if Is(k, "_G", "__index", "BannedKeys", "parent") then
			d3(string.rep("   ", depth) .. "[" .. name .. "]" .. history .. " " .. tostring(k) .. " is blocked table and will be skipped over.")
		else
			if type(v) == "table" then
				if depth < max then
					d3(string.rep("   ", depth) .. "[" .. name .. "]" .. history .. " " .. tostring(k) .. " = \{")
					Table.Print(v, name, search, filelocation, depth + 1, history .. " [" .. k .. "]")
					d3(string.rep("   ", depth) .. "[" .. name .. "]" .. history .. " \}")
				else
					d3(string.rep("   ", depth) .. "[" .. name .. "]" .. history .. " " .. tostring(k) .. " has reached its limit at a depth of " .. max .. " and will not continue to print deeper.")
				end
			else
				local str
				if Type(v, "nil") then
					str = "nil"
				elseif Type(v, "string") then
					str = "'" .. v .. "'"
				elseif Type(v, "boolean") then
					str = tostring(v):upper()
				elseif Type(v, "function") then
					if Table.BannedKeys[lasthistory] then
						InsertIfNil(TempFunctionStrings, tostring(v), true)
						if lasthistory == lastlasthistory then
							ResumePrinting = true
						end
						str = tostring(v) .. " (unable to dump function)"
					else
						local FunctionString = tostring(v)
						if TempFunctionStrings[FunctionString] then
							str = FunctionString .. " (unable to dump function)"
							Table.BannedKeys[lasthistory] = true
						else
							str = FunctionString .. " : " .. string.dump(v):gsub("[^ !#-~]", "."):gsub("(\n|\r)", ""):gsub("[@|%%|%`|%$|%'|%?]", ""):gsub("[.][,|!|@|#|$|^|&|*|(|)|_|=|>|<|%:|%;|~|`|\"|/|[| |a-z|A-Z|0-9|%]|%-|%+|%\|%/|?|%>|%<|%{|%}][.]", ""):gsub("[.][A-Z]+[.]", ""):gsub("[.][.]*[.]", "..."):gsub("\.LuaQ\.\.\.", "")
						end
					end
				else
					str = tostring(v)
				end

				if PrintToFile or str:len() < 150 then
					d3(string.rep("   ", depth) .. "[" .. name .. "]" .. history .. " " .. tostring(k) .. " = " .. str)
				else
					str = string.rep("   ", depth) .. "[" .. name .. "]" .. history .. " " .. tostring(k) .. " = " .. str
					local tbl = String.Split(str)
					if Valid(tbl) then
						local startlength = string.len(string.rep("   ", depth) .. "[" .. name .. "]" .. history .. " " .. tostring(k) .. " = ")
						for i, e in pairs(tbl) do
							if i == 1 then
								d3(e)
							else
								d3(string.rep(" ", startlength) .. e)
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
			local file = io.open(filelocation, "w")
			for k, v in table.pairsbykeys(PrintToFileTable) do
				file:write(v .. "\r\n")
			end
			file:close()

			PrintToFile = false
			table.clear(PrintToFileTable)
		end
	end
end

_G.MoogleSearch = Table.Print
_G.MooglePrint = Table.Print
-- End Table Functions --

-- Gui Functions --
function Gui.WindowStyle(tbl)
	if NotNil(tbl) then
		local counter, ColorConv = 0, Gui.ColorConv
		if tbl["Text"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["Text"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_Text, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["TextDisabled"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["TextDisabled"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_TextDisabled, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["WindowBG"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["WindowBG"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_WindowBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ChildWindowBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ChildWindowBg"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ChildWindowBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["Border"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["Border"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_Border, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["BorderShadow"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["BorderShadow"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_BorderShadow, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["FrameBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["FrameBg"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_FrameBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["FrameBgHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["FrameBgHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_FrameBgHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["FrameBgActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["FrameBgActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_FrameBgActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["TitleBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["TitleBg"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_TitleBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["TitleBgCollapsed"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["TitleBgCollapsed"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_TitleBgCollapsed, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["TitleBgActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["TitleBgActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_TitleBgActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["MenuBarBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["MenuBarBg"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_MenuBarBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ScrollbarBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ScrollbarBg"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ScrollbarBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ScrollbarGrab"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ScrollbarGrab"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ScrollbarGrab, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ScrollbarGrabHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ScrollbarGrabHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ScrollbarGrabHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ScrollbarGrabActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ScrollbarGrabActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ScrollbarGrabActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ComboBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ComboBg"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ComboBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["CheckMark"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["CheckMark"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_CheckMark, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["SliderGrab"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["SliderGrab"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_SliderGrab, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["SliderGrabActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["SliderGrabActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_SliderGrabActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["Button"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["Button"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_Button, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ButtonHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ButtonHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ButtonHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ButtonActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ButtonActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ButtonActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["Header"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["Header"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_Header, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["HeaderHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["HeaderHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_HeaderHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["HeaderActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["HeaderActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_HeaderActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["Column"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["Column"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_Column, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ColumnHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ColumnHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ColumnHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ColumnActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ColumnActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ColumnActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ResizeGrip"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ResizeGrip"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ResizeGrip, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ResizeGripHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ResizeGripHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ResizeGripHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ResizeGripActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ResizeGripActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ResizeGripActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["CloseButton"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["CloseButton"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_CloseButton, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["CloseButtonHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["CloseButtonHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_CloseButtonHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["CloseButtonActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["CloseButtonActive"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_CloseButtonActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["PlotLines"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["PlotLines"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_PlotLines, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["PlotLinesHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["PlotLinesHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_PlotLinesHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["PlotHistogram"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["PlotHistogram"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_PlotHistogram, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["PlotHistogramHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["PlotHistogramHovered"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_PlotHistogramHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["TextSelectedBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["TextSelectedBg"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_TextSelectedBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["TooltipBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["TooltipBg"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_TooltipBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if tbl["ModalWindowDarkening"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(tbl["ModalWindowDarkening"], "sRBG", "Linear")
			GUI:PushStyleColor(GUI.Col_ModalWindowDarkening, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		return counter
	end
end

function Gui.WindowStyleClose(count)
	GUI:PopStyleColor(count)
end

function Gui.ColorConv(tbl, from, to)
	if type(tbl) == "table" then
		if tbl[4] == nil then tbl[4] = 1 end
		if In(from, "sRBG", "RBG", "rbg") then
			if In(to, "Linear", "linear", "LinearRBG") then
				local tbl2 = {
					[1] = tbl[1] / 255,
					[2] = tbl[2] / 255,
					[3] = tbl[3] / 255,
					[4] = tbl[4]
				}
				return tbl2
			elseif to == "HSV" then
			elseif to == "HSL" then
			elseif to == "U32" then
			elseif to == "Hex" or "HEX" then
			end
		end
	elseif type(tbl) == "string" then
		local colors = {}
		if colors[tbl] then
			return colors[tbl]
		elseif #tbl == 6 or #tbl == 3 then
			local tbl = Split(tbl,#tbl/3)
			for i=1, #tbl do
				tbl[i] = tonumber(tbl[i],16)
			end
			tbl[4] = 1
			return tbl
		end
	end
end

function Gui.ColorBrightness(tbl)
	return (((tbl[1]*255)*299) + ((tbl[2]*255)*587) + ((tbl[3]*255)*114)) / 1000
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

	if Type(spacing, "number") then
		GUI:PushStyleVar(GUI.StyleVar_IndentSpacing, spacing)
		GUI:Indent()
	else
		GUI:Indent()
	end
end

function Gui.Unindent(spacing)

	if Type(spacing, "number") then
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

	local t = type(RGB)
	if t ~= "table" then
		if t == "boolean" then
			beforetext = RGB
			SameLineSpacing = nil
			RGB = nil
		else
			beforetext = SameLineSpacing
			SameLineSpacing = RGB
			RGB = nil
		end
	else
		ColorText = true
	end

	if NotNil(SameLineSpacing) then
		if beforetext then
			if ColorText then
				SameLine(SameLineSpacing)
				GUI:AlignFirstTextHeightToWidgets()
				GUI:PushStyleColor(GUI.Col_Text, RGB[1], RGB[2], RGB[3], RGB[4])
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
				GUI:PushStyleColor(GUI.Col_Text, RGB[1], RGB[2], RGB[3], RGB[4])
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
		if beforetext then
			SameLineSpacing = SameLineSpacing or 4
			SameLine(SameLineSpacing)
		end
		if ColorText then
			GUI:AlignFirstTextHeightToWidgets()
			GUI:PushStyleColor(GUI.Col_Text, RGB[1], RGB[2], RGB[3], RGB[4])
			GUI:Text(string)
			GUI:PopStyleColor()
		else
			GUI:AlignFirstTextHeightToWidgets()
			GUI:Text(string)
		end
		if beforetext==nil and SameLineSpacing then SameLine(SameLineSpacing) end
	end
end

function Gui.Checkbox(string, varname, varstring, reverse, tooltip)
	local tbl
	local key = _G
	local value
	if Type(varname, "string") then
		tbl = StrToTable(varname)
		for i = 1, table.size(tbl) do
			if Not(i, table.size(tbl)) then
				key = key[tbl[i]]
			else
				value = tbl[i]
			end
		end
	end
	if reverse then
		local c = Text(string)
		if tooltip ~= nil and GUI:IsItemHovered(c) then
			Tooltip(tooltip, 400)
		end
		Space()
		if tbl then
			key[value] = GUI:Checkbox("##" .. varstring, key[value])
		else
			varname = GUI:Checkbox("##" .. varstring, varname)
		end
		if tooltip ~= nil and GUI:IsItemHovered(c) then
			Tooltip(tooltip, 400)
		end
	else
		if tbl then
			key[value] = GUI:Checkbox("##" .. varstring, key[value])
		else
			varname = GUI:Checkbox("##" .. varstring, varname)
		end
		if tooltip ~= nil and GUI:IsItemHovered(c) then
			Tooltip(tooltip, 400)
		end
		Space()
		local c = Text(string)
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

function Gui.Image(path,x,y,more)
	if not path:match([[\]]) then
		path = ImageFolder..path
		if not path:match("%.") then
			path = path..[[.png]]
		end
	end
	if FileExists(path) then
		local c = GUI:Image(path, x, y)
		local tooltip = more.tooltip

		if tooltip then
			if GUI:IsItemHovered(c) then
				Tooltip(tooltip)
			end
		end
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
		for k, v in table.pairsbykeys(MoogleHotkeys) do
			Gui.OrderedKeys[#Gui.OrderedKeys + 1] = v
			Gui.IndexToDecimal[#Gui.IndexToDecimal + 1] = k
		end
	end
	for i = 1, (#tbl + 1) do
		GUI:PushItemWidth(125)
		local index = tbl[i] or 1
		local changed
		index, changed = GUI:Combo("##Key" .. tostring(i), index, Gui.OrderedKeys, 10)
		if changed then
			tbl[i] = index
			MoogleSave("tbl")
		end
		GUI:PopItemWidth()
		if i ~= (#tbl + 1) then
			GUI:SameLine(0, 5)
		end
	end
	local changed = false
	if table.valid(tbl) then
		for k, v in table.pairsbykeys(tbl) do
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
		for k, v in table.pairsbykeys(tbl) do
			local c
			local depthtemp = 0
			if depth > 1 then depthtemp = 1 else depthtemp = depth end
			Indent(25 * depthtemp)
			if Type(v, "table") then
				if table.valid(v) then
					if GUI:TreeNode(tostring(k)) then
						Gui.DrawTables(v, depth + 1)
						GUI:TreePop()
					end
				else
					if tonumber(k) ~= nil then
						Text("[" .. tostring(k) .. "] (", 4)
					else
						Text(tostring(k) .. " (", 4)
					end
					Text(type(v), { "0.169", "0.286", "1", "1" }, 4) Text(") = ", 4) Text("Empty Table", { "0.169", "0.286", "1", "1" }, 4, true)
				end
			else
				if tonumber(k) ~= nil then
					Text("[" .. tostring(k) .. "] (", 4)
				else
					Text(tostring(k) .. " (", 4)
				end
				if Type(v, "nil") then
					Text(type(v), { "0", "0.933", "0", "1" }, 4) Text(") = ", 4) Text("nil", { "0", "0.933", "0", "1" }, 4, true)
				elseif Type(v, "string") then
					Text(type(v), { "0", "0.6", "0.341", "1" }, 4) Text(") = ", 4) Text("\"" .. v .. "\"", { "0", "0.6", "0.341", "1" }, 4, true)
				elseif Type(v, "number") then
					Text(type(v), { "0", "0.769", "0.11", "1" }, 4) Text(") = ", 4) Text(tostring(v), { "0", "0.769", "0.11", "1" }, 4, true)
				elseif Type(v, "boolean") then
					Text(type(v), { "0.933", "0.4", "0", "1" }, 4) Text(") = ", 4) Text(string.upper(tostring(v)), { "0.933", "0.4", "0", "1" }, 4, true)
				elseif Type(v, "function") then
					local key = tostring(tbl) .. tostring(depth) .. tostring(k) .. tostring(v)
					c = Text(type(v), { "0.322", "0.718", "0.953", "1" }, 4) c = Text(") = ", 4) c = Text(tostring(v), { "0.322", "0.718", "0.953", "1" }, 4, true)
					if GUI:IsItemClicked(c) or FunctionsRevealed[key] then
						Text("Result: " .. tostring(v()), { "1", "1", "0", "1" }, 4, true)
						if FunctionsRevealed[key] then
							FunctionsRevealed[key] = not FunctionsRevealed[key]
						else
							FunctionsRevealed[key] = true
						end
					end
				elseif Type(v, "userdata") then
					Text(type(v), { "0.463", "0.463", "0.463", "1" }, 4) Text(") = ", 4) Text(tostring(v), { "0.463", "0.463", "0.463", "1" }, 4, true)
				else
					Text(type(v), { "0.169", "0.286", "1", "1" }, 4) Text(") = ", 4) Text(tostring(v), { "0.169", "0.286", "1", "1" }, 4, true)
				end
			end
			local depthtemp = 0
			if depth > 1 then depthtemp = 1 else depthtemp = depth end
			Unindent(25 * depthtemp)
		end
	end
end


-- End GUI Functions --
-- End Core Functions & Helper Functions --

-- self.API.ToggleGUI = false
-- function self.Draw()
-- 	if GUI:IsKeyDown(17) then -- CTRL
-- 		if GUI:IsKeyReleased(192) then -- `
-- 			self.API.ToggleGUI = not self.API.ToggleGUI
-- 		end
-- 	end

-- 	if self.API.ToggleGUI then
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
local function MarkerLogic(MarkerType, filters, AddPlayer, buffids, time, ownerid, MissingBuffs) -- MissingBuffs is boolean (true/false), if false then HasBuffs
	if TimeSince(lastcheck, 100) then
		lastcheck = Now()
		local el = EntityList(filters .. [[,maxdistance=55]])
		if AddPlayer then
			table.insert(el, Player)
		end
		if table.valid(el) then
			for id, entity in pairs(el) do
				local pass = false
				if buffids then
					if MissingBuffs then
						if MissingBuffs(entity, buffids, time, ownerid) then
							pass = true
						end
					else
						if HasBuffs(entity, buffids, time, ownerid) then
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
							for i, m in ipairs(MarkerTable[MarkerType]) do
								if NeedMarker and m == "empty" then
									MarkerTable[MarkerType][i] = entity.id
									EntitiesNeedMarked[entity.id] = MarkerType .. tostring(i)
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
							if MissingBuffs(entity, EntitiesHistory[entity.id]["buffids"], EntitiesHistory[entity.id]["time"], EntitiesHistory[entity.id]["ownerid"]) then
								pass = true
							end
						else
							if HasBuffs(entity, EntitiesHistory[entity.id]["buffids"], EntitiesHistory[entity.id]["time"], EntitiesHistory[entity.id]["ownerid"]) then
								pass = true
							end
						end
						if not pass then
							if type(MarkerTable[EntitiesHistory[entity.id]["MarkerType"]]) == "table" then
								for k, v in pairs(MarkerTable[EntitiesHistory[entity.id]["MarkerType"]]) do
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
			for k, v in pairs(MarkerTable) do
				if type(v) == "table" then
					for i, e in pairs(v) do
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
			for k, v in pairs(EntitiesNeedMarked) do
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
								elseif MarkerDelayLast == k and TimeSince(MarkerLastMark, (MarkerDelay * 1000)) then
									SendTextCommand([[/marking ]] .. v .. [[ <t>]])
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
							for id, entity in pairs(el) do
								Player:SetTarget(entity.id)
							end
						end
					end
				end
				PreviousTarget = 0
			end
		end
		if table.valid(EntitiesNeedRemoved) and not table.valid(EntitiesNeedMarked) then
			for k, v in pairs(EntitiesNeedRemoved) do
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
							elseif MarkerDelayLast == k and TimeSince(MarkerLastMark, (MarkerDelay * 1000)) then
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
			d("filters: " .. tostring(filters))
			d("MarkerTable:")
			table.print(MarkerTable)
			d("EntitiesNeedMarked:")
			table.print(EntitiesNeedMarked)
			d("EntitiesMarked:")
			table.print(EntitiesMarked)
			d("PreviousTarget: " .. tostring(PreviousTarget))
		end
	end
end


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--function self.Draw()
--end
local corefiles, loadcore = {
	["Main Window"] = false,
	["Moogle Updater"] = false,
}, true
local function LoadMoogleCore()
	if loadcore then
		local pass = true
		for k,v in pairs(corefiles) do
			if corefiles[k] == false then
				pass = false
				local file = MooglePath..k..".lua"
				if fileexist(file) then
--					d("MoogleLib: Loading "..k)
					LoadModule(file)
					corefiles[k] = true
				else
					Error("Missing Core File: "..k)
				end
			end
		end
		if pass then
			loadcore = false
		end
	end
end

local folders, create, timesince = {
	["Moogle Images"] = false,
	["Moogle Scripts"] = false,
	["Temp"] = false,
	["Temp\\input"] = false,
	["Temp\\output"] = false
}, true, 0
local function CreateFolders()
	if create then
		local finished = true
		for k,v in pairs(folders) do
			if not v then
				if not FolderExists(MooglePath..k) then
					FolderCreate(MooglePath..k)
					folders[k] = true
					finished = false
				end
			end
		end
		if finished then
			create = false
			timesince = Now()
		end
	else
		if TimeSince(timesince, 300000) then
			create = true
			timesince = Now()
		end
	end
end

local CheckVer, loaded, lastcheck = true, false, 0
function self.OnUpdate()
	if FinishedLoading then
		if loaded then
			if CheckVer then
				--				local update, tbl = API.VersionCheck(selfs)
				--				if update == true then
				--	--                FileWrite(MooglePath..[[MoogleLib.lua]],tbl)
				--	--                loadstring(tbl)()
				--					CheckVer = false
				--				elseif update == false then
				--					CheckVer = false
				--				end
			end
			LoadMoogleCore() CreateFolders()
			MoogleSave({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.MainMenuType]]] = selfs .. [[.Settings.MainMenuType]],
			})
		else
			MoogleLoad({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.MainMenuType]]] = selfs .. [[.Settings.MainMenuType]],
			})
			loaded = true
		end
		local q = OS.Queue
		if Valid(q) then
			if OS.Trash["ClearTrash"] then OS.Trash["ClearTrash"] = nil end
			if TimeSince(lastcheck,1000) then
				lastcheck = Now()
				for k,v in pairs(q) do
					if Type(v,"table") then
						if v.time then
							if TimeSince(v.time,5000) then
								if OS.Queue[k].CMD then OS.Queue[k].CMD:close() end
								if OS.Queue[k].file then OS.Queue[k].file:close() end
								OS.Queue[k] = nil
								--								RemoveTree("MoogleLib.Lua.OS.CMD.Checking Node.",tostring(k))
							end
						else
							if v.cmd then
								if OS.Trash[v.cmd] then
									if TimeSince(OS.Trash[v.cmd],5000) then
										--										RemoveTree("MoogleLib.Lua.OS.CMD.Checking Node.",tostring(k))
										if OS.Queue[k].CMD then OS.Queue[k].CMD:close() end
										if OS.Queue[k].file then OS.Queue[k].file:close() end
										OS.Queue[k] = nil
									end
								else
									OS.Trash[v.cmd] = Now()
								end
							else
								if OS.Trash[k] then
									if TimeSince(OS.Trash[k],5000) then
										--										RemoveTree("MoogleLib.Lua.OS.CMD.Checking Node.",tostring(k))
										OS.Queue[k] = nil
									end
								else
									OS.Trash[k] = Now()
								end
							end
						end
					end
				end
			end
		else
			if OS.Trash["ClearTrash"] then
				if TimeSince(OS.Trash["ClearTrash"],3000) then
					--					RemoveTree("MoogleLib.Lua.OS.CMD","Checking Node")
					OS.Trash = {}
				end
			else
				OS.Trash["ClearTrash"] = Now()
			end
		end
	else
		UpdateLocals()
		if FinishedLoading then
			Initialize(self.GUI)
		end
	end
end

API.Event("Gameloop.Initalize",selfs,"Initialize",self.Init)
API.Event("Gameloop.Update",selfs,"Update",self.OnUpdate)
API.Event("Gameloop.Draw",selfs,"Draw",self.Draw)
API.Event("Gameloop.Update",selfs,"InitializeInput",API.Input)
