MoogleMultiSessionManager = {}

MoogleMultiSessionManager.Info = {
	Creator = "Kali",
	Version = "0.0.9",
	StartDate = "02/28/2018",
	ChangeLog = {
	}
}

MoogleMultiSessionManager.GUI = {
	WindowName = "MoogleMultiSessionManager##MoogleMultiSessionManager",
	name = "Moogle MultiSession Manager",
	NavName = "Moogle MultiSession Manager",
	MiniName = " MultiSession",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = MoogleMultiSessionManager.GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "A module to monitor what other bot instances on your computer are doing, send commands to specific instances or all at the same time."
}

MoogleMultiSessionManager.Settings = {
	enable = true,
	POSUpdateInterval = 1000,
	ManageList = {}
}
local self = "MoogleMultiSessionManager"

MoogleMultiSessionManager.Data = {
	LastWrite = 0,
	LogTable = {}
}

local API, Lua, General, Debug, IO, Math, OS, String, Table, Gui, MinionPath, LuaPath, MooglePath, ImageFolder, ScriptsFolder, ACRFolder, SenseProfiles, SenseTriggers, Initialize, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, RecordKeybinds, Error, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, Size, Empty, NotEmpty, d2, DrawDebugInfo, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, MoogleCMDQueue, MoogleDownloadBuffer, CMDTable, CMD, DownloadString, DownloadTable, DownloadFile, VersionCheck, Ping, Split, starts, ends, StrToTable, Valid, NotValid, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables

local function UpdateLocals1()
	API = MoogleLib.API Lua = MoogleLib.Lua General = Lua.general Debug = Lua.debug IO = Lua.io Math = Lua.math OS = Lua.os String = Lua.string Table = Lua.table Gui = MoogleLib.Gui MinionPath = API.MinionPath LuaPath = API.LuaPath MooglePath = API.MooglePath ImageFolder = API.ImageFolder ScriptsFolder = API.ScriptsFolder ACRFolder = API.ACRFolder SenseProfiles = API.SenseProfiles SenseTriggers = API.SenseTriggers Initialize = API.Initialize Vars = API.Vars Distance2D = API.Distance2D Distance3D = API.Distance3D CurrentTarget = API.CurrentTarget MovePlayer = API.MovePlayer SetTarget = API.SetTarget ConvertCID = API.ConvertCID Entities = API.Entities Entities2 = API.Entities2 EntitiesUpdateInterval = API.EntitiesUpdateInterval EntitiesLastUpdate = API.EntitiesLastUpdate UpdateEntities = API.UpdateEntities CMDKeyPress = API.CMDKeyPress SendKey = API.SendKey RecordKeybinds = API.RecordKeybinds Error = General.Error IsNil = General.IsNil NotNil = General.NotNil Is = General.Is IsAll = General.IsAll Not = General.Not NotAll = General.NotAll Type = General.Type NotType = General.NotType Size = General.Size Empty = General.Empty NotEmpty = General.NotEmpty d2 = Debug.d2 DrawDebugInfo = Debug.DrawDebugInfo Sign = Math.Sign Round = Math.Round Convert4Bytes = Math.Convert4Bytes PowerShell = OS.PowerShell CreateFolder = OS.CreateFolder DeleteFile = OS.DeleteFile MoogleCMDQueue = OS.MoogleCMDQueue MoogleDownloadBuffer = OS.MoogleDownloadBuffer CMDTable = OS.CMDTable CMD = OS.CMD DownloadString = OS.DownloadString DownloadTable = OS.DownloadTable
end

local function UpdateLocals2()
	DownloadFile = OS.DownloadFile VersionCheck = OS.VersionCheck Ping = OS.Ping Split = String.Split starts = String.starts ends = String.ends StrToTable = String.ToTable Valid = Table.Valid NotValid = Table.NotValid InsertIfNil = Table.InsertIfNil RemoveIfNil = Table.RemoveIfNil UpdateIfChanged = Table.UpdateIfChanged RemoveExpired = Table.RemoveExpired Unpack = Table.Unpack Print = Table.Print WindowStyle = Gui.WindowStyle WindowStyleClose = Gui.WindowStyleClose ColorConv = Gui.ColorConv SameLine = Gui.SameLine Indent = Gui.Indent Unindent = Gui.Unindent Space = Gui.Space Text = Gui.Text Checkbox = Gui.Checkbox Tooltip = Gui.Tooltip GetRemaining = Gui.GetRemaining VirtualKeys = Gui.VirtualKeys OrderedKeys = Gui.OrderedKeys IndexToDecimal = Gui.IndexToDecimal HotKey = Gui.HotKey DrawTables = Gui.DrawTables
end

local MMMFolder,UUID
function MoogleMultiSessionManager.ModuleInit()
	if MoogleLib ~= nil then
		UpdateLocals1() UpdateLocals2()
		Initialize(MoogleMultiSessionManager.GUI)

		MoogleLoad({})
		if not FileExists(ImageFolder..MoogleMultiSessionManager.GUI.name..".png") then
			--            DownloadFile([[https://i.imgur.com/cdbXSLt.png]],ImageFolder..MoogleMultiSessionManager.GUI.name..".png")
		end
	end
end

local function Update()
	persistence.store(MMMFolder.."LogTable.lua",MoogleMultiSessionManager.Data.LogTable)
end

local function Load()
	local tbl,e = persistence.load(MMMFolder.."LogTable.lua")
	if table.valid(tbl) then
		if table.deepcompare(MoogleMultiSessionManager.Data.LogTable,tbl) == false then
			MoogleMultiSessionManager.Data.LogTable = deepcopy(tbl)
		end
	end
end

function MoogleMultiSessionManager.Draw()
	if MoogleLib ~= nil then
		Load()
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleMultiSessionManager.Settings
		local data = MoogleMultiSessionManager.Data

		if UUID and nav.selected == MoogleMultiSessionManager.GUI.NavName then
			main.Contents = function()
				if IsNil(settings.ManageList[UUID]) then settings.ManageList[UUID] = false end
				settings.ManageList[UUID] = GUI:Checkbox("Enable Moogle MultiSession Manager for this bot instance.",settings.ManageList[UUID])
				if settings.ManageList[UUID] == true then
					for k,v in pairs(data.LogTable) do
						if GUI:CollapsingHeader(k) then
							Text("Player Name: ") Text(v.name,{"1","1","0","1"},0,true) Space()
							local InCurrentParty,PartySize,IsLeader = false,0,false
							local el = EntityList.myparty
							if table.valid(el) then
								for i,e in pairs(el) do
									PartySize = PartySize + 1
									if e.isleader and v.name == e.name then
										IsLeader = true
									end
									if v.name == e.name then
										InCurrentParty = true
									end
								end
							end
							if InCurrentParty then
								if GUI:SmallButton("Kick From Party##"..k) then
									d("Action: Kick From Party")
									d("Current Character: "..Player.name)
									d("Selected Character: "..v.name)
									SendTextCommand([[/partycmd kick "]]..v.name..[["]])
									Update()
								end
							elseif not InCurrentParty then
								if GUI:SmallButton("Invite To Party##"..k) then
									d("Action: Invite To Party")
									d("Current Character: "..Player.name)
									d("Selected Character: "..v.name)
									SendTextCommand([[/partycmd add "]]..v.name..[["]])
									Update()
								end
							end
							if PartySize > 0 then
								Space()
								if GUI:SmallButton("Leave Party (solo drop)##"..k) then
									d("Action: Leave Party (Current Character Only)")
									d("Current Character: "..Player.name)
									d("Selected Character: "..v.name)
									SendTextCommand([[/partycmd leave]])
									Update()
								end
								if IsLeader then
									Space()
									if GUI:SmallButton("Dissolve Party##"..k) then
										d("Action: Dissolve party (won't work unless both characters are the same)")
										d("Current Character: "..Player.name)
										d("Selected Character: "..v.name)
										SendTextCommand([[/partycmd breakup]])
										Update()
									end
								end
							end

							Text("[",0) Text(v.datacenter,{"1","1","0","1"},0) Text("] ",0)
							Text(v.server,{"1","1","0","1"},0)

							Text(" - [",0) Text(v.mapid,{"1","1","0","1"},0) Text("] ",0)
							Text(v.mapname,{"1","1","0","1"})
							Text("POS x: ") Text(v.pos.x,{"1","1","0","1"},0,true)
							Indent(GUI:CalcTextSize("POS "))
								Text("y: ") Text(v.pos.y,{"1","1","0","1"},0,true)
								Text("z: ") Text(v.pos.z,{"1","1","0","1"},0,true)
								Text("h: ") Text(v.pos.h,{"1","1","0","1"},0,true)
							Unindent(GUI:CalcTextSize("POS "))

							if data.LogTable[k].SendTellText == nil or data.LogTable[k].SendTellText == "" then
								data.LogTable[k].SendTellText = " "
							end
							local changed
							data.LogTable[k].SendTellText,changed = GUI:InputText("##SendTellInput"..k,data.LogTable[k].SendTellText) Space()
							if changed then Update() end
							if GUI:SmallButton("Send Tell##"..k) then
								d("Action: Send Tell")
								d("Current Character: "..Player.name)
								d("Selected Character: "..v.name)
								SendTextCommand("/t "..v.name.." "..data.LogTable[k].SendTellText)
								data.LogTable[k].SendTellText = " "
								Update()
							end
						end
					end
				end
			end
		end
	end
end

function MoogleMultiSessionManager.OnUpdate( event, tickcount )
	if MoogleLib ~= nil and MoogleMultiSessionManager.Settings.enable then
		if Text == nil then UpdateLocals1() UpdateLocals2() end
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleMultiSessionManager.Settings
		local data = MoogleMultiSessionManager.Data
		
		if table.find(nav.Menu,MoogleMultiSessionManager.GUI.NavName) == nil then
			table.insert(nav.Menu,MoogleMultiSessionManager.GUI.NavName)
		end

		if IsNil(MMMFolder) then
			if not FolderExists(ScriptsFolder..[[Moogle MultiSession Manager\Logs\]]) then
				CreateFolder(ScriptsFolder..[[Moogle MultiSession Manager\Logs\]])
			end
		 	MMMFolder = ScriptsFolder..[[Moogle MultiSession Manager\Logs\]]
			UUID = GetUUID()
		else
			Load()
		end

		MoogleSave({})
		if data.LogTable[UUID] == nil then
			data.LogTable[UUID] = {}
			Update()
		end
		if data.LogTable[UUID].name ~= Player.name then data.LogTable[UUID].name = Player.name Update() end
		if TimeSince(data.LastWrite) > settings.POSUpdateInterval then
			if data.LogTable[UUID].pos == nil or table.deepcompare(data.LogTable[UUID].pos,Player.pos) == false then
				data.LogTable[UUID].pos = Player.pos Update()
			end
			data.LastWrite = Now()
		end
		if data.LogTable[UUID].mapid ~= Player.localmapid then data.LogTable[UUID].mapid = Player.localmapid Update() end
		if data.LogTable[UUID].mapname ~= GetMapName(Player.localmapid) then data.LogTable[UUID].mapname = GetMapName(Player.localmapid) Update() end
		if data.LogTable[UUID].datacenter ~= FFXIV_Login_DataCenterName then data.LogTable[UUID].datacenter = FFXIV_Login_DataCenterName Update() end
		if data.LogTable[UUID].server ~= FFXIV_Login_ServerName then data.LogTable[UUID].server = FFXIV_Login_ServerName Update() end
	end
end

RegisterEventHandler("Module.Initalize", MoogleMultiSessionManager.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleMultiSessionManager.Draw)
RegisterEventHandler("Gameloop.Update", MoogleMultiSessionManager.OnUpdate)