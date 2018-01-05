local tbl = 
{
	[1] = {
		name = "Moogle Updater",
		status = "open",
		filepath = [[Moogle Updater.lua]],
		table = "return MoogleUpdater",
		url = "https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle Updater.lua",
		version = "1.1.2",
		category = "Core",
		stability = "Core",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1515129490,
	},
	[2] = {
		name = "Main Window",
		status = "open",
		filepath = [[Main Window.lua]],
		table  = "return KaliMainWindow",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/Main Window.lua]],
		version = "1.2.1",
		category = "Core",
		stability = "Core",
		instver = KaliMainWindow.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1515129721,
	},
	[3] = {
		name = "MoogleLib",
		status = "open",
		filepath = [[MoogleLib.lua]],
		table = "return MoogleLib",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleLib.lua]],
		version = "1.1.0",
		category = "Core",
		stability = "Core",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = os.time { year = 2017, month = 12, day = 30, hour = 19, min = 59 },
	},
	[4] = {
		name = "Moogle Text to Speech",
		status = "open",
		filepath = [[Moogle Scripts\Moogle TTS\Moogle TTS.lua]],
		table = "return MoogleTTS",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle TTS.lua]],
		version = "1.1.1",
		category = "Utility",
		stability = "WiP but Working",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
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
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle FPS.lua]],
		version = "1.2.1",
		category = "Utility",
		stability = "Working",
		releasedate = os.time { year = 2017, month = 05, day = 29 },
		lastupdate = os.time { year = 2018, month = 01, day = 03, hour = 05, min = 20 },
		module = [[[Module]
Name=Moogle FPS
Dependencies=minionlib
Version=1
Files=Moogle FPS.lua
enabled=1]]
	},
}



return tbl
