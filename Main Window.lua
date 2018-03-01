KaliMainWindow = {}

KaliMainWindow.Info = {
	Creator = "Kali",
	Version = "1.3.3",
	StartDate = "09/24/17",
	ReleaseDate = "09/24/17",
	LastUpdate = "09/24/17",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Rework for MoogleLib",
		["1.2.1"] = "Updated to match current Initialize standard.",
		["1.2.2"] = "Main Window open on start fix",
		["1.2.3"] = "Updated Forum Link URL",
		["1.2.5"] = "Pushed Locals",
		["1.3.0"] = "Now remembers the last open window state and tab selected."
	}
}

KaliMainWindow.GUI = {
	WindowName = "KaliMainWindow##KaliMainWindow",
	name = "Moogle Script Management",
	NavName = "Moogle Script Management",
	open = false,
	visible = false,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = not KaliMainWindow.GUI.open"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "Module HUB for updating and downloading Moogle Scripts.",
	WindowStyle = {
		["Text"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["TextDisabled"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["WindowBG"] = { [1] = 7, [2] = 0, [3] = 12, [4] = 0.75 },
		["ChildWindowBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["Border"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["BorderShadow"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["FrameBg"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
		["FrameBgHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["FrameBgActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
		["TitleBg"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["TitleBgCollapsed"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["TitleBgActive"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
		["MenuBarBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ScrollbarBg"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
		["ScrollbarGrab"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["ScrollbarGrabHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["ScrollbarGrabActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
		["ComboBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["CheckMark"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
		["SliderGrab"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["SliderGrabActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
		["Button"] = { [1] = 51, [2] = 0, [3] = 127, [4] = 0.75 },
		["ButtonHovered"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.75 },
		["ButtonActive"] = { [1] = 84, [2] = 69, [3] = 95, [4] = 1.00 },
		["Header"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["HeaderHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["HeaderActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["Column"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ColumnHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ColumnActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ResizeGrip"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.75 },
		["ResizeGripHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.75 },
		["ResizeGripActive"] = { [1] = 84, [2] = 69, [3] = 95, [4] = 1.00 },
		["CloseButton"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["CloseButtonHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["CloseButtonActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["PlotLines"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["PlotLinesHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["PlotHistogram"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["PlotHistogramHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["TextSelectedBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["TooltipBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ModalWindowDarkening"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 }
	},
	Contents = function ()
	end,

	NavigationMenu = {
		WindowName = "KaliMainWindow##NavigationMenu",
		name = "Navigation Menu",
		open = true,
		visible = true,
		x = 8,
		selected = "Moogle Script Management",
		Menu = {},
		WindowStyle = {
			["Text"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["TextDisabled"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["WindowBG"] = { [1] = 4.45, [2] = 0, [3] = 6.9, [4] = 0.75 },
			["ChildWindowBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["Border"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["BorderShadow"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["FrameBg"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
			["FrameBgHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
			["FrameBgActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
			["TitleBg"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
			["TitleBgCollapsed"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
			["TitleBgActive"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
			["MenuBarBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["ScrollbarBg"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
			["ScrollbarGrab"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
			["ScrollbarGrabHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
			["ScrollbarGrabActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
			["ComboBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["CheckMark"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
			["SliderGrab"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
			["SliderGrabActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
			["Button"] = { [1] = 51, [2] = 0, [3] = 127, [4] = 0.75 },
			["ButtonHovered"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.75 },
			["ButtonActive"] = { [1] = 84, [2] = 69, [3] = 95, [4] = 1.00 },
			["Header"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["HeaderHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["HeaderActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["Column"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["ColumnHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["ColumnActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["ResizeGrip"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.75 },
			["ResizeGripHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.75 },
			["ResizeGripActive"] = { [1] = 84, [2] = 69, [3] = 95, [4] = 1.00 },
			["CloseButton"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["CloseButtonHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["CloseButtonActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["PlotLines"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["PlotLinesHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["PlotHistogram"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["PlotHistogramHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["TextSelectedBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["TooltipBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
			["ModalWindowDarkening"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 }
		}
	}
}

KaliMainWindow.Settings = {
	enable = true,
	open = false,
	selected = ""
}
local self = "KaliMainWindow"

local API, Lua, General, Debug, IO, Math, OS, String, Table, Gui, MinionPath, LuaPath, MooglePath, ImageFolder, ScriptsFolder, ACRFolder, SenseProfiles, SenseTriggers, Initialize, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, RecordKeybinds, Error, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, Size, Empty, NotEmpty, d2, DrawDebugInfo, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, MoogleCMDQueue, MoogleDownloadBuffer, CMDTable, CMD, DownloadString, DownloadTable, DownloadFile, VersionCheck, Ping, Split, starts, ends, StrToTable, Valid, NotValid, pairs, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables

local function UpdateLocals1()
	API = MoogleLib.API Lua = MoogleLib.Lua General = Lua.general Debug = Lua.debug IO = Lua.io Math = Lua.math OS = Lua.os String = Lua.string Table = Lua.table Gui = MoogleLib.Gui MinionPath = API.MinionPath LuaPath = API.LuaPath MooglePath = API.MooglePath ImageFolder = API.ImageFolder ScriptsFolder = API.ScriptsFolder ACRFolder = API.ACRFolder SenseProfiles = API.SenseProfiles SenseTriggers = API.SenseTriggers Initialize = API.Initialize Vars = API.Vars Distance2D = API.Distance2D Distance3D = API.Distance3D CurrentTarget = API.CurrentTarget MovePlayer = API.MovePlayer SetTarget = API.SetTarget ConvertCID = API.ConvertCID Entities = API.Entities Entities2 = API.Entities2 EntitiesUpdateInterval = API.EntitiesUpdateInterval EntitiesLastUpdate = API.EntitiesLastUpdate UpdateEntities = API.UpdateEntities CMDKeyPress = API.CMDKeyPress SendKey = API.SendKey RecordKeybinds = API.RecordKeybinds Error = General.Error IsNil = General.IsNil NotNil = General.NotNil Is = General.Is IsAll = General.IsAll Not = General.Not NotAll = General.NotAll Type = General.Type NotType = General.NotType Size = General.Size Empty = General.Empty NotEmpty = General.NotEmpty d2 = Debug.d2 DrawDebugInfo = Debug.DrawDebugInfo Sign = Math.Sign Round = Math.Round Convert4Bytes = Math.Convert4Bytes PowerShell = OS.PowerShell CreateFolder = OS.CreateFolder DeleteFile = OS.DeleteFile MoogleCMDQueue = OS.MoogleCMDQueue MoogleDownloadBuffer = OS.MoogleDownloadBuffer CMDTable = OS.CMDTable CMD = OS.CMD DownloadString = OS.DownloadString DownloadTable = OS.DownloadTable
end

local function UpdateLocals2()
	DownloadFile = OS.DownloadFile VersionCheck = OS.VersionCheck Ping = OS.Ping Split = String.Split starts = String.starts ends = String.ends StrToTable = String.ToTable Valid = Table.Valid NotValid = Table.NotValid pairs = Table.pairs InsertIfNil = Table.InsertIfNil RemoveIfNil = Table.RemoveIfNil UpdateIfChanged = Table.UpdateIfChanged RemoveExpired = Table.RemoveExpired Unpack = Table.Unpack Print = Table.Print WindowStyle = Gui.WindowStyle WindowStyleClose = Gui.WindowStyleClose ColorConv = Gui.ColorConv SameLine = Gui.SameLine Indent = Gui.Indent Unindent = Gui.Unindent Space = Gui.Space Text = Gui.Text Checkbox = Gui.Checkbox Tooltip = Gui.Tooltip GetRemaining = Gui.GetRemaining VirtualKeys = Gui.VirtualKeys OrderedKeys = Gui.OrderedKeys IndexToDecimal = Gui.IndexToDecimal HotKey = Gui.HotKey DrawTables = Gui.DrawTables
end

function KaliMainWindow.ModuleInit()
	if MoogleLib then
		UpdateLocals1() UpdateLocals2()
		Initialize(KaliMainWindow.GUI)
		MoogleLoad({
			["KaliMainWindow.enable"] = "KaliMainWindow.Settings.enable",
			["KaliMainWindow.open"] = "KaliMainWindow.GUI.open",
			["KaliMainWindow.selected"] = "KaliMainWindow.GUI.NavigationMenu.selected"
		})
	end
end

local AnimatedLastHover = 0
local AnimatedLastNotHover = 0
local AnimatedHovering = false
local AnimationRate = 0
local AnimationRemainingDuration = 0
local AnimationLastFrame = 0

local x = 0
local y = 0
local max = 1
local step = 1
local time = 0
local count = 0

-- local TestTable = {}

local lastsave = 0
function KaliMainWindow.Draw()
	local gamestate = GetGameState()
	if MoogleLib then
		MoogleSave({
			["KaliMainWindow.enable"] = "KaliMainWindow.Settings.enable",
			["KaliMainWindow.open"] = "KaliMainWindow.GUI.open",
		})
		if TimeSince(lastsave) > 60000 then
			MoogleSave({["KaliMainWindow.selected"] = "KaliMainWindow.GUI.NavigationMenu.selected"})
			lastsave = Now()
		end

		-- START MAIN WINDOW --
			local MainX = 0
			local MainY = 0
			local MainH = 0

			local StyleVars = WindowStyle(KaliMainWindow.GUI.WindowStyle)
			if KaliMainWindow.GUI.open then
				GUI:PushStyleVar(GUI.StyleVar_WindowMinSize,615,500)
				if NotNil(KaliMainWindow.GUI.oldPOS) and KaliMainWindow.GUI.name ~= KaliMainWindow.GUI.oldPOS.name then
					local oldPOS = KaliMainWindow.GUI.oldPOS
					GUI:SetNextWindowPos(oldPOS.pos.x, oldPOS.pos.y)
					GUI:SetNextWindowSize(oldPOS.size.x, oldPOS.size.y)
					KaliMainWindow.GUI.oldPOS = nil
				end
				KaliMainWindow.GUI.visible, KaliMainWindow.GUI.open = GUI:Begin(KaliMainWindow.GUI.name, KaliMainWindow.GUI.open)
				MainX,MainY = GUI:GetWindowPos()
				MainH = GUI:GetWindowHeight()
				if KaliMainWindow.GUI.visible then
					KaliMainWindow.GUI.NavigationMenu.open = true
					KaliMainWindow.GUI["Contents"]()
				else
					KaliMainWindow.GUI.NavigationMenu.open = false
				end
				GUI:PopStyleVar()
				GUI:End()
			end
			WindowStyleClose(StyleVars)
		-- END MAIN WINDOW --

		-- START SIDEBAR NAVIGATION MENU --

			local StyleVars = WindowStyle(KaliMainWindow.GUI.NavigationMenu.WindowStyle)
			if KaliMainWindow.GUI.NavigationMenu.open then
				GUI:SetNextWindowPos(MainX-KaliMainWindow.GUI.NavigationMenu.x+1,MainY+19)
				GUI:SetNextWindowSize(KaliMainWindow.GUI.NavigationMenu.x,MainH-29)
				GUI:PushStyleVar(GUI.StyleVar_WindowRounding,0)
				GUI:PushStyleVar(GUI.StyleVar_WindowPadding,0,0)
				GUI:PushStyleVar(GUI.StyleVar_WindowMinSize,1,1)
				GUI:PushStyleColor(GUI.Col_WindowBg, 0.0174509803921569, 0, 0.0270588235294118, 0.95)
				KaliMainWindow.GUI.NavigationMenu.visible, KaliMainWindow.GUI.NavigationMenu.open = GUI:Begin(KaliMainWindow.GUI.NavigationMenu.name, KaliMainWindow.GUI.NavigationMenu.open,GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoMove + GUI.WindowFlags_NoCollapse + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse)
				if KaliMainWindow.GUI.NavigationMenu.visible then
					-- Start Navigation Menu Animation --

						local x,y = GUI:GetMousePos()
						if GUI:IsWindowHovered() or ((((MainX-KaliMainWindow.GUI.NavigationMenu.x+1) - x) <= 20) and (x <= MainX) and (y >= MainY+19) and (y <= MainY+19+(MainH-29)+15)) then
							-- Mouse cursor is hovering window, expand window until you reach desired width --
							local duration = 250
							local CurrentDistance = KaliMainWindow.GUI.NavigationMenu.x
							local MinDistance = 8
							local MaxDistance = 243

							if not AnimatedHovering then
								AnimatedHovering = true
								AnimatedLastHover = Now()

								local RatioCompleted = (CurrentDistance - MinDistance) / (MaxDistance - MinDistance)

								AnimationRemainingDuration = duration - (RatioCompleted * duration)

								local DistanceRemaining = MaxDistance - CurrentDistance

								AnimationRate = DistanceRemaining / AnimationRemainingDuration
								AnimationLastFrame = Now()
							end

							local time = TimeSince(AnimatedLastHover)

							if time < AnimationRemainingDuration then
								KaliMainWindow.GUI.NavigationMenu.x = KaliMainWindow.GUI.NavigationMenu.x + ((TimeSince(AnimationLastFrame) * AnimationRate))
								AnimationLastFrame = Now()
							else
								KaliMainWindow.GUI.NavigationMenu.x = MaxDistance
							end
						else
							-- Mouse cursor has left the window, retract the window until you reach your minimum width --
							local duration = 1000
							local CurrentDistance = KaliMainWindow.GUI.NavigationMenu.x
							local MinDistance = 8
							local MaxDistance = 243

							if AnimatedHovering then
								AnimatedHovering = false
								AnimatedLastNotHover = Now()

								local RatioCompleted = (CurrentDistance - MinDistance) / (MaxDistance - MinDistance)

								AnimationRemainingDuration = duration - ((1 - RatioCompleted) * duration)

								local DistanceRemaining = CurrentDistance - MinDistance

								AnimationRate = DistanceRemaining / AnimationRemainingDuration
								AnimationLastFrame = Now()
							end

							local time = TimeSince(AnimatedLastNotHover)

							if time < AnimationRemainingDuration then
								KaliMainWindow.GUI.NavigationMenu.x = KaliMainWindow.GUI.NavigationMenu.x - ((TimeSince(AnimationLastFrame) * AnimationRate))
								AnimationLastFrame = Now()
							else
								KaliMainWindow.GUI.NavigationMenu.x = MinDistance
							end

							if GUI:GetWindowWidth() < 10 then
								KaliMainWindow.GUI.NavigationMenu.x = 8
								GUI:PushStyleVar(GUI.StyleVar_ItemSpacing,0,0)
								GUI:PushStyleVar(GUI.StyleVar_ItemInnerSpacing,0,0)
								if KaliMainWindow.AnimatedSideBar then
									if (AnimatedSpot + GUI:GetTextLineHeightWithSpacing()) >= (MainH - 35) then
										AnimatedIncrease = false
										AnimatedSpot = (MainH - 35) - GUI:GetTextLineHeightWithSpacing()
									elseif AnimatedSpot <= 1 then
										AnimatedIncrease = true
									end

									if AnimatedIncrease then
										GUI:Dummy(0,AnimatedSpot)
										GUI:Text("«")
										if (AnimatedSpot + (((MainH - 35) - GUI:GetTextLineHeightWithSpacing()) / (1000 / gPulseTime))) > 243 then
											AnimatedSpot = 243
										else
											AnimatedSpot = AnimatedSpot + (((MainH - 35) - GUI:GetTextLineHeightWithSpacing()) / (1000 / gPulseTime))
										end
									else
										GUI:Dummy(0,AnimatedSpot)
										GUI:Text("«")
										AnimatedSpot = AnimatedSpot - (((MainH - 35) - GUI:GetTextLineHeightWithSpacing()) / (1000 / gPulseTime))
									end
								else
									GUI:Dummy(0,((GUI:GetWindowHeight() - GUI:GetTextLineHeightWithSpacing()) / 2))
									GUI:Text("«")
								end
								GUI:PopStyleVar(2)
							end
						end
					-- End Navigation Menu Animation --

					if GUI:GetWindowWidth() > 10 then
						GUI:Dummy(0,1)
						GUI:Dummy(((243 - GUI:CalcTextSize("Main Menu")) / 2),0)GUI:SameLine(0,0)
						GUI:Text("Main Menu")
						GUI:Separator()

						GUI:Dummy(1,1)
						GUI:Dummy(5,0)GUI:SameLine(0,0)
						GUI:PushItemWidth(232)
							GUI:PushStyleColor(GUI.Col_FrameBg, 0,0,0,0)
							GUI:ListBoxHeader("##NavigationList", table.size(KaliMainWindow.GUI.NavigationMenu.Menu), math.floor((MainH - 70)/18))
								local function IsSelected(str)
									if Type(str,"string") then
										-- d("str: "..str.." NavMenu.selected: "..KaliMainWindow.GUI.NavigationMenu.selected.." IsTheSame: "..tostring(KaliMainWindow.GUI.NavigationMenu.selected == str))
										if KaliMainWindow.GUI.NavigationMenu.selected == str then
											return true
										else
											return false
										end
									else
										ml_error("IsSelected string check failed, is "..tostring(type(str)))
										return false
									end
								end

								local c = GUI:Selectable("Moogle Script Management", IsSelected("Moogle Script Management"))
								if GUI:IsItemClicked(c) then KaliMainWindow.GUI.NavigationMenu.selected = MoogleUpdater.GUI.NavName end

								for k,v in pairs(KaliMainWindow.GUI.NavigationMenu.Menu) do
									if v ~= "Moogle Script Management" then
										local c = GUI:Selectable(v, IsSelected(v))
										if GUI:IsItemClicked(c) then KaliMainWindow.GUI.NavigationMenu.selected = v end
									end
								end
							GUI:ListBoxFooter()

							-- KaliMainWindow.GUI.NavigationMenu.selected = GUI:ListBox("##NavigationList",KaliMainWindow.GUI.NavigationMenu.selected,KaliMainWindow.GUI.NavigationMenu.Menu,math.floor((MainH - 70)/18))
							GUI:PopStyleColor()
						GUI:PopItemWidth()
						GUI:Dummy(0,0)

						GUI:Separator()
						GUI:Dummy(0,0)
						GUI:Dummy(5,0)GUI:SameLine(0,0)
						local x,y = GUI:CalcTextSize("Forum Topic")
						local c = GUI:Button("Forum Topic",x+10,y+10)
						if GUI:IsItemClicked(c) then
							io.popen([[cmd /c start http://www.mmominion.com/thread-20229.html]])
						end
						
						GUI:SameLine(0,5)
						local x,y = GUI:CalcTextSize("MoogleStuff Discord")
						local c = GUI:Button("MoogleStuff Discord",x+10,y+10)
						if GUI:IsItemClicked(c) then
							io.popen([[cmd /c start https://discord.gg/Ytr9jJC]])
						end
					end
				end
				GUI:PopStyleColor()
				GUI:PopStyleVar(3)
				GUI:End()
			end
			WindowStyleClose(StyleVars)
		-- END SIDEBAR NARVIGATION MENU --
	end
end

RegisterEventHandler("Module.Initalize", KaliMainWindow.ModuleInit)
RegisterEventHandler("Gameloop.Draw", KaliMainWindow.Draw)
RegisterEventHandler("Gameloop.Update", KaliMainWindow.OnUpdate)
