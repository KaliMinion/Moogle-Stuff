local tbl = 
{
	[1] = {
		name = "Moogle Updater",
		filename = "MoogleUpdater.lua",
		table = "return MoogleUpdater",
		url = "",
		version = "1.0.0",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[2] = {
		name = "Main Window",
		filename = "MainWindow.lua",
		table  = "return KaliMainWindow",
		url = "",
		version = "1.0.0",
		instver = KaliMainWindow.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[3] = {
		name = "Moogle Functions",
		filename = "Functions.lua",
		table = "return MoogleFunctions",
		url = "",
		version = "1.0.0",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[4] = {
		name = "Moogle Text to Speech",
		filename = "Moogle TTS.lua",
		table = "return MoogleTTS",
		url = "",
		version = "1.0.0",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[5] = {
		name = "Moogle Hoarder",
		filename = "Moogle Hoarder.lua",
		table = "return MoogleHoarder",
		url = "https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/Moogle%20Hoarder.lua",
		version = "1.0.0",
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
}



return tbl
