-- MOOGLE SCRIPTS START --
local tbl = 
{
	[1] = {
		name = "Moogle Updater",
		status = "open",
		filepath = [[Moogle Updater.lua]],
		table = "return MoogleUpdater",
		url = "https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleUpdater.lua",
		version = "1.2.6",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1516395959,
		info = [[Downloads scripts, keeps them updated. :P]],
	},
	[2] = {
		name = "Main Window",
		status = "open",
		filepath = [[Main Window.lua]],
		table  = "return KaliMainWindow",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MainWindow.lua]],
		version = "1.2.6",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		instver = KaliMainWindow.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1516396010,
		info = [[The Main Window that all Moogle Scripts share to display the settings for each module.]],
	},
	[3] = {
		name = "MoogleLib",
		status = "open",
		filepath = [[MoogleLib.lua]],
		table = "return MoogleLib",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleLib.lua]],
		version = "1.2.4",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1516395898,
		info = [[Where all my Moogle Functions are stored.]],
	},
	[4] = {
		name = "Moogle Text to Speech",
		status = "open",
		filepath = [[Moogle Scripts\Moogle TTS\Moogle TTS.lua]],
		table = "return MoogleTTS",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleTTS.lua]],
		version = "1.1.3",
		category = "Utility",
		stability = "WiP but Working",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1516181725,
		info = [[Narrates NPC dialog, as well as some other windows in game.]],
		module = [[[Module]
Name=Moogle TTS
Dependencies=minionlib
Version=1
Files=Moogle TTS.lua
enabled=1]],
	},
	[5] = {
		name = "Moogle FPS",
		status = "open",
		filepath = [[Moogle Scripts\Moogle FPS\Moogle FPS.lua]],
		table = "return MoogleFPS",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleFPS.lua]],
		version = "1.2.4",
		category = "Utility",
		stability = "Working",
		releasedate = os.time { year = 2017, month = 05, day = 29 },
		lastupdate = 1516181643,
		info = [[An FPS overlay like Fraps or Nvidia's GeForce Experience. For people who have issue using Minion with other overlays.]],
		module = [[[Module]
Name=Moogle FPS
Dependencies=minionlib
Version=1
Files=Moogle FPS.lua
enabled=1]]
	},
}
return tbl
-- MOOGLE SCRIPTS END --
