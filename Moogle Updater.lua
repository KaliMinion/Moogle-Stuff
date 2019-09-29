local MoogleUpdater = {}
local self = MoogleUpdater
local selfs = "MoogleUpdater"

self.Info = {
	Creator = "Kali",
	Version = "1.4.0",
	StartDate = "12/09/17",
	ReleaseDate = "12/09/17",
	URL = "https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/Moogle%20Updater.lua",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Updated for MoogleLib",
		["1.1.1"] = "Tweaks",
		["1.1.2"] = "Adjusted Layout",
		["1.1.5"] = "Added Auto Download and Auto Reload",
		["1.1.6"] = "Download Fixes",
		["1.1.7"] = "URL Fixes",
		["1.1.8"] = "Core Category Renamed",
		["1.2.1"] = "Now outputs Windows and PowerShell version to System Info.txt",
		["1.2.2"] = "Removed auto reload when checking for missing core files.",
		["1.2.9"] = "Download Fixes...",
		["1.3.1"] = "Added Save Settings",
		["1.3.2"] = "Made settings visible to users"
	}
}

self.GUI = {
	WindowName = "MoogleUpdater##MoogleUpdater",
	name = "Moogle Script Management",
	NavName = "Moogle Script Management",
	MiniName = "Moogle Manager",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = "..selfs..".GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "Module HUB for updating and downloading Moogle Scripts."
}

self.Settings = {
	enable = true,
	CheckInterval = 60, -- in the unit of time the user has selected
	CheckUnit = "Seconds",
	LastCheck = 0,
	Notifications = true, -- if False, then toaster notifications will be disabled
	ToasterTime = 5, -- if set to zero, toaster popups never disappear until clicked on or updating the script

	Beta = false,
	DrawReady = false
}
local settings = self.Settings
local CheckInterval, CheckUnit, LastCheck, Notifications, ToasterTime, Beta, DrawReady =
settings.CheckInterval, settings.CheckUnit, settings.LastCheck, settings.Notifications, settings.ToasterTime, settings.Beta, settings.DrawReady

self.Data = {
	MoogleScripts = {},
	MoogleVersions = {},
	MoogleLastPushes = {},
	NewScripts = {},
	NewLabelScripts = {},
	UpdatedScripts = {},
	UpdatedScriptsReady = {},
	UpdatedLabelScripts = {},
	NeedWebRequest = true,
	NeedWebContent = true,

	TimeUnits = { "Seconds", "Minutes", "Hours", "Days", "Weeks", "Months" },
	InstalledModules = {},
	DownloadOneTimers = {},
	PendingDeletion = {},
	AdjustChildren = {},
	NeedImages = true,
	FinishedUpdating = true,
	FinishedImages = {},

	webpage = {},
	lastresult = nil,
	timevalue = 0,
	FirstRun = false,
	docheck = true,
	CheckVer = false,
	loaded = false,
}
local data = self.Data
local MoogleScripts, MoogleVersions, MoogleLastPushes, NewScripts, NewLabelScripts, UpdatedScripts, UpdatedScriptsReady, UpdatedLabelScripts, NeedWebRequest, NeedWebContent, TimeUnits, InstalledModules, DownloadOneTimers, PendingDeletion, AdjustChildren, NeedImages, FinishedUpdating, FinishedImages, webpage, lastresult, timevalue, FirstRun, docheck, CheckVer, loaded =
data.MoogleScripts, data.MoogleVersions, data.MoogleLastPushes, data.NewScripts, data.NewLabelScripts, data.UpdatedScripts, data.UpdatedScriptsReady, data.UpdatedLabelScripts, data.NeedWebRequest, data.NeedWebContent, data.TimeUnits, data.InstalledModules, data.DownloadOneTimers, data.PendingDeletion, data.AdjustChildren, data.NeedImages, data.FinishedUpdating, data.FinishedImages, data.webpage, data.lastresult, data.timevalue, data.FirstRun, data.docheck, data.CheckVer, data.loaded

local function UpdateSettingLocals(setlocals)
	if setlocals == nil then
		if settings.CheckInterval ~= CheckInterval then settings.CheckInterval = CheckInterval end
		if settings.CheckUnit ~= CheckUnit then settings.CheckUnit = CheckUnit end
		if settings.LastCheck ~= LastCheck then settings.LastCheck = LastCheck end
		if settings.Notifications ~= Notifications then settings.Notifications = Notifications end
		if settings.ToasterTime ~= ToasterTime then settings.ToasterTime = ToasterTime end
		if settings.Beta ~= Beta then settings.Beta = Beta end
		--	if settings.DrawReady ~= DrawReady then settings.DrawReady = DrawReady end
	else
		if CheckInterval ~= settings.CheckInterval then CheckInterval = settings.CheckInterval end
		if CheckUnit ~= settings.CheckUnit then CheckUnit = settings.CheckUnit end
		if LastCheck ~= settings.LastCheck then LastCheck = settings.LastCheck end
		if Notifications ~= settings.Notifications then Notifications = settings.Notifications end
		if ToasterTime ~= settings.ToasterTime then ToasterTime = settings.ToasterTime end
		if Beta ~= settings.Beta then Beta = settings.Beta end
		--	if DrawReady ~= settings.DrawReady then DrawReady = settings.DrawReady end
	end
end
local function UpdateDataLocals(setlocals)
	if setlocals == nil then
		if data.MoogleScripts ~= MoogleScripts then data.MoogleScripts = MoogleScripts end
		if data.MoogleVersions ~= MoogleVersions then data.MoogleVersions = MoogleVersions end
		if data.MoogleLastPushes ~= MoogleLastPushes then data.MoogleLastPushes = MoogleLastPushes end
		--	if data.NewScripts ~= NewScripts then data.NewScripts = NewScripts end
		--	if data.NewLabelScripts ~= NewLabelScripts then data.NewLabelScripts = NewLabelScripts end
		--	if data.UpdatedScripts ~= UpdatedScripts then data.UpdatedScripts = UpdatedScripts end
		--	if data.UpdatedScriptsReady ~= UpdatedScriptsReady then data.UpdatedScriptsReady = UpdatedScriptsReady end
		--	if data.UpdatedLabelScripts ~= UpdatedLabelScripts then data.UpdatedLabelScripts = UpdatedLabelScripts end
		--	if data.NeedWebRequest ~= NeedWebRequest then data.NeedWebRequest = NeedWebRequest end
		--	if data.NeedWebContent ~= NeedWebContent then data.NeedWebContent = NeedWebContent end
		if data.TimeUnits ~= TimeUnits then data.TimeUnits = TimeUnits end
		--	if data.InstalledModules ~= InstalledModules then data.InstalledModules = InstalledModules end
		--	if data.DownloadOneTimers ~= DownloadOneTimers then data.DownloadOneTimers = DownloadOneTimers end
		--	if data.PendingDeletion ~= PendingDeletion then data.PendingDeletion = PendingDeletion end
		--	if data.AdjustChildren ~= AdjustChildren then data.AdjustChildren = AdjustChildren end
		--	if data.NeedImages ~= NeedImages then data.NeedImages = NeedImages end
		--	if data.FinishedUpdating ~= FinishedUpdating then data.FinishedUpdating = FinishedUpdating end
		--	if data.FinishedImages ~= FinishedImages then data.FinishedImages = FinishedImages end
		if data.webpage ~= webpage then data.webpage = webpage end
		if data.lastresult ~= lastresult then data.lastresult = lastresult end
		if data.timevalue ~= timevalue then data.timevalue = timevalue end
		--	if data.FirstRun ~= FirstRun then data.FirstRun = FirstRun end
		--	if data.docheck ~= docheck then data.docheck = docheck end
		if data.CheckVer ~= CheckVer then data.CheckVer = CheckVer end
		if data.loaded ~= loaded then data.loaded = loaded end
	else
		if MoogleScripts ~= data.MoogleScripts then MoogleScripts = data.MoogleScripts end
		if MoogleVersions ~= data.MoogleVersions then MoogleVersions = data.MoogleVersions end
		if MoogleLastPushes ~= data.MoogleLastPushes then MoogleLastPushes = data.MoogleLastPushes end
		--	if NewScripts ~= data.NewScripts then NewScripts = data.NewScripts end
		--	if NewLabelScripts ~= data.NewLabelScripts then NewLabelScripts = data.NewLabelScripts end
		--	if UpdatedScripts ~= data.UpdatedScripts then UpdatedScripts = data.UpdatedScripts end
		--	if UpdatedScriptsReady ~= data.UpdatedScriptsReady then UpdatedScriptsReady = data.UpdatedScriptsReady end
		--	if UpdatedLabelScripts ~= data.UpdatedLabelScripts then UpdatedLabelScripts = data.UpdatedLabelScripts end
		--	if NeedWebRequest ~= data.NeedWebRequest then NeedWebRequest = data.NeedWebRequest end
		--	if NeedWebContent ~= data.NeedWebContent then NeedWebContent = data.NeedWebContent end
		if TimeUnits ~= data.TimeUnits then TimeUnits = data.TimeUnits end
		--	if InstalledModules ~= data.InstalledModules then InstalledModules = data.InstalledModules end
		--	if DownloadOneTimers ~= data.DownloadOneTimers then DownloadOneTimers = data.DownloadOneTimers end
		--	if PendingDeletion ~= data.PendingDeletion then PendingDeletion = data.PendingDeletion end
		--	if AdjustChildren ~= data.AdjustChildren then AdjustChildren = data.AdjustChildren end
		--	if NeedImages ~= data.NeedImages then NeedImages = data.NeedImages end
		--	if FinishedUpdating ~= data.FinishedUpdating then FinishedUpdating = data.FinishedUpdating end
		--	if FinishedImages ~= data.FinishedImages then FinishedImages = data.FinishedImages end
		if webpage ~= data.webpage then webpage = data.webpage end
		if lastresult ~= data.lastresult then lastresult = data.lastresult end
		if timevalue ~= data.timevalue then timevalue = data.timevalue end
		--	if FirstRun ~= data.FirstRun then FirstRun = data.FirstRun end
		--	if docheck ~= data.docheck then docheck = data.docheck end
		if CheckVer ~= data.CheckVer then CheckVer = data.CheckVer end
		if loaded ~= data.loaded then loaded = data.loaded end
	end
end
local trash

function self.Init()
	io.popen([[powershell -Command "$PSVer = 'PowerShell Version: ' + $PSVersionTable.PSVersion.Major + '.' + $PSVersionTable.PSVersion.Minor; $WinVer = 'Windows Version: ' + (Get-WmiObject -class Win32_OperatingSystem).Caption + ' ' + (Get-CimInstance Win32_OperatingSystem).OSArchitecture; $PackVer = 'Service Pack Version: ' + (Get-CimInstance Win32_OperatingSystem).ServicePackMajorVersion + '.' + (Get-CimInstance Win32_OperatingSystem).ServicePackMinorVersion ; $OSVer = 'OS Version: ' + (Get-CimInstance Win32_OperatingSystem).Version ; ($PSVer, $WinVer, $PackVer, $OSVer) | Out-File -filepath ']] .. LuaPath .. [[MoogleStuff Files\System Info.txt'"]])
end

local CurrentVersions, CurrentLastPushes = {}, {}
function self.OnUpdate()
	--	UpdateSettingLocals() UpdateDataLocals()
	if FinishedLoading then -- Initiate Locals --
		if loaded then -- Load User Saved Settings --
			if CheckVer then -- Do a version check --
				--[[
								local update, tbl = VersionCheck(selfs, self.Info.URL)
								if update == true then
									FileWrite(MooglePath .. "Moogle Updater.lua", tbl)
									loadstring(tbl)()
									CheckVer = false
								elseif update == false then
									CheckVer = false
								end
				]]
			else -- We are running the current version, time for logic --
				local main = KaliMainWindow.GUI
				local nav = KaliMainWindow.GUI.NavigationMenu

				if CheckUnit == "Seconds" then
					if timevalue ~= CheckInterval then timevalue = CheckInterval end
				elseif CheckUnit == "Minutes" then
					if timevalue ~= CheckInterval * 60 then timevalue = CheckInterval * 60 end
				elseif CheckUnit == "Hours" then
					if timevalue ~= CheckInterval * 3600 then timevalue = CheckInterval * 3600 end
				elseif CheckUnit == "Days" then
					if timevalue ~= CheckInterval * 86400 then timevalue = CheckInterval * 86400 end
				elseif CheckUnit == "Weeks" then
					if timevalue ~= CheckInterval * 604800 then timevalue = CheckInterval * 604800 end
				elseif CheckUnit == "Months" then
					if timevalue ~= CheckInterval * 2592000 then timevalue = CheckInterval * 2592000 end
				end
				if os.difftime(os.time(), LastCheck) >= timevalue then -- Check to see if enough time has passed to do another check --
					AddTree("MoogleUpdater","Check Scripts",true)
					local result = lastresult or GitFileText("MoogleScripts2")
					if Type(result,"string") and #result > 3 then
						AddTree("MoogleUpdater.Check Scripts","Obtained MoogleScripts",true)
						if #webpage == 0 then webpage = loadstring(result)() end
						if Valid(webpage) then
							AddTree("MoogleUpdater.Check Scripts.Obtained MoogleScripts","Valid Script",true)
							if lastresult ~= result then lastresult = result end
							if MoogleScripts ~= webpage then MoogleScripts = webpage end

							local pass = true
							for i = 1, #webpage do
								local entry = webpage[i]
								local name, status, filepath, tablestr, url, category, info =
								entry.name, entry.status, entry.filepath, entry.table, GitURL(entry.url), entry.category, entry.info

								AddTree("MoogleUpdater.Check Scripts.Obtained MoogleScripts.Valid Script",name,true)
								if CurrentVersions[name] == nil then
									AddTree("MoogleUpdater.Check Scripts.Obtained MoogleScripts.Valid Script."..name,"Missing Current Version Record",true)
									local update, str, result = VersionCheck(tablestr, url, MoogleVersions[name])
									if str then
										AddTree("MoogleUpdater.Check Scripts.Obtained MoogleScripts.Valid Script."..name..".Missing Current Version Record","Pass Success",true)
										CurrentVersions[name] = str
										if MoogleVersions[name] then
											if CurrentVersions[name] > MoogleVersions[name] then MoogleVersions[name] = CurrentVersions[name] end
										else
											MoogleVersions[name] = CurrentVersions[name]
										end
									else
										AddTree("MoogleUpdater.Check Scripts.Obtained MoogleScripts.Valid Script."..name..".Missing Current Version Record","Pass Failed",true)
										pass = false
									end

									if update then
										-- You need to use the result to set the update live --
									end
								else
									AddTree("MoogleUpdater.Check Scripts.Obtained MoogleScripts.Valid Script."..name,"Current Version Record Found",true)
								end

								if CurrentLastPushes[name] == nil then
									local result = LastPush(entry.url..".lua")
									if result then CurrentLastPushes[name] = result else pass = false end
									if CurrentLastPushes[name] then
										if MoogleLastPushes[name] then
											if MoogleLastPushes[name] ~= CurrentLastPushes[name] then MoogleLastPushes[name] = CurrentLastPushes[name] end
										else
											MoogleLastPushes[name] = CurrentLastPushes[name]
										end
										-- local result = DownloadString(url)
										-- if result then end
									end
								end

								if FileExists(filepath) then
									if _G[tablestr] then -- Checking if you have the module installed and loaded --
									else
										LoadModule(filepath)
									end
								else

								end
							end
							if pass then
								LastCheck, lastresult, webpage = os.time(), nil, {}
								CurrentVersions, CurrentLastPushes = {}, {}
								MoogleDebug.LastSuccessfulUpdate = Now()
								if MoogleLog then
									Error("MoogleVersions:")
									table.print(MoogleVersions)
									Error("MoogleLastPushes:")
									table.print(MoogleLastPushes)
								end
							end
						else
							AddTree("MoogleUpdater.Check Scripts.Obtained MoogleScripts","Not Valid Script",true)
						end
					else
						AddTree("MoogleUpdater.Check Scripts","Waiting for MoogleScripts",true)
					end
				else
					AddTree("MoogleUpdater","Waiting for next check interval",true)
				end
			end
			MoogleSave({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.AutoUpdate]]] = selfs .. [[.Settings.AutoUpdate]],
				[selfs .. [[.CheckInterval]]] = selfs .. [[.Settings.CheckInterval]],
				[selfs .. [[.CheckUnit]]] = selfs .. [[.Settings.CheckUnit]],
				[selfs .. [[.AutoReload]]] = selfs .. [[.Settings.AutoReload]],
				[selfs .. [[.Notifications]]] = selfs .. [[.Settings.Notifications]],
				[selfs .. [[.ToasterTime]]] = selfs .. [[.Settings.ToasterTime]],
				[selfs .. [[.Beta]]] = selfs .. [[.Settings.Beta]]
			})
			if CheckUnit ~= "Seconds" and CheckUnit ~= "Minutes" then
				MoogleSave({ [selfs .. [[.LastCheck]]] = selfs .. [[.Settings.LastCheck]] })
			end
			UpdateSettingLocals() UpdateDataLocals()
		else
			MoogleLoad({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				[selfs .. [[.AutoUpdate]]] = selfs .. [[.Settings.AutoUpdate]],
				[selfs .. [[.CheckInterval]]] = selfs .. [[.Settings.CheckInterval]],
				[selfs .. [[.LastCheck]]] = selfs .. [[.Settings.LastCheck]],
				[selfs .. [[.CheckUnit]]] = selfs .. [[.Settings.CheckUnit]],
				[selfs .. [[.AutoReload]]] = selfs .. [[.Settings.AutoReload]],
				[selfs .. [[.Notifications]]] = selfs .. [[.Settings.Notifications]],
				[selfs .. [[.ToasterTime]]] = selfs .. [[.Settings.ToasterTime]],
				[selfs .. [[.Beta]]] = selfs .. [[.Settings.Beta]]
			})
			UpdateSettingLocals(true) UpdateDataLocals(true)
			loaded = true
		end
	else
		UpdateLocals()
		if FinishedLoading then
			Initialize(self.GUI)
		end
	end
end

function self.Draw()
	if FinishedLoading and loaded then -- Initiate Locals --
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu

		--		if DrawReady then
		InsertIfNil(nav.Menu, main.NavName)

		if nav.selected == main.NavName then
			main.Contents = function()
				-- Start Settings --
				local x = GUI:CalcTextSize(tostring(CheckInterval))
				Text("Check Interval:") Space() GUI:PushItemWidth(x+10) CheckInterval = GUI:InputText("##CheckInterval", CheckInterval, GUI.InputTextFlags_CharsDecimal + GUI.InputTextFlags_CharsNoBlank + GUI.InputTextFlags_AutoSelectAll) CheckInterval = tonumber(CheckInterval) GUI:PopItemWidth() Space(0)
				local x = GUI:CalcTextSize(tostring(CheckUnit))
				local UnitIndex
				GUI:PushItemWidth(x + 30) UnitIndex = GUI:Combo("##CheckUnit", table.find(TimeUnits, CheckUnit), TimeUnits, #TimeUnits) GUI:PopItemWidth()
				if Type(TimeUnits[UnitIndex], "string") and CheckUnit ~= TimeUnits[UnitIndex] then
					CheckUnit = TimeUnits[UnitIndex]
				end
				Space(20)
				local x = GUI:CalcTextSize(tostring(ToasterTime))
				Notifications = GUI:Checkbox("Toaster Time (sec):", Notifications) Space() GUI:PushItemWidth(x + 60) ToasterTime = GUI:InputInt("##ToasterTime", ToasterTime, 1, 300) GUI:PopItemWidth()

				Space(20)
				local str
				local lastname = KaliMainWindow.GUI.name
				if Beta then
					str = "Leave Beta"
					if KaliMainWindow.GUI.name ~= [[Moogle Script Management (Beta)]] then KaliMainWindow.GUI.name = [[Moogle Script Management (Beta)]] end
				else
					str = "Join Beta"
					if KaliMainWindow.GUI.name ~= [[Moogle Script Management]] then KaliMainWindow.GUI.name = [[Moogle Script Management]] end
				end
				if GUI:SmallButton(str) then
					KaliMainWindow.GUI.oldPOS = {
						pos = { x = 0, y = 0 },
						size = { x = 0, y = 0 },
						name = lastname
					}
					local oldPOS = KaliMainWindow.GUI.oldPOS
					oldPOS.pos.x, oldPOS.pos.y = GUI:GetWindowPos()
					oldPOS.size.x, oldPOS.size.y = GUI:GetWindowSize()
					Beta = not Beta
				end
				-- End Settings --
				for k,v in table.pairsbykeys(MoogleScripts) do
					local name, status, filepath, table, url, category, stability, info = v.name, v.status, v.filepath, v.table, v.url, v.category, v.stability, v.info
					if NotAll(stability,"Beta","Dev") or (stability == "Beta" and (Beta or settings.Dev)) or (Is(stability,"Locked","Closed","Broken","Breaks Other Modules") and settings.Dev) then
						local yChild = AdjustChildren[k] or 50

						GUI:PushStyleVar(GUI.StyleVar_WindowPadding, 5, 5) GUI:PushStyleVar(GUI.StyleVar_ItemSpacing, 0, 0) GUI:PushStyleVar(GUI.StyleVar_ItemInnerSpacing, 0, 0)
						GUI:BeginChild("##" .. name:gsub(" ", ""), 0, yChild, true, GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_NoScrollbar)
							local width, icon, module, LastPush = GUI:GetContentRegionAvailWidth(), 23, _G[table], MoogleLastPushes[name]
							local xName, yName = GUI:CalcTextSize(name)
							local xCategory,yCategory = GUI:CalcTextSize("Category:" .. category)
							local xStability,yStability = GUI:CalcTextSize("Stability:" .. stability)
							local label, labelSpace, labelWidth, stb = "", 0, 0, 0
							local pushtime

							if Is(category,"Core Moogle Module") then
								Image("CoreModule",19,19,{tooltip=category})
							elseif module then
								module.Settings.enable = GUI:Checkbox("##"..table,module.Settings.enable)
								if GUI:IsItemHoveredRect() then
									local str,str2
									if module.Settings.enable then
										str = "enabled" str2 = "disable"
									else
										str = "disabled" str2 = "enable"
									end
									Tooltip("Currently "..str..", click to "..str2)
								end
							else
								Image("Download",19,19,{tooltip="Install "..name})
							end
							Text(name,true)

							if LastPush then
								pushtime = os.difftime(os.time(),LastPush)
--								if pushtime < week(4) then
--									label = label .. "[New]"
--									labelSpace = labelSpace + 4
--									Text("[New]", { "1", "0", "0", "1" }, 4, true)
--								end
								if pushtime < day(3) then
									label = label .. "[Updated]"
									labelSpace = labelSpace + 4
									Text("[Updated]", { "1", "1", "0", "1" }, 4, true)
								end
								if stability == "Beta" then
									label = label .. "[Beta]"
									labelSpace = labelSpace + 4
									Text("[Beta]", { "0.3", "1", "0.3", "1" }, 4, true)
								end
								labelWidth = GUI:CalcTextSize(label) + labelSpace
							end

							if stability ~= "open" and stability ~= name then stb = xStability end
							local add if stb then add = 8 else add = 4 end
							Space(width - (icon + xName + labelWidth + xCategory + stb + add))
							Text("Category:") Text(category, { "1", "1", "0", "1" }, 4, true)
							if stb~=0 then Text("Stability:",true) Text(stability, { "1", "1", "0", "1" }, 4, true) end

						GUI:EndChild()
						GUI:PopStyleVar(3)
					end
				end
				UpdateSettingLocals() UpdateDataLocals()
			end
		end
		--		end
	end
end

API.Event("Gameloop.Initalize",selfs,"Initialize",self.Init)
API.Event("Gameloop.Update",selfs,"Update",self.OnUpdate)
API.Event("Gameloop.Draw",selfs,"Draw",self.Draw)

_G.MoogleUpdater = MoogleUpdater
-- End of File --
