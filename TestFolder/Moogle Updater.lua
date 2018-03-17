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
	NavName = "Moogle Script Management",
	open = false
}

self.Settings = {
	enable = true,
	CheckInterval = 30, -- in the unit of time the user has selected
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
	ModuleDownloads = {},
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
local MoogleScripts, MoogleVersions, MoogleLastPushes, NewScripts, NewLabelScripts, UpdatedScripts, UpdatedScriptsReady, UpdatedLabelScripts, NeedWebRequest, NeedWebContent, TimeUnits, ModuleDownloads, DownloadOneTimers, PendingDeletion, AdjustChildren, NeedImages, FinishedUpdating, FinishedImages, webpage, lastresult, timevalue, FirstRun, docheck, CheckVer, loaded =
data.MoogleScripts, data.MoogleVersions, data.MoogleLastPushes, data.NewScripts, data.NewLabelScripts, data.UpdatedScripts, data.UpdatedScriptsReady, data.UpdatedLabelScripts, data.NeedWebRequest, data.NeedWebContent, data.TimeUnits, data.ModuleDownloads, data.DownloadOneTimers, data.PendingDeletion, data.AdjustChildren, data.NeedImages, data.FinishedUpdating, data.FinishedImages, data.webpage, data.lastresult, data.timevalue, data.FirstRun, data.docheck, data.CheckVer, data.loaded
--[[
Notifications, ToasterTime, Beta, MoogleVersions, MoogleLastPushes, NewScripts, NewLabelScripts, UpdatedScripts, UpdatedScriptsReady, UpdatedLabelScripts, NeedWebRequest, NeedWebContent, TimeUnits, ModuleDownloads, DownloadOneTimers, PendingDeletion, AdjustChildren, FinishedUpdating, FirstRun, docheck
]]
--local function UpdateSettingLocals()
--	if settings.CheckInterval ~= CheckInterval then settings.CheckInterval = CheckInterval end
--	if settings.CheckUnit ~= CheckUnit then settings.CheckUnit = CheckUnit end
--	if settings.LastCheck ~= LastCheck then settings.LastCheck = LastCheck end
--	if settings.Notifications ~= Notifications then settings.Notifications = Notifications end
--	if settings.ToasterTime ~= ToasterTime then settings.ToasterTime = ToasterTime end
--	if settings.Beta ~= Beta then settings.Beta = Beta end
--	if settings.DrawReady ~= DrawReady then settings.DrawReady = DrawReady end
--end
--local function UpdateDataLocals()
--	if data.MoogleScripts ~= MoogleScripts then data.MoogleScripts = MoogleScripts end
--	if data.MoogleVersions ~= MoogleVersions then data.MoogleVersions = MoogleVersions end
--	if data.MoogleLastPushes ~= MoogleLastPushes then data.MoogleLastPushes = MoogleLastPushes end
--	if data.NewScripts ~= NewScripts then data.NewScripts = NewScripts end
--	if data.NewLabelScripts ~= NewLabelScripts then data.NewLabelScripts = NewLabelScripts end
--	if data.UpdatedScripts ~= UpdatedScripts then data.UpdatedScripts = UpdatedScripts end
--	if data.UpdatedScriptsReady ~= UpdatedScriptsReady then data.UpdatedScriptsReady = UpdatedScriptsReady end
--	if data.UpdatedLabelScripts ~= UpdatedLabelScripts then data.UpdatedLabelScripts = UpdatedLabelScripts end
--	if data.NeedWebRequest ~= NeedWebRequest then data.NeedWebRequest = NeedWebRequest end
--	if data.NeedWebContent ~= NeedWebContent then data.NeedWebContent = NeedWebContent end
--	if data.TimeUnits ~= TimeUnits then data.TimeUnits = TimeUnits end
--	if data.ModuleDownloads ~= ModuleDownloads then data.ModuleDownloads = ModuleDownloads end
--	if data.DownloadOneTimers ~= DownloadOneTimers then data.DownloadOneTimers = DownloadOneTimers end
--	if data.PendingDeletion ~= PendingDeletion then data.PendingDeletion = PendingDeletion end
--	if data.AdjustChildren ~= AdjustChildren then data.AdjustChildren = AdjustChildren end
--	if data.NeedImages ~= NeedImages then data.NeedImages = NeedImages end
--	if data.FinishedUpdating ~= FinishedUpdating then data.FinishedUpdating = FinishedUpdating end
--	if data.FinishedImages ~= FinishedImages then data.FinishedImages = FinishedImages end
--	if data.webpage ~= webpage then data.webpage = webpage end
--	if data.timevalue ~= timevalue then data.timevalue = timevalue end
--	if data.FirstRun ~= FirstRun then data.FirstRun = FirstRun end
--	if data.docheck ~= docheck then data.docheck = docheck end
--	if data.CheckVer ~= CheckVer then data.CheckVer = CheckVer end
--	if data.loaded ~= loaded then data.loaded = loaded end
--end

function self.Init()
	io.popen([[powershell -Command "$PSVer = 'PowerShell Version: ' + $PSVersionTable.PSVersion.Major + '.' + $PSVersionTable.PSVersion.Minor; $WinVer = 'Windows Version: ' + (Get-WmiObject -class Win32_OperatingSystem).Caption + ' ' + (Get-CimInstance Win32_OperatingSystem).OSArchitecture; $PackVer = 'Service Pack Version: ' + (Get-CimInstance Win32_OperatingSystem).ServicePackMajorVersion + '.' + (Get-CimInstance Win32_OperatingSystem).ServicePackMinorVersion ; $OSVer = 'OS Version: ' + (Get-CimInstance Win32_OperatingSystem).Version ; ($PSVer, $WinVer, $PackVer, $OSVer) | Out-File -filepath ']] .. LuaPath .. [[MoogleStuff Files\System Info.txt'"]])
end

function self.OnUpdate()
--	UpdateSettingLocals() UpdateDataLocals()
	if FinishedLoading then -- Initiate Locals --
--		Error("MoogleVersions:")
--		table.print(MoogleVersions)
--		Error("MoogleLastPushes:")
--		table.print(MoogleLastPushes)
		if loaded then -- Load User Saved Settings --
			if CheckVer then -- Do a version check --
--				local update, tbl = VersionCheck(selfs, self.Info.URL)
--				if update == true then
--					--                FileWrite(MooglePath .. [[Moogle Updater.lua]], tbl)
--					--                loadstring(tbl)()
--					CheckVer = false
--				elseif update == false then
--					CheckVer = false
--				end
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
					local result = lastresult or DownloadString(GitURL("MoogleScripts2"))
					if Type(result,"string") and #result > 3 then
						if #webpage == 0 then webpage = loadstring(result)() end
						if Valid(webpage) then
							if lastresult ~= result then lastresult = result end
							if MoogleScripts ~= webpage then MoogleScripts = webpage end

							local pass = true
							for i = 1, #webpage do
								local entry = webpage[i]
								local name, status, filepath, tablestr, etable, url, category, stability, info =
								entry.name, entry.status, entry.filepath, entry.table, loadstring(entry.table), GitURL(entry.url), entry.category, entry.stability, entry.info

								if MoogleVersions[name] == nil then
									local update, str = VersionCheck(tablestr:gsub("return ",""), url)
									if str then MoogleVersions[name] = str Error(MoogleVersions[name]) else pass = false end
								end

								if MoogleLastPushes[name] == nil then
									local result = LastPush(entry.url..".lua")
									if result then MoogleLastPushes[name] = result Error(MoogleLastPushes[name]) else pass = false end
								end

								if etable() and etable().Info then -- Checking if you have the module installed and loaded --
								end
							end
							if pass then
								LastCheck = Now()
								data.lastresult = nil
								MoogleDebug.LastSuccessfulUpdate = Now()
								Error("Completed Pass")
							end
						end
					end
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
	if FinishedLoading then -- Initiate Locals --
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu

		if DrawReady then
			-- Download Images needed for Draw process --
				if NeedImages then
					local Images = {
						["https://i.imgur.com/7fi6fyo.png"] = "KaliDownload.png",
						["https://i.imgur.com/3gGlOb5.png"] = "KaliDownloaded.png",
						["https://i.imgur.com/qmxNnED.png"] = "MoogleStuff.png",
						["https://i.imgur.com/YCrtrUW.png"] = "MoogleStuff2.png",
						["https://i.imgur.com/f94SN16.png"] = "CoreModule.png",
						["https://i.imgur.com/ySDKO55.png"] = "DeleteModule.png",
						["https://i.imgur.com/p0r73pU.png"] = "ImGUI.png",
						["https://i.imgur.com/ZNizSZM.png"] = "Metrics.png",
						["https://i.imgur.com/qkw94dD.png"] = "ViewCode.png"
					}
					local finished = true
					for url, image in table.pairsbykeys(Images) do
						if FinishedImages[url] == nil then
							local result = DownloadFile(url, ImageFolder .. image)
							if result == true then FinishedImages[url] = image end
							if finished then finished = result end
						end
					end
					if finished then
						NeedImages = false
					end
				end
			-- End Image Downloading --

			-- Add entry to sidewindow navigation list --
			InsertIfNil(nav.Menu, self.GUI.NavName)
			-- End Sidewindow Navigation List --

			if nav.selected == self.GUI.NavName then
				main.Contents = function()

				end
			end
		end
	end
end

local function RegisterInitFunction() if self.Init then self.Init() end end

local function RegisterDrawFunction() if self.Draw then self.Draw() end end

local function RegisterUpdateFunction() if self.OnUpdate then self.OnUpdate() end end

RegisterEventHandler("Module.Initalize", RegisterInitFunction)
RegisterEventHandler("Gameloop.Draw", RegisterDrawFunction)
RegisterEventHandler("Gameloop.Update", RegisterUpdateFunction)

_G.MoogleUpdater = MoogleUpdater
-- End of File --
