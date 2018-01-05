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
	Version = "1.1.2",
	StartDate = "12/28/17",
	ReleaseDate = "12/30/17",
	LastUpdate = "01/04/18",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Rework for MoogleLib",
		["1.1.1"] = "Teaks",
		["1.1.2"] = "Download Overwrite Fix",
	}
}

MoogleLib.Settings = {
	enable = true,
	MainMenuType = 2,
	MainMenuEntryCreated = false
}

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
	local MinionPath = API.MinionPath

	API.LuaPath = GetLuaModsPath()
	local LuaPath = API.LuaPath

	API.MooglePath = LuaPath..[[MoogleStuff Files\]]
	local MooglePath = API.MooglePath

	API.ImageFolder = MooglePath..[[Moogle Images\]]
	local ImageFolder = API.ImageFolder

	API.ScriptsFolder = MooglePath..[[Moogle Scripts\]]
	local ScriptsFolder = API.ScriptsFolder
-- End Helper Variables --

-- Core Functions & Helper Functions --
	-- API Functions --
		function API.Initialize(ModuleTable)
			local MenuType = MoogleLib.Settings.MainMenuType
			local MainIcon = ImageFolder..[[MoogleStuff.png]]
			local ModuleIcon = ImageFolder..ModuleTable.name..[[.png]]
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

		function API.SaveVar(varstr,var)
			if In(varstr,"help","Help","?") then
				d([[SaveVar Function Example: MoogleLib.API.SaveVar("a.b.c[d][test]",tbl)]])
			else
				local IsNil = General.IsNil
				local Error = General.Error

				local t = {};
				local changed = false
				for w in varstr:gmatch("[%P/_/:]+") do
					t[#t+1] = w
				end
				local LastTable = Settings

				if table.valid(t) then
					for k,v in pairs(t) do
						if k ~= #t then
							if IsNil(LastTable[v]) then
								LastTable[v] = {}
								changed = true
							elseif type(LastTable[v]) ~= "table" then
								Error("LastTable[v] is not a table, but is a: "..type(LastTable[v]))
							end
							LastTable = LastTable[v]
						elseif k == #t then
							if IsNil(LastTable[v]) then
								LastTable[v] = var
								changed = true
							else
								if type(LastTable[v]) == "table" then
									if table.deepcompare(LastTable[v],var) == false then
										LastTable[v] = var
										changed = true
									end
								elseif LastTable[v] ~= var then
									LastTable[v] = var changed = true
								end
							end
						end
					end
				else
					Error("t is not a valid table.")
				end
				if changed then
					ml_settings_mgr:Save()
				end
			end
		end

		function API.CurrentTarget(check, useNil)
			local NotNil = General.NotNil
			local IsNil = General.IsNil
			local Type = General.Type

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
				if useNil then
					return nil
				else
					return false
				end
			end
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

		function General.Is(check, compare, altyes, altno)
			local NotNil = General.NotNil
			local Type = General.Type
			
			if NotNil(compare) then
				if check == compare then
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

		function General.Not(check, compare, altyes, altno)
			if check ~= compare then
				return altyes or true
			else
				return altno or false
			end
		end

		function General.Type(var, compare, altyes, altno)
			local NotNil = General.NotNil

			if NotNil(compare) then
				if type(var) == compare then
					return altyes or true
				else
					return altno or false
				end
			else
				return type(var)
			end
		end

		function General.Size(check, sign, value) -- Short version of table.size, but adds in the option to return only if it meets the requirements
			local Type = General.Type
			local Error = General.Error
			
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
			local Size = General.Size
			
			if Size(check) == 0 then
				return true
			else
				return false
			end
		end

		function General.NotEmpty(check)
			local Size = General.Size
			
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
				local IsNil = General.IsNil

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
		local sign = Math.Sign
		return floor(value / bracket + sign(value) * 0.5) * bracket
	end
	-- End Math Functions --

	-- Operating System (OS) Functions --
		function OS.PowerShell(cmd)
			io.popen([[powershell -Command "]]..cmd..[["]])
		end

		function OS.CreateFolder(path)
			io.popen([[MKDIR  "]]..path..[["]])
		end

		OS.DownloadQueue = {}
		OS.DownloadQueueBackup = {}
		OS.DownloadNextAttempt = {}
		OS.FinishedDownloads = {}
		function OS.Download(url,path,overwrite)
			local DownloadQueue = OS.DownloadQueue
			local DownloadQueueBackup = OS.DownloadQueueBackup
			local DownloadNextAttempt = OS.DownloadNextAttempt
			local FinishedDownloads = OS.FinishedDownloads
			local NotNil = General.NotNil
			local IsNil = General.IsNil
			local InsertIfNil = Table.InsertIfNil
			local Size = General.Size
			local PowerShell = OS.PowerShell
			local CreateFolder = OS.CreateFolder

			if type(url) == "string" then
				if not FileExists(path) or overwrite then
					if IsNil(DownloadNextAttempt[url]) or Now() > DownloadNextAttempt[url] then
						-- File does not exist, check to make sure the parent folder exists --
						local FolderPath = (path:match("(.*"..[[\]]..")")):sub(1,-2)
						if FolderExists(FolderPath) then
							d(url.." - "..path)
							-- Folder exists, just need to start the download --
							PowerShell([[(New-Object System.Net.WebClient).DownloadFile(']]..url..[[',']]..path..[[')]])
							-- InsertIfNil(DownloadQueue,url,path)
							DownloadQueue[url] = path
							DownloadNextAttempt[url] = nil
						else
							-- Folder does not exist, to prevent conflict, create parent folder first before downloading --
							if IsNil(DownloadNextAttempt[url]) then
								CreateFolder(FolderPath)
							end
							DownloadNextAttempt[url] = Now()+100
							DownloadQueueBackup[url] = path
						end
					end
					return true
				else
					-- File now exists, time for cleanup --
					InsertIfNil(FinishedDownloads,url,path)
					DownloadQueue[url] = nil
					DownloadNextAttempt[url] = nil
					DownloadQueueBackup[url] = nil
					return false
				end
			end
		end
	-- End Operating System (OS) Functions --

	-- String Functions --
	-- End String Functions --

	-- Table Functions --
		function Table.Valid(tbl) -- Short version of table.valid
			local Type = General.Type

			if Type(tbl, "table") then
				return table.valid(tbl)
			else
				return false
			end
		end

		function Table.InsertIfNil(tbl, key, value)
			local Type = General.Type
			local NotNil = General.NotNil
			local IsNil = General.IsNil
			local Not = General.Not

			if Type(tbl,"table") then
				if NotNil(value) then
					if IsNil(tbl[key]) then
						tbl[key] = value
					elseif Not(value, "") and Not(value, " ") then
						if tbl[key] ~= value then
							tbl[key] = value
						end
					end
				elseif table.find(tbl, key) == nil then
					-- key is now treated as value --
					-- Value does not exist in table, add it to table --
					tbl[#tbl + 1] = key
				end
			elseif NotNil(tbl) and IsNil(value) then
				-- We're now checking to see if we should update a variable instead --
				if tbl ~= key then tbl = key end
			end
		end

		function Table.RemoveIfNil(check, tbl, key)
			local IsNil = General.IsNil

			if IsNil(check) then
				tbl[key] = nil
			end
		end

		function Table.UpdateIfChanged(tbl, key, value)
			if tbl[key] ~= value then tbl[key] = value end
		end
	-- End Table Functions --

	-- GUI Functions --
		function Gui.WindowStyle(table)
			local ColorConv = Gui.ColorConv
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
			local NotNil = General.NotNil

			if NotNil(spacingX) then
				GUI:SameLine(posX, spacingX)
			else
				local x = posX or 0
				GUI:SameLine(0, posX)
			end
		end

		function Gui.Indent(spacing)
			local Type = General.Type

			if Type(spacing,"number") then
				GUI:PushStyleVar(GUI.StyleVar_IndentSpacing, spacing)
				GUI:Indent()
			else
				GUI:Indent()
			end
		end

		function Gui.Unindent(spacing)
			local Type = General.Type

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
			local NotNil = General.NotNil
			local SameLine = Gui.SameLine
			local ColorText = false

			local RGB = RGB
			local SameLineSpacing = SameLineSpacing
			local beforetext = beforetext

			if type(RGB) ~= "table" then
				SameLineSpacing = RGB
				beforetext = SameLineSpacing
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
			local NotNil = General.NotNil
			local Is = General.Is
			local Text = Gui.Text
			local Tooltip = Gui.Tooltip
			local Space = Gui.Space

			if reverse then
				c = Text(string)
				if tooltip ~= nil and GUI:IsItemHovered(c) then
					Tooltip(tooltip, 400)
				end
				Space()
				varname = GUI:Checkbox("##"..varstring, varname)
				if tooltip ~= nil and GUI:IsItemHovered(c) then
					Tooltip(tooltip, 400)
				end
			else
				varname = GUI:Checkbox("##"..varstring, varname)
				if tooltip ~= nil and GUI:IsItemHovered(c) then
					Tooltip(tooltip, 400)
				end
				Space()
				c = Text(string)
				if tooltip ~= nil and GUI:IsItemHovered(c) then
					Tooltip(tooltip, 400)
				end
			end
			return varname
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
			local Text = Gui.Text

			length = length or 400
			GUI:BeginTooltip()
			GUI:PushTextWrapPos(length)
			Text(string)
			GUI:PopTextWrapPos()
			GUI:EndTooltip()
		end

		function Gui.GetRemaining(which)
			local NotNil = General.NotNil
			local Is = General.Is

			if NotNil(which) then
				local x, y = GUI:GetContentRegionAvail()
				return Is(which, "x", x, y)
			else
				return GUI:GetContentRegionAvail()
			end
		end
	-- End GUI Functions --
-- End Core Functions & Helper Functions --
