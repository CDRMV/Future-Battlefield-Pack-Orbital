#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local FBPOWeaponFile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOweapons.lua')
local ADFOrbitalLaser = FBPOWeaponFile.ADFOrbitalLaser

UASP0600 = Class(AAirUnit) {

    BeamExhaustCruise = '/mods/Future Battlefield Pack Orbital/effects/emitters/Aeon_Spaceship_Engine_beam_emit.bp',
    BeamExhaustIdle = '/mods/Future Battlefield Pack Orbital/effects/emitters/Aeon_Spaceship_Engine_trail_emit.bp',
	
	Weapons = {
		AOMainGun = Class(ADFOrbitalLaser) {},
        OMainGun = Class(ADFOrbitalLaser) {},
        PBMainGun = Class(ADFOrbitalLaser) {},
    },

}


TypeClass = UASP0600