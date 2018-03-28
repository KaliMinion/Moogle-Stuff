AnimaTracker = {
	Initiated = false,
	LastCheck = 0,
	TimeStamp = 0,
	Current = 0,
	Density = {
		["Vague"] = 8,
		["Meagre"] = 16,
		["Vigorous"] = 24,
		["Robust"] = 32,
		["Sturdy"] = 64,
		["Hardened"] = 96,
		["Stalwart"] = 128,
	},
}

function AnimaTracker.CheckGlass(close)
	local MainID = Inventory:Get(1000):GetItem(0).id

	if MainID > 15236 and MainID < 15251 then
		if not IsControlOpen("Relic2Glass") then
			if TimeSince(AnimaTracker.LastCheck) > 1000 then
				GetItem(2002029):Cast()
				AnimaTracker.LastCheck = Now()
			end
		else
			local data = GetControl("Relic2Glass"):GetRawData()
			if data and data[2] then
				local tbl = data[2].value
				if table.size(tbl) == 4 then
					local progress, c = 0, 0
					for k, v in table.pairsbykeys(tbl) do
						if v < 0 then v = 128 + math.abs(v) end
						progress = progress + (v * math.pow(256, c))
						c = c + 1
					end
					if close then GetItem(2002029):Cast() end
					return progress
				end
			end
		end
	end
end

function AnimaTracker.OnUpdate()
	if (MGetGameState() == FFXIV.GAMESTATE.INGAME) then
		if AnimaTracker.Initiated then
			if TimeSince(AnimaTracker.LastCheck) > 5000 then
				for k, v in pairs(GetChatLines()) do
					if v.timestamp > AnimaTracker.TimeStamp then
						AnimaTracker.TimeStamp = v.timestamp
						if v.code == 57 then
							local line = v.line
							for k, v in pairs(AnimaTracker.Density) do
								if line:lower():match(k:lower()) then
									AnimaTracker.Current = AnimaTracker.Current + v
--									d("Current Progress: " .. AnimaTracker.Current .. " (" .. tostring((AnimaTracker.Current / 2000) * 100) .. "%%)")
								end
							end
						end
					end
				end
				AnimaTracker.LastCheck = Now()
			end
			if IsControlOpen("Relic2Glass") then
				local result = AnimaTracker.CheckGlass()
				if result then
					AnimaTracker.Current = result
--					d("Current Progress: " .. result .. " (" .. tostring((result / 2000) * 100) .. "%%)")
				end
			end
		else
			local result = AnimaTracker.CheckGlass(true)
			if result then
				AnimaTracker.Current = result
				for k, v in pairs(GetChatLines()) do if v.timestamp > AnimaTracker.TimeStamp then AnimaTracker.TimeStamp = v.timestamp end end
--				d("Current Progress: " .. result .. " (" .. tostring((result / 2000) * 100) .. "%%)")
				AnimaTracker.Initiated = true
			end
		end
	end
end

function AnimaTracker.Draw()
	if (MGetGameState() == FFXIV.GAMESTATE.INGAME) then
		GUI:Begin("##AnimaTracker",true,GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_NoCollapse + GUI.WindowFlags_AlwaysAutoResize)
--			GUI:SetWindowSize(270,45)
			local function sign(v)
				return (v >= 0 and 1) or -1
			end
			local function round(v, bracket)
				bracket = bracket or 1
				return math.floor(v/bracket + sign(v) * 0.5) * bracket
			end

			local percent = round((AnimaTracker.Current / 2000) * 100,0.01)
			GUI:PushStyleVar(GUI.StyleVar_FrameRounding,10)
			GUI:PushStyleColor(GUI.Col_Text,0,0,0,1)
			GUI:ProgressBar(AnimaTracker.Current / 2000,250,25,AnimaTracker.Current..[[/2000 (]]..percent..[[%)]])
			GUI:PopStyleColor()
			GUI:PopStyleVar()
		GUI:End()
	end
end

RegisterEventHandler("Gameloop.Update", AnimaTracker.OnUpdate)
RegisterEventHandler("Gameloop.Draw", AnimaTracker.Draw)
