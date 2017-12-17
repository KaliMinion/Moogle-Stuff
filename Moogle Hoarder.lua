MoogleHoarder = {}

MoogleHoarder.Info = {
	Creator = "Kali",
	Version = "1.0.0",
	StartDate = "12/02/17",
	ReleaseDate = "12/02/17",
	LastUpdate = "12/02/17",
	ChangeLog = {
		["1.0.0"] = "Initial release"
	}
}

MoogleHoarder.GUI = {
	WindowName = "MoogleHoarder##MoogleHoarder", -- Window Name, each GUI Window must be unique, in all caps
	name = "Moogle Hoarder", -- Official Name of your Module
	NavName = "Item Manager",
	open = false, -- if your window is open when the bot starts
	visible = true, -- if it is visible when opened.
	MiniButton = false, -- The blue mini buttons at the bottom of the screen
	MainMenuType = 2, -- 0 = No Main Menu Entry, 1 = Normal Main Menu Entry, 2 = Expansion Menu inside Main Menu 3 = FFXIV ADDON Menu
	AddonMenuName = "MoogleStuff", -- The text you'll see in your personal submenu header
	Available = true,
	AddonMenuId = "MOOGLESTUFF##MENU_HEADER", -- Unique MenuID for your personal menu header
	AddonMenuRefName = "ffxiv_MoogleStuff", -- lowercase, no space, coding purposes only but unique to you
	ToolTip = "An item manager to organize and condense your inventory across all retainers.", -- The tooltip you see when your hover over the Minion Menu entry
	-- To have icons with your module and/or add-on menu, name the .png files the same as "name" and/or AddonMenuName
	-- Limit MainMenuType3 to personal use only
}

MoogleHoarder.Settings = {
	enable = true,
	CurrentRetainer = "",
	Step = 0,
	PlayerInventoryUpdateInterval = 10000,
	LastPlayerUpdate = 0,
	RetainerOrder = {}
}

MoogleHoarder.Inventory = {
	Player = {},
	Armoury = {},
	Retainers = {}
}

function MoogleHoarder.UpdatePlayerInventory()
	for slot,item in pairs(Inventory:Get(0):GetList()) do -- Inventory Bag Slots 1-35
		InsertIfNil(MoogleHoarder.Inventory.Player,slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(1):GetList()) do -- Inventory Bag Slots 36-70
		InsertIfNil(MoogleHoarder.Inventory.Player,35+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(2):GetList()) do -- Inventory Bag Slots 71-105
		InsertIfNil(MoogleHoarder.Inventory.Player,70+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3):GetList()) do -- Inventory Bag Slots 106-140
		InsertIfNil(MoogleHoarder.Inventory.Player,105+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(2001):GetList()) do -- Inventory Bag Elemental Shards
		InsertIfNil(MoogleHoarder.Inventory.Player,140+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(1000):GetList()) do -- Armoury Currently Equipped
		InsertIfNil(MoogleHoarder.Inventory.Armoury,slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3500):GetList()) do -- Armoury Main Hand Weapons and Tools
		InsertIfNil(MoogleHoarder.Inventory.Armoury,14+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3200):GetList()) do -- Armoury Off Hand Weapons and Tools
		InsertIfNil(MoogleHoarder.Inventory.Armoury,49+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3201):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,84+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3202):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,119+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3203):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,154+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3204):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,189+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3205):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,224+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3206):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,259+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3207):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,294+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3208):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,329+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3209):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,364+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3300):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,399+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(3400):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Armoury,417+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
end

function MoogleHoarder.UpdateRetainerInventory()
	local CurrentRetainer = MoogleHoarder.Settings.CurrentRetainer
	for slot,item in pairs(Inventory:Get(10000):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Retainers[CurrentRetainer],slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(10001):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Retainers[CurrentRetainer],25+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(10002):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Retainers[CurrentRetainer],50+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(10003):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Retainers[CurrentRetainer],75+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(10004):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Retainers[CurrentRetainer],100+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(10005):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Retainers[CurrentRetainer],125+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
	for slot,item in pairs(Inventory:Get(10006):GetList()) do
		InsertIfNil(MoogleHoarder.Inventory.Retainers[CurrentRetainer],150+slot,{name = item.name, id = item.id, ishq = item.ishq, hqid = item.hqid, slot = item.slot, type = item.type, count = item.count, max = item.max, condition = item.condition, collectability = item.collectability, spiritbond = item.spirtbond, level = item.level, requiredlevel = item.requiredlevel, class = item.class, category = item.category, uicategory = item.uicategory, searchcategory = item.searchcategory, canequip = item.canequip, equipslot = item.equipslot, price = item.price})
	end
end

MoogleHoarder.OpenAllStatus = {
	Status = false,
	CurrentRetainer = 1,
	Step = 1,
	BellID = 0
}
function MoogleHoarder.OpenAllRetainers()
	local retainer = MoogleHoarder.OpenAllStatus.CurrentRetainer
	local retainerCount = Size(MoogleHoarder.Settings.RetainerOrder)
	local status = MoogleHoarder.OpenAllStatus.Status
	local step = MoogleHoarder.Settings.Step
	local step2 = MoogleHoarder.OpenAllStatus.Step

	if Is(MoogleHoarder.OpenAllStatus.BellID,0) then
		MoogleHoarder.OpenAllStatus.BellID = CurrentTarget("id")
	end

	if (retainer-1) < retainerCount then
		d("step: "..step.." step2: "..step2)
		if Is(step,1) and Is(step2,1) then -- Select Retainer Screen
			GetControl("SelectString"):Action("SelectIndex",retainer-1)
			MoogleHoarder.OpenAllStatus.Step = 2
		elseif Is(step,2) and Is(step2,2) then -- Talk Screen
			GetControl("Talk"):Action("Click",0)
			MoogleHoarder.OpenAllStatus.Step = 3
		elseif Is(step,3) and Is(step2,3) then -- Retainer Actions Screen
			local leave = 0
			for k,v in pairs(GetControl("SelectString"):GetData()) do
				v = tostring(v):match("(%a+)%.")
				if Is(v,"Quit") then
					leave = k
				end
			end
			if Not(leave,0) then
				GetControl("SelectString"):Action("SelectIndex",leave)
				MoogleHoarder.OpenAllStatus.Step = 4
			end
		elseif Is(step,2) and Is(step2,4) then -- Talk Screen
			GetControl("Talk"):Action("Click",0)
			MoogleHoarder.OpenAllStatus.Step = 5
		elseif Is(step,0) and Is(step2,5) then -- Talk Screen
			if Is(CurrentTarget("name"),"Summoning Bell") then
				MoogleHoarder.OpenAllStatus.CurrentRetainer = retainer + 1
				MoogleHoarder.OpenAllStatus.Step = 1
			else
				Player:SetTarget(MoogleHoarder.OpenAllStatus.BellID)
				Player:Interact(MoogleHoarder.OpenAllStatus.BellID)
			end
		end
	else
		CurrentRetainer = 1
		MoogleHoarder.OpenAllStatus.Status = false
	end
end

function MoogleHoarder.NextRetainer(which)
end

function MoogleHoarder.ModuleInit()
	local MainIcon = 0
	local ModuleIcon = 0
	local MainMenuTypeName = 0
	local check = true
	local function NameCheck(t)
		for k, v in pairs(t) do
			if k == "name" and v == MoogleHoarder.GUI.AddonMenuName then
				MoogleHoarder.GUI.Available = false
				if PreveiousK == "header" then
					MoogleHoarder.GUI.MainMenuType = 3
					check = false
				elseif type(PreveiousK) == "number" then
					MoogleHoarder.GUI.MainMenuType = 2
					check = false
				end
			elseif type(v) == "table" then
				PreveiousK = k
				NameCheck(v)
			end
		end
		if check then
			for k, v in pairs(t) do
				if k == "name" and v == "ImGUI Demo" then
					MoogleHoarder.GUI.Available = false
					MoogleHoarder.GUI.MainMenuType = 1
				elseif type(v) == "table" then
					NameCheck(v)
				end
			end
		end
	end
	NameCheck(ml_gui.ui_mgr.menu.components)
	-- Checking for icon locations for your Main Menu and Module
	if FileExists(GetStartupPath().."\\GUI\\UI_Textures\\"..tostring(MoogleHoarder.GUI.AddonMenuName)..".png") then
		MainIcon = GetStartupPath().."\\GUI\\UI_Textures\\"..tostring(MoogleHoarder.GUI.AddonMenuName)..".png"
	elseif FileExists(GetStartupPath().."\\LuaMods\\"..MoogleHoarder.GUI.AddonMenuName.."\\"..tostring(MoogleHoarder.GUI.AddonMenuName)..".png") then
		MainIcon = GetStartupPath().."\\LuaMods\\"..MoogleHoarder.GUI.AddonMenuName.."\\"..tostring(MoogleHoarder.GUI.AddonMenuName)..".png"
	end
	if FileExists(GetStartupPath().."\\GUI\\UI_Textures\\"..tostring(MoogleHoarder.GUI.name)..".png") then
		ModuleIcon = GetStartupPath().."\\GUI\\UI_Textures\\"..tostring(MoogleHoarder.GUI.name)..".png"
	elseif FileExists(GetStartupPath().."\\LuaMods\\"..MoogleHoarder.GUI.name.."\\"..tostring(MoogleHoarder.GUI.name)..".png") then
		ModuleIcon = GetStartupPath().."\\LuaMods\\"..MoogleHoarder.GUI.name.."\\"..tostring(MoogleHoarder.GUI.name)..".png"
	end
	if MoogleHoarder.GUI.MainMenuType == 0 then -- Determining Menu Type chosen by user
		MainMenuTypeName = nil
	elseif MoogleHoarder.GUI.MainMenuType == 1 or MoogleHoarder.GUI.MainMenuType == 2 then
		MainMenuTypeName = "FFXIVMINION##MENU_HEADER"
	elseif MoogleHoarder.GUI.MainMenuType == 3 then
		MainMenuTypeName = MoogleHoarder.GUI.AddonMenuId
	end
	if MoogleHoarder.GUI.Available then -- create your menu headers
		if MoogleHoarder.GUI.MainMenuType == 2 then
			ml_gui.ui_mgr:AddMember({ id = MoogleHoarder.GUI.AddonMenuId, name = MoogleHoarder.GUI.AddonMenuName, texture = MainIcon}, MainMenuTypeName)
		elseif MoogleHoarder.GUI.MainMenuType == 3 then
			ml_gui.ui_mgr:AddComponent({header = { id = MainMenuTypeName, expanded = false, name = MoogleHoarder.GUI.AddonMenuName, texture = MainIcon}, members = {}})
		end
	end
	if MoogleHoarder.GUI.MainMenuType == 2 then
		ml_gui.ui_mgr:AddSubMember({ id = MoogleHoarder.GUI.WindowName, name = MoogleHoarder.GUI.name, onClick = function () MoogleHoarder.GUI.open = not MoogleHoarder.GUI.open end, tooltip = MoogleHoarder.GUI.ToolTip, texture = ModuleIcon}, MainMenuTypeName, MoogleHoarder.GUI.AddonMenuId)
	else
		if FileExists(ModuleIcon) then -- Creating Minion Menu entry with icon
			ml_gui.ui_mgr:AddMember({ id = MoogleHoarder.GUI.WindowName, name = MoogleHoarder.GUI.name, onClick = function () if (not MoogleHoarder.GUI.open) then MoogleHoarder.GUI.open = true else MoogleHoarder.GUI.open = false end end, tooltip = MoogleHoarder.GUI.ToolTip, texture = ModuleIcon}, MainMenuTypeName)
		else -- Creating Minion Menu entry without icon
			ml_gui.ui_mgr:AddMember({ id = MoogleHoarder.GUI.WindowName, name = MoogleHoarder.GUI.name, onClick = function () if (not MoogleHoarder.GUI.open) then MoogleHoarder.GUI.open = true else MoogleHoarder.GUI.open = false end end, tooltip = MoogleHoarder.GUI.ToolTip}, MainMenuTypeName)
		end
	end

	if (MoogleHoarder.GUI.MiniButton) then -- Mini Button
		table.insert(ml_global_information.menu.windows, {name = MoogleHoarder.GUI.name, openWindow = function() MoogleHoarder.GUI.open = true end, isOpen = function() return MoogleHoarder.GUI.open end})
	end
	if (MoogleHoarder.GUI.MiniButton) then
		table.insert(ml_global_information.menu.windows, menuTab) -- Mini Button
	end
	if MoogleHoarder.GUI.Available then
		if MoogleHoarder.GUI.MainMenuType == 2 then
			-- Adding the ImGUI Test Window as a Minion Menu entry
			ml_gui.ui_mgr:AddSubMember({ id = "ImGui Demo", name = "ImGUI Demo", onClick = function () ml_gui.showtestwindow = not ml_gui.showtestwindow end, tooltip = "ImGui Demo is an overview of what's possible with the UI.", texture = GetStartupPath().."\\GUI\\UI_Textures\\ImGUI.png"}, MainMenuTypeName, MoogleHoarder.GUI.AddonMenuId)
			-- Adding the ImGUI Test Window as a Minion Menu entry
			ml_gui.ui_mgr:AddSubMember({ id = "ImGui Metrics", name = "ImGUIMetrics", onClick = function () ml_gui.showmetricswindow = not ml_gui.showmetricswindow end, tooltip = "ImGui Metrics shows every window's rendering information, visible or hidden.", texture = GetStartupPath().."\\GUI\\UI_Textures\\Metrics.png"}, MainMenuTypeName, MoogleHoarder.GUI.AddonMenuId)
		else
			-- Adding the ImGUI Test Window as a Minion Menu entry
			ml_gui.ui_mgr:AddMember({ id = "ImGui Demo", name = "ImGUI Demo", onClick = function () ml_gui.showtestwindow = true end, tooltip = "ImGui Demo is an overview of what's possible with the UI.", texture = GetStartupPath().."\\GUI\\UI_Textures\\ImGUI.png"}, MainMenuTypeName)
			-- Adding the ImGUI Test Window as a Minion Menu entry
			ml_gui.ui_mgr:AddMember({ id = "ImGui Metrics", name = "ImGUIMetrics", onClick = function () ml_gui.showmetricswindow = true end, tooltip = "ImGui Metrics shows every window's rendering information, visible or hidden.", texture = GetStartupPath().."\\GUI\\UI_Textures\\Metrics.png"}, MainMenuTypeName)
		end
	end
	--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
	--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
	--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
end

function MoogleHoarder.Draw()
	if NotNil(MoogleHoarder) and MoogleHoarder.Settings.enable then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleHoarder.Settings

		if nav.selected == MoogleHoarder.GUI.NavName then
			main.Contents = function()
				local TotalInventoryCount = Size(MoogleHoarder.Inventory.Player) + Size(MoogleHoarder.Inventory.Armoury)
				for k,v in pairs(MoogleHoarder.Inventory.Retainers) do
					TotalInventoryCount = TotalInventoryCount + Size(v)
				end
				Text("Number of items owned: "..TotalInventoryCount)
			end
		end
	end
end

function MoogleHoarder.OnUpdate( event, tickcount )
	if NotNil(MoogleHoarder) and MoogleHoarder.Settings.enable  then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleHoarder.Settings
		local inv = MoogleHoarder.Inventory

		-- Add entry to sidewindow navigation list --
		if table.find(nav.Menu,MoogleHoarder.GUI.NavName) == nil then
			table.insert(nav.Menu,MoogleHoarder.GUI.NavName)
		end


		-- Step Detection Logic --
			local Step = MoogleHoarder.Settings.Step
			local CurrentRetainer = MoogleHoarder.Settings.CurrentRetainer
			local sstr = GetControlStrings("SelectString")
			local retalk = GetControlStrings("Talk")

			if Is(CurrentTarget("name"),"Summoning Bell") then
				if NotNil(sstr) then
					local str = sstr[2]

					if Is(str,"Select retainer.") then MoogleHoarder.Settings.Step = 1 Step = 1
					else MoogleHoarder.Settings.Step = 3 Step = 3 end
				end
				if IsControlOpen("Talk") and NotNil(retalk) then
					MoogleHoarder.Settings.Step = 2 Step = 2
					if CurrentRetainer ~= retalk[2] then
						MoogleHoarder.Settings.CurrentRetainer = retalk[2]
						MoogleHoarder.UpdateRetainerInventory()
					end
					InsertIfNil(MoogleHoarder.Inventory.Retainers,retalk[2])
					MoogleHoarder.UpdateRetainerInventory()
				end
			else
				MoogleHoarder.Settings.Step = 0 Step = 0
			end
		-- End Step Detection Logic --

		-- Initalize the entire data gathering process by checking if your current target is the Summoning Bell --
		if Is(MoogleHoarder.OpenAllStatus.Status) then
			MoogleHoarder.OpenAllRetainers()
		elseif Not(Step,0) then
			if Is(Step,1) then
				if Empty(MoogleHoarder.Settings.RetainerOrder) then
					d("Retainer Table is empty, doing first run populate retainer inventory update.")
					for k,v in pairs(GetControl("SelectString"):GetData()) do
						v = tostring(v):match("(%a+)%.")
						if Not(v,"Quit") then
							InsertIfNil(MoogleHoarder.Settings.RetainerOrder,k+1,v)
						end
					end
					MoogleHoarder.OpenAllStatus.Status = true
				end
			end
		end

		if TimeSince(MoogleHoarder.Settings.LastPlayerUpdate) >= MoogleHoarder.Settings.PlayerInventoryUpdateInterval then
			MoogleHoarder.Settings.LastPlayerUpdate = Now()
			MoogleHoarder.UpdatePlayerInventory()
		end
	end
end

--item:Move(bag,slot)

RegisterEventHandler("Module.Initalize", MoogleHoarder.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleHoarder.Draw)
RegisterEventHandler("Gameloop.Update", MoogleHoarder.OnUpdate)