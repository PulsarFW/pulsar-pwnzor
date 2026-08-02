<div align="center">

<img src="https://r2.fivemanage.com/GPYOH8Hq4GPyAY7czrgLe/pulsarbanner.png" alt="Pulsar Framework" width="100%" />

<br/>

# PULSAR-PWNZOR

### Anti-cheat — token verification, AFK/aspect-ratio/FOV checks, ped-free zones, resource start/stop tracking

<br/>

![Lua](https://img.shields.io/badge/Lua_5.4-2C2D72?style=flat-square&logo=lua&logoColor=white)
![FiveM](https://img.shields.io/badge/FiveM-F40552?style=flat-square)

<br/>

<sub>Enjoy the framework? A coffee helps keep active development, hardening, and support going.</sub>

<a href="https://buymeacoffee.com/pulsarframework"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 50px !important;width: 180px !important;" /></a>

<br/>

[Overview](#overview) · [Dependencies](#dependencies)

</div>

---

## Overview

Every other resource in the framework loads `client/check.lua` from this one alongside its own scripts — that's the actual anti-cheat hook, not something you call into by hand. Also covers AFK detection, aspect-ratio/FOV validation, `Config.PedFreeZones` (spawn-ped suppression around sensitive interiors), and tracks `onResourceStart`/`onResourceStopped` server-side.

> [!WARNING]
> This is loaded by nearly every other resource in the framework via `client_script("@pulsar_pwnzor/client/check.lua")`. Treat changes here as framework-wide, not local to this resource.

---

## Dependencies

- `pulsar_core` — framework core

---

## License

This resource is free to use and modify under the [Pulsar Framework License](LICENSE.md). Redistribution is welcome as long as it stays free — selling this resource or any derivative of it requires written permission from the Pulsar Framework team.

---

<div align="center">

![Pulsar Framework](https://img.shields.io/badge/Pulsar-Framework-7c3aed?style=flat-square)
![Built for FiveM](https://img.shields.io/badge/Built_for-FiveM-F40552?style=flat-square)

</div>
