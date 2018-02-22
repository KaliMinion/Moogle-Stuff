-- MOOGLE SCRIPTS START --
local tbl = 
{
	[1] = {
		name = "Moogle Updater",
		status = "open",
		filepath = [[Moogle Updater.lua]],
		table = "return MoogleUpdater",
		url = [[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleUpdater.lua]],
		version = "1.2.11",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1519329488,
		info = [[Downloads scripts, keeps them updated. :P]],
	},
	[2] = {
		name = "Main Window",
		status = "open",
		filepath = [[Main Window.lua]],
		table  = "return KaliMainWindow",
		url = [[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MainWindow.lua]],
		version = "1.2.10",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		instver = KaliMainWindow.Info.Version or false,
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1519064004,
		info = [[The Main Window that all Moogle Scripts share to display the settings for each module.]],
	},
	[3] = {
		name = "MoogleLib",
		status = "open",
		filepath = [[MoogleLib.lua]],
		table = "return MoogleLib",
		url = [[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleLib.lua]],
		version = "1.3.3",
		category = "Core Moogle Module",
		stability = "Core Moogle Module",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1519329448,
		info = [[Where all my Moogle Functions are stored.]],
	},
	[4] = {
		name = "Moogle Text to Speech",
		status = "open",
		filepath = [[Moogle Scripts\Moogle TTS\Moogle TTS.lua]],
		table = "return MoogleTTS",
		url = [[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleTTS.lua]],
		version = "1.1.5",
		category = "Utility",
		stability = "WiP but Working",
		releasedate = os.time { year = 2017, month = 12, day = 9 },
		lastupdate = 1519064202,
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
		url = [[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleFPS.lua]],
		version = "1.2.6",
		category = "Utility",
		stability = "Working",
		releasedate = os.time { year = 2017, month = 05, day = 29 },
		lastupdate = 1519063945,
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
		url = [[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MooglePushButton.lua]],
		version = "1.0.1",
		category = "Dev",
		stability = "Working",
		releasedate = os.time { year = 2018, month = 01, day = 25 },
		lastupdate = 1519064147,
		info = [[A developer module like the one in Dev, but able to iterate PushButton presses.]],
		module = [[[Module]
Name=Moogle PushButton
Dependencies=minionlib
Version=1
Files=Moogle PushButton.lua
enabled=1]]
	},
	[7] = {
		name = "Moogle Tweaks",
		status = "open",
		filepath = [[Moogle Scripts\Moogle Tweaks\Moogle Tweaks.lua]],
		table = "return MoogleTweaks",
		url = [[https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleTweaks.lua]],
		version = "1.0.1",
		category = "Utility",
		stability = "WiP but Working",
		releasedate = os.time { year = 2018, month = 02, day = 19 },
		lastupdate = 1519253097,
		info = [[Navigate to NPCs and trade in items for stuffs, temp name, will make it better later.]],
		module = [[[Module]
Name=Moogle Tweaks
Dependencies=minionlib
Version=1
Files=Moogle Tweaks.lua
enabled=1]]
	},
}
return tbl
-- MOOGLE SCRIPTS END --
