local tbl = 
{
	[1] = {
		name = "Moogle Updater",
		filepath = [[MoogleUpdater.lua]],
		table = "return MoogleUpdater",
		url = "",
		version = "1.0.0",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[2] = {
		name = "Main Window",
		filepath = [[MainWindow.lua]],
		table  = "return KaliMainWindow",
		url = "https://github.com/KaliMinion/Moogle-Stuff/raw/master/MainWindow.lua",
		version = "1.0.0",
		instver = KaliMainWindow.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[3] = {
		name = "Moogle Functions",
		filepath = [[Functions.lua]],
		table = "return MoogleFunctions",
		url = "https://github.com/KaliMinion/Moogle-Stuff/raw/master/Functions.lua",
		version = "1.0.0",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[4] = {
		name = "Moogle Text to Speech",
		filepath = [[Moogle Scripts\Moogle TTS\Moogle TTS.lua]],
		table = "return MoogleTTS",
		url = "https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle%20TTS.lua",
		version = "1.0.0",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[5] = {
		name = "Moogle Hoarder",
		filepath = [[Moogle Scripts\Moogle Hoarder\Moogle Hoarder.lua]],
		table = "return MoogleHoarder",
		url = "https://github.com/KaliMinion/Moogle-Stuff/raw/master/Moogle%20Hoarder.lua",
		version = "1.0.0",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
}



return tbl
