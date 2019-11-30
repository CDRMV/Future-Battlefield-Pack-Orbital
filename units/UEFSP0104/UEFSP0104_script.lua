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
local TDFOrbitalLightLaserWeapon = WeaponFile.TDFOrbitalLightLaserWeapon
local TDFOrbitalLightAntifighterLaserWeapon = WeaponFile.TDFOrbitalLightAntifighterLaserWeapon

UEFSP0104 = Class(TAirUnit) {

    BeamExhaustCruise = '/effects/emitters/air_move_trail_beam_02_emit.bp',
    BeamExhaustIdle = '/effects/emitters/air_idle_trail_beam_01_emit.bp',

    Weapons = {
        MainGun = Class(TDFOrbitalLaserWeapon) {},
        MainGun2 = Class(TDFOrbitalLightLaserWeapon) {},
        MainGun3 = Class(TDFOrbitalLightLaserWeapon) {},
        MainGun4 = Class(TDFOrbitalLightAntifighterLaserWeapon) {},
    },

}


TypeClass = UEFSP0104