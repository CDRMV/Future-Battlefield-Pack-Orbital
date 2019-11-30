#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TDFOrbitalLaserWeapon = WeaponFile.TDFOrbitalLaserWeapon

UEFOS1101 = Class(TAirUnit) {
    Weapons = {
        MainGun = Class(TDFOrbitalLaserWeapon) {},
    },	
}

TypeClass = UEFOS1101