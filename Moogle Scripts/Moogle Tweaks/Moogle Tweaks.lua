MoogleTweaks = {}

MoogleTweaks.Info = {
	Creator = "Kali",
	Version = "1.0.2",
	StartDate = "02/02/18",
	StartDate = "02/02/18",
	StartDate = "02/02/18",
	ChangeLog = {
		["1.0.0"] = "Initial release"
	}
}

MoogleTweaks.GUI = {
	WindowName = "MoogleTweaks##MoogleTweaks",
	name = "Moogle Tweaks",
	NavName = "Moogle Tweaks",
	MiniName = "Tweaks",
	open = false,
	visible = true,
	MiniButton = false,
	OnClick = loadstring("KaliMainWindow.GUI.open = true KaliMainWindow.GUI.NavigationMenu.selected = MoogleTweaks.GUI.NavName"),
	IsOpen = loadstring("return KaliMainWindow.GUI.open"),
	ToolTip = "Minion Tweaks and small scripts compiled into one module."
}

MoogleTweaks.Settings = {
	enable = true,
	filterclosed = true,
}
local self = "MoogleTweaks"

MoogleTweaks.Data = {
	AccursedHoardAppraisal = false,
	GCExpertDelivery = false,
	SellTripleTriadCards = false,
	MiniCactpot = false,
	PlayerMoveMode = nil,
	Navigating = false,
}

local API, Lua, General, Debug, IO, Math, OS, String, Table, Gui, MinionPath, LuaPath, MooglePath, ImageFolder, ScriptsFolder, ACRFolder, SenseProfiles, SenseTriggers, Initialize, Vars, Distance2D, Distance3D, CurrentTarget, MovePlayer, SetTarget, ConvertCID, Entities, Entities2, EntitiesUpdateInterval, EntitiesLastUpdate, UpdateEntities, CMDKeyPress, SendKey, RecordKeybinds, Error, IsNil, NotNil, Is, IsAll, Not, NotAll, Type, NotType, Size, Empty, NotEmpty, d2, DrawDebugInfo, Sign, Round, Convert4Bytes, PowerShell, CreateFolder, DeleteFile, MoogleCMDQueue, MoogleDownloadBuffer, CMDTable, CMD, DownloadString, DownloadTable, DownloadFile, VersionCheck, Ping, Split, starts, ends, StrToTable, Valid, NotValid, pairs, InsertIfNil, RemoveIfNil, UpdateIfChanged, RemoveExpired, Unpack, Print, WindowStyle, WindowStyleClose, ColorConv, SameLine, Indent, Unindent, Space, Text, Checkbox, Tooltip, GetRemaining, VirtualKeys, OrderedKeys, IndexToDecimal, HotKey, DrawTables

local function UpdateLocals1()
	API = MoogleLib.API Lua = MoogleLib.Lua General = Lua.general Debug = Lua.debug IO = Lua.io Math = Lua.math OS = Lua.os String = Lua.string Table = Lua.table Gui = MoogleLib.Gui MinionPath = API.MinionPath LuaPath = API.LuaPath MooglePath = API.MooglePath ImageFolder = API.ImageFolder ScriptsFolder = API.ScriptsFolder ACRFolder = API.ACRFolder SenseProfiles = API.SenseProfiles SenseTriggers = API.SenseTriggers Initialize = API.Initialize Vars = API.Vars Distance2D = API.Distance2D Distance3D = API.Distance3D CurrentTarget = API.CurrentTarget MovePlayer = API.MovePlayer SetTarget = API.SetTarget ConvertCID = API.ConvertCID Entities = API.Entities Entities2 = API.Entities2 EntitiesUpdateInterval = API.EntitiesUpdateInterval EntitiesLastUpdate = API.EntitiesLastUpdate UpdateEntities = API.UpdateEntities CMDKeyPress = API.CMDKeyPress SendKey = API.SendKey RecordKeybinds = API.RecordKeybinds Error = General.Error IsNil = General.IsNil NotNil = General.NotNil Is = General.Is IsAll = General.IsAll Not = General.Not NotAll = General.NotAll Type = General.Type NotType = General.NotType Size = General.Size Empty = General.Empty NotEmpty = General.NotEmpty d2 = Debug.d2 DrawDebugInfo = Debug.DrawDebugInfo Sign = Math.Sign Round = Math.Round Convert4Bytes = Math.Convert4Bytes PowerShell = OS.PowerShell CreateFolder = OS.CreateFolder DeleteFile = OS.DeleteFile MoogleCMDQueue = OS.MoogleCMDQueue MoogleDownloadBuffer = OS.MoogleDownloadBuffer CMDTable = OS.CMDTable CMD = OS.CMD DownloadString = OS.DownloadString DownloadTable = OS.DownloadTable
end

local function UpdateLocals2()
	DownloadFile = OS.DownloadFile VersionCheck = OS.VersionCheck Ping = OS.Ping Split = String.Split starts = String.starts ends = String.ends StrToTable = String.ToTable Valid = Table.Valid NotValid = Table.NotValid pairs = Table.pairs InsertIfNil = Table.InsertIfNil RemoveIfNil = Table.RemoveIfNil UpdateIfChanged = Table.UpdateIfChanged RemoveExpired = Table.RemoveExpired Unpack = Table.Unpack Print = Table.Print WindowStyle = Gui.WindowStyle WindowStyleClose = Gui.WindowStyleClose ColorConv = Gui.ColorConv SameLine = Gui.SameLine Indent = Gui.Indent Unindent = Gui.Unindent Space = Gui.Space Text = Gui.Text Checkbox = Gui.Checkbox Tooltip = Gui.Tooltip GetRemaining = Gui.GetRemaining VirtualKeys = Gui.VirtualKeys OrderedKeys = Gui.OrderedKeys IndexToDecimal = Gui.IndexToDecimal HotKey = Gui.HotKey DrawTables = Gui.DrawTables
end

function MoogleTweaks.ModuleInit()
	UpdateLocals1() UpdateLocals2()
	Initialize(MoogleTweaks.GUI)
	DownloadFile([[https://i.imgur.com/SBGNinb.png]],ImageFolder..MoogleTweaks.GUI.name..".png")
end

local step = 0
local lastreward
function MoogleTweaks.AccursedHoardAppraisal()
	local ExpeditionBishop = {
		CID = 1017659,
		localmapid = 153,
		pos = {h = -0.98797219991684, x = 182.19337463379, y = 8.9280824661255, z = -39.75354385376}
	}

	if MovePlayer(ExpeditionBishop.pos, ExpeditionBishop.localmapid) and SetTarget(ConvertCID(ExpeditionBishop.CID),true) then
		if step == 0 then
			if IsControlOpen("Talk") then
				step = step + 1
			end
		end
		if step == 1 then
			if IsControlOpen("SelectString") then
				step = step + 1
			elseif IsControlOpen("Talk") then
				UseControlAction("Talk","Click")
			end
		end
		if step == 2 then
			if IsControlOpen("SelectString") then
				GetControl("SelectString"):Action("SelectIndex",0)
			end
			if IsControlOpen("ItemAppraisal") then
				step = step + 1
			end
		end
		if step == 3 then
			if IsControlOpen("ItemAppraisal") then
				local data = GetControl("ItemAppraisal"):GetRawData()
				if data then
					local Reward = data[3] if Reward then
						Reward = Reward.value
						if lastreward ~= Reward then
							d(Reward)
							lastreward = Reward
						end
					end
					local Bronze = data[10] if Bronze then Bronze = Bronze.value.A end
					local Iron = data[14] if Iron then Iron = Iron.value.A end
					local Silver = data[18] if Silver then Silver = Silver.value.A end
					local Gold = data[22] if Gold then Gold = Gold.value.A end
					local Total = Bronze + Iron + Silver + Gold

					if Total > 0 then
						GetControl("ItemAppraisal"):PushButton(34,1)
					else
						GetControl("ItemAppraisal"):PushButton(24,1)
						step = 0
						MoogleTweaks.Data.AccursedHoardAppraisal = false
						Player:SetMoveMode(MoogleTweaks.Data.PlayerMoveMode)
					end
				end
			elseif IsControlOpen("SelectYesno") then
				UseControlAction("SelectYesno","Yes")
			end
		end
	end
end

local step,errormes,remain,officer = 0,true
function MoogleTweaks.GCExpertDelivery()
	local SerpentPersonalOfficer = {
		CID = 1002394,
		localmapid = 132,
		pos = {h = 0.5055980682373, x = -69.535400390625, y = -0.50095015764236, z = -9.9946899414063}
	}

	if IsNil(officer) then
		if Player.grandcompany == 2 then
			officer = table.deepcopy(SerpentPersonalOfficer)
		end
	else
		if MovePlayer(officer.pos, officer.localmapid) and SetTarget(ConvertCID(officer.CID),true) then
			if step == 0 then
				if IsControlOpen("SelectString") then
					step = step + 1
				end
			end
			if step == 1 then
				if IsControlOpen("GrandCompanySupplyList") then
					step = step + 1
				elseif IsControlOpen("SelectString") then
					GetControl("SelectString"):Action("SelectIndex",0)
				end
			end
			if step == 2 then
				if IsControlOpen("GrandCompanySupplyList") then
					local GCSupplyList = GetControl("GrandCompanySupplyList")
					local data = GCSupplyList:GetRawData()

					if data[7] then
						if data[7].value.A == 2 then
							if data[8].value.A > 0 then
								local seals = GCSupplyList:GetStrings()[6]
								if seals and seals ~= "" then
									local current,trash = seals:match("^.+/"):gsub("%D","")
									local max,trash = seals:match("^.+/(.+)"):gsub("%D","")
									remain = tonumber(max) - tonumber(current)
									-- if data[9].value.A == 0 then
									-- 	if errormes ~= true then errormes = true end
										GCSupplyList:PushButton(34,0)
										step = step + 1
									-- else
									-- 	if errormes then
									-- 		errormes = false
									-- 		Error("Please set Expert Delivery filter to Hide Armoury Chest Items, option 3.")
									-- 		step = 0
									-- 		MoogleTweaks.Data.GCExpertDelivery = false
									-- 	end
									-- end
								end
							else
								d("Completed Grand Company Expert Exchange turn-in.")
								step = 0
								MoogleTweaks.Data.GCExpertDelivery = false
							end
						else
							GCSupplyList:PushButton(24,4)
						end
					end
				end
			end
			if step == 3 then
				if IsControlOpen("GrandCompanySupplyReward") then
					local GCSupplyReward = GetControl("GrandCompanySupplyReward")
					local data = GCSupplyReward:GetRawData()
					local A = tonumber(data[10].value.A)
					local B = tonumber(data[10].value.B)
					if A < 0 then A = 256 - A end
					local value = (B * 256) + A

					if remain then
						if remain > value then
							if errormes ~= true then errormes = true end
							GetControl("GrandCompanySupplyReward"):PushButton(24,0)
							step = step - 1
						else
							if errormes then
								errormes = false
								GetControl("GrandCompanySupplyReward"):PushButton(24,1)
								Error("Please spend your Grand Company seals, terminating turn-in process.")
								step = 0
								MoogleTweaks.Data.GCExpertDelivery = false
							end
						end
					end
				end
			end
		end
	end
end

local step,CardTable,LastMPG,OpenTime = 0
function MoogleTweaks.SellTripleTriadCards()
	local TripleTriadTrader = {
		CID = 1010478,
		localmapid = 144,
		pos = {h = 2.0858142375946, x = -99.198913574219, y = -0.86297023296356, z = 66.117309570313}
	}

	if MovePlayer(TripleTriadTrader.pos, TripleTriadTrader.localmapid) and SetTarget(ConvertCID(TripleTriadTrader.CID),true) then
		if step == 0 then
			if IsControlOpen("SelectIconString") then
				step = step + 1
			end
		end
		if step == 1 then
			if IsControlOpen("TripleTriadCoinExchange") then
				step = step + 1
			elseif IsControlOpen("SelectIconString") then
				GetControl("SelectIconString"):Action("SelectIndex",1)
			end
		end
		if step == 2 then
			if IsControlOpen("ShopCardDialog") then
				step = step + 1
			elseif IsControlOpen("TripleTriadCoinExchange") then
				local ctrl = GetControl("TripleTriadCoinExchange")
				if ctrl and Size(ctrl) > 1 then
					local data = ctrl:GetRawData()
					if data and Size(data) > 1 then
						local count = Convert4Bytes(data[2])
						if count > 0 then
							if data[1] and NotAll(data[1].value,nil,""," ") then
								LastMPG = data[1].value
								local Card = data[45].value:gsub("[^%a%s%p%d]","")
								local ItemID = Convert4Bytes(data[165])
								CardTable = GetItem(ItemID)
								local Price = Convert4Bytes(data[85])
								local Qty = Convert4Bytes(data[125])
								local InDeck = data[205].value

								if InDeck then
									d("Selling "..Card.." ["..tostring(ItemID).."] for "..tostring(Price).." MGP.")
									ctrl:PushButton(34,1)
									step = step + 1
								else
									d(Card.." ["..tostring(ItemID).."] not in deck, exiting menu to use card as item.")
									ctrl:Close()
									step = 90
								end
							end
						else
							d("Finished selling cards, exiting menu.")
							ctrl:Close()
							step = 0
							MoogleTweaks.Data.SellTripleTriadCards = false
						end
					end
				end
			end
		end
		if step == 3 then
			if IsControlOpen("ShopCardDialog") then
				step = step + 1
				OpenTime = Now()
			end
		end
		if step == 4 then
			if IsControlOpen("ShopCardDialog") and TimeSince(OpenTime) > 100 then
				local ctrl = GetControl("ShopCardDialog")
				if ctrl and Size(ctrl) > 1 then
					local data = ctrl:GetRawData()
					if data and Size(data) > 1 then
						if data[4].value == LastMPG then
							ctrl:PushButton(24,0) -- Sell Card
							step = step + 1
						end
					end
				end
			end
		end
		if step == 5 then
			if IsControlOpen("TripleTriadCoinExchange") then
				local ctrl = GetControl("TripleTriadCoinExchange")
				if ctrl and Size(ctrl) > 1 then
					local data = ctrl:GetRawData()
					if data and Size(data) > 1 then
						local count = Convert4Bytes(data[2])
						if count > 0 then
							if data[1] and NotAll(data[1].value,nil,""," ") then
								local current = data[1].value
								if current and current ~= "" and LastMPG ~= current then
									step = 2
								end
							end
						else
							d("Finished selling cards, exiting menu.")
							ctrl:Close()
							step = 0
							MoogleTweaks.Data.SellTripleTriadCards = false
						end
					end
				end
			end
		end
		if step == 90 then
			if CardTable and Valid(CardTable) then
				CardTable:Cast()
				if MIsCasting() then
					step = 91
				end
			end
		end
		if step == 91 then
			if not MIsCasting() then
				step = 0
			end
		end
	end
end

local step,countcheck,lastmark = 0,1,0
function MoogleTweaks.MiniCactpot()
	local MiniCactpotBroker = {
		CID = 1010445,
		localmapid = 144,
		pos = {h = 2.0428621768951, x = -49.302001953125, y = 1.6000002622604, z = 22.201843261719}
	}

	if MovePlayer(MiniCactpotBroker.pos, MiniCactpotBroker.localmapid) and SetTarget(ConvertCID(MiniCactpotBroker.CID),true) then
		if step == 0 then
			if IsControlOpen("LotteryDaily") then
				step = 4
			elseif IsControlOpen("SelectIconString") then
				step = step + 1
			elseif IsControlOpen("Talk") then
				step = 2
			else
				SetTarget(ConvertCID(MiniCactpotBroker.CID),true)
			end
		end
		if step == 1 then
			if IsControlOpen("Talk") then
				step = step + 1
			elseif IsControlOpen("SelectIconString") then
				GetControl("SelectIconString"):Action("SelectIndex",0)
			end
		end
		if step == 2 then
			if IsControlOpen("SelectIconString") then
				-- We have used all of our uses --
				step = 0
				countcheck = 1
				GetControl("SelectIconString"):Action("SelectIndex",2)
				MoogleTweaks.Data.MiniCactpot = false
				d("All 3 tickets have been used, daily limit reached.")
			elseif IsControlOpen("SelectYesno") then
				step = step + 1
			elseif IsControlOpen("Talk") then
				GetControl("Talk"):Action("Click")
			end
		end
		if step == 3 then
			if IsControlOpen("LotteryDaily") then
				step = step + 1
			elseif IsControlOpen("SelectYesno") then
				GetControl("SelectYesno"):Action("Yes")
			end
		end
		if step == 4 then
			if IsControlOpen("Talk") then
				GetControl("Talk"):Action("Click")
			end
			if IsControlOpen("GoldSaucerReward") then
				countcheck = 1
				step = step + 1
			elseif IsControlOpen("LotteryDaily") then
				local ctrl = GetControl("LotteryDaily")
				if ctrl and Size(ctrl) > 1 then
					local data = ctrl:GetRawData()
					if data and Size(data) > 1 then
						local avail = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true}

						local Slots = {
							NW = data[7].value,
							N = data[8].value,
							NE = data[9].value,
							W = data[10].value,
							C = data[11].value,
							E = data[12].value,
							SW = data[13].value,
							S = data[14].value,
							SE = data[15].value
						}
						local total = 0
						for k,v in pairs(Slots) do
							total = total + v
						end

						if total > 0 then
							local Uncover = {
								NW = function() ctrl:PushButton(24,1) end,
								N = function() ctrl:PushButton(24,2) end,
								NE = function() ctrl:PushButton(24,3) end,
								W = function() ctrl:PushButton(24,4) end,
								C = function() ctrl:PushButton(24,5) end,
								E = function() ctrl:PushButton(24,6) end,
								SW = function() ctrl:PushButton(24,7) end,
								S = function() ctrl:PushButton(24,8) end,
								SE = function() ctrl:PushButton(24,9) end
							}
							local RowCount = {NWSE = 0, NWSW = 0, NS = 0, NESE = 0, NESW = 0, NWNE = 0, WE = 0, SWSE = 0}
							local RowValue = {NWSE = 0, NWSW = 0, NS = 0, NESE = 0, NESW = 0, NWNE = 0, WE = 0, SWSE = 0}
							local RowLowestPotential = {NWSE = 0, NWSW = 0, NS = 0, NESE = 0, NESW = 0, NWNE = 0, WE = 0, SWSE = 0}
							local RowHighestPotential = {NWSE = 0, NWSW = 0, NS = 0, NESE = 0, NESW = 0, NWNE = 0, WE = 0, SWSE = 0}
							local Row = {
								NWSE = function() ctrl:PushButton(24,10) end,
								NWSW = function() ctrl:PushButton(24,11) end,
								NS = function() ctrl:PushButton(24,12) end,
								NESE = function() ctrl:PushButton(24,13) end,
								NESW = function() ctrl:PushButton(24,14) end,
								NWNE = function() ctrl:PushButton(24,15) end,
								WE = function() ctrl:PushButton(24,16) end,
								SWSE = function() ctrl:PushButton(24,17) end,
							}
							local Payout = {[6] = 10000, [7] = 36, [8] = 720, [9] = 360, [10] = 80, [11] = 252, [12] = 108, [13] = 72, [14] = 54, [15] = 180, [16] = 72, [17] = 180, [18] = 119, [19] = 36, [20] = 306, [21] = 1080, [22] = 144, [23] = 1800, [24] = 3600}

							local stage = data[1].value

							local uncovered = 0
							for k,v in table.pairsbykeys(Slots) do
								if v ~= 0 then
									avail[v] = false
									uncovered = uncovered + 1
								end
							end

							local count = 0
							for k,v in table.pairsbykeys(Slots) do
								if v ~= 0 then
									count = count + 1
									for i,e in table.pairsbykeys(RowCount) do
										if string.len(i) / string.len(k) == 2 then
											if string.match(i,k) then
												RowCount[i] = RowCount[i] + 1
												RowValue[i] = RowValue[i] + v
											end
										end
									end
								end
							end

							local SlotCount = {}
							local absmin = 10001
							local absmax = 0
							for k,v in table.pairsbykeys(RowLowestPotential) do
								local row = {}
								row[1] = k:sub(1,k:len()/2)
								row[3] = k:sub(k:len()/2+1,k:len())

								if row[1] and row[3] then
									local Find = {NW = {SE = "C", SW = "W", NE = "N"}, N = {S = "C"}, NE = {SE = "E", SW = "C"}, W = {E = "C"}, SW = {SE = "S"}}
									row[2] = Find[row[1]][row[3]]

									local rowcount = 0
									if Slots[row[1]] ~= 0 then rowcount = rowcount + 1 end
									if Slots[row[2]] ~= 0 then rowcount = rowcount + 1 end
									if Slots[row[3]] ~= 0 then rowcount = rowcount + 1 end

									local current = Slots[row[1]] + Slots[row[2]] + Slots[row[3]]
									local min = 10001
									local max = 0

									local temp = {}
									for i=1, 9 do
										if Slots[row[1]] == 0 then
											if avail[i] then
												temp[1] = i
											else
												temp[1] = nil
											end
										else
											temp[1] = Slots[row[1]]
										end

										if temp[1] then
											for e=1, 9 do
												if Slots[row[2]] == 0 then
													if avail[e] and e ~= i then
														temp[2] = e
													else
														temp[2] = nil
													end
												else
													temp[2] = Slots[row[2]]
												end

												if temp[2] then
													for j=1, 9 do
														if Slots[row[3]] == 0 then
															if avail[j] and j ~= e and j ~= i then
																temp[3] = j
															else
																temp[3] = nil
															end
														else
															temp[3] = Slots[row[3]]
														end

														if temp[3] and #temp == 3 then
															local value = Payout[temp[1] + temp[2] + temp[3]]

															if SlotCount[row[1]] == nil then
																SlotCount[row[1]] = 1
															else
																SlotCount[row[1]] = SlotCount[row[1]] + 1
															end
															if SlotCount[row[2]] == nil then
																SlotCount[row[2]] = 1
															else
																SlotCount[row[2]] = SlotCount[row[2]] + 1
															end
															if SlotCount[row[3]] == nil then
																SlotCount[row[3]] = 1
															else
																SlotCount[row[3]] = SlotCount[row[3]] + 1
															end

															if value < min then min = value end
															if value > max then max = value end
														end
													end
												end
											end
										end
									end

									RowLowestPotential[k] = min
									RowHighestPotential[k] = max

									if min < absmin then absmin = min end
									if max > absmax then absmax = max end
								end
							end

							table.print(SlotCount)

							local absmin2 = 10001
							local absmax2 = 0
							for k,v in pairs(RowHighestPotential) do
								if v < absmin2 then absmin2 = v end
								if v > absmax2 then absmax2 = v end
							end

							d("RowLowestPotential:") table.print(RowLowestPotential)
							d("RowHighestPotential:") table.print(RowHighestPotential)
							local str1 = "Rows with the Lowest of the Low Values ["..tostring(absmin).."] are: "
							local str2 = "Rows with the Highest of the Low Values ["..tostring(absmax).."] are: "
							for k,v in pairs(RowLowestPotential) do
								if v == absmin then str1 = str1..k.." " end
								if v == absmax then str2 = str2..k.." " end
							end

							absmaxtbl = {}
							local str3 = "Rows with the Lowest of the High Values ["..tostring(absmin2).."] are: "
							local str4 = "Rows with the Highest of the High Values ["..tostring(absmax2).."] are: "
							for k,v in pairs(RowHighestPotential) do
								if v == absmin2 then str3 = str3..k.." " end
								if v == absmax2 then
									str4 = str4..k.." "
									absmaxtbl[#absmaxtbl+1] = k
								end
							end

							d("--------------------------------")
							d(str1)
							d(str2)
							d(str3)
							d(str4)
							if stage == 0 or stage == 1 then
								-- Select three slots to uncover --
								if uncovered == countcheck and countcheck < 4 then
									local max = 0
									local tbl = {}
									local slotrows = {
										NW = {
											NWSE = true,
											NWSW = true,
											NWNE = true
										},
										N = {
											NS = true,
											NWNE = true
										},
										NE = {
											NESE = true,
											NESW = true,
											NWNE = true
										},
										W = {
											WE = true,
											NWSW = true
										},
										C = {
											NWSE = true,
											NS = true,
											NESW = true,
											WE = true
										},
										E = {
											NESE = true,
											WE = true
										},
										SW = {
											NWSW = true,
											NESW = true,
											SWSE = true
										},
										S = {
											NS = true,
											SWSE = true
										},
										SE = {
											NWSE = true,
											NESE = true,
											SWSE = true
										}
									}
									for k,v in pairs(SlotCount) do
										if Slots[k] == 0 then
											local found = false
											for i,e in pairs(slotrows[k]) do
												if table.find(absmaxtbl,i) then
													found = true
												end
											end
											if found then
												if v == max then
													tbl[#tbl+1] = k
												elseif v > max then
													max = v
													tbl = {}
													tbl[#tbl+1] = k
												end
											end
										end
									end

									Uncover[table.randomvalue(tbl)]()
									countcheck = countcheck + 1
									lastmark = Now()
								elseif uncovered ~= countcheck then
									if TimeSince(lastmark) > 500 then
										countcheck = uncovered
										lastmark = Now()
									end
								end

							elseif stage == 2 then
								-- Select a line to add up --
								Row[table.randomvalue(absmaxtbl)]()
								ctrl:PushButton(24,18)
							elseif stage == 5 then
								step = step + 1
							end
						end
					end
				end
			end
		end
		if step == 5 then
			if IsControlOpen("GoldSaucerReward") then
				step = step + 1
			end
		end
		if step == 6 then
			if not IsControlOpen("GoldSaucerReward") then
				if IsControlOpen("LotteryDaily") then
					GetControl("LotteryDaily"):PushButton(24,18)
				elseif IsControlOpen("Talk") then
					step = step + 1
				end
			end
		end
		if step == 7 then
			if IsControlOpen("Talk") then
				step = 2
			end
		end
	end
end

function MoogleTweaks.Draw()
	if MoogleLib ~= nil then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleTweaks.Settings

		if nav.selected == MoogleTweaks.GUI.NavName then
			main.Contents = function()
				if GUI:SmallButton("Accursed Hoard Appraisal") then
					MoogleTweaks.Data.AccursedHoardAppraisal = true
				end

				if GUI:SmallButton("Grand Company Expert Delivery") then
					MoogleTweaks.Data.GCExpertDelivery = true
				end

				Space() Text("Gridania only atm... need the other NPC locations.")

				if GUI:SmallButton("Sell Triple Triad Cards for MGP") then
					MoogleTweaks.Data.SellTripleTriadCards = true
				end

				if GUI:SmallButton("Mini Cactpot") then
					MoogleTweaks.Data.MiniCactpot = true
				end

				if GUI:SmallButton("Help! I'm stuck executing a function!") then
					MoogleTweaks.Data = {
						AccursedHoardAppraisal = false,
						GCExpertDelivery = false,
						SellTripleTriadCards = false,
						MiniCactpot = false,
						PlayerMoveMode = nil,
						Navigating = false,
					}
					step = 0
					lastreward = nil
					errormes = true
					remain = nil
					officer = nil
					CardTable = nil
					LastMPG = nil
					OpenTime = nil
					countcheck = 1
					lastmark = 0
					if MIsMoving() then Player:Stop() end
				end
				Space() Text("(Reset, temp fix if I missed something)")
			end
		end
	end
end

function MoogleTweaks.OnUpdate( event, tickcount )
	if MoogleLib ~= nil and MoogleTweaks.Settings.enable then
		local main = KaliMainWindow.GUI
		local nav = KaliMainWindow.GUI.NavigationMenu
		local settings = MoogleTweaks.Settings
		if NotNil (Player.settings) and table.valid(Player.settings) then
			if IsNil(MoogleTweaks.Data.PlayerMoveMode) then MoogleTweaks.Data.PlayerMoveMode = Player.settings.movemode end

			if MoogleTweaks.Data.Navigating == false then
				if MoogleTweaks.Data.PlayerMoveMode ~= Player.settings.movemode then
					MoogleTweaks.Data.PlayerMoveMode = Player.settings.movemode
				end
			end

			if table.find(nav.Menu,MoogleTweaks.GUI.NavName) == nil then
				table.insert(nav.Menu,MoogleTweaks.GUI.NavName)
			end

			if MoogleTweaks.Data.AccursedHoardAppraisal then
				MoogleTweaks.AccursedHoardAppraisal()
			end

			if MoogleTweaks.Data.GCExpertDelivery then
				MoogleTweaks.GCExpertDelivery()
			end

			if MoogleTweaks.Data.SellTripleTriadCards then
				MoogleTweaks.SellTripleTriadCards()
			end

			if MoogleTweaks.Data.MiniCactpot then
				MoogleTweaks.MiniCactpot()
			end
		end
	end
end

RegisterEventHandler("Module.Initalize", MoogleTweaks.ModuleInit)
RegisterEventHandler("Gameloop.Draw", MoogleTweaks.Draw)
RegisterEventHandler("Gameloop.Update", MoogleTweaks.OnUpdate)
