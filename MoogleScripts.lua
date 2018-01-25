-- MOOGLE SCRIPTS START --
local tbl = 
{
	[1] = {
		name = "Moogle Updater",
		status = "open",
		filepath = [[Moogle Updater.lua]],
		table = "return MoogleUpdater",
		url = "https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleUpdater.lua",
		version = "1.2.8",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1516511608,
		info = [[Downloads scripts, keeps them updated. :P]],
	},
	[2] = {
		name = "Main Window",
		status = "open",
		filepath = [[Main Window.lua]],
		table  = "return KaliMainWindow",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MainWindow.lua]],
		version = "1.2.9",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		instver = KaliMainWindow.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1516909839,
		info = [[The Main Window that all Moogle Scripts share to display the settings for each module.]],
	},
	[3] = {
		name = "MoogleLib",
		status = "open",
		filepath = [[MoogleLib.lua]],
		table = "return MoogleLib",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleLib.lua]],
		version = "1.3.1",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1516909799,
		info = [[Where all my Moogle Functions are stored.]],
	},
	[4] = {
		name = "Moogle Text to Speech",
		status = "open",
		filepath = [[Moogle Scripts\Moogle TTS\Moogle TTS.lua]],
		table = "return MoogleTTS",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleTTS.lua]],
		version = "1.1.4",
		category = "Utility",
		stability = "WiP but Working",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1516509654,
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
		version = "1.2.5",
		category = "Utility",
		stability = "Working",
		releasedate = os.time { year = 2017, month = 05, day = 29 },
		lastupdate = 1516509692,
		info = [[An FPS overlay like Fraps or Nvidia's GeForce Experience. For people who have issue using Minion with other overlays.]],
		module = [[[Module]
Name=Moogle FPS
Dependencies=minionlib
Version=1
Files=Moogle FPS.lua
enabled=1]]
	},
	[6] = {
		name = "Moogle PushButton",
		status = "open",
		filepath = [[Moogle Scripts\Moogle PushButton\Moogle PushButton.lua]],
		table = "return MooglePushButton",
		url = [[https://github.com/KaliMinion/Moogle-Stuff/raw/master/MooglePushButton.lua]],
		version = "1.0.0",
		category = "Dev",
		stability = "Working",
		releasedate = os.time { year = 2018, month = 01, day = 25 },
		lastupdate = 1516910177,
		info = [[A developer module like the one in Dev, but able to iterate PushButton presses.]],
		module = [[[Module]
Name=Moogle PushButton
Dependencies=minionlib
Version=1
Files=Moogle PushButton.lua
enabled=1]]
	},
}
return tbl
-- MOOGLE SCRIPTS END --
