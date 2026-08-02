local _blacklistedClientEvents = {
	"esx:getSharedObject",
	"ambulancier:selfRespawn",
	"bank:transfer",
	"esx_ambulancejob:revive",
	"esx-qalle-jail:openJailMenu",
	"esx_jailer:wysylandoo",
	"esx_society:openBossMenu",
	"esx:spawnVehicle",
	"esx_status:set",
	"HCheat:TempDisableDetection",
	"UnJP",
}

local afkCodes = {}

local _blacklistedCommands = {
	"brutan",
	"chocolate",
	"haha",
	"killmenu",
	"KP",
	"lol",
	"lynx",
	"opk",
	--"panic",
	"panickey",
	"panik",
	-- "pk",
	"FunCtionOk",
	"porcodiooo",
	"demmerda",
	"puzzi",
	"jolmany",
}

local _retrieved = {}

function RegisterCallbacks()
	plsr.Chat:RegisterStaffCommand("toggleafk", function(source, args, rawCommand)
		local disabled = GlobalState["DisableAFK"] or false
		GlobalState["DisableAFK"] = not disabled

		plsr.Chat.Send.System:Single(
			source,
			string.format("AFK Kicking %s", GlobalState["DisableAFK"] and "Disabled" or "Enabled")
		)
	end, {
		help = "Enabled/Disable AFK Kicks",
	}, 0)

	-- plsr.Chat:RegisterAdminCommand("pwnzorban", function(source, args, rawCommand)
	-- 	local player = plsr.Fetch:SID(tonumber(args[1]))
	-- 	if player ~= nil then
	-- 		plsr.Punishment.Ban:Source(player:GetData("Source"), -1, args[2], "Pwnzor")
	-- 	end
	-- end, {
	-- 	help = "Fake Pwnzor Ban",
	-- 	params = {
	-- 		{
	-- 			name = "Target",
	-- 			help = "State ID of Who You Want To Ban",
	-- 		},
	-- 		{
	-- 			name = "Reason",
	-- 			help = "Reason For The Ban",
	-- 		},
	-- 	},
	-- }, 2)

	-- plsr.Chat:RegisterAdminCommand("pwnzorsource", function(source, args, rawCommand)
	-- 	local player = plsr.Fetch:Source(tonumber(args[1]))
	-- 	if player ~= nil then
	-- 		plsr.Punishment.Ban:Source(tonumber(args[1]), -1, args[2], "Pwnzor")
	-- 	end
	-- end, {
	-- 	help = "Ban Player From Server",
	-- 	params = {
	-- 		{
	-- 			name = "Target",
	-- 			help = "Source of Who You Want To Ban",
	-- 		},
	-- 		{
	-- 			name = "Reason",
	-- 			help = "Reason For The Ban",
	-- 		},
	-- 	},
	-- }, 2)

	plsr.Callbacks:RegisterServerCallback("Pwnzor:GetEvents", function(source, data, cb)
		if not plsr.Pwnzor.Players:Get(source, "GetEvents") then
			plsr.Pwnzor.Players:Set(source, "GetEvents")
			cb(_blacklistedClientEvents)
		else
			if not plsr.Fetch:Source(source).Permissions:IsAdmin() then
				plsr.Punishment.Ban:Source(source, -1, "Attempt To Recall GetEvents", "Pwnzor")
			end
		end
	end)

	plsr.Callbacks:RegisterServerCallback("Pwnzor:GetCommands", function(source, data, cb)
		if not plsr.Pwnzor.Players:Get(source, "GetCommands") then
			plsr.Pwnzor.Players:Set(source, "GetCommands")
			cb(_blacklistedCommands)
		else
			if not plsr.Fetch:Source(source).Permissions:IsAdmin() then
				plsr.Punishment.Ban:Source(source, -1, "Attempt To Recall GetCommands", "Pwnzor")
			end
		end
	end)

	plsr.Callbacks:RegisterServerCallback("Pwnzor:AFK", function(source, data, cb)
		if Config.Components.AFK.Enabled then
			plsr.Punishment:Kick(source, "You Were Kicked For Being AFK", "Pwnzor", true)
		end
	end)

	local _fovScreenshotLast = {}

	plsr.Callbacks:RegisterServerCallback("Pwnzor:FOV", function(source, data, cb)
		if Config.Components.FOV.Enabled then
			local char = plsr.Fetch:CharacterSource(source)
			local fov = data.fov
			if char then
				if not _fovScreenshotLast[source] or (GetGameTimer() - _fovScreenshotLast[source]) > 30000 then
					_fovScreenshotLast[source] = GetGameTimer()
					plsr.Pwnzor:Screenshot(char:GetData("SID"), string.format("Detected Modified FOV: %s", fov))
				end

				plsr.Logger:Warn(
					"Pwnzor",
					string.format(
						"%s %s (%s) Detected Modified FOV: %s",
						char:GetData("First"),
						char:GetData("Last"),
						char:GetData("SID"),
						fov
					),
					{
						console = true,
						file = false,
						database = true,
						discord = {
							embed = true,
							type = "error",
							webhook = GetConvar("discord_pwnzor_webhook", ""),
						},
					}
				)

				if Config.Components.FOV.Options.KickPlayer then
					Wait(5000) -- need time to process screenshot

					plsr.Punishment:Kick(src, string.format("Detected Modified FOV: %s", fov), "Pwnzor", true)
				end
			end
		end
	end)

	plsr.Callbacks:RegisterServerCallback("Pwnzor:AspectRatio", function(source, data, cb)
		if Config.Components.AspectRatio.Enabled then
			local src = source
			local char = plsr.Fetch:CharacterSource(src)
			if char then
				plsr.Pwnzor:Screenshot(char:GetData("SID"), "Detected Unusual Resolution")

				plsr.Logger:Warn(
					"Pwnzor",
					string.format(
						"%s %s (%s) Detected Unusual Resolution",
						char:GetData("First"),
						char:GetData("Last"),
						char:GetData("SID")
					),
					{
						console = true,
						file = false,
						database = true,
						discord = {
							embed = true,
							type = "error",
							webhook = GetConvar("discord_pwnzor_webhook", ""),
						},
					}
				)

				if Config.Components.AspectRatio.Options.KickPlayer then
					Wait(5000) -- need time to process screenshot

					plsr.Punishment:Kick(src, "Detected Unusual Resolution", "Pwnzor", true)
				end
			end
		end
	end)

	plsr.Callbacks:RegisterServerCallback("Pwnzor:Trigger", function(source, data, cb)
		cb("💙 From Pwnzor 🙂")
		if not plsr.Fetch:Source(source).Permissions:IsAdmin() then
			plsr.Logger:Info(
				"Pwnzor",
				string.format("Pwnzor Trigger For %s: %s (check) %s (match)", source, data.check, data.match),
				{
					console = true,
					file = true,
					database = true,
					discord = {
						embed = true,
						type = "error",
						webhook = GetConvar("discord_pwnzor_webhook", ""),
					},
				}
			)
			plsr.Punishment.Ban:Source(
				source,
				-1,
				string.format("Pwnzor Trigger: %s (check) %s (match)", data.check, data.match),
				"Pwnzor"
			)
		end
	end)

	plsr.Callbacks:RegisterServerCallback("Pwnzor:GetCode", function(source, data, cb)
		afkCodes[source] = plsr.Generator.Hacker.ingVerb()
		cb(afkCodes[source])
	end)

	plsr.Callbacks:RegisterServerCallback("Pwnzor:EnterCode", function(source, data, cb)
		if afkCodes[source] ~= nil then
			if afkCodes[source] == data then
				afkCodes[source] = nil
				cb(true)
			else
				plsr.Execute:Client(source, "Notification", "Error", "Incorrect AFK Code")
				cb(false)
			end
		else
			cb(false)
		end
	end)
end
