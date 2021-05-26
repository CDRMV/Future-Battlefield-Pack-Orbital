local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function



LOG('Future Battlefield Pack Orbital: [uiutil.lua '..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. Hooking "UIFile" to add our own unit icons')

local MyUnitIdTable = {
   uasp0101=true, -- Aeon Tech 1 Corvette (Spaceship)
   uasp0102=true, -- Aeon Tech 1 Frigate (Spaceship)
   uasp0201=true, -- Aeon Tech 2 Destroyer (Spaceship)
   uasp0202=true, -- Aeon Tech 2 Cruiser (Spaceship)
}

	local IconPath = "/Mods/Future Battlefield Pack Orbital"
	-- Adds icons to the engeneer/factory buildmenu
	local oldUIFile = UIFile
	function UIFile(filespec)
		local IconName = string.gsub(filespec,'_icon.dds','')
        IconName = string.gsub(IconName,'/icons/units/','')
		if MyUnitIdTable[IconName] then
			local curfile =  IconPath .. filespec
			return curfile
		end
		return oldUIFile(filespec)
	end

else
	LOG('Future Battlefield Pack Orbital: [uiutil.lua '..debug.getinfo(1).currentline..'] - Gameversion is 3652 or newer. No need to insert the unit icons by our own function.')
end -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function