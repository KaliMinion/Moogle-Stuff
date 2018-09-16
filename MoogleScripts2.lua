local MooglePath = GetLuaModsPath() .. [[MoogleStuff Files\]]

local MoogleScripts = {
	[1] = {
		name = [[Moogle Updater]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Updater.lua]],
		table = [[MoogleUpdater]],
		url = [[TestFolder/Moogle Updater]],
		category = [[Core Moogle Module]],
		stability = [[open]],
		info = [[Downloads scripts, keeps them updated. :P!]]
	},
	[2] = {
		name = [[Main Window]],
		status = [[open]],
		filepath = MooglePath..[[Main Window.lua]],
		table = [[KaliMainWindow]],
		url = [[TestFolder/Main Window]],
		category = [[Core Moogle Module]],
		stability = [[open]],
		info = [[The Main Window that all Moogle Scripts share to display the settings for each module.]]
	},
	[3] = {
		name = [[MoogleLib]],
		status = [[open]],
		filepath = MooglePath..[[MoogleLib.lua]],
		table = [[MoogleLib]],
		url = [[TestFolder/MoogleLib]],
		category = [[Core Moogle Module]],
		stability = [[open]],
		info = [[Where all my Moogle Functions are stored.]]
	},
	[4] = {
		name = [[Moogle FPS]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Scripts\Moogle FPS.lua]],
		table = [[MoogleFPS]],
		url = [[TestFolder/Moogle Scripts/Moogle FPS]],
		category = [[Utility]],
		stability = [[open]],
		info = [[An FPS overlay like Fraps or Nvidia's GeForce Experience. For people who have issue using Minion with other overlays.]]
	},
}
return MoogleScripts
