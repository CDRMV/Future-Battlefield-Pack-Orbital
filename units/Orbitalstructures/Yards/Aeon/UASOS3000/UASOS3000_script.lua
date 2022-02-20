#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirFactoryUnit = import('/lua/aeonunits.lua').AAirFactoryUnit 
local FBPOWeaponFile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOweapons.lua')
local ADFOrbitalLaser = FBPOWeaponFile.ADFOrbitalLaser

UASOS3000 = Class(AAirFactoryUnit) {
	Weapons = {
		AOMainGun = Class(ADFOrbitalLaser) {},
    },
}

TypeClass = UASOS3000