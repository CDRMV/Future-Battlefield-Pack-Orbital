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
local TDFLaserLightWeapon = WeaponFile.TDFLaserLightWeapon

UEFOS2301 = Class(TAirUnit) {
    Weapons = {
        AAGun = Class(TDFLaserLightWeapon) {},
    },	
}

TypeClass = UEFOS2301