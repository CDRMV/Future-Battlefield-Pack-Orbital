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
local TDFOrbitalLaserWeapon = FBPOWeaponFile.TDFOrbitalLaserWeapon
local TDFOrbitalLightLaserWeapon = FBPOWeaponFile.TDFOrbitalLightLaserWeapon
local TDFOrbitalLightAntifighterLaserWeapon = FBPOWeaponFile.TDFOrbitalLightAntifighterLaserWeapon

UASP0301 = Class(AAirUnit) {

    BeamExhaustCruise = '/mods/Future Battlefield Pack Orbital/effects/emitters/Aeon_Spaceship_Engine_beam_emit.bp',
    BeamExhaustIdle = '/mods/Future Battlefield Pack Orbital/effects/emitters/Aeon_Spaceship_Engine_trail_emit.bp',

    Weapons = {
        MainGun = Class(TDFOrbitalLaserWeapon) {},
        MainGun2 = Class(TDFOrbitalLightLaserWeapon) {},
        MainGun3 = Class(TDFOrbitalLightLaserWeapon) {},
        MainGun4 = Class(TDFOrbitalLightAntifighterLaserWeapon) {},
    },

}


TypeClass = UASP0301