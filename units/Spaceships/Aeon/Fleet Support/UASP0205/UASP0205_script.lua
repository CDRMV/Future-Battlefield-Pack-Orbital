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

UASP0205 = Class(AAirUnit) {

    Weapons = {
		AOMainGun = Class(ADFOrbitalLaser) {},
        OMainGun = Class(ADFOrbitalLaser) {},
        PBMainGun = Class(ADFOrbitalLaser) {},
    },

}


TypeClass = UASP0205