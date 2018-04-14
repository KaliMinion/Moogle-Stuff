local API = MoogleLib.API
API.MinionPath = GetStartupPath() local MinionPath = API.MinionPath
API.LuaPath = GetLuaModsPath() local LuaPath = API.LuaPath

API.MooglePath = LuaPath .. [[MoogleStuff Files\]] local MooglePath = API.MooglePath
API.ImageFolder = MooglePath .. [[Moogle Images\]] local ImageFolder = API.ImageFolder
API.ScriptsFolder = MooglePath .. [[Moogle Scripts\]] local ScriptsFolder = API.ScriptsFolder
API.TempFolder = MooglePath .. [[Temp\]] local TempFolder = API.TempFolder

API.ACRFolder = LuaPath .. [[ACR\CombatRoutines\]] local ACRFolder = API.ACRFolder
API.SenseProfiles = LuaPath .. [[Sense\profiles\]] local SenseProfiles = API.SenseProfiles
API.SenseTriggers = LuaPath .. [[Sense\triggers\]] local SenseTriggers = API.SenseTriggers

local MoogleScripts = {
	[1] = {
		name = [[Moogle Updater]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Updater.lua]],
		table = [[return MoogleUpdater]],
		url = [[TestFolder/Moogle Updater]],
		category = [[Core Moogle Module]],
		stability = [[open]],
		info = [[Downloads scripts, keeps them updated. :P!]]
	},
	[2] = {
		name = [[Main Window]],
		status = [[open]],
		filepath = MooglePath..[[Main Window.lua]],
		table = [[return KaliMainWindow]],
		url = [[TestFolder/Main Window]],
		category = [[Core Moogle Module]],
		stability = [[open]],
		info = [[The Main Window that all Moogle Scripts share to display the settings for each module.]]
	},
	[3] = {
		name = [[MoogleLib]],
		status = [[open]],
		filepath = MooglePath..[[MoogleLib.lua]],
		table = [[return MoogleLib]],
		url = [[TestFolder/MoogleLib]],
		category = [[Core Moogle Module]],
		stability = [[open]],
		info = [[Where all my Moogle Functions are stored.]]
	},
	[4] = {
		name = [[Moogle FPS]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Scripts\Moogle FPS.lua]],
		table = [[return MoogleFPS]],
		url = [[TestFolder/Moogle Scripts/Moogle FPS]],
		category = [[Utility]],
		stability = [[open]],
		info = [[An FPS overlay like Fraps or Nvidia's GeForce Experience. For people who have issue using Minion with other overlays.]]
	},
	[5] = {
		name = [[Moogle Text to Speech]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Scripts\Moogle TTS.lua]],
		table = [[return MoogleTTS]],
		url = [[TestFolder/Moogle Scripts/Moogle TTS]],
		category = [[Utility]],
		stability = [[open]],
		info = [[Narrates NPC dialog, as well as some other windows in game.]]
	},
	[6] = {
		name = [[Moogle PushButton]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Scripts\Moogle PushButton.lua]],
		table = [[return MooglePushButton]],
		url = [[TestFolder/Moogle Scripts/Moogle PushButton]],
		category = [[Dev]],
		stability = [[open]],
		info = [[A developer module like the one in Dev, but able to iterate PushButton presses.]]
	},
}
return MoogleScripts
