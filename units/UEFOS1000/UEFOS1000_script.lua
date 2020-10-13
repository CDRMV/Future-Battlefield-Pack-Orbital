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
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UEFOS1000 = Class(TAirFactoryUnit) {
    Weapons = {
        MainGun = Class(TDFOrbitalLaserWeapon) {},
        MainGun2 = Class(TDFOrbitalLightLaserWeapon) {},
        MainGun5 = Class(TSAMLauncher) {},
    },	
}

TypeClass = UEFOS1000