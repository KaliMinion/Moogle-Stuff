local tbl = 
{
	[1] = {
		name = "Moogle Updater",
		filepath = [[Moogle Updater.lua]],
		table = "return MoogleUpdater",
		url = "https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle%20Updater.lua",
		version = "1.1.0",
		category = "Core",
		stability = "Core",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 30, hour = 19, min = 53 },
	},
	[2] = {
		name = "Main Window",
		filepath = [[Main Window.lua]],
		table  = "return KaliMainWindow",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/Main%20Window.lua]],
		version = "1.2.0",
		category = "Core",
		stability = "Core",
		instver = KaliMainWindow.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 30, hour = 19, min = 53 },
	},
	[3] = {
		name = "MoogleLib",
		filepath = [[MoogleLib.lua]],
		table = "return MoogleLib",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleLib.lua]],
		version = "1.1.0",
		category = "Core",
		stability = "Core",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 30, hour = 19, min = 59 },
	},
	[4] = {
		name = "Moogle Text to Speech",
		filepath = [[Moogle Scripts\Moogle TTS\Moogle TTS.lua]],
		table = "return MoogleTTS",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle TTS.lua]],
		version = "1.0.0",
		category = "Utility",
		stability = "WiP but Working",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		module = [[[Module]
Name=Moogle TTS
Dependencies=minionlib
Version=1
Files=Moogle TTS.lua
enabled=1]],
	},
	[5] = {
		name = "Moogle Hoarder",
		filepath = [[Moogle Scripts\Moogle Hoarder\Moogle Hoarder.lua]],
		table = "return MoogleHoarder",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle Hoarder.lua]],
		version = "1.0.0",
		category = "Utility",
		stability = "Barely even a Module",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		module = [[[Module]
Name=Moogle Hoarder
Dependencies=minionlib
Version=1
Files=Moogle Hoarder.lua
enabled=1]]
	},
}



return tbl
