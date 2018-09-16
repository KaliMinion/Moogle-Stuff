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
	[6] = {
		name = [[Moogle PushButton]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Scripts\Moogle PushButton.lua]],
		table = [[MooglePushButton]],
		url = [[TestFolder/Moogle Scripts/Moogle PushButton]],
		category = [[Dev]],
		stability = [[open]],
		info = [[A developer module like the one in Dev, but able to iterate PushButton presses.]]
	},
	[7] = {
		name = [[Moogle Recorder]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Scripts\Moogle Recorder.lua]],
		table = [[MoogleRecorder]],
		url = [[TestFolder/Moogle Scripts/Moogle Recorder]],
		category = [[Dev]],
		stability = [[Beta]],
		info = [[A developer module to record entity actions in a timeline fashion, recording behavior and patterns.]]
	},
	[8] = {
		name = [[Moogle Music]],
		status = [[open]],
		filepath = MooglePath..[[Moogle Scripts\Moogle Music.lua]],
		table = [[MoogleMusic]],
		url = [[TestFolder/Moogle Scripts/Moogle Music]],
		category = [[Dev]],
		stability = [[Beta]],
		info = [[A branch off of Ace's Music player with a few extra features.]]
	},
}
return MoogleScripts
