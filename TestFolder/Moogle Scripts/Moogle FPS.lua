local MoogleFPS = {}
local self = MoogleFPS
local selfs = "MoogleFPS"

self.Info = {
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

self.GUI = {
	WindowName = "MoogleFPS##MoogleFPS",
	name = "Moogle FPS",
	NavName = "FPS Overlay",
	MiniName = "FPS",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = "..selfs..".GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "FPS and stuff"
}

self.MiniGUI = {
	WindowName = "MoogleFPSMini##MoogleFPS",
	name = "MiniFPS",
	open = true,
	visible = true,
	WindowData = {
		xPos = 0, yPos = 0, xSize = 0, ySize = 0, xScreen = 0, yScreen = 0
	}
}

self.Settings = {
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
local settings = self.Settings
local enable, FPSTime, Position, EdgeDistance, Opacity, PulseDelay, ShowMs, ShowPer, ShowLabels, Scale = settings.enable, settings.FPSTime, settings.Position, settings.EdgeDistance, settings.Opacity, settings.PulseDelay, settings.ShowMs, settings.ShowPer, settings.ShowLabels, settings.Scale

self.Data = {
	loaded = false,
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
local data = self.Data
local loaded = data.loaded

function self.Init()
	Initialize(self.GUI)

	MoogleLoad({
		["self.enable"] = "self.Settings.enable",
		["self.FPSTime"] = "self.Settings.FPSTime",
		["self.Position"] = "self.Settings.Position",
		["self.EdgeDistance"] = "self.Settings.EdgeDistance",
		["self.Opacity"] = "self.Settings.Opacity",
		["self.PulseDelay"] = "self.Settings.PulseDelay",
		["self.ShowMs"] = "self.Settings.ShowMs",
		["self.ShowPer"] = "self.Settings.ShowPer",
		["self.ShowLabels"] = "self.Settings.ShowLabels",
		["self.Scale"] = "self.Settings.Scale"
	})
end

function self.Draw()
	if FinishedLoading then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = self.Settings

		if nav.selected == self.GUI.NavName then
			main.Contents = function()
				Text("Record FPS, MPF, and PER for ") SameLine()
				GUI:PushItemWidth(75)
				self.Settings.FPSTime,c = GUI:InputInt("##FPSTime",self.Settings.FPSTime)
				if c then
				end
				GUI:PopItemWidth()
				SameLine() Text(" seconds to calculate average")

				Text("Calculate once every ") SameLine()
				GUI:PushItemWidth(85)
				self.Settings.PulseDelay,c = GUI:InputInt("##PulseDelay",self.Settings.PulseDelay,50)
				if c then
				end
				GUI:PopItemWidth()
				SameLine() Text(" milliseconds")

				self.Settings.ShowLabels,c = Checkbox("Show Labels",self.Settings.ShowLabels,"ShowLabels")
				if c then
				end
				SameLine(5)

				self.Settings.ShowMs,c = Checkbox("Show MPF(ms)",self.Settings.ShowMs,"ShowMs")
				if c then
				end
				SameLine(5)


				self.Settings.ShowPer,c = Checkbox("Show Bot Performance",self.Settings.ShowPer,"ShowPer")
				if c then
				end

				Text("Set Text Scaling for Mini Window to ") SameLine()
				GUI:PushItemWidth(85)
				self.Settings.Scale,c = GUI:InputFloat("##Scale",self.Settings.Scale,0.1,0.1,1)
				if c then
				end
				GUI:PopItemWidth()
				SameLine() Text(" x normal size")

				Text("Leave ") SameLine()
				GUI:PushItemWidth(85)
				self.Settings.EdgeDistance,c = GUI:InputInt("##EdgeDistance",self.Settings.EdgeDistance,1)
				if c then
				end
				GUI:PopItemWidth()
				SameLine() Text(" pixels of padding on each side when snapping")

				Text("Set the Mini Window's opacity to ") SameLine()
				GUI:PushItemWidth(85)
				self.Settings.Opacity,c = GUI:InputFloat("##Opacity",self.Settings.Opacity,0.1,0.1,1)
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

				local Position = self.Settings.Position

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
						self.Settings.Position = "TL"
					else
						self.Settings.Position = "M"
					end
				elseif TopRight ~= TopRight2 then
						self.Settings.Position = "TR"
					if TopRight then
					else
						self.Settings.Position = "M"
					end
				elseif BottomLeft ~= BottomLeft2 then
						self.Settings.Position = "BL"
					if BottomLeft then
					else
						self.Settings.Position = "M"
					end
				elseif BottomRight ~= BottomRight2 then
						self.Settings.Position = "BR"
					if BottomRight then
					else
						self.Settings.Position = "M"
					end
				end
			end
		end

		if self.Settings.enable and (self.MiniGUI.open) then
			self.MiniGUI.WindowData.xScreen,self.MiniGUI.WindowData.yScreen = GUI:GetScreenSize()
			local xSize = self.MiniGUI.WindowData.xSize
			local ySize = self.MiniGUI.WindowData.ySize
			local xScreen = self.MiniGUI.WindowData.xScreen
			local yScreen = self.MiniGUI.WindowData.yScreen
			local EdgeDistance = self.Settings.EdgeDistance

			GUI:PushStyleColor(GUI.Col_Text,1,1,0,1)
			GUI:PushStyleColor(GUI.Col_WindowBg,0,0,0,self.Settings.Opacity)
			GUI:PushStyleVar(GUI.StyleVar_WindowPadding,10,3)
			GUI:PushStyleVar(GUI.StyleVar_WindowRounding,3)
			GUI:PushStyleVar(GUI.StyleVar_ItemSpacing,0,0)
			GUI:PushStyleVar(GUI.StyleVar_ItemInnerSpacing,0,0)

			local function FixedWindow()
				self.MiniGUI.visible, self.MiniGUI.open = GUI:Begin(self.MiniGUI.name, self.MiniGUI.open, GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_AlwaysAutoResize + GUI.WindowFlags_NoMove)
			end
			local function FloatingWindow()
				self.MiniGUI.visible, self.MiniGUI.open = GUI:Begin(self.MiniGUI.name, self.MiniGUI.open, GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_AlwaysAutoResize)
			end

			if Is(self.Settings.Position,"TL") then
				GUI:SetNextWindowPos(EdgeDistance, EdgeDistance) FixedWindow()
			elseif Is(self.Settings.Position,"TR") then
				GUI:SetNextWindowPos(xScreen - (xSize + EdgeDistance), EdgeDistance) FixedWindow()
			elseif Is(self.Settings.Position,"BL") then
				GUI:SetNextWindowPos(EdgeDistance, yScreen - (ySize + EdgeDistance)) FixedWindow()
			elseif Is(self.Settings.Position,"BR") then
				GUI:SetNextWindowPos(xScreen - (xSize + EdgeDistance), yScreen - (ySize + EdgeDistance)) FixedWindow()
			else
				FloatingWindow()
			end

			self.MiniGUI.WindowData.xSize,self.MiniGUI.WindowData.ySize = GUI:GetWindowSize(); xSize = self.MiniGUI.WindowData.xSize; ySize = self.MiniGUI.WindowData.ySize
			GUI:SetWindowFontScale(self.Settings.Scale)
			if self.MiniGUI.visible then
				if GUI:IsMouseHoveringWindow() then
					Tooltip("FPS: Average Frames per Second\nms: Average Milliseconds between each Frame\nPER: Average Bot Performance, which is the time it takes to complete one cycle")
				end
				local ShowLabels = self.Settings.ShowLabels
				local FPS = self.Data.FPS.Average
				local MPF = self.Data.MPF.Average
				local PER = self.Data.BotPerformance.Average
				local InfoSize = 0
				local buffer = 0

				local temp0 = GUI:CalcTextSize(string.format("%.1f",Round(FPS,0.1)))
				local temp1 = GUI:CalcTextSize(string.format("%.1f",Round(MPF,0.1)))
				local temp2 = GUI:CalcTextSize(string.format("%.4f",Round(PER,0.0001)))

				Text(string.format("%.1f",Round(FPS,0.1)))
				if ShowLabels then
					buffer = temp0
					if self.Settings.ShowMs then
						if buffer < temp1 then buffer = temp1 end
					end
					if self.Settings.ShowPer then
						if buffer < temp2 then buffer = temp2 end
					end
					Space((buffer-temp0) + 4)
					Text("FPS")
				end

				if self.Settings.ShowMs then
					Text(string.format("%.1f",Round(MPF,0.1)))
					if ShowLabels then
						Space((buffer-temp1) + 4)
						Text("ms")
					end
				end
				if self.Settings.ShowPer then
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
					local PulseDelay = self.Settings.PulseDelay
					local Data = self.Data
					local LastTic = Data.LastTic

					if table.find(nav.Menu,self.GUI.NavName) == nil then
						table.insert(nav.Menu,self.GUI.NavName)
					end

					if TimeSince(LastTic) > PulseDelay then
						Data.LastTic,LastTic = Now(),Now()
						Data.FPS.FrameCount = GUI:GetFrameCount()
						Data.MPF.Time = os.clock()
						Data.BotPerformance.BotPerformance = GetBotPerformance()
						local FrameCount = Data.FPS.FrameCount
						local PreviousFrame = Data.FPS.PreviousFrame
						local FPSTime = self.Settings.FPSTime * 1000
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
			MoogleSave({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.FPSTime]]] = selfs .. [[.Settings.FPSTime]],
				[selfs .. [[.Position]]] = selfs .. [[.Settings.Position]],
				[selfs .. [[.EdgeDistance]]] = selfs .. [[.Settings.EdgeDistance]],
				[selfs .. [[.Opacity]]] = selfs .. [[.Settings.Opacity]],
				[selfs .. [[.PulseDelay]]] = selfs .. [[.Settings.PulseDelay]],
				[selfs .. [[.ShowMs]]] = selfs .. [[.Settings.ShowMs]],
				[selfs .. [[.ShowPer]]] = selfs .. [[.Settings.ShowPer]],
				[selfs .. [[.ShowLabels]]] = selfs .. [[.Settings.ShowLabels]],
				[selfs .. [[.Scale]]] = selfs .. [[.Settings.Scale]]
			})
		else
			MoogleLoad({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.FPSTime]]] = selfs .. [[.Settings.FPSTime]],
				[selfs .. [[.Position]]] = selfs .. [[.Settings.Position]],
				[selfs .. [[.EdgeDistance]]] = selfs .. [[.Settings.EdgeDistance]],
				[selfs .. [[.Opacity]]] = selfs .. [[.Settings.Opacity]],
				[selfs .. [[.PulseDelay]]] = selfs .. [[.Settings.PulseDelay]],
				[selfs .. [[.ShowMs]]] = selfs .. [[.Settings.ShowMs]],
				[selfs .. [[.ShowPer]]] = selfs .. [[.Settings.ShowPer]],
				[selfs .. [[.ShowLabels]]] = selfs .. [[.Settings.ShowLabels]],
				[selfs .. [[.Scale]]] = selfs .. [[.Settings.Scale]]
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

API.Event("Gameloop.Initalize",selfs,"Initialize",self.Init)
API.Event("Gameloop.Update",selfs,"Update",self.OnUpdate)
API.Event("Gameloop.Draw",selfs,"Draw",self.Draw)

_G.MoogleFPS = MoogleFPS
-- End of File --
