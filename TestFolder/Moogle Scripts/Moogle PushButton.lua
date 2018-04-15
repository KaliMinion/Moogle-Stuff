local MooglePushButton = {}
local self = MooglePushButton
local selfs = "MooglePushButton"

self.Info = {
	Creator = "Kali",
	Version = "1.0.1",
	StartDate = "01/24/18",
	ReleaseDate = "01/24/18",
	LastUpdate = "01/24/18",
	ChangeLog = {
		["1.0.0"] = "Initial release"
	}
}

self.GUI = {
	WindowName = "MooglePushButton##MooglePushButton",
	name = "Moogle PushButton",
	NavName = "Moogle PushButton",
	MiniName = "PushButton",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = "..selfs..".GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "Attack an in game window with button presses to discover commands"
}

self.Settings = {
	enable = true,
	loaded = false,
	filterclosed = true,
}
local settings = self.Settings
local enable, loaded, filterclosed = settings.enable, settings.loaded, settings.filterclosed

self.Data = {}
local data = self.Data

function self.OnUpdate(event, tickcount)
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
			end
			MoogleSave({})
		else
			MoogleLoad({})
			loaded = true
		end
	else
		UpdateLocals()
		if FinishedLoading then
			Initialize(self.GUI)
		end
	end
end

local LongestStr, listheight, buttonheight, devtable, IterateDev, selected, selectedtbl, actionarg, scrollbarsize, padding, framepadding = 0, 10, 20, { arg1min = 0, arg1max = 50, arg2min = 0, arg2max = 50, rate = 0, lasttic = 0, control = "" }, false, nil, nil, nil, nil, nil, nil
function self.Draw()
	if settings.enable then
		local main = KaliMainWindow.GUI
		local nav = main.NavigationMenu

		if table.find(nav.Menu,self.GUI.NavName) == nil then
			table.insert(nav.Menu,self.GUI.NavName)
		end
		if nav.selected == self.GUI.NavName then
			main.Contents = function()
				local tbl = {}
				local tbl2 = {}
				if IsNil(scrollbarsize) then scrollbarsize = ml_gui.style.current.scrollbarsize end
				if IsNil(padding) then padding = ml_gui.style.current.windowpadding.x end
				if IsNil(framepadding) then framepadding = ml_gui.style.current.framepadding.x end
				for k, v in pairs(GetControls()) do
					if settings.filterclosed then
						if v:IsOpen() then
							tbl[v.name] = v
						else
							tbl2[v.name] = v
						end
					else
						tbl[v.name] = v
					end
				end

				if Valid(tbl) then
					GUI:PushStyleVar(GUI.StyleVar_ItemInnerSpacing, 0, 0)
					GUI:PushStyleVar(GUI.StyleVar_WindowPadding, 0, 0)
					GUI:BeginChild("##AddonControlViewer", LongestStr + scrollbarsize + (framepadding * 2) + padding, 0, false, GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse)
					GUI:PushStyleColor(GUI.Col_FrameBg, 0, 0, 0, 0.5)

					GUI:PushItemWidth(LongestStr + scrollbarsize + (framepadding * 2))
					local headerheight = math.floor(GUI:GetWindowHeight() / listheight)
					if settings.filterclosed then
						headerheight = headerheight / 2
					end
					GUI:ListBoxHeader("##AddonControls", table.size(tbl), headerheight)
					local function IsSelected(str)
						if Type(str, "string") then
							if selected == str then
								return true
							else
								return false
							end
						else
							ml_error("IsSelected string check failed, is " .. tostring(type(str)))
							return false
						end
					end

					for k, v in table.pairsbykeys(tbl) do
						local isclosed = not v:IsOpen()
						if v:IsOpen() then
							local hasactions = Valid(v:GetActions())
							local hasdata = Valid(v:GetData())
							local hasstrings = Valid(v:GetStrings())

							local size = GUI:CalcTextSize(k)
							if size > LongestStr then LongestStr = size end


							if settings.filterclosed and IsNil(selected) and not isclosed then selected = k selectedtbl = v end
							if isclosed and selected ~= k then
								GUI:PushStyleColor(GUI.Col_Text, 0.33, 0.33, 0.33, 1)
							elseif v:IsOpen() and selected ~= k then
								if hasactions then
									GUI:PushStyleColor(GUI.Col_Text, 1, 1, 0.651, 1)
								elseif hasdata then
									GUI:PushStyleColor(GUI.Col_Text, 1, 0.651, 0.651, 1)
								elseif hasstrings then
									GUI:PushStyleColor(GUI.Col_Text, 0.651, 0.651, 1, 1)
								end
							end

							local c = GUI:Selectable(k, IsSelected(k))

							if selected ~= k then if isclosed or hasactions or hasdata or hasstrings then GUI:PopStyleColor() end end

							local x, y = GUI:GetItemRectSize() if listheight ~= y then listheight = y end
							if GUI:IsItemClicked(c) then
								if GUI:IsKeyDown(16) and GUI:IsKeyDown(17) then
									v:Destroy() if selected == k then selected = nil selectedtbl = nil actionarg = 0 devarg1 = 0 devarg2 = 0 end
								elseif GUI:IsKeyDown(16) then
									GUI:SetClipboardText(k)
								elseif GUI:IsKeyDown(17) then
									v:Close() if selected == k then selected = nil selectedtbl = nil actionarg = 0 devarg1 = 0 devarg2 = 0 end
								else
									selected = k selectedtbl = v
								end
							end
						end
					end
					GUI:ListBoxFooter()

					if Valid(tbl2) then
						GUI:ListBoxHeader("##AddonControls2", table.size(tbl2), headerheight)
						for k, v in table.pairsbykeys(tbl2) do
							local isclosed = not v:IsOpen()

							local size = GUI:CalcTextSize(k)
							if size > LongestStr then LongestStr = size end
							if isclosed then GUI:PushStyleColor(GUI.Col_Text, 0.33, 0.33, 0.33, 1) end
							local c = GUI:Selectable(k, IsSelected(k))
							if isclosed then GUI:PopStyleColor() end
							local x, y = GUI:GetItemRectSize() if listheight ~= y then listheight = y end
							if GUI:IsItemClicked(c) then
								if GUI:IsKeyDown(16) and GUI:IsKeyDown(17) then
									v:Destroy() if selected == k then selected = nil selectedtbl = nil actionarg = 0 devarg1 = 0 devarg2 = 0 end
								else
									v:Open() selected = k selectedtbl = v
								end
							end
						end
						GUI:ListBoxFooter()
					end
					GUI:PopItemWidth()
					GUI:PopStyleColor()
					GUI:EndChild() SameLine(0, 0)
					GUI:BeginChild("##AddonContent", 0, 0, false)
					--					Checkbox("Filter out closed Controls.", "self.Settings.filterclosed", "FilterClosed")
					settings.filterclosed = GUI:Checkbox("Filter out closed Controls.",settings.filterclosed)
					if Valid(selectedtbl) then
						local control = GetControl(selectedtbl.name)
						if control then
							local isopen = control:IsOpen()
							if isopen then
								Text("Selected Control: ") Text(control.name, { "1", "1", "0", "1" }, 0, true)
							end
							if isopen then
								Space()
								if GUI:SmallButton("Close") then control:Close() selected = nil selectedtbl = nil actionarg = 0 devarg1 = 0 devarg2 = 0 end
							else
								Space()
								if GUI:SmallButton("Open") then control:Open() end
							end
							Space()
							if GUI:SmallButton("Destroy") then control:Destroy() selected = nil selectedtbl = nil actionarg = 0 devarg1 = 0 devarg2 = 0 end
							local Actions = control:GetActions()
							if Valid(Actions) then
								Text("Actions:")
								Indent()
								if IsNil(actionarg) then actionarg = 0 end
								for id, action in table.pairsbykeys(Actions) do
									if GUI:Button(action, 150, buttonheight) then
										control:Action(action, actionarg)
									end
									Space()
									actionarg, c = GUI:SliderInt("##" .. tostring(id) .. tostring(action), actionarg, -50, 50)
									local x, y = GUI:GetItemRectSize() if buttonheight ~= y then buttonheight = y end
								end
								Unindent()
							end

							local Data = control:GetData()
							if Valid(Data) then
								Text("Data:")
								Indent()
								for k, v in table.pairsbykeys(Data) do
									if Type(v, "table") then
										for i, e in table.pairsbykeys(v) do
											if Type(e, "table") then
												Text("[" .. tostring(i) .. "] -")
												for a, b in table.pairsbykeys(e) do
													Text("[" .. tostring(a) .. "]: ") Text(tostring(b), { "1", "1", "0", "1" }, 0, true)
												end
											else
												Text(tostring(i) .. ": ") Text(tostring(e), { "1", "1", "0", "1" }, 0, true)
											end
										end
									else
										Text(tostring(k) .. ": ") Text(tostring(v), { "1", "1", "0", "1" }, 0, true)
									end
								end
								Unindent()
							end

							local Strings = control:GetStrings()
							Text("Strings:")
							Indent()
							if Valid(Strings) then
								for k, v in table.pairsbykeys(Strings) do
									Text(tostring(k) .. ": ") Text(tostring(v), { "1", "1", "0", "1" }, 0, true)
								end
							end
							Unindent()

							if GUI:Button("PushButtonRange", 150, 15) then
								if devtable.arg1 == nil then devtable.arg1 = devtable.arg1min end
								if devtable.arg2 == nil then devtable.arg2 = devtable.arg2min end
								IterateDev = not IterateDev
								if IterateDev == false then
									devtable = { arg1min = 0, arg1max = 50, arg1 = devtable.arg1min, arg2min = 0, arg2max = 50, arg2 = devtable.arg2min, rate = devtable.rate, lasttic = 0, control = "" }
								end
							end
							Space() Text("(" .. tostring(devtable.arg1) .. "," .. tostring(devtable.arg2) .. ")")
							Space() devtable.rate = GUI:SliderInt("##Rate", devtable.rate, 0, 5000)
							GUI:PushItemWidth(75)
							devtable.arg1min = GUI:InputInt("##DevArg1Min", devtable.arg1min, 1, 5) Space()
							devtable.arg1max = GUI:InputInt("##DevArg1Max", devtable.arg1max, 1, 5) Space(50)

							devtable.arg2min = GUI:InputInt("##DevArg2Min", devtable.arg2min, 1, 5) Space()
							devtable.arg2max = GUI:InputInt("##DevArg2Max", devtable.arg2max, 1, 5)
							GUI:PopItemWidth()

							-- Logic --
							if IterateDev then
								if devtable.control == "" then devtable.control = control.name end
								if devtable.control == control.name then
									local arg1 = devtable.arg1
									local arg1min = devtable.arg1min
									local arg1max = devtable.arg1max
									local arg2 = devtable.arg2
									local arg2min = devtable.arg2min
									local arg2max = devtable.arg2max
									local rate = devtable.rate
									local lasttic = devtable.lasttic

									if TimeSince(lasttic) >= rate then
										devtable.lasttic = Now()

										if arg1 < arg1min then arg1 = arg1min end
										if arg2 < arg2min then arg2 = arg2min end
										control:PushButton(arg1, arg2)

										if arg2 < arg2max then
											devtable.arg2 = arg2 + 1
										else
											devtable.arg2 = arg2min
											if arg1 < arg1max then
												devtable.arg1 = arg1 + 1
											else
												IterateDev = false
												devtable = { arg1min = 0, arg1max = 50, arg1 = devtable.arg1min, arg2min = 0, arg2max = 50, arg2 = devtable.arg2min, rate = devtable.rate, lasttic = 0, control = "" }
											end
										end
									end
								else
									IterateDev = false
									devtable = { arg1min = 0, arg1max = 50, arg1 = devtable.arg1min, arg2min = 0, arg2max = 50, arg2 = devtable.arg2min, rate = devtable.rate, lasttic = 0, control = "" }
								end
							end

							local datas = control:GetRawData()
							if datas then
								if (GUI:TreeNode("RawData##" .. tostring(id))) then
									if (table.valid(datas)) then
										GUI:Separator()
										GUI:Columns(3, "##RawDataDetails", true)
										GUI:Text("Index"); GUI:NextColumn()
										GUI:Text("Type"); GUI:NextColumn()
										GUI:Text("Value"); GUI:NextColumn()
										GUI:Separator()
										for index, data in pairs(datas) do
											if (data.type ~= "0") then
												GUI:Text(tostring(index)) GUI:NextColumn()
												GUI:Text(tostring(data.type)) GUI:NextColumn()
												GUI:PushItemWidth(500)
												if (data.type == "int32") then
													GUI:Text(tostring(data.value))
												elseif (data.type == "bool") then
													GUI:Text(tostring(data.value))
												elseif (data.type == "string") then
													GUI:Text(data.value)
												elseif (data.type == "4bytes") then
													GUI:Text("A: " .. tostring(data.value.A) .. " B: " .. tostring(data.value.B) .. " C: " .. tostring(data.value.C) .. " D: " .. tostring(data.value.D))
												else
													GUI:Text("")
												end
												GUI:NextColumn()
												GUI:PopItemWidth()
											end
										end
										GUI:Separator()
										GUI:Columns(1)
									end
									GUI:TreePop()
								end
							end
						end
					end
					GUI:EndChild()
					GUI:PopStyleVar(2)
				end
			end
		end
	end
end

API.Event("Gameloop.Initalize", selfs, "Initialize", self.Init)
API.Event("Gameloop.Update", selfs, "Update", self.OnUpdate)
API.Event("Gameloop.Draw", selfs, "Draw", self.Draw)

_G.MooglePushButton = MooglePushButton
-- End of File --