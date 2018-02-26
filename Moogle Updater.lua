MoogleUpdater = {}

MoogleUpdater.Info = {
	Creator = "Kali",
	Version = "1.3.0",
	StartDate = "12/09/17",
	ReleaseDate = "12/09/17",
	LastUpdate = "12/09/17",
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
		["1.3.0"] = "Added Save Settings"
	}
}

MoogleUpdater.GUI = {
	NavName = "Moogle Script Management",
	open = false
}

MoogleUpdater.Settings = {
	enable = true,
	AutoUpdate = true, -- if False, then notifies the user when an update is available, otherwise notifies the user that it updated a script
	CheckInterval = 30, -- in the unit of time the user has selected
	CheckUnit = "Seconds",
	LastCheck = 0,

	AutoReload = false, -- if True, once updating a script, the updater will automatically reload lua to make the update live
	Notifications = true, -- if False, then toaster notifications will be disabled
	ToasterTime = 5, -- if set to zero, toaster popups never disappear until clicked on or updating the script
}
local self = "MoogleUpdater"

MoogleUpdater.MoogleScripts = {}
MoogleUpdater.NewScripts = {}
MoogleUpdater.NewLabelScripts = {}
MoogleUpdater.UpdatedScripts = {}
MoogleUpdater.UpdatedScriptsReady = {}
MoogleUpdater.UpdatedLabelScripts = {}
local NeedWebRequest = true
local NeedWebContent = true

local API, Lua, General, Debug, IO, Math, OS, String, Table, Gui, MinionPath, LuaPath, MooglePath, ImageFolder, ScriptsFolder, ACRFolder, SenseProfiles, SenseTriggers, Initialize, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, RecordKeybinds, Error, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, Size, Empty, NotEmpty, d2, DrawDebugInfo, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, MoogleCMDQueue, MoogleDownloadBuffer, CMDTable, CMD, DownloadString, DownloadTable, DownloadFile, VersionCheck, Ping, Split, starts, ends, StrToTable, Valid, NotValid, pairs, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables

local function UpdateLocals1()
	API = MoogleLib.API Lua = MoogleLib.Lua General = Lua.general Debug = Lua.debug IO = Lua.io Math = Lua.math OS = Lua.os String = Lua.string Table = Lua.table Gui = MoogleLib.Gui MinionPath = API.MinionPath LuaPath = API.LuaPath MooglePath = API.MooglePath ImageFolder = API.ImageFolder ScriptsFolder = API.ScriptsFolder ACRFolder = API.ACRFolder SenseProfiles = API.SenseProfiles SenseTriggers = API.SenseTriggers Initialize = API.Initialize Vars = API.Vars Distance2D = API.Distance2D Distance3D = API.Distance3D CurrentTarget = API.CurrentTarget MovePlayer = API.MovePlayer SetTarget = API.SetTarget ConvertCID = API.ConvertCID Entities = API.Entities Entities2 = API.Entities2 EntitiesUpdateInterval = API.EntitiesUpdateInterval EntitiesLastUpdate = API.EntitiesLastUpdate UpdateEntities = API.UpdateEntities CMDKeyPress = API.CMDKeyPress SendKey = API.SendKey RecordKeybinds = API.RecordKeybinds Error = General.Error IsNil = General.IsNil NotNil = General.NotNil Is = General.Is IsAll = General.IsAll Not = General.Not NotAll = General.NotAll Type = General.Type NotType = General.NotType Size = General.Size Empty = General.Empty NotEmpty = General.NotEmpty d2 = Debug.d2 DrawDebugInfo = Debug.DrawDebugInfo Sign = Math.Sign Round = Math.Round Convert4Bytes = Math.Convert4Bytes PowerShell = OS.PowerShell CreateFolder = OS.CreateFolder DeleteFile = OS.DeleteFile MoogleCMDQueue = OS.MoogleCMDQueue MoogleDownloadBuffer = OS.MoogleDownloadBuffer CMDTable = OS.CMDTable CMD = OS.CMD DownloadString = OS.DownloadString DownloadTable = OS.DownloadTable
end

local function UpdateLocals2()
	DownloadFile = OS.DownloadFile VersionCheck = OS.VersionCheck Ping = OS.Ping Split = String.Split starts = String.starts ends = String.ends StrToTable = String.ToTable Valid = Table.Valid NotValid = Table.NotValid pairs = Table.pairs InsertIfNil = Table.InsertIfNil RemoveIfNil = Table.RemoveIfNil UpdateIfChanged = Table.UpdateIfChanged RemoveExpired = Table.RemoveExpired Unpack = Table.Unpack Print = Table.Print WindowStyle = Gui.WindowStyle WindowStyleClose = Gui.WindowStyleClose ColorConv = Gui.ColorConv SameLine = Gui.SameLine Indent = Gui.Indent Unindent = Gui.Unindent Space = Gui.Space Text = Gui.Text Checkbox = Gui.Checkbox Tooltip = Gui.Tooltip GetRemaining = Gui.GetRemaining VirtualKeys = Gui.VirtualKeys OrderedKeys = Gui.OrderedKeys IndexToDecimal = Gui.IndexToDecimal HotKey = Gui.HotKey DrawTables = Gui.DrawTables
end

function MoogleUpdater.ModuleInit()
	if MoogleLib then
		UpdateLocals1() UpdateLocals2()
		MoogleLoad({
			["MoogleUpdater.enable"] = "MoogleUpdater.Settings.enable",
			["MoogleUpdater.AutoUpdate"] = "MoogleUpdater.Settings.AutoUpdate",
			["MoogleUpdater.CheckInterval"] = "MoogleUpdater.Settings.CheckInterval",
			["MoogleUpdater.CheckUnit"] = "MoogleUpdater.Settings.CheckUnit",
			["MoogleUpdater.LastCheck"] = "MoogleUpdater.Settings.LastCheck",
			["MoogleUpdater.AutoReload"] = "MoogleUpdater.Settings.AutoReload",
			["MoogleUpdater.Notifications"] = "MoogleUpdater.Settings.Notifications",
			["MoogleUpdater.ToasterTime"] = "MoogleUpdater.Settings.ToasterTime"
		})
		-- DownloadTable([[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleScripts.lua]],"MoogleUpdater.MoogleScripts")
	io.popen([[powershell -Command "$PSVer = 'PowerShell Version: ' + $PSVersionTable.PSVersion.Major + '.' + $PSVersionTable.PSVersion.Minor; $WinVer = 'Windows Version: ' + (Get-WmiObject -class Win32_OperatingSystem).Caption + ' ' + (Get-CimInstance Win32_OperatingSystem).OSArchitecture; $PackVer = 'Service Pack Version: ' + (Get-CimInstance Win32_OperatingSystem).ServicePackMajorVersion + '.' + (Get-CimInstance Win32_OperatingSystem).ServicePackMinorVersion ; $OSVer = 'OS Version: ' + (Get-CimInstance Win32_OperatingSystem).Version ; ($PSVer, $WinVer, $PackVer, $OSVer) | Out-File -filepath ']]..LuaPath..[[MoogleStuff Files\System Info.txt'"]])
	end
end

MoogleUpdater.TimeUnits = {"Seconds","Minutes","Hours","Days","Weeks","Months"}

local ModuleDownloads = {}
local DownloadOneTimers = {}
local PendingDeletion = {}
local AdjustChildren = {}
local NeedImages = true
local FinishedUpdating = true
function MoogleUpdater.Draw()
	if MoogleLib and KaliMainWindow ~= nil then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleUpdater.Settings

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
				for url,image in table.pairsbykeys(Images) do
					if not FileExists(ImageFolder..image) then
						if IsNil(MoogleDownloadBuffer[url]) then
							MoogleDebug.NeedImagesURL = url
							DownloadFile(url,ImageFolder..image)
						end
						finished = false
					else
						if IsNil(MoogleDownloadBuffer[url]) then
							MoogleDebug.NeedImagesURL = url
							DownloadFile(url,ImageFolder..image)
							finished = false
						end
					end
				end
				if finished then
					NeedImages = false
				end
			end
			MoogleDebug.NeedImages = NeedImages
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

						GUI:PushStyleVar(GUI.StyleVar_WindowPadding,5,5)
						GUI:PushStyleVar(GUI.StyleVar_ItemSpacing,0,0)
						GUI:PushStyleVar(GUI.StyleVar_ItemInnerSpacing,0,0)
						GUI:BeginChild("##"..v.name:gsub(" ",""),0,yChild,true)
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

							if category == "Core Moogle Module" then
								-- Core Files ignore all checks --
									if FileExists(ImageFolder..[[CoreModule.png]]) then
										local c = GUI:Image(ImageFolder..[[CoreModule.png]],19,19)

										if GUI:IsItemHovered(c) then
											Tooltip("Core Moogle Module")
										end
									end
									Space(4)
									Text(name)

									local Label = ""
									local LabelSpace = 0

									if table.find(MoogleUpdater.NewLabelScripts,name) then
										Label = Label.."[New]"
										LabelSpace = LabelSpace + 4
										Text("[New]",{"1","0","0","1"},4,true)
									end

									if table.find(MoogleUpdater.UpdatedScripts,name) then
										Label = Label.."[Updated]"
										LabelSpace = LabelSpace + 4
										Text("[Updated]",{"1","1","0","1"},4,true)
									end

									local LabelWidth = GUI:CalcTextSize(Label) + LabelSpace

									Space(width - (Icon + xName + LabelWidth + xCategory))
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
														DownloadFile(url,MooglePath..filepath)
														DownloadOneTimers[url] = MooglePath..filepath
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

								local Label = ""

								if table.find(MoogleUpdater.NewLabelScripts,name) then
									Label = "[New]"
									Text("[New]",{"1","0","0","1"},4,true)
								end

								if table.find(MoogleUpdater.UpdatedScripts,name) then
									Label = "[Updated]"
									Text("[Updated]",{"1","1","0","1"},4,true)
								end

								local LabelWidth = GUI:CalcTextSize(Label) + 4

								if Not(tbl,"NotInstalled") or FileExists(MooglePath..filepath) then
									Space(width - (Icon + xName + LabelWidth + xCategory + 4 + xStability + 4 + Icon))
								else
									Space(width - (Icon + xName + LabelWidth + xCategory + 4 + xStability + 4))
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
							local LeftText = GUI:CalcTextSize("Last Update: 000d 00h 00m 00s")
							GUI:BeginChild("##LeftInfo"..name, LeftText, GUI:GetItemsLineHeightWithSpacing() * 3)
								Text("Version: "..v.version)
								Text("Release Date: "..tostring(os.date ("%x", v.releasedate)))
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
							GUI:EndChild() SameLine(0)
							GUI:BeginChild("##Description"..name, GUI:GetContentRegionAvail() - 30, GUI:GetItemsLineHeightWithSpacing() * 3,true)
								GUI:PushTextWrapPos()
								GUI:Text(v.info)
							GUI:EndChild() SameLine(0)
							GUI:BeginChild("##Image"..name, 30, GUI:GetItemsLineHeightWithSpacing() * 3)
								local x,y = GUI:GetContentRegionMax()
								GUI:Dummy(0,y-30)
								GUI:Dummy(3,0) SameLine(0)
								if FileExists(ImageFolder..[[ViewCode.png]]) then
									local c = GUI:Image(ImageFolder..[[ViewCode.png]],30,30)
									if GUI:IsItemHovered(c) then
										Tooltip("View Code")
										if GUI:IsItemClicked(c) then
											io.popen([[cmd /c start ]]..v.url)
										end
									end
								end
							GUI:EndChild()

							local xChildAvail,yChildAvail = GUI:GetContentRegionAvail()
							if AdjustChildren[k] == nil then
								AdjustChildren[k] = 50 - yChildAvail
							else
								AdjustChildren[k] = AdjustChildren[k] - yChildAvail
							end
						GUI:EndChild()
						GUI:PopStyleVar(3)
						GUI:Dummy(0,1)
					end
				end
				DrawDebugInfo("Moogle Updater",DownloadOneTimers,MoogleCMDQueue,MoogleDownloadBuffer,OS.CMDTable)
				--OS.CMDTable
				--MoogleCMDQueue
				--MoogleUpdater
				--MoogleDebug
			end
		end
	end
end

local webpage = {}
local timevalue = 0
local FirstRun = false
local docheck = true
function MoogleUpdater.OnUpdate(event, tickcount)
	if MoogleLib then
		MoogleSave({
			["MoogleUpdater.enable"] = "MoogleUpdater.Settings.enable",
			["MoogleUpdater.AutoUpdate"] = "MoogleUpdater.Settings.AutoUpdate",
			["MoogleUpdater.CheckInterval"] = "MoogleUpdater.Settings.CheckInterval",
			["MoogleUpdater.CheckUnit"] = "MoogleUpdater.Settings.CheckUnit",
			["MoogleUpdater.LastCheck"] = "MoogleUpdater.Settings.LastCheck",
			["MoogleUpdater.AutoReload"] = "MoogleUpdater.Settings.AutoReload",
			["MoogleUpdater.Notifications"] = "MoogleUpdater.Settings.Notifications",
			["MoogleUpdater.ToasterTime"] = "MoogleUpdater.Settings.ToasterTime"
		})
	-- Check if all the folders are created --
		local MooglePath = GetLuaModsPath()..[[MoogleStuff Files\]]
		if not FolderExists(MooglePath..[[Moogle Images]]) then
			FolderCreate(MooglePath..[[Moogle Images]])
		end
		if not FolderExists(MooglePath..[[Moogle Scripts]]) then
			FolderCreate(MooglePath..[[Moogle Scripts]])
		end

	-- Check for OneTime Downloads that need to be executed once more --
	if MoogleLib and table.valid(DownloadOneTimers) then
		for url,filepath in pairs(DownloadOneTimers) do
			if IsNil(OS.MoogleDownloadBuffer[url]) and MoogleCMDQueue[url] then
				DownloadFile(url,filepath)
			else
				DownloadOneTimers[url] = nil
				OS.MoogleDownloadBuffer[url] = nil
			end
		end
	end

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

					-- Remove Folders and Files --
						if not In(filepath,""," ",nil) then
							local lastfolder = string.gsub(MooglePath..filepath,"([^\\]+)$","")
							if FolderExists(lastfolder) then
								io.popen([[rmdir /s /q "]]..lastfolder..[["]])
								notchanged = false
							end
						end

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

	if MoogleUpdater.Settings.AutoUpdate or not table.valid(MoogleUpdater.MoogleScripts) then
		-- Check to see if Moogle Scripts has been updated --
			if os.difftime(os.time(),MoogleUpdater.Settings.LastCheck) >= timevalue then
				local scripts = MoogleUpdater.MoogleScripts
				
				local tbl = DownloadString([[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleScripts.lua]])
				if NotNil(tbl) and type(tbl) == "string" then
					webpage = loadstring(tbl)()
				end
				if table.valid(webpage) then
					MoogleDebug.LastSuccessfulUpdate = Now()
					for i,e in pairs(webpage) do
						if scripts[i] == nil then -- New Script
							MoogleUpdater.NewScripts[i] = e.name
						elseif scripts[i].version ~= e.version then -- Updated Script
							if MoogleUpdater.UpdatedScripts[i] == nil then
								FinishedUpdating = false
								DownloadFile(e.url,MooglePath..e.filepath)
								MoogleUpdater.UpdatedScripts[i] = e.name
							end
						else
							if loadstring(e.table..[[ ~= nil]])() and loadstring(e.table..[[.Info ~= nil]])() then
								local InstalledScriptVersion = (loadstring(e.table..[[.Info.Version]])())
								if scripts[i].version ~= InstalledScriptVersion then
									-- New Script --
									if MoogleUpdater.UpdatedScripts[i] == nil then
										FinishedUpdating = false
										DownloadFile(e.url,MooglePath..e.filepath)
										MoogleUpdater.UpdatedScripts[i] = e.name
									end
								end
							end
						end
						if os.difftime(os.time(),e.releasedate) < 604800 then
							-- New label scripts, released within 1 week --
							MoogleUpdater.NewLabelScripts[i] = e.name
						end

						if table.find(MoogleUpdater.NewLabelScripts,e.name) and os.difftime(os.time(),e.releasedate) > 604800 then
							MoogleUpdater.NewLabelScripts[table.find(MoogleUpdater.NewLabelScripts,e.name)] = nil
						end

						if os.difftime(os.time(),e.lastupdate) < 604800 then
							-- New label scripts, released within 1 week --
							MoogleUpdater.UpdatedLabelScripts[i] = e.name
						end	

						if table.find(MoogleUpdater.UpdatedLabelScripts,e.name) and os.difftime(os.time(),e.lastupdate) > 604800 then
							MoogleUpdater.UpdatedLabelScripts[table.find(MoogleUpdater.UpdatedLabelScripts,e.name)] = nil
						end			
					end
					MoogleUpdater.MoogleScripts = webpage
					webpage = {}
					if not table.valid(MoogleUpdater.UpdatedScripts) then
						MoogleUpdater.Settings.LastCheck = os.time()
					else
						if FinishedUpdating then
							MoogleUpdater.Settings.LastCheck = os.time()
						else
							MoogleUpdater.Settings.LastCheck = MoogleUpdater.Settings.LastCheck + 5
						end
					end
				end

				local same = true
				if MoogleUpdater.Settings.AutoUpdate and table.valid(MoogleUpdater.UpdatedScripts) then
					for k,v in pairs(MoogleUpdater.UpdatedScripts) do
						if MoogleUpdater.UpdatedScriptsReady[k] == nil then
							MoogleUpdater.UpdatedScriptsReady[k] = false
							DownloadFile(scripts[k].url,MooglePath..scripts[k].filepath)
							same = false
							FinishedUpdating = false
						elseif MoogleUpdater.UpdatedScriptsReady[k] ~= v then
							DownloadFile(scripts[k].url,MooglePath..scripts[k].filepath)
							MoogleUpdater.UpdatedScriptsReady[k] = v
						end
					end
					if same then
						if FinishedUpdating == false then
							FinishedUpdating = true
						end
						if not FFXIV_Common_BotRunning and MoogleUpdater.Settings.AutoReload then
							Reload()
						end
					end
				end
			end
		-- End Moogle Scripts Check --
	end end
end

RegisterEventHandler("Module.Initalize", MoogleUpdater.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleUpdater.Draw)
RegisterEventHandler("Gameloop.Update", MoogleUpdater.OnUpdate)
