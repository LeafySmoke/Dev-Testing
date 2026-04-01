# jg-mechanic livery whitelist workaround

This resource adds a safe livery gate you can call from `jg-mechanic` so only allowed liveries are applied.

## Why this workaround

Most mechanic scripts directly apply the selected livery. If you need roleplay/lore restrictions (e.g., only approved liveries per model), you need a whitelist check between UI selection and final vehicle modification.

## Install

1. Copy this folder into your server resources.
2. Ensure it starts before `jg-mechanic`:

```cfg
ensure ox_lib
ensure jg-mechanic-livery-whitelist-workaround
ensure jg-mechanic
```

3. Edit `config.lua` and fill `Config.LiveryWhitelist`.

## Integrate with jg-mechanic

In the spot where `jg-mechanic` currently applies livery directly, replace it with:

```lua
local ok, reason = exports['jg-mechanic-livery-whitelist-workaround']:applyWhitelistedLivery(vehicle, selectedLivery)
if not ok then
  -- optional: your framework notify
  print(('[jg-livery-whitelist] blocked livery: %s'):format(reason or 'not allowed'))
end
```

If your `jg-mechanic` flow is server-driven, trigger this event on the vehicle owner client:

```lua
TriggerClientEvent('jg-livery-whitelist:client:applyRequestedLivery', targetSource, VehToNet(vehicle), selectedLivery)
```

## Notes

- This uses `ox_lib` callback (`lib.callback.await/register`).
- Livery index validity is checked against `GetVehicleLiveryCount`.
- Whitelist is keyed by **display model name** (lowercase), such as `police3`, `sultanrs`, etc.
