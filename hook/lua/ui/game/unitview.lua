local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function
	LOG('Future Battlefield Pack Orbital: [unitview.lua '..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. Hooking "UpdateWindow" to add our own unit icons')

local MyUnitIdTable = {
 -- Aeon Laserfence

   uab0208=true, -- Aeon Tech 2 Laserfence
   uab0208a=true, -- Aeon Tech 2 Laserfence Short Vertical
   uab0208b=true, -- Aeon Tech 2 Laserfence Short Horizontal
   uab0208c=true, -- Aeon Tech 2 Laserfence Long Vertical
   uab0208d=true, -- Aeon Tech 2 Laserfence Long Horizontal

 -- Aeon Spaceships and Orbitalengineers

   uasp0100=true, -- Aeon Tech 1 Orbital Engineer
   uasp0101=true, -- Aeon Tech 1 Corvette (Spaceship)
   uasp0102=true, -- Aeon Tech 1 Frigate (Spaceship)
   uasp0200=true, -- Aeon Tech 2 Orbital Engineer
   uasp0201=true, -- Aeon Tech 2 Destroyer (Spaceship)
   uasp0202=true, -- Aeon Tech 2 Cruiser (Spaceship)
   uasp0300=true, -- Aeon Tech 3 Orbital Engineer
}

	local IconPath = "/Mods/Future Battlefield Pack Orbital"

	local oldUpdateWindow = UpdateWindow
	function UpdateWindow(info)
		oldUpdateWindow(info)
		if MyUnitIdTable[info.blueprintId] then
			controls.icon:SetTexture(IconPath .. '/icons/units/' .. info.blueprintId .. '_icon.dds')
		end
	end

else
	LOG('Future Battlefield Pack Orbital: [unitview.lua '..debug.getinfo(1).currentline..'] - Gameversion is 3652 or newer. No need to insert the unit icons by our own function.')
end -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function