local tbl = 
{
	[1] = {
		name = "Moogle Updater",
		enable = MoogleUpdater.Settings.enable or false,
		url = "",
		version = "1.0.0",
		instver = MoogleUpdater.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[2] = {
		name = "Main Window",
		enable  = KaliMainWindow.Settings.enable or false,
		url = "",
		version = "1.0.0",
		instver = KaliMainWindow.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[3] = {
		name = "Moogle Functions",
		enable = MoogleFunctions.Settings.enable or false,
		url = "",
		version = "1.0.0",
		instver = MoogleFunctions.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[4] = {
		name = "Moogle Text to Speech",
		enable = MoogleTTS.Settings.enable or false,
		url = "",
		version = "1.0.0",
		instver = MoogleTTS.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
	[5] = {
		name = "Moogle Hoarder",
		enable = MoogleHoarder.Settings.enable or false,
		url = "",
		version = "1.0.0",
		instver = MoogleHoarder.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
		lastupdate = os.time { year = 2017, month = 12, day = 9, hour = 10, min = 44 },
	},
}



return tbl
