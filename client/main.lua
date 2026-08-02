CreateThread(function()
	RegisterEvents()
	RegisterCommands()
end)

AddEventHandler("onResourceStart", function(resourceName)
	if GetGameTimer() >= 10000 then
		TriggerServerEvent("Pwnzor:Server:ResourceStarted", resourceName)
	end
end)

AddEventHandler("onResourceStopped", function(resourceName)
	TriggerServerEvent("Pwnzor:Server:ResourceStopped", resourceName)
end)
