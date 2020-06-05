local KaliMainWindow = {} --1
local self = KaliMainWindow
local selfs = "KaliMainWindow"

self.Info = {
	Creator = "Kali",
	Version = "1.3.4",
	StartDate = "09/24/17",
	ReleaseDate = "09/24/17",
	LastUpdate = "09/24/17",
	URL = "https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/Main%20Window.lua",
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

self.GUI = {
	WindowName = "KaliMainWindow##KaliMainWindow",
	name = "Moogle Script Management",
	NavName = "Moogle Script Management",
	open = true,
	visible = true,
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

self.Settings = {
	enable = true,
	open = false,
	requirefocus = true
}

self.Data = {
	CheckVer = true,
	lastsave = 0,
	loaded = false
}
local data = self.Data
local CheckVer, lastsave, loaded = data.CheckVer, data.lastsave, data.loaded

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
function self.Draw()
	if FinishedLoading then
		-- START MAIN WINDOW --
			local MainX = 0
			local MainY = 0
			local MainH = 0

			local StyleVars = WindowStyle(self.GUI.WindowStyle)
			if self.GUI.open then
				GUI:PushStyleVar(GUI.StyleVar_WindowMinSize,615,500)
				if NotNil(self.GUI.oldPOS) and self.GUI.name ~= self.GUI.oldPOS.name then
					local oldPOS = self.GUI.oldPOS
					GUI:SetNextWindowPos(oldPOS.pos.x, oldPOS.pos.y)
					GUI:SetNextWindowSize(oldPOS.size.x, oldPOS.size.y)
					self.GUI.oldPOS = nil
				end
				self.GUI.visible, self.GUI.open = GUI:Begin(self.GUI.name, self.GUI.open)
				if self.GUI.focused ~= GUI:IsWindowFocused() then
					self.GUI.focused = GUI:IsWindowFocused()
					if self.GUI.focused then
						GUI:SetWindowFocus(self.GUI.NavigationMenu.name)
						GUI:SetWindowFocus(self.GUI.name)
					end
				end
					MainX,MainY = GUI:GetWindowPos()
				MainH = GUI:GetWindowHeight()
				if self.GUI.visible then
					self.GUI.NavigationMenu.open = true
					self.GUI["Contents"]()
				else
					self.GUI.NavigationMenu.open = false
				end
				GUI:PopStyleVar()
				GUI:End()
			end
			WindowStyleClose(StyleVars)
		-- END MAIN WINDOW --

		-- START SIDEBAR NAVIGATION MENU --

			local StyleVars = WindowStyle(self.GUI.NavigationMenu.WindowStyle)
			if self.GUI.NavigationMenu.open then
				GUI:SetNextWindowPos(MainX-self.GUI.NavigationMenu.x+1,MainY+19)
				GUI:SetNextWindowSize(self.GUI.NavigationMenu.x,MainH-29)
				GUI:PushStyleVar(GUI.StyleVar_WindowRounding,0)
				GUI:PushStyleVar(GUI.StyleVar_WindowPadding,0,0)
				GUI:PushStyleVar(GUI.StyleVar_WindowMinSize,1,1)
				GUI:PushStyleColor(GUI.Col_WindowBg, 0.0174509803921569, 0, 0.0270588235294118, 0.95)
				self.GUI.NavigationMenu.visible, self.GUI.NavigationMenu.open = GUI:Begin(self.GUI.NavigationMenu.name, self.GUI.NavigationMenu.open,GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoMove + GUI.WindowFlags_NoCollapse + GUI.WindowFlags_NoScrollbar)
				if self.GUI.NavigationMenu.visible then

					if self.GUI.NavigationMenu.focused ~= GUI:IsWindowFocused() then
						self.GUI.NavigationMenu.focused = GUI:IsWindowFocused()
					end
					if self.GUI.NavigationMenu.hovered ~= GUI:IsWindowHovered() then
						self.GUI.NavigationMenu.hovered = GUI:IsWindowHovered()
					end
					-- Start Navigation Menu Animation --

						local x,y = GUI:GetMousePos()

						local NavDimensions = (((MainX-self.GUI.NavigationMenu.x+1) - x) <= 20) and (x <= MainX) and (y >= MainY+19) and (y <= MainY+19+(MainH-29)+15)
						if NavDimensions and ((self.GUI.NavigationMenu.hovered or self.GUI.NavigationMenu.focused or self.GUI.NavigationMenu.active) or self.Settings.requirefocus == false or self.GUI.NavigationMenu.ListBoxClicked) then
							if self.GUI.NavigationMenu.FocusMain == false then --self.GUI.NavigationMenu.ListBoxClicked
								if self.GUI.NavigationMenu.focused or self.GUI.NavigationMenu.ListBoxClicked then
									GUI:SetWindowFocus(self.GUI.name)
									GUI:SetWindowFocus(self.GUI.NavigationMenu.name)
									self.GUI.NavigationMenu.FocusMain = true
								end
							end
--								( or ) then

--								and (self.GUI.NavigationMenu.hovered or  and (GUI:IsMouseDown(1) or GUI:IsMouseClicked(1))) then
							-- Mouse cursor is hovering window, expand window until you reach desired width --
							local duration = 250
							local CurrentDistance = self.GUI.NavigationMenu.x
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
								self.GUI.NavigationMenu.x = self.GUI.NavigationMenu.x + ((TimeSince(AnimationLastFrame) * AnimationRate))
								AnimationLastFrame = Now()
							else
								self.GUI.NavigationMenu.x = MaxDistance
							end
						else
							-- Mouse cursor has left the window, retract the window until you reach your minimum width --
							self.GUI.NavigationMenu.FocusMain = false
							local duration = 1000
							local CurrentDistance = self.GUI.NavigationMenu.x
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
								self.GUI.NavigationMenu.x = self.GUI.NavigationMenu.x - ((TimeSince(AnimationLastFrame) * AnimationRate))
								AnimationLastFrame = Now()
							else
								self.GUI.NavigationMenu.x = MinDistance
							end

							if GUI:GetWindowWidth() < 10 then
								self.GUI.NavigationMenu.x = 8
								GUI:PushStyleVar(GUI.StyleVar_ItemSpacing,0,0)
								GUI:PushStyleVar(GUI.StyleVar_ItemInnerSpacing,0,0)
								if self.AnimatedSideBar then
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
							local C = GUI:ListBoxHeader("##NavigationList", table.size(self.GUI.NavigationMenu.Menu), math.floor((MainH - 70)/18))
								local function IsSelected(str)
									if Type(str,"string") then
										-- d("str: "..str.." NavMenu.selected: "..self.GUI.NavigationMenu.selected.." IsTheSame: "..tostring(self.GUI.NavigationMenu.selected == str))
										if self.GUI.NavigationMenu.selected == str then
											return true
										else
											return false
										end
									else
										ml_error("IsSelected string check failed, is "..tostring(type(str)))
										return false
									end
								end

								GUI:Selectable("Moogle Script Management", IsSelected("Moogle Script Management"))
								if GUI:IsItemClicked(0) then
									self.GUI.NavigationMenu.selected = MoogleUpdater.GUI.NavName
								elseif GUI:IsItemHovered() and GUI:IsItemClicked(1) then
									GUI:OpenPopup("Moogle Script Management")
								end
								if GUI:BeginPopup("Moogle Script Management") then
									local checked, pressed = GUI:Checkbox("##Moogle Script Management".."MiniButton",MoogleUpdater.GUI.MiniButton)
									Text("Mini Button",true)
									if GUI:IsItemClicked() then
										pressed = true
									end
									if pressed then
										MoogleUpdater.GUI.MiniButton = not MoogleUpdater.GUI.MiniButton

										if MoogleUpdater.GUI.MiniButton then
											local ModuleTable = MoogleUpdater.GUI
											local MiniName = ModuleTable.MiniName
											local create = true
											for k,v in pairs(ml_global_information.menu.windows) do if v.name == MiniName then create = false end end
											if create then
												table.insert(ml_global_information.menu.windows, { name = MiniName, openWindow = function() ModuleTable.OnClick() end, isOpen = function() return ModuleTable.IsOpen() end })
											end
										else
											local ModuleTable = MoogleUpdater.GUI
											local MiniName = ModuleTable.MiniName
											for k,v in pairs(ml_global_information.menu.windows) do if v.name == MiniName then ml_global_information.menu.windows[k] = nil end end
										end
									end
									GUI:EndPopup()
								end

								for k,v in pairs(self.GUI.NavigationMenu.Menu) do
									if v ~= "Moogle Script Management" then
										local c = GUI:Selectable(v, IsSelected(v))
										if GUI:IsItemClicked(c) then self.GUI.NavigationMenu.selected = v end
									end
								end
							GUI:ListBoxFooter()
							local active = GUI:IsItemClicked(C) or GUI:IsItemHovered(C)
							if self.GUI.NavigationMenu.active ~= active then self.GUI.NavigationMenu.active = active end
							if self.GUI.NavigationMenu.ListBoxClicked ~= GUI:IsItemClicked() then self.GUI.NavigationMenu.ListBoxClicked = GUI:IsItemClicked() end
							if self.GUI.NavigationMenu.ListBoxHovered ~= GUI:IsItemHovered() then self.GUI.NavigationMenu.ListBoxHovered = GUI:IsItemHovered() end

							-- self.GUI.NavigationMenu.selected = GUI:ListBox("##NavigationList",self.GUI.NavigationMenu.selected,self.GUI.NavigationMenu.Menu,math.floor((MainH - 70)/18))
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

function self.OnUpdate()
	if FinishedLoading then -- Initiate Locals --
		if loaded then -- Load User Saved Settings --
			if CheckVer then -- Do a version check --
--				local update, tbl = VersionCheck(selfs, self.Info.URL, self.Info.Version)
--				if update == true then
--	--					FileWrite(MooglePath..[[Main Window.lua]],tbl)
--	--					loadstring(tbl)()
--					CheckVer = false
--				elseif update == false then
--					Error("Window Test")
--					CheckVer = false
--				end
			else -- We are running the current version, time for logic --
			end
			MoogleSave({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.requirefocus]]] = selfs .. [[.Settings.requirefocus]],
				[selfs .. [[.open]]] = selfs .. [[.GUI.open]],
			})
			if TimeSince(lastsave, 60000) then
				MoogleSave({[selfs .. [[.selected]]] = selfs .. [[.GUI.NavigationMenu.selected]]})
				lastsave = Now()
			end
		else
			MoogleLoad({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.requirefocus]]] = selfs .. [[.Settings.requirefocus]],
				[selfs .. [[.open]]] = selfs .. [[.GUI.open]],
				[selfs .. [[.selected]]] = selfs .. [[.GUI.NavigationMenu.selected]],
			})
			CheckVer, lastsave, loaded = data.CheckVer, data.lastsave, data.loaded
			loaded = true
		end
	else
		UpdateLocals()
		if FinishedLoading then
--			Initialize(self.GUI)
		end
	end
end

API.Event("Gameloop.Initalize",selfs,"Initialize",self.Init)
API.Event("Gameloop.Update",selfs,"Update",self.OnUpdate)
API.Event("Gameloop.Draw",selfs,"Draw",self.Draw)

_G.KaliMainWindow = KaliMainWindow
-- End of File --
