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
local MooglePath = GetLuaModsPath()..[[\MoogleStuff Files\]]
local ImageFolder = GetLuaModsPath()..[[\MoogleStuff Files\Moogle Images\]]
local NeedWebRequest = true
local NeedWebContent = true

function MoogleUpdater.ModuleInit()
	if FileExists(MooglePath..[[Moogle Scripts.lua]]) then
		MoogleUpdater.MoogleScripts = FileLoad(MooglePath..[[Moogle Scripts.lua]])
	end
end

MoogleUpdater.TimeUnits = {"Seconds","Minutes","Hours","Days","Weeks","Months"}


-- function MoogleUpdater.InvokeWebRequest(url,path,param1,param2)
-- 	if not In(param1,nil,"") then param1 = "."..param1 else param1 = "" end
-- 	if not In(param2,nil,"") then param2 = "."..param2 else param2 = "" end

-- 	local TempPath = MooglePath..[[temp.lua]]
-- 	if not In(path,"",nil) and FileExists(path) then TempPath = path end
-- 	if FileExists(TempPath) and NeedWebContent and NeedWebRequest == false then

-- 		local file = io.open(TempPath,"r")
-- 		local filesize = 0
-- 		if file ~= nil then
-- 			filesize = file:seek("end")
-- 			file:close()
-- 		end

-- 		if filesize ~= 0 then
-- 			-- We have recieved the webpage information that was requested --
-- 			local webpage = FileLoad(TempPath)
-- 			if table.valid(webpage) then 
-- 				NeedWebContent = false
-- 			end
-- 			return webpage
-- 		end
-- 	elseif NeedWebRequest then
-- 		io.popen([[powershell -Command "(iwr -uri ]]..url..[[ -OutFile ']]..TempPath..[[')]]..param1..param2..[["]])
-- 		NeedWebRequest = false
-- 		NeedWebContent = true
-- 		return nil
-- 	end
-- end

local ModuleDownloads = {}
function MoogleUpdater.Draw()
	if KaliMainWindow ~= nil then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleUpdater.Settings

		-- Download Images needed for Draw process --
			Download([[https://i.imgur.com/7fi6fyo.png]],ImageFolder..[[KaliDownload.png]])
			Download([[https://i.imgur.com/3gGlOb5.png]],ImageFolder..[[KaliDownloaded.png]])
			Download([[https://i.imgur.com/qmxNnED.png]],ImageFolder..[[MoogleStuff.png]])
			Download([[https://i.imgur.com/YCrtrUW.png]],ImageFolder..[[MoogleStuff2.png]])
		-- End Image Downloading --

		-- Add entry to sidewindow navigation list --
			InsertIfNil(nav.Menu,MoogleUpdater.GUI.NavName)
		-- End Sidewindow Navigation List --

		if nav.selected == MoogleUpdater.GUI.NavName then
			main.Contents = function()
				-- Check to see if you have pending Download Checks --
					if Valid(ModuleDownloads) then
						-- GUI:AlignFirstTextHeightToWidgets()
						Text("You need to",0)
						local x,y = GUI:CalcTextSize("Reload Lua")
						local c = GUI:Button("Reload Lua",x+10,y+10)
						if GUI:IsItemClicked(c) then
							Reload()
						end
						local check = "module"
						if Size(ModuleDownloads) > 1 then check = check.."s" end
						Text("to use your "..Size(ModuleDownloads).." new moogle "..check..".",0,true)
					end
				-- End Pending Download Checks --
				local scripts = MoogleUpdater.MoogleScripts
				if Valid(scripts) then
					for k,v in table.pairsbykeys(scripts) do
						GUI:BeginChild("##"..v.name:gsub(" ",""),0,50,true)
							if In(v.name,"Moogle Updater", "Main Window", "Moogle Functions") then
								GUI:Checkbox(v.name.." v"..v.version,true)
							else
								local tbl = loadstring(v.table)() or "NotInstalled"
								if Not(tbl,"NotInstalled") then
									tbl.Settings.enable = GUI:Checkbox(v.name.." v"..v.version,tbl.Settings.enable)
								else
									if FileExists(ImageFolder..[[KaliDownload.png]]) then
										if not FileExists(MooglePath..v.filepath) then
											GUI:AlignFirstTextHeightToWidgets()
											local c = GUI:Image(ImageFolder..[[KaliDownload.png]],19,19)
											if GUI:IsItemHovered(c) then
												Tooltip("Download and Install Lua")
												if GUI:IsItemClicked(c) then
													if not In(v.filepath,""," ",nil) then
														local lastfolder = string.gsub(MooglePath..v.filepath,"([^\\]+)$","")
														if not FolderExists(lastfolder) then
															FolderCreate(lastfolder)
														end
														Download(v.url,MooglePath..v.filepath)
													end
												end
											end
											GUI:SameLine(0,4)
											GUI:Text(v.name.." v"..v.version)
										else
											-- File Exists but need to create module.def file --
											if FileExists(string.gsub(MooglePath..v.filepath,"([^\\]+)$","")..[[module.def]]) then
												-- Module.def file exists, now ready for Lua Reload --
												InsertIfNil(ModuleDownloads,v.name)
												if FileExists(ImageFolder..[[KaliDownloaded.png]]) then
													GUI:AlignFirstTextHeightToWidgets()
													local c = GUI:Image(ImageFolder..[[KaliDownloaded.png]],19,19)
													if GUI:IsItemHovered(c) then
														Tooltip("Finished Downloading, click to reload Lua")
														if GUI:IsItemClicked(c) then
															Reload()
														end
													end
													GUI:SameLine(0,4)
													GUI:Text(v.name.." v"..v.version)
												else
													GUI:SameLine(0,23) Text(v.name.." v"..v.version)
												end
											else
												if NotNil(v.module) then
													FileWrite(string.gsub(MooglePath..v.filepath,"([^\\]+)$","")..[[module.def]],v.module)
												end
											end
										end
									else
										GUI:SameLine(0,23) Text(v.name.." v"..v.version)
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
