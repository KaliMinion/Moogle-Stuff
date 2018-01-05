MoogleUpdater = {}

MoogleUpdater.Info = {
	Creator = "Kali",
	Version = "1.1.3",
	StartDate = "12/09/17",
	ReleaseDate = "12/09/17",
	LastUpdate = "12/09/17",
	ChangeLog = {
		["1.0.0"] = "Initial release",
		["1.1.0"] = "Updated for MoogleLib",
		["1.1.1"] = "Tweaks",
		["1.1.2"] = "Adjusted Layout",
		["1.1.3"] = "Added Auto Download and Auto Reload",
	}
}

MoogleUpdater.GUI = {
	NavName = "Moogle Script Management",
	open = false
}

MoogleUpdater.Settings = {
	enable = true,
	AutoUpdate = false, -- if False, then notifies the user when an update is available, otherwise notifies the user that it updated a script
	CheckInterval = 30, -- in the unit of time the user has selected
	CheckUnit = "Seconds",
	LastCheck = 0,

	AutoReload = false, -- if True, once updating a script, the updater will automatically reload lua to make the update live
	Notifications = true, -- if False, then toaster notifications will be disabled
	ToasterTime = 5, -- if set to zero, toaster popups never disappear until clicked on or updating the script
}

MoogleUpdater.MoogleScripts = {}
MoogleUpdater.NewScripts = {}
MoogleUpdater.NewLabelScripts = {}
MoogleUpdater.UpdatedScripts = {}
MoogleUpdater.UpdatedScriptsReady = {}
MoogleUpdater.UpdatedLabelScripts = {}
local NeedWebRequest = true
local NeedWebContent = true

function MoogleUpdater.ModuleInit()
	if FileExists(MoogleLib.API.MooglePath..[[Moogle Scripts.lua]]) then
		MoogleUpdater.MoogleScripts = FileLoad(MoogleLib.API.MooglePath..[[Moogle Scripts.lua]])
	end
end

MoogleUpdater.TimeUnits = {"Seconds","Minutes","Hours","Days","Weeks","Months"}

local ModuleDownloads = {}
local PendingDeletion = {}
local AdjustChildren = {}
local NeedImages = true
function MoogleUpdater.Draw()
	if KaliMainWindow ~= nil then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleUpdater.Settings
		-- Helper Variables --
			local MinionPath = MoogleLib.API.MinionPath
			local LuaPath = MoogleLib.API.LuaPath
			local MooglePath = MoogleLib.API.MooglePath
			local ImageFolder = MoogleLib.API.ImageFolder
			local ScriptsFolder = MoogleLib.API.ScriptsFolder
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
		-- End Helper Variables --
		local Download = OS.Download
		local InsertIfNil = Table.InsertIfNil
		local Text = Gui.Text
		local Valid = Table.Valid
		local Space = Gui.Space
		local SameLine = Gui.SameLine
		local Tooltip = Gui.Tooltip
		local Checkbox = Gui.Checkbox
		local Not = General.Not
		local NotNil = General.NotNil
		local CreateFolder = OS.CreateFolder
		local Size = General.Size
		local DownloadQueue = OS.DownloadQueue
		local DownloadQueueBackup = OS.DownloadQueueBackup
		local DownloadNextAttempt = OS.DownloadNextAttempt
		local FinishedDownloads = OS.FinishedDownloads

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
					["https://i.imgur.com/ZNizSZM.png"] = "Metrics.png"
				}
				local downloading = false
				for url,image in pairs(Images) do
					if not downloading then
						-- Need to download --
						downloading = Download(url,ImageFolder..image)
					end
				end
				if not downloading then
					NeedImages = false
				end
			end
		-- End Image Downloading --

		-- Add entry to sidewindow navigation list --
			InsertIfNil(nav.Menu,MoogleUpdater.GUI.NavName)
		-- End Sidewindow Navigation List --

		if nav.selected == MoogleUpdater.GUI.NavName then
			main.Contents = function()
				-- Check to see if you have pending Download Checks --
					if Valid(ModuleDownloads) then
						Text("You need to")
						SameLine()
						
						local x,y = GUI:CalcTextSize("Reload Lua")
						local c = GUI:Button("Reload Lua",x+10,y+10)
						if GUI:IsItemClicked(c) then
							Reload()
						end

						local check = "module"
						if Size(ModuleDownloads) > 1 then
							check = check.."s"
						end
						
						Text("to use your "..Size(ModuleDownloads).." new moogle "..check..".",4,true)
					end
				-- End Pending Download Checks --

				local scripts = MoogleUpdater.MoogleScripts
				if Valid(scripts) then
					for k,v in table.pairsbykeys(scripts) do
						local yChild = AdjustChildren[k] or 50
						GUI:BeginChild("##"..v.name:gsub(" ",""),0,yChild,true,GUI.WindowFlags_AlwaysAutoResize)
							local name = v.name
							local category = v.category
							local stability = v.stability
							local filepath = v.filepath
							local url = v.url

							local width = GUI:GetContentRegionAvailWidth()
							local Icon = 23
							local xName,yName = GUI:CalcTextSize(name)
							local xCategory,yCategory = GUI:CalcTextSize("Category:"..category) + 4
							local xStability,yStability = GUI:CalcTextSize("Stability:"..stability) + 4

							if In(name,"Moogle Updater", "Main Window", "MoogleLib") then
								-- Core Files ignore all checks --
									if FileExists(ImageFolder..[[CoreModule.png]]) then
										local c = GUI:Image(ImageFolder..[[CoreModule.png]],19,19)

										if GUI:IsItemHovered(c) then
											Tooltip("Core Moogle Module")
										end
									end
									Space(4)
									Text(name)
									Space(width - (Icon + xName + xCategory))
									Text("Category:") Text(category,{"1","1","0","1"},4,true)
								-- End Core Module Check --
							else
								local tbl = loadstring(v.table)() or "NotInstalled"
								if Not(tbl,"NotInstalled") then
									tbl.Settings.enable = Checkbox(name,tbl.Settings.enable,"ScriptEnabled",false,"Enable/Disable Module\n\nNote: Technically the module is still enabled, but this prevents code from running while the table still exists.")
								else
									if FileExists(ImageFolder..[[KaliDownload.png]]) then
										if not FileExists(MooglePath..filepath) then
											local c = GUI:Image(ImageFolder..[[KaliDownload.png]],19,19)
											if GUI:IsItemHovered(c) then
												Tooltip("Download and Install "..name)
												if GUI:IsItemClicked(c) then
													if not In(filepath,""," ",nil) then
														local lastfolder = string.gsub(MooglePath..filepath,"([^\\]+)$","")
														if not FolderExists(lastfolder) then
															CreateFolder(lastfolder)
														end
														Download(url,MooglePath..filepath)
													end
												end
											end
											Space(4)
											Text(name)
										else
											-- File Exists but need to create module.def file --
											if FileExists(string.gsub(MooglePath..filepath,"([^\\]+)$","")..[[module.def]]) then
												-- Module.def file exists, now ready for Lua Reload --
												InsertIfNil(ModuleDownloads,name)
												if FileExists(ImageFolder..[[KaliDownloaded.png]]) then
													local c = GUI:Image(ImageFolder..[[KaliDownloaded.png]],19,19)
													if GUI:IsItemHovered(c) then
														Tooltip("Finished Downloading, click again to reload Lua")
														if GUI:IsItemClicked(c) then
															Reload()
														end
													end
												end
												Space(4)
												GUI:Text(name)
											else
												if NotNil(v.module) then
													FileWrite(string.gsub(MooglePath..filepath,"([^\\]+)$","")..[[module.def]],v.module)
												end
											end
										end
									else
										Space(23)
										Text(name)
									end
								end

								-- Begin right side options for non core files --
								if Not(tbl,"NotInstalled") or FileExists(MooglePath..filepath) then
									Space(width - (Icon + xName + xCategory + 4 + xStability + 4 + Icon))
								else
									Space(width - (Icon + xName + xCategory + 4 + xStability + 4))
								end
									Text("Category:")
									Text(category,{"1","1","0","1"},4,true)
									Text("Stability:",8,true)
									Text(stability,{"1","1","0","1"},4,true)

								if Not(tbl,"NotInstalled") or FileExists(MooglePath..filepath) then
									SameLine(4)
									if FileExists(ImageFolder..[[DeleteModule.png]]) then
										local c = GUI:Image(ImageFolder..[[DeleteModule.png]],19,19)
										if GUI:IsItemHovered(c) then
											Tooltip("Permanently Delete Moogle Module")

											if GUI:IsItemClicked(c) then
												PendingDeletion[k] = name
											end
										end
									end
								end
							end
							Text("Release Date: "..tostring(os.date ("%x", v.lastupdate)))
							local LastUpdateVar = os.difftime(os.time(),v.lastupdate)
							local days = 0
							local hours = 0
							local minutes = 0
							local seconds = 0

							if LastUpdateVar > 86400 then
								local temp = math.floor(LastUpdateVar/86400)
								days = temp
								LastUpdateVar = LastUpdateVar - (temp * 86400)
							end
							if LastUpdateVar > 3600 then
								local temp = math.floor(LastUpdateVar/3600)
								hours = temp
								LastUpdateVar = LastUpdateVar - (temp * 3600)
							end
							if LastUpdateVar > 60 then
								local temp = math.floor(LastUpdateVar/60)
								minutes = temp
								LastUpdateVar = LastUpdateVar - (temp * 60)
							end
							if LastUpdateVar < 60 then
								local temp = LastUpdateVar
								seconds = temp
								LastUpdateVar = LastUpdateVar - temp
							end

							local TimeStr = ""

							if days ~= 0 then TimeStr = TimeStr..days.."d " end
							if hours ~= 0 or days ~= 0 then TimeStr = TimeStr..string.format("%02d",hours).."h " end
							if minutes ~= 0 or hours ~= 0 then TimeStr = TimeStr..string.format("%02d",minutes).."m " end
							if seconds ~= 0 or minutes ~= 0 then TimeStr = TimeStr..string.format("%02d",seconds).."s" end

							Text("Last Update: "..TimeStr)

							local xChildAvail,yChildAvail = GUI:GetContentRegionAvail()
							if AdjustChildren[k] == nil then
								AdjustChildren[k] = 50 - yChildAvail
							else
								AdjustChildren[k] = AdjustChildren[k] - yChildAvail
							end
						GUI:EndChild()
					end
				end
			end
		end
	end
end

local webpage = {}
local timevalue = 0
local FirstRun = false
local docheck = true
function MoogleUpdater.OnUpdate(event, tickcount)
	-- Check if all the folders are created --
		local MooglePath = GetLuaModsPath()..[[MoogleStuff Files\]]
		if not FolderExists(MooglePath..[[Moogle Images]]) then
			FolderCreate(MooglePath..[[Moogle Images]])
		end
		if not FolderExists(MooglePath..[[Moogle Scripts]]) then
			FolderCreate(MooglePath..[[Moogle Scripts]])
		end
	-- Check to see if you have backed up downloads --
		if MoogleLib ~= nil then
			local OS = MoogleLib.Lua.os
			if table.valid(OS.DownloadQueueBackup) then
				local Download = OS.Download
				for k,v in pairs(OS.DownloadQueueBackup) do
					Download(k,v)
				end
			end
		end
	-- End Download Check --

	-- Check for Pending Deletion --
	if MoogleLib ~= nil and table.valid(PendingDeletion) then
		-- There are entries in PendingDeletion, so we need to remove all traces --
		for k,v in pairs(PendingDeletion) do
			local notchanged = true
			if MoogleUpdater.MoogleScripts[k] ~= nil then
				if loadstring(MoogleUpdater.MoogleScripts[k].table.." ~= nil")() then
					-- First Lets remove the Minion Button entry --
						local TableName = loadstring(MoogleUpdater.MoogleScripts[k].table..".GUI.name")()
						local changed = false
						local changed2 = false
						for k,v in pairs(ml_gui.ui_mgr.menu.components[2].members) do
							if changed then
								ml_gui.ui_mgr.menu.components[2].members[k-1] = table.deepcopy(ml_gui.ui_mgr.menu.components[2].members[k])
								if ml_gui.ui_mgr.menu.components[2].members[k+1] == nil then
									ml_gui.ui_mgr.menu.components[2].members[k] = nil
								end
							end
							if v.name == TableName then
								ml_gui.ui_mgr.menu.components[2].members[k] = nil
								changed = true
							end
							if type(v) == "table" and v.submembers ~= nil then
								for i,e in pairs(v.submembers) do
									if changed2 then
										ml_gui.ui_mgr.menu.components[2].members[k].submembers[i-1] = table.deepcopy(ml_gui.ui_mgr.menu.components[2].members[k].submembers[i])
										if ml_gui.ui_mgr.menu.components[2].members[k].submembers[i+1] == nil then
											ml_gui.ui_mgr.menu.components[2].members[k].submembers[i] = nil
										end
									end
									if type(e) == "table" and e.name == TableName then
										ml_gui.ui_mgr.menu.components[2].members[k].submembers[i] = nil
										changed2 = true
									end
								end
							end
						end
						for k,v in pairs(ml_gui.ui_mgr.menu.components) do
							if v.header.name == "MoogleStuff" then
								local changed3 = false
								for i,e in pairs(v.members) do
									if changed3 then
										ml_gui.ui_mgr.menu.components[k].members[i-1] = table.deepcopy(ml_gui.ui_mgr.menu.components[k].members[i])
										if ml_gui.ui_mgr.menu.components[k].members[i+1] == nil then
											ml_gui.ui_mgr.menu.components[k].members[i] = nil
										end
									end
									if e.name == TableName then
										ml_gui.ui_mgr.menu.components[k].members[i] = nil
										changed3 = true
									end
								end
							end
						end
					-- Now lets remove the MiniButton entry --
						local key = loadstring(MoogleUpdater.MoogleScripts[k].table..[[.GUI.MiniName]])()
						if key ~= nil then
							for k,v in pairs(ml_global_information.menu.windows) do
								if v.name == key then
									ml_global_information.menu.windows[k] = nil
								end
							end
						end
					-- Now lets remove the Moogle Manager SideMenu entry --
						local key = table.find(KaliMainWindow.GUI.NavigationMenu.Menu,loadstring(MoogleUpdater.MoogleScripts[k].table..[[.GUI.NavName]])())
						if key ~= nil then
							KaliMainWindow.GUI.NavigationMenu.Menu[key] = nil
						end
					-- Now lets remove the Table of the module we're deleting --
						loadstring(MoogleUpdater.MoogleScripts[k].table:gsub("return ","").." = nil")()
				end
				-- Table Cleanup --
					local url = MoogleUpdater.MoogleScripts[k].url
					local filepath = MoogleUpdater.MoogleScripts[k].filepath
					local OS = MoogleLib.Lua.os
					local Download = OS.Download
					local DownloadQueue = OS.DownloadQueue
					local DownloadQueueBackup = OS.DownloadQueueBackup
					local DownloadNextAttempt = OS.DownloadNextAttempt
					local FinishedDownloads = OS.FinishedDownloads

					-- Remove Folders and Files --
						if not In(filepath,""," ",nil) then
							local lastfolder = string.gsub(MooglePath..filepath,"([^\\]+)$","")
							if FolderExists(lastfolder) then
								io.popen([[rmdir /s /q "]]..lastfolder..[["]])
								notchanged = false
							end
						end

					if DownloadQueue[url] ~= nil then DownloadQueue[url] = nil end
					if DownloadQueueBackup[url] ~= nil then DownloadQueueBackup[url] = nil end
					if DownloadNextAttempt[url] ~= nil then DownloadNextAttempt[url] = nil end
					if FinishedDownloads[url] ~= nil then FinishedDownloads[url] = nil end
					if table.valid(ModuleDownloads) then
						for i,e in pairs(ModuleDownloads) do
							if e == v then
								ModuleDownloads[i] = nil
								notchanged = false
							end
						end
					end
			end
			if notchanged then
				PendingDeletion[k] = nil
			end
		end
	end
	-- End Pending Deletion Check --

	local CheckInterval = MoogleUpdater.Settings.CheckInterval
	local CheckUnit = MoogleUpdater.Settings.CheckUnit

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

	if docheck then
		if not FileExists(MooglePath..[[Moogle Scripts.lua]]) or not FileExists(MooglePath..[[Main Window.lua]]) or not FileExists(MooglePath..[[MoogleLib.lua]]) then
			if not FirstRun then
				io.popen([[powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle%20Scripts.lua',']]..MooglePath..[[Moogle Scripts.lua')]])
				io.popen([[powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/Main%20Window.lua',']]..MooglePath..[[Main Window.lua')]])
				io.popen([[powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleLib.lua',']]..MooglePath..[[MoogleLib.lua')]])
				FirstRun = true
			end
		else
			docheck = false
		end
	elseif MoogleUpdater.Settings.LastCheck == 0 or os.difftime(os.time(),MoogleUpdater.Settings.LastCheck) >= timevalue then
			if FirstRun then
				Reload()
			else
			-- Helper Variables --
				local MinionPath = MoogleLib.API.MinionPath
				local LuaPath = MoogleLib.API.LuaPath
				local MooglePath = MoogleLib.API.MooglePath
				local ImageFolder = MoogleLib.API.ImageFolder
				local ScriptsFolder = MoogleLib.API.ScriptsFolder
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
				local Download = OS.Download
			-- End Helper Variables --
				-- Check to see if Moogle Scripts has been updated --
					if table.size(webpage) == 0 then

						if NeedWebRequest == true and NeedWebContent == true then
							Download([[https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle%20Scripts.lua]],MooglePath..[[Moogle Scripts.lua]],true)
							NeedWebRequest = false
						elseif NeedWebRequest == false and NeedWebContent == true then
							local file = io.open(MooglePath..[[Moogle Scripts.lua]],"r")
							local filesize = 0
							if file ~= nil then
								filesize = file:seek("end")
								file:close()
							end

							if filesize ~= 0 then
								webpage = FileLoad(MooglePath..[[Moogle Scripts.lua]])
								if table.valid(webpage) then 
									NeedWebContent = false
								end
							end
						end
					elseif table.valid(webpage) and table.size(webpage) ~= 0 then
						local different = false
						for i,e in pairs(webpage) do
							if MoogleUpdater.MoogleScripts[i] == nil then
								-- New Script --
								MoogleUpdater.NewScripts[i] = e.name
							elseif MoogleUpdater.MoogleScripts[i].version ~= e.version then
								-- New Script --
								MoogleUpdater.UpdatedScripts[i] = e.name
							else
								if loadstring(e.table..[[ ~= nil]])() and loadstring(e.table..[[.Info ~= nil]])() then
									local InstalledScriptVersion = (loadstring(e.table..[[.Info.Version]])())
									if MoogleUpdater.MoogleScripts[i].version ~= InstalledScriptVersion then
										-- New Script --
										MoogleUpdater.UpdatedScripts[i] = e.name
									end
								end
							end

							if os.difftime(os.time(),e.releasedate) < 604800 then
								-- New label scripts, released within 1 week --
								MoogleUpdater.NewLabelScripts[i] = e.name
							end

							if os.difftime(os.time(),e.lastupdate) < 604800 then
								-- New label scripts, released within 1 week --
								MoogleUpdater.UpdatedLabelScripts[i] = e.name
							end				
						end

						if table.deepcompare(MoogleUpdater.MoogleScripts,webpage) == false then
							MoogleUpdater.MoogleScripts = table.deepcopy(webpage)
						end
						MoogleUpdater.Settings.LastCheck = os.time()
						table.clear(webpage)
						NeedWebRequest = true
						NeedWebContent = true
					end

					local same = true
					if table.valid(MoogleUpdater.UpdatedScripts) then
						for k,v in pairs(MoogleUpdater.UpdatedScripts) do
							if MoogleUpdater.UpdatedScriptsReady[k] == nil then
								Download(MoogleUpdater.MoogleScripts[k].url,ScriptsFolder..MoogleUpdater.MoogleScripts[k]..filepath)
								same = false
							end
							if OS.FinishedDownloads[MoogleUpdater.MoogleScripts[k].url] ~= nil then
								MoogleUpdater.UpdatedScriptsReady[k] = v
							end
						end
					end
					if same and not FFXIV_Common_BotRunning then
						Reload()
					end
				-- End Moogle Scripts Check --
			end
	else
		if FileExists(MooglePath..[[temp.lua]]) then
			local TempPath = MooglePath..[[temp.lua]]
			local file = io.open(TempPath,"r")
			local filesize = 0
			if file ~= nil then
				filesize = file:seek("end")
				file:close()
			end

			if filesize ~= 0 then
				FileDelete(MooglePath..[[temp.lua]])
			end
		end
	end
end

RegisterEventHandler("Module.Initalize", MoogleUpdater.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleUpdater.Draw)
RegisterEventHandler("Gameloop.Update", MoogleUpdater.OnUpdate)
