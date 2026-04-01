Config = {}

-- model name => livery indexes allowed for that vehicle.
-- Example: ["sultanrs"] = {0, 2, 5}
Config.LiveryWhitelist = {
  -- ["police3"] = { 0, 1, 3 },
}

-- If true, a vehicle with no entry in the table above can use any livery.
Config.AllowUnlistedVehicles = false

-- Optional user-facing notification callback.
-- Replace with your own notification resource.
Config.Notify = function(message)
  BeginTextCommandThefeedPost('STRING')
  AddTextComponentSubstringPlayerName(message)
  EndTextCommandThefeedPostTicker(false, false)
end
