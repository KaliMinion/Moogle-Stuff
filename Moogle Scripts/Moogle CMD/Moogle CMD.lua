MoogleCMD = {}

MoogleCMD.Info = {
	Creator = "Kali",
	Version = "1.0.0",
	StartDate = "01/26/18",
	ReleaseDate = "01/26/18",
	LastUpdate = "01/26/18",
	ChangeLog = {
		["1.0.0"] = "Initial release"
	}
}

MoogleCMD.GUI = {
	WindowName = "MoogleCMD##MoogleCMD",
	name = "Moogle CMD",
	NavName = "Moogle CMD",
	MiniName = "CMD",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = MoogleCMD.GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "Visually display io.popen as if you were using CMD."
}

MoogleCMD.Settings = {
	enable = true
}
local self = "MoogleCMD"

MoogleCMD.Data = {
	file = {},
	Instances = 1,
}

local API, Lua, General, Debug, IO, Math, OS, String, Table, Gui, MinionPath, LuaPath, MooglePath, ImageFolder, ScriptsFolder, ACRFolder, SenseProfiles, SenseTriggers, Initialize, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, RecordKeybinds, Error, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, Size, Empty, NotEmpty, d2, DrawDebugInfo, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, MoogleCMDQueue, MoogleDownloadBuffer, CMDTable, CMD, DownloadString, DownloadTable, DownloadFile, VersionCheck, Ping, Split, starts, ends, StrToTable, Valid, NotValid, pairs, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables

local function UpdateLocals1()
	API = MoogleLib.API Lua = MoogleLib.Lua General = Lua.general Debug = Lua.debug IO = Lua.io Math = Lua.math OS = Lua.os String = Lua.string Table = Lua.table Gui = MoogleLib.Gui MinionPath = API.MinionPath LuaPath = API.LuaPath MooglePath = API.MooglePath ImageFolder = API.ImageFolder ScriptsFolder = API.ScriptsFolder ACRFolder = API.ACRFolder SenseProfiles = API.SenseProfiles SenseTriggers = API.SenseTriggers Initialize = API.Initialize Vars = API.Vars Distance2D = API.Distance2D Distance3D = API.Distance3D CurrentTarget = API.CurrentTarget MovePlayer = API.MovePlayer SetTarget = API.SetTarget ConvertCID = API.ConvertCID Entities = API.Entities Entities2 = API.Entities2 EntitiesUpdateInterval = API.EntitiesUpdateInterval EntitiesLastUpdate = API.EntitiesLastUpdate UpdateEntities = API.UpdateEntities CMDKeyPress = API.CMDKeyPress SendKey = API.SendKey RecordKeybinds = API.RecordKeybinds Error = General.Error IsNil = General.IsNil NotNil = General.NotNil Is = General.Is IsAll = General.IsAll Not = General.Not NotAll = General.NotAll Type = General.Type NotType = General.NotType Size = General.Size Empty = General.Empty NotEmpty = General.NotEmpty d2 = Debug.d2 DrawDebugInfo = Debug.DrawDebugInfo Sign = Math.Sign Round = Math.Round Convert4Bytes = Math.Convert4Bytes PowerShell = OS.PowerShell CreateFolder = OS.CreateFolder DeleteFile = OS.DeleteFile MoogleCMDQueue = OS.MoogleCMDQueue MoogleDownloadBuffer = OS.MoogleDownloadBuffer CMDTable = OS.CMDTable CMD = OS.CMD DownloadString = OS.DownloadString DownloadTable = OS.DownloadTable
end

local function UpdateLocals2()
	DownloadFile = OS.DownloadFile VersionCheck = OS.VersionCheck Ping = OS.Ping Split = String.Split starts = String.starts ends = String.ends StrToTable = String.ToTable Valid = Table.Valid NotValid = Table.NotValid pairs = Table.pairs InsertIfNil = Table.InsertIfNil RemoveIfNil = Table.RemoveIfNil UpdateIfChanged = Table.UpdateIfChanged RemoveExpired = Table.RemoveExpired Unpack = Table.Unpack Print = Table.Print WindowStyle = Gui.WindowStyle WindowStyleClose = Gui.WindowStyleClose ColorConv = Gui.ColorConv SameLine = Gui.SameLine Indent = Gui.Indent Unindent = Gui.Unindent Space = Gui.Space Text = Gui.Text Checkbox = Gui.Checkbox Tooltip = Gui.Tooltip GetRemaining = Gui.GetRemaining VirtualKeys = Gui.VirtualKeys OrderedKeys = Gui.OrderedKeys IndexToDecimal = Gui.IndexToDecimal HotKey = Gui.HotKey DrawTables = Gui.DrawTables
end

function MoogleCMD.ModuleInit()
	if MoogleLib ~= nil then
		UpdateLocals1() UpdateLocals2()
		Initialize(MoogleCMD.GUI)
	end
end

function MoogleCMD.Draw()
	if MoogleLib ~= nil then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleCMD.Settings

		if nav.selected == MoogleCMD.GUI.NavName then
			main.Contents = function()
			end
		end
	end
end

function MoogleCMD.OnUpdate( event, tickcount )
	if MoogleLib ~= nil and MoogleCMD.Settings.enable then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleCMD.Settings
		local Data = MoogleCMD.Data

		if table.find(nav.Menu,MoogleCMD.GUI.NavName) == nil then
			table.insert(nav.Menu,MoogleCMD.GUI.NavName)
		end


		for i=1, (math.abs(Data.Instances - table.size(Data.file))) + Data.Instances do
			if i > Data.Instances then
				Data.file[i] = nil
			elseif IsNil(Data.file[i]) then
				Data.file[i] = io.tmpfile()
			end
		end
	end
end

RegisterEventHandler("Module.Initalize", MoogleCMD.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleCMD.Draw)
RegisterEventHandler("Gameloop.Update", MoogleCMD.OnUpdate)