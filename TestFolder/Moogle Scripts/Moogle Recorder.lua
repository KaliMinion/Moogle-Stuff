local MoogleRecorder = {}
local self = MoogleRecorder
local selfs = "MoogleRecorder"
local main = KaliMainWindow.GUI
local nav = KaliMainWindow.GUI.NavigationMenu

self.Info = {
	Creator = "Kali",
	Version = "0.0.1",
	StartDate = "12/09/17",
	ReleaseDate = "12/09/17",
	ChangeLog = {
		["1.0.0"] = "Initial release",
	}
}

self.GUI = {
	WindowName = "MoogleRecorder##MoogleRecorder",
	name = "Moogle Recorder",
	NavName = "Moogle Recorder",
	MiniName = "Recorder",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = "..selfs..".GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "Record Entity Actions and Behavior Patterns."
}

self.Settings = {
	enable = true,
}
local settings = self.Settings
local enable = settings.enable

self.Data = {
	loaded = false,
}
local data = self.Data
local loaded = data.loaded

function self.Init()
end

function self.Draw()
	if nav.selected == self.GUI.NavName then
		main.Contents = function()
		end
	end
end

function self.OnUpdate()
	if FinishedLoading then -- Initiate Locals --
		if loaded then -- Load User Saved Settings --
			if enable then
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
					if table.find(nav.Menu,self.GUI.NavName) == nil then
						table.insert(nav.Menu,self.GUI.NavName)
					end
				end
				MoogleSave({
					[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
				})
			end
		else
			MoogleLoad({
				[selfs .. [[.enable]]] = selfs .. [[.Settings.enable]],
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

API.Event("Gameloop.Initalize",selfs,"Initialize",self.Init)
API.Event("Gameloop.Update",selfs,"Update",self.OnUpdate)
API.Event("Gameloop.Draw",selfs,"Draw",self.Draw)

_G.MoogleRecorder = MoogleRecorder
-- End of File --
