local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function
	LOG('Future Battlefield Pack Orbital: [unitview.lua '..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. Hooking "UpdateWindow" to add our own unit icons')

local MyUnitIdTable = {

 -- Aeon Elite Land Units

   ual0300x=true, -- Aeon Elite Extermination Bot (Deroy)

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
   
  -- Aeon Ringplatforms
   uabrt100=true, -- Aeon Tech 1 Ringplatform
   uabrt200=true, -- Aeon Tech 2 Ringplatform
   uabrt300=true, -- Aeon Tech 3 Ringplatform
   
   
  -- Aeon Defense Satellites
   uasos1003=true, -- Aeon Tech 1 Anti Orbital Defense Satellite
   uasos1004=true, -- Aeon Tech 1 Anti Starfighter Defense Satellite
   uasos2003=true, -- Aeon Tech 1 Anti Orbital Defense Satellite (Long Range)
   uasos2004=true, -- Aeon Tech 2 Anti Starfighter Defense Satellite
   uasos2005=true, -- Aeon Tech 2 Anti Orbital Defense Satellite
   uasos3003=true, -- Aeon Tech 3 Multi Defense Satellite

  -- Aeon Anti Orbital Cannons

   uabaoc100=true, -- Aeon Tech 1 Anti Orbital Cannon
   uabaoc200=true, -- Aeon Tech 2 Anti Orbital Cannon
   uabaoc300=true, -- Aeon Tech 3 Anti Orbital Cannon
   
  -- Aeon Anti Orbital Support Cannons

   uabaosc100=true, -- Aeon Tech 1 Anti Orbital Shield Disruptor
   uabaosc200=true, -- Aeon Tech 2 Anti Orbital Shield Disruptor
   uabaosc300=true, -- Aeon Tech 3 Anti Orbital Shield Disruptor


  -- Aeon Planetary Spaceship Yards

   uab0106=true, -- Aeon Tech 1 Planetary Spaceship Yard
   uab0206=true, -- Aeon Tech 2 Planetary Spaceship Yard
   uab0306=true, -- Aeon Tech 3 Planetary Spaceship Yard
   
  -- Aeon Spacestation

   uasos2002=true, -- Aeon Tech 2 Spacestation
   
   -- Aeon Tradestation and Tradeships

   uasos2006=true, -- Aeon Tech 2 Tradestation
   
   uaspt0200=true, -- Aeon Tech 2 Cargo/Tradeship
   
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
   uasp0203=true, -- Aeon Tech 2 Interdictor (Spaceship)
   uasp0204=true, -- Aeon Tech 2 Dropshuttle Carrier (Spaceship)
   uasp0205=true, -- Aeon Tech 2 Fleet Support (Spaceship)
   uasp0300=true, -- Aeon Tech 3 Orbital Engineer
   uasp0301=true, -- Aeon Tech 3 Star Carrier (Spaceship)
   uasp0302=true, -- Aeon Tech 3 Star Dreadnought (Spaceship)
   uasp0304=true, -- Aeon Tech 3 Dropshuttle Carrier (Spaceship)
   uasp0404=true, -- Aeon Experimental Dropshuttle Carrier (Spaceship)
   
 -- Aeon Starfighters and -bombers
   uafsf100=true, -- Aeon Tech 1 Basic Starfighter
   uafsf101=true, -- Aeon Tech 1 Basic Starbomber
   
 -- Aeon Shuttles
   uafsf203=true, -- Aeon Tech 2 Drop Shuttle
   uafsf204=true, -- Aeon Tech 2 Ringplatform Drop Shuttle
   uafsf303=true, -- Aeon Tech 3 Drop Shuttle
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