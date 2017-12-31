MoogleUpdater = {}

MoogleUpdater.Info = {
	Creator = "Kali",
	Version = "1.0.0",
	StartDate = "12/09/17",
	ReleaseDate = "12/09/17",
	LastUpdate = "12/09/17",
	ChangeLog = {
		["1.0.0"] = "Initial release"
	}
}

MoogleUpdater.GUI = {
	NavName = "Moogle Script Management",
	open = false
}

MoogleUpdater.Settings = {
	enable = true,
	AutoUpdate = false, -- if False, then notifies the user when an update is available, otherwise notifies the user that it updated a script
	CheckInterval = 5, -- in the unit of time the user has selected
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
MoogleUpdater.UpdatedLabelScripts = {}
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
local NeedWebRequest = true
local NeedWebContent = true

function MoogleUpdater.ModuleInit()
	if FileExists(MooglePath..[[Moogle Scripts.lua]]) then
		MoogleUpdater.MoogleScripts = FileLoad(MooglePath..[[Moogle Scripts.lua]])
	end
	ml_error("test")
	table.print(MoogleUpdater.MoogleScripts)
end

MoogleUpdater.TimeUnits = {"Seconds","Minutes","Hours","Days","Weeks","Months"}

local ModuleDownloads = {}
local NeedImages = true
function MoogleUpdater.Draw()
	if KaliMainWindow ~= nil then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleUpdater.Settings
		local Download = OS.Download
		local InsertIfNil = Table.InsertIfNil

		-- Download Images needed for Draw process --
			if NeedImages then
				local Images = {
					["https://i.imgur.com/7fi6fyo.png"] = "KaliDownload.png",
					["https://i.imgur.com/3gGlOb5.png"] = "KaliDownloaded.png",
					["https://i.imgur.com/qmxNnED.png"] = "MoogleStuff.png",
					["https://i.imgur.com/YCrtrUW.png"] = "MoogleStuff2.png",
					["https://i.imgur.com/f94SN16.png"] = "CoreModule.png",
					["https://i.imgur.com/ySDKO55.png"] = "DeleteModule.png",
				}
				local downloading = false
				for url,image in pairs(Images) do
					if FileExists(ImageFolder..image) then
						-- File Exists --
					elseif not downloading then
						-- Need to download --
						downloading = true
						Download(url,ImageFolder..image)
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
				local Text = Gui.Text
				local Valid = Table.Valid
				local Space = Gui.Space
				local SameLine = Gui.SameLine
				local Tooltip = Gui.Tooltip
				local Checkbox = Gui.Checkbox
				local Not = General.Not
				local NotNil = General.NotNil
				local CreateFolder = OS.CreateFolder

				-- Check to see if you have pending Download Checks --
					if Valid(ModuleDownloads) then
						Text("You need to",0)
						
						local x,y = GUI:CalcTextSize("Reload Lua")
						local c = GUI:Button("Reload Lua",x+10,y+10)
						if GUI:IsItemClicked(c) then
							Reload()
						end

						local check = "module"
						if Size(ModuleDownloads) > 1 then
							check = check.."s"
						end
						
						Text("to use your "..Size(ModuleDownloads).." new moogle "..check..".",0,true)
					end
				-- End Pending Download Checks --

				local scripts = MoogleUpdater.MoogleScripts
				if Valid(scripts) then
					for k,v in table.pairsbykeys(scripts) do
						GUI:BeginChild("##"..v.name:gsub(" ",""),0,50,true)
							if In(v.name,"Moogle Updater", "Main Window", "MoogleLib") then
								-- Core Files ignore all checks --
									if FileExists(ImageFolder..[[CoreModule.png]]) then
										local c = GUI:Image(ImageFolder..[[CoreModule.png]],19,19)

										if GUI:IsItemHovered(c) then
											Tooltip("Core Moogle Module")
										end
										
										Space(4)
										Text(v.name.."  v"..v.version)
									else
										Space(23) Text(v.name.."  v"..v.version)
									end

									local temp = true
									Checkbox(v.name.."  v"..v.version,temp,"temp1",false,"test")
								-- End Core Module Check --
							else
								local tbl = loadstring(v.table)() or "NotInstalled"
								if Not(tbl,"NotInstalled") then
									tbl.Settings.enable = GUI:Checkbox(v.name.."  v"..v.version,tbl.Settings.enable,"ScriptEnabled",false,"test")
								else
									if FileExists(ImageFolder..[[KaliDownload.png]]) then
										if not FileExists(MooglePath..v.filepath) then
											local c = GUI:Image(ImageFolder..[[KaliDownload.png]],19,19)
											if GUI:IsItemHovered(c) then
												Tooltip("Download and Install Lua")
												if GUI:IsItemClicked(c) then
													if not In(v.filepath,""," ",nil) then
														local lastfolder = string.gsub(MooglePath..v.filepath,"([^\\]+)$","")
														if not FolderExists(lastfolder) then
															CreateFolder(lastfolder)
														end
														Download(v.url,MooglePath..v.filepath)
													end
												end
											end
											Space(4)
											Text(v.name.."  v"..v.version)
										else
											-- File Exists but need to create module.def file --
											if FileExists(string.gsub(MooglePath..v.filepath,"([^\\]+)$","")..[[module.def]]) then
												-- Module.def file exists, now ready for Lua Reload --
												InsertIfNil(ModuleDownloads,v.name)
												if FileExists(ImageFolder..[[KaliDownloaded.png]]) then
													local c = GUI:Image(ImageFolder..[[KaliDownloaded.png]],19,19)
													if GUI:IsItemHovered(c) then
														Tooltip("Finished Downloading, click to reload Lua")
														if GUI:IsItemClicked(c) then
															Reload()
														end
													end

													Space(4)
													GUI:Text(v.name.."  v"..v.version)
												else
													Space(23) Text(v.name.."  v"..v.version)
												end
											else
												if NotNil(v.module) then
													FileWrite(string.gsub(MooglePath..v.filepath,"([^\\]+)$","")..[[module.def]],v.module)
												end
											end
										end
									else
										Space(23) Text(v.name.."  v"..v.version)
									end
								end

								-- Begin right side options for non core files --
								local x = GUI:GetContentRegionAvailWidth()
								local start,starty = GUI:CalcTextSize(v.name.."  v"..v.version)
								local labels = " Category:  Stability:  "
								local category = tostring(v.category)
								local stability = tostring(v.stability)
								local x2,y2 = GUI:CalcTextSize(labels)
								local x3,y3 = GUI:CalcTextSize(category)
								local x4,y4 = GUI:CalcTextSize(stability)
								local trashcan = 0

								if Not(tbl,"NotInstalled") or FileExists(MooglePath..v.filepath) then
									trashcan = 19
								end
								
								local x5 = x - (start + x2 + x3 + x4 + 19 + trashcan + 3)
								Space(x5) Text("Category:",true)

								GUI:PushStyleColor(GUI.Col_Text,1,1,0,1)
									Text(category,true)
								GUI:PopStyleColor()

								Text(" Stability:",true)

								GUI:PushStyleColor(GUI.Col_Text,1,1,0,1)
									Text(stability.." ",true)
								GUI:PopStyleColor()

								if Not(tbl,"NotInstalled") or FileExists(MooglePath..v.filepath) then
									SameLine()
									if FileExists(ImageFolder..[[DeleteModule.png]]) then

										local c = GUI:Image(ImageFolder..[[DeleteModule.png]],19,19)
										if GUI:IsItemHovered(c) then
											Tooltip("Permanently Delete Moogle Module")

											if GUI:IsItemClicked(c) then
												if NotNil(loadstring(v.table)()) then
													local key = table.find(KaliMainWindow.GUI.NavigationMenu.Menu,loadstring(v.table..[[.GUI.NavName]])())
													KaliMainWindow.GUI.NavigationMenu.Menu[key] = nil
												end

												if NotNil(MoogleFunctions.DownloadQueue[v.url]) then
													MoogleFunctions.DownloadQueue[v.url] = nil
												end

												local tbl = v.table:gsub("return ","")
												loadstring(tbl.." = nil")()
												
												if not In(v.filepath,""," ",nil) then
													local lastfolder = string.gsub(MooglePath..v.filepath,"([^\\]+)$","")
													if FolderExists(lastfolder) then
														io.popen([[rmdir /s /q "]]..lastfolder..[["]])
													end
												end

												local key = table.find(ModuleDownloads,v.name)
												if NotNil(key) then
													ModuleDownloads[key] = nil
												end
											end
										end
									end
								end
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
function MoogleUpdater.OnUpdate(event, tickcount)
	-- Check if all the folders are created --
		if not FolderExists(MooglePath..[[Moogle Images]]) then
			FolderCreate(MooglePath..[[Moogle Images]])
		end
		if not FolderExists(MooglePath..[[Moogle Scripts]]) then
			FolderCreate(MooglePath..[[Moogle Scripts]])
		end
	-- Check to see if you have backed up downloads --
		if MoogleFunctions ~= nil then
			for k,v in pairs(MoogleFunctions.DownloadQueue) do
				Download(k,v)
			end
		end
	-- End Download Check --

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

	if not FileExists(MooglePath..[[Moogle Scripts.lua]]) or not FileExists(MooglePath..[[MainWindow.lua]]) or not FileExists(MooglePath..[[Functions.lua]]) then
		if not FirstRun then
			io.popen([[powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle%20Scripts.lua',']]..MooglePath..[[Moogle Scripts.lua')]])
			io.popen([[powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/MainWindow.lua',']]..MooglePath..[[MainWindow.lua')]])
			io.popen([[powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/Functions.lua',']]..MooglePath..[[Functions.lua')]])
			FirstRun = true
		end
	elseif MoogleUpdater.Settings.LastCheck == 0 or os.difftime(os.time(),MoogleUpdater.Settings.LastCheck) >= timevalue then
		if FirstRun then
			Reload()
		else
			-- Check to see if Moogle Scripts has been updated --
				if table.size(webpage) == 0 then
					if NeedWebRequest == true and NeedWebContent == true then
						io.popen([[powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle%20Scripts.lua',']]..MooglePath..[[Moogle Scripts.lua')]])
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
							MoogleUpdater.NewScripts[i] = true
						elseif MoogleUpdater.MoogleScripts[i].version ~= e.version then
							-- New Script --
							d("MoogleUpdater.MoogleScripts[i].version: "..tostring(MoogleUpdater.MoogleScripts[i].version).." e.version: "..tostring(e.version))
							MoogleUpdater.UpdatedScripts[i] = true
						end

						if os.difftime(os.time(),e.releasedate) < 604800 then
							-- New label scripts, released within 1 week --
							MoogleUpdater.NewLabelScripts[i] = true
						end

						if os.difftime(os.time(),e.lastupdate) < 604800 then
							-- New label scripts, released within 1 week --
							MoogleUpdater.UpdatedLabelScripts[i] = true
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
