#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirFactoryUnit = import('/lua/terranunits.lua').TAirFactoryUnit 
local FBPOWeaponFile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOweapons.lua')
local TDFOrbitalLaserWeapon = FBPOWeaponFile.TDFOrbitalLaserWeapon
local TDFOrbitalLightLaserWeapon = FBPOWeaponFile.TDFOrbitalLightLaserWeapon

UEFOS2000 = Class(TAirFactoryUnit) {
    Weapons = {
        MainGun = Class(TDFOrbitalLaserWeapon) {},
        MainGun1 = Class(TDFOrbitalLaserWeapon) {},
        MainGun2 = Class(TDFOrbitalLightLaserWeapon) {},
    },	
}

TypeClass = UEFOS2000