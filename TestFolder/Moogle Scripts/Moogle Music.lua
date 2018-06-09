local MoogleMusic = {}
local self = MoogleMusic
local selfs = "MoogleMusic"
local main = KaliMainWindow.GUI
local nav = KaliMainWindow.GUI.NavigationMenu

self.Info = {
	Creator = "Kali",
	Version = "1.0.0",
	StartDate = "06/09/2018",
	ReleaseDate = "06/09/2018",
	ChangeLog = {
		["1.0.0"] = "Initial release",
	}
}

self.GUI = {
	WindowName = "MoogleMusic##MoogleMusic",
	name = "Moogle Music",
	NavName = "Moogle Music",
	MiniName = "Music",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = "..selfs..".GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "A branch off of Ace's Music player with a few extra features."
}

self.Settings = {
	enable = true,
}
local settings = self.Settings
local enable = settings.enable

self.Data = {
	loaded = false,
	Database = {}
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

_G.MoogleMusic = MoogleMusic
-- End of File --
