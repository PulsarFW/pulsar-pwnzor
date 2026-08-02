AddEventHandler("Proxy:Shared:RegisterReady", function()
	exports["pulsar_core"]:RegisterComponent("Pwnzor", PWNZOR)
end)

PWNZOR = PWNZOR or {}
