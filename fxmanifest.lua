fx_version 'cerulean'
games { 'gta5' }

name 'Pulsar Pwnzor'
description 'Anti-cheat with token verification, AFK/aspect/FOV checks, and ped-free zones'
author 'Artmines - maintained for Pulsar Framework'
url 'https://pulsarframe.work'
version 'v1.0.0'

version_check 'yes'
github 'https://github.com/PulsarFW/pulsar_pwnzor'

client_script '@pulsar_core/components/cl_error.lua'
shared_script '@pulsar_core/core/sh_pulsar.lua'

client_scripts({
	'cl_*.lua',
	'client/*.lua',
})

server_scripts({
	'sv_*.lua',
	'server/*.lua',
})

exports({
	'SetupClient',
})

server_exports({
	'SetupServer',
})
lua54 'yes'