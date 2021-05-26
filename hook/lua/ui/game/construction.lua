
function GetBackgroundTextures(unitID)
    local bp = __blueprints[unitID]
    local validIcons = {land = true, air = true, sea = true, amph = true, orbit = true}
    local icon = "land"
	local Modpath = "/mods/Future Battlefield Pack Orbital"
    if unitID and unitID ~= 'default' then
        if not validIcons[bp.General.Icon] then
            if bp.General.Icon then WARN(debug.traceback(nil, "Invalid icon" .. bp.General.Icon .. " for unit " .. tostring(unitID))) end
            bp.General.Icon = "land"
		else
			icon = bp.General.Icon
		end
    end
	return UIUtil.UIFile(Modpath .. '/icons/units/backgrounds/' .. icon .. '_up.dds'),
			UIUtil.UIFile(Modpath .. '/icons/units/backgrounds/' .. icon .. '_down.dds'),
			UIUtil.UIFile(Modpath .. '/icons/units/backgrounds/' .. icon .. '_over.dds'),
			UIUtil.UIFile(Modpath .. '/icons/units/backgrounds/' .. icon .. '_up.dds')
end