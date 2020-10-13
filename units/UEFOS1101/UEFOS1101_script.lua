#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local FBPOWeaponFile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOweapons.lua')
local TDFOrbitalLaserWeapon = FBPOWeaponFile.TDFOrbitalLaserWeapon

UEFOS1101 = Class(TAirUnit) {
    Weapons = {
        MainGun = Class(TDFOrbitalLaserWeapon) {},
    },	
}

TypeClass = UEFOS1101