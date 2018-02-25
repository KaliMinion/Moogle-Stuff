MoogleFPS = {}

MoogleFPS.Info = {
	Creator = "Kali",
	Version = "1.2.7",
	StartDate = "05/26/17",
	ReleaseDate = "05/29/17",
	LastUpdate = "01/03/18",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Added hide ms and hide labels in Mini FPS window, fixed GW2 support, removed wait for in game check, and fixed table serialization in debug window.",
		["1.1.1"] = "Fixed Debug window styling.",
		["1.1.2"] = "Forgot to include BannedKeys for Debug.",
		["1.2.0"] = "Rework for new Moolge Script Manager.",
		["1.2.3"] = "Tweaks and MiniButton support",
		["1.2.4"] = "Pushed Locals",
		["1.2.7"] = "Added Save Settings"
	}
}

MoogleFPS.GUI = {
	WindowName = "MoogleFPS##MoogleFPS",
	name = "Moogle FPS",
	NavName = "FPS Overlay",
	MiniName = "FPS",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = MoogleFPS.GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "FPS and stuff"
}

MoogleFPS.MiniGUI = {
	WindowName = "MoogleFPSMini##MoogleFPS",
	name = "MiniFPS",
	open = true,
	visible = true,
	WindowData = {
		xPos = 0, yPos = 0, xSize = 0, ySize = 0, xScreen = 0, yScreen = 0
	}
}

MoogleFPS.Settings = {
	enable = true,
	FPSTime = 5, -- Time to hold FPS History in seconds
	Position = "TL", -- TL = Top Left; TR = Top Right; BL = Bottom Left; BR = Bottom Right; M = Manual
	EdgeDistance = 7,
	Opacity = 0.5,
	PulseDelay = 100,
	ShowMs = false,
	ShowPer = false,
	ShowLabels = true,
	Scale = 1.5
}
local self = "MoogleFPS"

MoogleFPS.Data = {
	LastTic = 0,
	FPS = {
		FPS = 0,
		Average = 0,
		FrameCount = 0,
		PreviousFrame = 0,
		History = {},
	},
	MPF = {
		MPF = 0,
		Average = 0,
		Time = 0,
		PreviousTime = 0,
		History = {},
	},
	BotPerformance = {
		BotPerformance = 0,
		Average = 0,
		History = {}
	}
}

local API, Lua, General, Debug, IO, Math, OS, String, Table, Gui, MinionPath, LuaPath, MooglePath, ImageFolder, ScriptsFolder, ACRFolder, SenseProfiles, SenseTriggers, Initialize, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, RecordKeybinds, Error, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, Size, Empty, NotEmpty, d2, DrawDebugInfo, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, MoogleCMDQueue, MoogleDownloadBuffer, CMDTable, CMD, DownloadString, DownloadTable, DownloadFile, VersionCheck, Ping, Split, starts, ends, StrToTable, Valid, NotValid, pairs, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables

local function UpdateLocals1()
	API = MoogleLib.API Lua = MoogleLib.Lua General = Lua.general Debug = Lua.debug IO = Lua.io Math = Lua.math OS = Lua.os String = Lua.string Table = Lua.table Gui = MoogleLib.Gui MinionPath = API.MinionPath LuaPath = API.LuaPath MooglePath = API.MooglePath ImageFolder = API.ImageFolder ScriptsFolder = API.ScriptsFolder ACRFolder = API.ACRFolder SenseProfiles = API.SenseProfiles SenseTriggers = API.SenseTriggers Initialize = API.Initialize Vars = API.Vars Distance2D = API.Distance2D Distance3D = API.Distance3D CurrentTarget = API.CurrentTarget MovePlayer = API.MovePlayer SetTarget = API.SetTarget ConvertCID = API.ConvertCID Entities = API.Entities Entities2 = API.Entities2 EntitiesUpdateInterval = API.EntitiesUpdateInterval EntitiesLastUpdate = API.EntitiesLastUpdate UpdateEntities = API.UpdateEntities CMDKeyPress = API.CMDKeyPress SendKey = API.SendKey RecordKeybinds = API.RecordKeybinds Error = General.Error IsNil = General.IsNil NotNil = General.NotNil Is = General.Is IsAll = General.IsAll Not = General.Not NotAll = General.NotAll Type = General.Type NotType = General.NotType Size = General.Size Empty = General.Empty NotEmpty = General.NotEmpty d2 = Debug.d2 DrawDebugInfo = Debug.DrawDebugInfo Sign = Math.Sign Round = Math.Round Convert4Bytes = Math.Convert4Bytes PowerShell = OS.PowerShell CreateFolder = OS.CreateFolder DeleteFile = OS.DeleteFile MoogleCMDQueue = OS.MoogleCMDQueue MoogleDownloadBuffer = OS.MoogleDownloadBuffer CMDTable = OS.CMDTable CMD = OS.CMD DownloadString = OS.DownloadString DownloadTable = OS.DownloadTable
end

local function UpdateLocals2()
	DownloadFile = OS.DownloadFile VersionCheck = OS.VersionCheck Ping = OS.Ping Split = String.Split starts = String.starts ends = String.ends StrToTable = String.ToTable Valid = Table.Valid NotValid = Table.NotValid pairs = Table.pairs InsertIfNil = Table.InsertIfNil RemoveIfNil = Table.RemoveIfNil UpdateIfChanged = Table.UpdateIfChanged RemoveExpired = Table.RemoveExpired Unpack = Table.Unpack Print = Table.Print WindowStyle = Gui.WindowStyle WindowStyleClose = Gui.WindowStyleClose ColorConv = Gui.ColorConv SameLine = Gui.SameLine Indent = Gui.Indent Unindent = Gui.Unindent Space = Gui.Space Text = Gui.Text Checkbox = Gui.Checkbox Tooltip = Gui.Tooltip GetRemaining = Gui.GetRemaining VirtualKeys = Gui.VirtualKeys OrderedKeys = Gui.OrderedKeys IndexToDecimal = Gui.IndexToDecimal HotKey = Gui.HotKey DrawTables = Gui.DrawTables
end

function MoogleFPS.ModuleInit()
	if MoogleLib ~= nil then
		UpdateLocals1() UpdateLocals2()
		Initialize(MoogleFPS.GUI)

		MoogleLoad({
			["MoogleFPS.enable"] = "MoogleFPS.Settings.enable",
			["MoogleFPS.FPSTime"] = "MoogleFPS.Settings.FPSTime",
			["MoogleFPS.Position"] = "MoogleFPS.Settings.Position",
			["MoogleFPS.EdgeDistance"] = "MoogleFPS.Settings.EdgeDistance",
			["MoogleFPS.Opacity"] = "MoogleFPS.Settings.Opacity",
			["MoogleFPS.PulseDelay"] = "MoogleFPS.Settings.PulseDelay",
			["MoogleFPS.ShowMs"] = "MoogleFPS.Settings.ShowMs",
			["MoogleFPS.ShowPer"] = "MoogleFPS.Settings.ShowPer",
			["MoogleFPS.ShowLabels"] = "MoogleFPS.Settings.ShowLabels",
			["MoogleFPS.Scale"] = "MoogleFPS.Settings.Scale"
		})
		if not FileExists(ImageFolder..MoogleFPS.GUI.name..".png") then
			DownloadFile([[https://i.imgur.com/cdbXSLt.png]],ImageFolder..MoogleFPS.GUI.name..".png")
		end
	end
end

function MoogleFPS.Draw()
	if MoogleLib ~= nil then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleFPS.Settings

		if nav.selected == MoogleFPS.GUI.NavName then
			main.Contents = function()
				Text("Record FPS, MPF, and PER for ") SameLine()
				GUI:PushItemWidth(75)
				MoogleFPS.Settings.FPSTime,c = GUI:InputInt("##FPSTime",MoogleFPS.Settings.FPSTime)
				if c then
				end
				GUI:PopItemWidth()
				SameLine() Text(" seconds to calculate average")

				Text("Calculate once every ") SameLine()
				GUI:PushItemWidth(85)
				MoogleFPS.Settings.PulseDelay,c = GUI:InputInt("##PulseDelay",MoogleFPS.Settings.PulseDelay,50)
				if c then
				end
				GUI:PopItemWidth()
				SameLine() Text(" milliseconds")

				MoogleFPS.Settings.ShowLabels,c = Checkbox("Show Labels",MoogleFPS.Settings.ShowLabels,"ShowLabels")
				if c then
				end
				SameLine(5)

				MoogleFPS.Settings.ShowMs,c = Checkbox("Show MPF(ms)",MoogleFPS.Settings.ShowMs,"ShowMs")
				if c then
				end
				SameLine(5)
				

				MoogleFPS.Settings.ShowPer,c = Checkbox("Show Bot Performance",MoogleFPS.Settings.ShowPer,"ShowPer")
				if c then
				end

				Text("Set Text Scaling for Mini Window to ") SameLine()
				GUI:PushItemWidth(85)
				MoogleFPS.Settings.Scale,c = GUI:InputFloat("##Scale",MoogleFPS.Settings.Scale,0.1,0.1,1)
				if c then
				end
				GUI:PopItemWidth()
				SameLine() Text(" x normal size")

				Text("Leave ") SameLine()
				GUI:PushItemWidth(85)
				MoogleFPS.Settings.EdgeDistance,c = GUI:InputInt("##EdgeDistance",MoogleFPS.Settings.EdgeDistance,1)
				if c then
				end
				GUI:PopItemWidth()
				SameLine() Text(" pixels of padding on each side when snapping")

				Text("Set the Mini Window's opacity to ") SameLine()
				GUI:PushItemWidth(85)
				MoogleFPS.Settings.Opacity,c = GUI:InputFloat("##Opacity",MoogleFPS.Settings.Opacity,0.1,0.1,1)
				if c then
				end
				GUI:PopItemWidth()

				Text("Snap the Mini Window to a corner of the screen:")

				local TopLeft = false
				local TopRight = false
				local BottomLeft = false
				local BottomRight = false

				local TopLeft2 = false
				local TopRight2 = false
				local BottomLeft2 = false
				local BottomRight2 = false

				local Position = MoogleFPS.Settings.Position

				if Is(Position,"TL") then
					TopLeft = true
					TopLeft2 = true
				elseif Is(Position,"TR") then
					TopRight = true
					TopRight2 = true
				elseif Is(Position,"BL") then
					BottomLeft = true
					BottomLeft2 = true
				elseif Is(Position,"BR") then
					BottomRight = true
					BottomRight2 = true
				end

				local x = 55
				local y = 35
				GUI:PushStyleVar(GUI.StyleVar_ItemSpacing,0,0)
				GUI:BeginChild("##TL",x,y,true)
					TopLeft,c = Checkbox("TL",TopLeft,"TL")
				GUI:EndChild() SameLine()
				GUI:BeginChild("##TR",x,y,true)
					TopRight,c = Checkbox("TR",TopRight,"TR",true)
				GUI:EndChild()
				GUI:BeginChild("##BL",x,y,true)
					BottomLeft,c = Checkbox("BL",BottomLeft,"BL")
				GUI:EndChild() SameLine()
				GUI:BeginChild("##BR",x,y,true)
					BottomRight,c = Checkbox("BR",BottomRight,"BR",true)
				GUI:EndChild()
				GUI:PopStyleVar()

				if TopLeft ~= TopLeft2 then
					if TopLeft then
						MoogleFPS.Settings.Position = "TL"
					else
						MoogleFPS.Settings.Position = "M"
					end
				elseif TopRight ~= TopRight2 then
						MoogleFPS.Settings.Position = "TR"
					if TopRight then
					else
						MoogleFPS.Settings.Position = "M"
					end
				elseif BottomLeft ~= BottomLeft2 then
						MoogleFPS.Settings.Position = "BL"
					if BottomLeft then
					else
						MoogleFPS.Settings.Position = "M"
					end
				elseif BottomRight ~= BottomRight2 then
						MoogleFPS.Settings.Position = "BR"
					if BottomRight then
					else
						MoogleFPS.Settings.Position = "M"
					end
				end
			end
		end

		if MoogleFPS.Settings.enable and (MoogleFPS.MiniGUI.open) then
			MoogleFPS.MiniGUI.WindowData.xScreen,MoogleFPS.MiniGUI.WindowData.yScreen = GUI:GetScreenSize()
			local xSize = MoogleFPS.MiniGUI.WindowData.xSize
			local ySize = MoogleFPS.MiniGUI.WindowData.ySize
			local xScreen = MoogleFPS.MiniGUI.WindowData.xScreen
			local yScreen = MoogleFPS.MiniGUI.WindowData.yScreen
			local EdgeDistance = MoogleFPS.Settings.EdgeDistance

			GUI:PushStyleColor(GUI.Col_Text,1,1,0,1)
			GUI:PushStyleColor(GUI.Col_WindowBg,0,0,0,MoogleFPS.Settings.Opacity)
			GUI:PushStyleVar(GUI.StyleVar_WindowPadding,10,3)
			GUI:PushStyleVar(GUI.StyleVar_WindowRounding,3)
			GUI:PushStyleVar(GUI.StyleVar_ItemSpacing,0,0)
			GUI:PushStyleVar(GUI.StyleVar_ItemInnerSpacing,0,0)

			local function FixedWindow()
				MoogleFPS.MiniGUI.visible, MoogleFPS.MiniGUI.open = GUI:Begin(MoogleFPS.MiniGUI.name, MoogleFPS.MiniGUI.open, GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_AlwaysAutoResize + GUI.WindowFlags_NoMove)
			end
			local function FloatingWindow()
				MoogleFPS.MiniGUI.visible, MoogleFPS.MiniGUI.open = GUI:Begin(MoogleFPS.MiniGUI.name, MoogleFPS.MiniGUI.open, GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_AlwaysAutoResize)
			end

			if Is(MoogleFPS.Settings.Position,"TL") then
				GUI:SetNextWindowPos(EdgeDistance, EdgeDistance) FixedWindow()
			elseif Is(MoogleFPS.Settings.Position,"TR") then
				GUI:SetNextWindowPos(xScreen - (xSize + EdgeDistance), EdgeDistance) FixedWindow()
			elseif Is(MoogleFPS.Settings.Position,"BL") then
				GUI:SetNextWindowPos(EdgeDistance, yScreen - (ySize + EdgeDistance)) FixedWindow()
			elseif Is(MoogleFPS.Settings.Position,"BR") then
				GUI:SetNextWindowPos(xScreen - (xSize + EdgeDistance), yScreen - (ySize + EdgeDistance)) FixedWindow()
			else
				FloatingWindow()
			end
			
			MoogleFPS.MiniGUI.WindowData.xSize,MoogleFPS.MiniGUI.WindowData.ySize = GUI:GetWindowSize(); xSize = MoogleFPS.MiniGUI.WindowData.xSize; ySize = MoogleFPS.MiniGUI.WindowData.ySize
			GUI:SetWindowFontScale(MoogleFPS.Settings.Scale)
			if MoogleFPS.MiniGUI.visible then
				if GUI:IsMouseHoveringWindow() then
					Tooltip("FPS: Average Frames per Second\nms: Average Milliseconds between each Frame\nPER: Average Bot Performance, which is the time it takes to complete one cycle")
				end
				local ShowLabels = MoogleFPS.Settings.ShowLabels
				local FPS = MoogleFPS.Data.FPS.Average
				local MPF = MoogleFPS.Data.MPF.Average
				local PER = MoogleFPS.Data.BotPerformance.Average
				local InfoSize = 0
				local buffer = 0

				local temp0 = GUI:CalcTextSize(string.format("%.1f",Round(FPS,0.1)))
				local temp1 = GUI:CalcTextSize(string.format("%.1f",Round(MPF,0.1)))
				local temp2 = GUI:CalcTextSize(string.format("%.4f",Round(PER,0.0001)))

				Text(string.format("%.1f",Round(FPS,0.1)))
				if ShowLabels then
					buffer = temp0
					if MoogleFPS.Settings.ShowMs then
						if buffer < temp1 then buffer = temp1 end
					end
					if MoogleFPS.Settings.ShowPer then
						if buffer < temp2 then buffer = temp2 end
					end
					Space((buffer-temp0) + 4)
					Text("FPS")
				end

				if MoogleFPS.Settings.ShowMs then
					Text(string.format("%.1f",Round(MPF,0.1)))
					if ShowLabels then
						Space((buffer-temp1) + 4)
						Text("ms")
					end
				end
				if MoogleFPS.Settings.ShowPer then
					Text(string.format("%.4f",Round(PER,0.0001)))
					if ShowLabels then
						Space((buffer-temp2) + 4)
						Text("PER")
					end
				end
			end
			GUI:PopStyleColor(2)
			GUI:PopStyleVar(4)
			GUI:End()
		end
	end
end

function MoogleFPS.OnUpdate( event, tickcount )
	if MoogleLib ~= nil then
		MoogleSave({
			["MoogleFPS.enable"] = "MoogleFPS.Settings.enable",
			["MoogleFPS.FPSTime"] = "MoogleFPS.Settings.FPSTime",
			["MoogleFPS.Position"] = "MoogleFPS.Settings.Position",
			["MoogleFPS.EdgeDistance"] = "MoogleFPS.Settings.EdgeDistance",
			["MoogleFPS.Opacity"] = "MoogleFPS.Settings.Opacity",
			["MoogleFPS.PulseDelay"] = "MoogleFPS.Settings.PulseDelay",
			["MoogleFPS.ShowMs"] = "MoogleFPS.Settings.ShowMs",
			["MoogleFPS.ShowPer"] = "MoogleFPS.Settings.ShowPer",
			["MoogleFPS.ShowLabels"] = "MoogleFPS.Settings.ShowLabels",
			["MoogleFPS.Scale"] = "MoogleFPS.Settings.Scale"
		})
		if MoogleFPS.Settings.enable then
			local main = KaliMainWindow.GUI
			local nav = KaliMainWindow.GUI.NavigationMenu
			local settings = MoogleFPS.Settings
			local PulseDelay = MoogleFPS.Settings.PulseDelay
			local Data = MoogleFPS.Data
			local LastTic = Data.LastTic

			if table.find(nav.Menu,MoogleFPS.GUI.NavName) == nil then
				table.insert(nav.Menu,MoogleFPS.GUI.NavName)
			end

			if TimeSince(LastTic) > PulseDelay then
				Data.LastTic,LastTic = Now(),Now()
				Data.FPS.FrameCount = GUI:GetFrameCount()
				Data.MPF.Time = os.clock()
				Data.BotPerformance.BotPerformance = GetBotPerformance()
				local FrameCount = Data.FPS.FrameCount
				local PreviousFrame = Data.FPS.PreviousFrame
				local FPSTime = MoogleFPS.Settings.FPSTime * 1000
				local Time = Data.MPF.Time
				local PreviousTime = Data.MPF.PreviousTime
				local CurrentBotPerformance = Data.BotPerformance.BotPerformance

				Data.FPS.FPS = (FrameCount - PreviousFrame) / (Time - PreviousTime)
				local FPS = Data.FPS.FPS
				Data.FPS.History[LastTic] = FPS
					for k,v in pairs(Data.FPS.History) do
						if k < LastTic - (FPSTime) then
							Data.FPS.History[k] = nil
						end
					end

				Data.MPF.MPF = ((Time - PreviousTime) / (FrameCount - PreviousFrame)) * 1000
				local MPF = Data.MPF.MPF
				Data.MPF.History[LastTic] = MPF
					for k,v in pairs(Data.MPF.History) do
						if k < LastTic - (FPSTime) then
							Data.MPF.History[k] = nil
						end
					end

				Data.BotPerformance.History[LastTic] = CurrentBotPerformance
					for k,v in pairs(Data.BotPerformance.History) do
						if k < LastTic - (FPSTime) then
							Data.BotPerformance.History[k] = nil
						end
					end

				local function TableAverage(tbl)
					local sum = 0
					local size = 0
					for k,v in pairs(tbl) do sum = sum + v size = size + 1 end
					return sum / size
				end

				Data.FPS.Average = TableAverage(Data.FPS.History)
				Data.MPF.Average = TableAverage(Data.MPF.History)
				Data.BotPerformance.Average = TableAverage(Data.BotPerformance.History)

				Data.FPS.PreviousFrame = FrameCount
				Data.MPF.PreviousTime = Time
			end
		end
	end
end

RegisterEventHandler("Module.Initalize", MoogleFPS.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleFPS.Draw)
RegisterEventHandler("Gameloop.Update", MoogleFPS.OnUpdate)
