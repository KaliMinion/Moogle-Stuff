MoogleFunctions = {}

MoogleFunctions.Settings = {
	enable = false
}

-- Start Minion Helper Functions --
	function d2(variable,string,DebugTraceback)
		ml_gui.showconsole = true
		local str = ""
		if NotNil(DebugTraceback) then
			str = "%["..DebugTraceback.."%] "
		end
		d(str..string..": "..tostring(variable))
	end

	MoogleFunctions.DownloadQueue = {}
	local LastTry = 0
	MoogleFunctions.FinishedDownloads = {}
	function Download(url,path)
		if not In(url,""," ",nil) then
			if not FileExists(path) then
				d("url: "..url.." path: "..path)
				if IsNil(table.find(MoogleFunctions.DownloadQueue,url)) or TimeSince(LastTry) > 1000 then
					io.popen([[powershell -Command "(New-Object System.Net.WebClient).DownloadFile(']]..url..[[',']]..path..[[')]])
					MoogleFunctions.DownloadQueue[url] = path
					LastTry = Now()
				end
			else
				MoogleFunctions.FinishedDownloads[url] = path
				if NotNil(table.find(MoogleFunctions.DownloadQueue,url)) then
					for k,v in pairs(MoogleFunctions.DownloadQueue) do
						if k == url then
							MoogleFunctions.DownloadQueue[k] = nil
						end
					end
				end
			end
		end
	end

	function SaveVar(check,var)
	end

	function Error(string)
		ml_error(string)
	end

	function Valid(tbl) -- Short version of table.valid
		if Type(tbl,"table") then
			return table.valid(tbl)
		else
			return false
		end
	end

	function Type(var,compare,altyes,altno)
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

	function Is(check,compare,altyes,altno)
		if NotNil(compare) then
			if check == compare then
				return altyes or true
			else
				return altno or false
			end
		else
			if Type(check,"boolean") then
				return check
			else
				return false
			end
		end
	end

	function Not(check,compare,altyes,altno)
		if check ~= compare then
			return altyes or true
		else
			return altno or false
		end
	end

	function IsNil(check,alt,original)
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

	function NotNil(check,alt)
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

	function Empty(tbl)
		if Type(tbl,"table") then
			if Size(tbl) == 0 then
				return true
			else
				return false
			end
		else
			return false
		end
	end

	function InsertIfNil(tbl,key,value)
		if type(tbl) == "table" then
			if NotNil(tbl) then
				if NotNil(value) then
					if IsNil(tbl[key]) then
						tbl[key] = value
					elseif Not(value,"") and Not(value," ") then
						if tbl[key] ~= value then
							tbl[key] = value
						end
					end
				elseif table.find(tbl,key) == nil then
					-- key is now treated as value --
					-- Value does not exist in table, add it to table --
					tbl[#tbl+1] = key
				end
			end
		elseif NotNil(tbl) and IsNil(value) then
			-- We're now checking to see if we should update a variable instead --
			if tbl ~= key then tbl = key end
		end
	end

	function RemoveIfNil(valuesource,tbl,key)
		if IsNil(valuesource) then
			tbl[key] = nil
		end
	end

	function UpdateIfChanged(tbl,key,value)
		if tbl[key] ~= value then tbl[key] = value end
	end

	function Size(tbl,sign,value) -- Short version of table.size, but adds in the option to return only if it meets the requirements
		if sign == nil then
			local t = type(tbl)
			if t == "table" then
				local count = 0
				for _ in pairs(tbl) do count = count + 1 end
				return count
			elseif t == "string" then
				return #tbl
			elseif t == "number" then
				local str = tostring(tbl)
				return string.len(str:gsub("%.",""))
			else
				Error("Tried to find the size of a value that's not a Table, String, or Number, but was "..type(tbl))
			end
		else
			value = value
			if type(value) == "table" then -- if value is a table, then we are comparing the sizes of two tables
				value = #value
			end
			if sign == "==" then
				if #tbl == value then
					return true
				else
					return false
				end
			elseif sign == "~=" then
				if #tbl ~= value then
					return true
				else
					return false
				end
			elseif sign == ">" then
				if #tbl > value then
					return true
				else
					return false
				end
			elseif sign == "<" then
				if #tbl < value then
					return true
				else
					return false
				end
			elseif sign == ">=" then
				if #tbl >= value then
					return true
				else
					return false
				end
			elseif sign == "<=" then
				if #tbl <= value then
					return true
				else
					return false
				end
			end
		end
	end

	function Dist2D(table1,table2,bracket) -- Requires EntityList's Entity Table
		if Valid(table1) and Valid(table2) then
			local pos1 = table1.pos
			local pos2 = table2.pos
			d("pos1: "..tostring(Valid(pos1)).." size: "..Size(pos1).." type: "..type(pos1))
			d("pos2: "..tostring(Valid(pos2)).." size: "..Size(pos2).." type: "..type(pos2))
			if (Valid(pos1) and Size(pos1) == 4) and (Valid(pos2) and Size(pos2) == 4) then
				local sqrt = math.sqrt
				local pow = math.pow
				local round = math.round
				local distance = sqrt(pow((pos2.x - pos1.x),2)+pow((pos2.z - pos1.z),2))
				if bracket == nil then
					return distance - (table1.hitradius + table2.hitradius)
				else
					return round(distance - (table1.hitradius + table2.hitradius),bracket)
				end
			else
				if not Valid(pos1) then
					Error("Table 1 is not a valid table.")
				elseif Size(pos1) ~= 4 then
					Error("Table 1 is not a position table")
				end
				if not Valid(pos2) then
					Error("Table 2 is not a valid table")
				elseif Size(pos2) ~= 4 then
					Error("Table 2 is not a position table")
				end
			end
		else
			local table1 = table1
			local table2 = table2
			local errors = false
			if not Valid(table1) then
				if type(table1) == "number" then
					table1 = EntityList:Get(table1)
				else
					errors = true
					Error("Table 1 is a "..type(table1))
				end
			end
			if not Valid(table2) then
				if type(table2) == "number" then
					table1 = EntityList:Get(table1)
				else
					errors = true
					Error("Table 2 is a "..type(table2))
				end
			end
			if errors == false then
				Distance2D(table1,table2)
			end
		end
	end

	function Dist3D(table1,table2,bracket) -- Requires EntityList's Entity Table
		if Valid(table1) and Valid(table2) then
			local pos1 = table1.pos
			local pos2 = table2.pos
			if (Valid(pos1) and Size(pos1) == 4) and (Valid(pos2) and Size(pos2) == 4) then
				local sqrt = math.sqrt
				local pow = math.pow
				local round = math.round
				local distance = sqrt(pow((pos2.x - pos1.x),2)+pow((pos2.z - pos1.z),2)+pow((pos2.y - pos1.y),2))
				if bracket == nil then
					return distance - (table1.hitradius + table2.hitradius)
				else
					return round(distance - (table1.hitradius + table2.hitradius),bracket)
				end
			else
				if not Valid(pos1) then
					Error("Table 1 is not a valid table.")
				elseif Size(pos1) ~= 4 then
					Error("Table 1 is not a position table")
				end
				if not Valid(pos2) then
					Error("Table 2 is not a valid table")
				elseif Size(pos2) ~= 4 then
					Error("Table 2 is not a position table")
				end
			end
		else
			local table1 = table1
			local table2 = table2
			local errors = false
			if not Valid(table1) then
				if type(table1) == "number" then
					table1 = EntityList:Get(table1)
				else
					errors = true
					Error("Table 1 is a "..type(table1))
				end
			end
			if not Valid(table2) then
				if type(table2) == "number" then
					table1 = EntityList:Get(table1)
				else
					errors = true
					Error("Table 2 is a "..type(table2))
				end
			end
			if errors == false then
				Distance2D(table1,table2)
			end
		end
	end

	function CurrentTarget(check,useNil)
		local target = Player:GetTarget()
		if target ~= nil then
			if check == nil then
				return true
			elseif check == "table" then
				return target
			elseif check == "Distance2D" then
				return Distance2D(Player,target)
			elseif check == "Distance3D" then
				return Distance3D(Player,target)
			else
				return target[check]
			end
		else
			if useNil then
				return nil
			else
				return false
			end
		end
	end

	function EntityCheck(EntityID,check,useNil)
		local entity = EntityList:Get(EntityID)
		if entity ~= nil then
			if check == nil then
				return true
			elseif check == "table" then
				return entity
			elseif check == "Distance2D" then
				return Distance2D(Player,entity)
			elseif check == "Distance3D" then
				return Distance3D(Player,entity)
			else
				return entity[check]
			end
		else
			if useNil then
				return nil
			else
				return false
			end
		end
	end

	function GetActions(ActionID,check,target)
		local GetAction = SkillMgr.GetAction

		if type(ActionID) == "number" then
			ActionID = GetAction(ActionID)
		end

		if table.valid(ActionID) then
			if check == nil then
				return true
			elseif check == "cast" then
				if target == nil then
					return ActionID:Cast()
				else
					return ActionID:Cast(target)
				end
			elseif check == "table" then
				return ActionID
			else
				return ActionID[check]
			end
		else
			return nil
		end
	end

	function ActionCheck(Action,Stat)
		local GetAction = SkillMgr.GetAction
		local precast = 0.25
		if GetActions(Action) and CD(Action) < precast then
			if Stat == "tp" or "TP" then
				if GetActions(Action,"cost") <= Player.tp then
					return true
				else
					return false
				end
			elseif Stat == "mp" or "MP" then
				if GetActions(Action,"cost") <= Player.mp.current then
					return true
				else
					return false
				end
			elseif Stat == "gp" or "GP" then
				if GetActions(Action,"cost") <= Player.gp.current then
					return true
				else
					return false
				end
			elseif Stat == "cp" or "CP" then
				if GetActions(Action,"cost") <= Player.cp.current then
					return true
				else
					return false
				end
			end
		else
			return false
		end
	end

	function CD(ActionID)
		return GetActions(ActionID,"cdmax") - GetActions(ActionID,"cd")
	end

	function BattleState()
		local delay = 700
		local precast = 250
		local GCDcd = GetActions(97,"cd")
		-- Determine the Player's current battle state --
		if Player.incombat then
			-- Player is in combat, determine the GCD/oGCD state --
			if CD(97) < precast then
				return "GCD"
			elseif GCDcd < delay then
				return "oGCD1"
			elseif GCDcd < (delay * 2) then
				return "oGCD2"
			elseif GCDcd < (delay * 3) then
				return "oGCD3"
			end
		else
			if CurrentTarget("incombat") or CurrentTarget("aggro") then
				return "Target In Combat"
			else
				return "OOC"
			end
		end
	end

	local MoveStart = 0
	function MovementState()
		if Player:IsMoving() then
			if MoveStart == 0 then MoveStart = Now() end
			return true
		else
			if MoveStart ~= 0 then MoveStart = 0 end
			return false
		end
	end

	local OOCTime = 0
	function OOCTime()
		if Player.incombat then
			if OOCTime ~= 0 then OOCTime = 0 end
		else
			if OOCTime == 0 then OOCTime = Now() end
		end
	end
-- End Minion Helper Functions --

PingIP = ""
out = ""
status = "stop"
lastupdate = 0
-- Start Windows Functions --
	function Ping(ip)
		-- local pipe = io.popen("ping "..ip)
		-- for line in pipe:lines() do
		-- 	d(line)
		-- end
		-- pipe:close()
		
		local pipe
		if status == "stop" then
			pipe = io.popen("ping "..ip)
			status = "start"
		end
		if pipe then
			out = pipe:read(1)
				d(out)
			if not out then
				if lastupdate == 0 then lastupdate = Now() end
				if TimeSince(lastupdate) > 5000 then
					pipe:close()
					pipe = nil
					status = "stop"
					lastupdate = 0
					out = ""
					PingIP = ""
				else
					Ping(PingIP)
				end
			end
		end


		-- local fp = io.popen("ping 204.2.229.99");
		-- ml_global_information.AwaitThen(3000, function()
		-- 	str = fp:read("*a");
		-- 	fp:close();
		-- 	for s in str:gmatch("[^\r\n]+") do
		-- 		d(s)
		-- 	end
		-- end)
	end
-- End Windows Functions --

-- Start Math Functions --
	function math.sign(value)
		return (value >= 0 and 1) or -1
	end
	function math.round(value, bracket)
		bracket = bracket or 1
		local floor = math.floor
		local sign = math.sign
		return floor(value/bracket + sign(value) * 0.5) * bracket
	end
-- End Math Functions --

-- Start GUI Functions --
	function WindowStyle(table)
		if PingIP ~= "" then
			Ping(PingIP)
		end

		local counter = 0
		if table["Text"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["Text"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_Text, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["TextDisabled"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["TextDisabled"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_TextDisabled, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["WindowBG"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["WindowBG"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_WindowBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ChildWindowBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ChildWindowBg"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ChildWindowBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["Border"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["Border"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_Border, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["BorderShadow"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["BorderShadow"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_BorderShadow, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["FrameBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["FrameBg"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_FrameBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["FrameBgHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["FrameBgHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_FrameBgHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["FrameBgActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["FrameBgActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_FrameBgActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["TitleBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["TitleBg"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_TitleBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["TitleBgCollapsed"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["TitleBgCollapsed"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_TitleBgCollapsed, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["TitleBgActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["TitleBgActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_TitleBgActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["MenuBarBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["MenuBarBg"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_MenuBarBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ScrollbarBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ScrollbarBg"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ScrollbarBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ScrollbarGrab"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ScrollbarGrab"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ScrollbarGrab, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ScrollbarGrabHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ScrollbarGrabHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ScrollbarGrabHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ScrollbarGrabActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ScrollbarGrabActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ScrollbarGrabActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ComboBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ComboBg"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ComboBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["CheckMark"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["CheckMark"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_CheckMark, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["SliderGrab"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["SliderGrab"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_SliderGrab, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["SliderGrabActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["SliderGrabActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_SliderGrabActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["Button"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["Button"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_Button, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ButtonHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ButtonHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ButtonHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ButtonActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ButtonActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ButtonActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["Header"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["Header"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_Header, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["HeaderHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["HeaderHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_HeaderHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["HeaderActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["HeaderActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_HeaderActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["Column"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["Column"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_Column, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ColumnHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ColumnHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ColumnHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ColumnActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ColumnActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ColumnActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ResizeGrip"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ResizeGrip"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ResizeGrip, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ResizeGripHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ResizeGripHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ResizeGripHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ResizeGripActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ResizeGripActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ResizeGripActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["CloseButton"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["CloseButton"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_CloseButton, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["CloseButtonHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["CloseButtonHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_CloseButtonHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["CloseButtonActive"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["CloseButtonActive"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_CloseButtonActive, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["PlotLines"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["PlotLines"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_PlotLines, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["PlotLinesHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["PlotLinesHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_PlotLinesHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["PlotHistogram"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["PlotHistogram"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_PlotHistogram, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["PlotHistogramHovered"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["PlotHistogramHovered"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_PlotHistogramHovered, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["TextSelectedBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["TextSelectedBg"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_TextSelectedBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["TooltipBg"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["TooltipBg"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_TooltipBg, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		if table["ModalWindowDarkening"][4] ~= 0 then
			counter = counter + 1
			local tbl = ColorConv(table["ModalWindowDarkening"],"sRBG","Linear")
			GUI:PushStyleColor(GUI.Col_ModalWindowDarkening, tbl[1], tbl[2], tbl[3], tbl[4])
		end
		return counter
	end

	function WindowStyleClose(count)
		GUI:PopStyleColor(count)
	end

	function ColorConv(tbl,from,to)
		if tbl[4] == nil then tbl[4] = 1 end
		if from == "sRBG" or "RBG" or "rbg" then
			if to == "Linear" or "linear" or "LinearRBG" then
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
	end

	function SameLine(posX,spacingX)
		if NotNil(spacingX) then
			GUI:SameLine(posX,spacingX)
		elseif NotNil(posX) then
			GUI:SameLine(0,spacingX)
		else
			GUI:SameLine(0,0)
		end
	end

	function Indent(spacing)
		if type(spacing) == "number" then
			GUI:PushStyleVar(GUI.StyleVar_IndentSpacing,spacing)
			GUI:Indent()
		else
			GUI:Indent()
		end
	end

	function Unindent(spacing)
		if type(spacing) == "number" then
			GUI:Unindent()
			GUI:PopStyleVar()
		else
			GUI:Unindent()
		end
	end

	function Space(spacing)
		GUI:SameLine(0,spacing)
		--
	end

	function Text(string,SameLineSpacing,beforetext)
		if NotNil(SameLineSpacing) then
			if beforetext then
				SameLine(SameLineSpacing)
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(string)
			else
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(string)
				SameLine(SameLineSpacing)
			end
		else
			GUI:AlignFirstTextHeightToWidgets()
			GUI:Text(string)
		end
	end
	-- GUIVarUpdate (function) = \...currentProfile...name...IsNull..._G...type...table...Settings...[ACR]: Profile requires a valid profile.GUI table with a name entry to use the settings save feature...

	-- 	 D = "\x1bLuaQ\x00\x01\x04\b\x04\b\x00G\x00\x00\x00\x00\x00\x00\x00E:\\MINIONAPP\\Bots\\FFXIVMinion64\\LuaMods\\/ffxivminion/ffxiv_helpers.lua\x00\xad\x13\x00\x00\xb7\x13\x00\x00\x00\x02\x00\x03\v\x00\x00\x00\x18\x00@\x00\x0f\x80\x01\x80\x18\x00\xc0\x00\x0f\x80\x00\x80\x84\x00\x80\x00\x9f\x00\x00\x01\x0f\x80\x00\x80_\x00\x00\x01\x0f\x00\x00\x80\x1f\x00\x00\x01\x1f\x00\x80\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\v\x00\x00\x00\xae\x13\x00\x00\xae\x13\x00\x00\xaf\x13\x00\x00\xaf\x13\x00\x00\xb0\x13\x00\x00\xb0\x13\x00\x00\xb0\x13\x00\x00\xb2\x13\x00\x00\xb3\x13\x00\x00\xb5\x13\x00\x00\xb7\x13\x00\x00\x02\x00\x00\x00\b\x00\x00\x00\x00\x00\x00\x00variant\x00\x00\x00\x00\x00\n\x00\x00\x00\b\x00\x00\x00\x00\x00\x00\x00default\x00\x00\x00\x00\x00\n\x00\x00\x00\x00\x00\x00\x00"

	function Checkbox(string,varname,varstring,reverse,tooltip,savetype)
		if NotNil(savetype) then
			if Is(savetype,"ACR") then
				if reverse then
					GUI:AlignFirstTextHeightToWidgets(); c = GUI:Text(string);
					if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip,400) end end
					GUI:SameLine(0,5) c = ACR.GUIVarUpdate(GUI:Checkbox("##"..varstring,varname),varstring)
					if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip,400) end end
				else
					c = ACR.GUIVarUpdate(GUI:Checkbox("##"..varstring,varname),varstring)
					if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip,400) end end
					GUI:SameLine(0,5) c = GUI:Text(string)
					if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip,400) end end
				-- else
				-- 	c = ACR.GUIVarUpdate(GUI:Checkbox(string,varname),varstring)
				-- 	if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip,400) end end
				end
			else
				-- Save to user file --
			end
		else
			-- Normal Checkbox that doesn't save to user file --
		end
	end

	function SliderInt(string,varname,varstring,min,max,width,reverse,tooltip)
		if reverse then
			GUI:AlignFirstTextHeightToWidgets(); c = GUI:Text(string);
			if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
			GUI:SameLine(0,5) GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderInt("##"..varstring,varname,min,max),varstring) GUI:PopItemWidth()
			if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		else
			GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderInt("##"..varstring,varname,min,max),varstring)
		if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
			GUI:PopItemWidth() c = GUI:SameLine(0,5)
			GUI:SameLine(0,5) c = GUI:Text(string)
			if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- else
		-- 	GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderInt(string,varname,min,max),varstring) GUI:PopItemWidth()
		-- 	if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		end
	end

	function SliderFloat(string,varname,varstring,min,max,float,width,reverse,tooltip)
		if reverse then
			GUI:AlignFirstTextHeightToWidgets(); c = GUI:Text(string); GUI:SameLine(0,5);
		if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
			GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderFloat("##"..varstring,varname,min,max,"%."..float.."f"),varstring) GUI:PopItemWidth()
			if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		else
			GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderFloat("##"..varstring,varname,min,max,"%."..float.."f"),varstring)
		if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
			GUI:PopItemWidth() GUI:SameLine(0,5) c = GUI:Text(string)
			if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		-- else
		-- 	GUI:PushItemWidth(width) c = ACR.GUIVarUpdate(GUI:SliderFloat(string,varname,min,max,"%."..float.."f"),varstring) GUI:PopItemWidth()
		-- 	if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip.."\n\nHold CTRL+Left Click to edit manually.") end end
		end
	end

	function Combo(maintable,value,varstring,tooltip)
		local pos = 1
		local t = {}
		local t2 = {}
		local size = 0
		for k,v in table.pairsbykeys(maintable) do
			t[k] = pos
			t2[pos] = k
			if GUI:CalcTextSize(k) > size then size = GUI:CalcTextSize(k) end
			pos = pos + 1
		end
		GUI:PushItemWidth(size+28)
		c = ACR.GUIVarUpdate(t2[GUI:Combo("##test",t[value],t2,table.size(t2))],varstring)
		if tooltip ~= nil then if GUI:IsItemHovered(c) then Tooltip(tooltip,400) end end
		GUI:PopItemWidth()
	end

	function Tooltip(string,length)
		length = length or 400
		GUI:BeginTooltip()
		GUI:PushTextWrapPos(length)
		Text(string)
		GUI:PopTextWrapPos()
		GUI:EndTooltip()
	end

	function GetRemaining(which)
		if NotNil(which) then
			local x,y = GUI:GetContentRegionAvail()
			return Is(which,"x",x,y)
		else
			return GUI:GetContentRegionAvail()
		end
	end
-- End GUI Functions --
