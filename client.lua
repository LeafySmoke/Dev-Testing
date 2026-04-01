local RESOURCE_EXPORT = 'applyWhitelistedLivery'

local function applyWhitelistedLivery(vehicle, requestedLivery)
  if vehicle == 0 or not DoesEntityExist(vehicle) then
    return false, 'Invalid vehicle'
  end

  local model = GetEntityModel(vehicle)
  local maxLiveries = GetVehicleLiveryCount(vehicle)

  if maxLiveries <= 0 then
    return false, 'This vehicle has no liveries'
  end

  local livery = tonumber(requestedLivery)
  if not livery or livery < 0 or livery >= maxLiveries then
    return false, ('Livery index must be between 0 and %s'):format(maxLiveries - 1)
  end

  local allowed = lib.callback.await('jg-livery-whitelist:server:isAllowed', false, model, livery)
  if not allowed then
    return false, 'This livery is not whitelisted for the vehicle'
  end

  SetVehicleModKit(vehicle, 0)
  SetVehicleLivery(vehicle, livery)
  SetVehicleMod(vehicle, 48, livery, false) -- mod type 48 = livery for many vehicles

  return true
end

-- Export for jg-mechanic integration.
exports(RESOURCE_EXPORT, applyWhitelistedLivery)

-- Optional event you can trigger instead of calling the export directly.
RegisterNetEvent('jg-livery-whitelist:client:applyRequestedLivery', function(netId, livery)
  local vehicle = NetworkGetEntityFromNetworkId(netId)
  local success, reason = applyWhitelistedLivery(vehicle, livery)
  if not success and reason then
    Config.Notify(reason)
  end
end)
