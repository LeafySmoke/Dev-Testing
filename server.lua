local function modelNameFromHash(model)
  return string.lower(GetDisplayNameFromVehicleModel(model or 0))
end

local function isLiveryAllowed(model, livery)
  local name = modelNameFromHash(model)
  local allowed = Config.LiveryWhitelist[name]

  if not allowed then
    return Config.AllowUnlistedVehicles
  end

  for i = 1, #allowed do
    if allowed[i] == livery then
      return true
    end
  end

  return false
end

lib.callback.register('jg-livery-whitelist:server:isAllowed', function(_, model, livery)
  return isLiveryAllowed(model, livery)
end)
