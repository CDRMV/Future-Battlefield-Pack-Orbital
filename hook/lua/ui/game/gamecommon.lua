local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function
	LOG('Future Battlefield Pack Orbital: [gamecommon.lua '..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. Hooking "GetUnitIconFileNames" to add our own unit icons')

local MyUnitIdTable = {
 -- Aeon Laserfence

   uab0208=true, -- Aeon Tech 2 Laserfence
   uab0208a=true, -- Aeon Tech 2 Laserfence Short Vertical
   uab0208b=true, -- Aeon Tech 2 Laserfence Short Horizontal
   uab0208c=true, -- Aeon Tech 2 Laserfence Long Vertical
   uab0208d=true, -- Aeon Tech 2 Laserfence Long Horizontal
   
   -- Aeon Modula Tower

   uab0207=true, -- Aeon Tech 2 Foundation Module
   uab0207a=true, -- Aeon Tech 2 Solar Energy Module
   uab0207b=true, -- Aeon Tech 2 Energy Storage Module
   uab0207c=true, -- Aeon Tech 2 Mass Storage Module
   uab0207d=true, -- Aeon Tech 2 Mass Fabricator Module
   uab0207e=true, -- Aeon Tech 2 Habitat Module
   
   -- Aeon Planetary Spaceship Yards

   uab0106=true, -- Aeon Tech 1 Planetary Spaceship Yard
   uab0206=true, -- Aeon Tech 2 Planetary Spaceship Yard
   uab0306=true, -- Aeon Tech 3 Planetary Spaceship Yard
   
   -- Aeon Tradestation and Tradeships

   uasos2006=true, -- Aeon Tech 2 Tradestation
   
   uactsp0200=true, -- Aeon Tech 2 Cargo/Tradeship
   
  -- Aeon Planetary Orbital Spaceship Yards (with Capital)

   uasos1000=true, -- Aeon Tech 1 Orbital Spaceship Yard
   uasos1001=true, -- Aeon Tech 1 Orbital Capital Spaceship Yard
   uasos2000=true, -- Aeon Tech 1 Orbital Spaceship Yard
   uasos2001=true, -- Aeon Tech 1 Orbital Capital Spaceship Yard
   uasos3000=true, -- Aeon Tech 1 Orbital Spaceship Yard
   uasos3001=true, -- Aeon Tech 1 Orbital Capital Spaceship Yard

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
	-- Adds icons to the unitselectionwindow
	local oldGetUnitIconFileNames = GetUnitIconFileNames
	function GetUnitIconFileNames(blueprint)
		if MyUnitIdTable[blueprint.Display.IconName] then
			local iconName = IconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
			local upIconName = IconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
			local downIconName = IconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
			local overIconName = IconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
			return iconName, upIconName, downIconName, overIconName
		else
			return oldGetUnitIconFileNames(blueprint)
		end
	end

else
	LOG('Future Battlefield Pack Orbital: [gamecommon.lua '..debug.getinfo(1).currentline..'] - Gameversion is 3652 or newer. No need to insert the unit icons by our own function.')
end -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function