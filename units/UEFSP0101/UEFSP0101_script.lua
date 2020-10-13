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
local TDFOrbitalLightLaserWeapon = FBPOWeaponFile.TDFOrbitalLightLaserWeapon
local TDFOrbitalLightAntifighterLaserWeapon = FBPOWeaponFile.TDFOrbitalLightAntifighterLaserWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UEFSP0101 = Class(TAirUnit) {

    BeamExhaustCruise = '/effects/emitters/air_move_trail_beam_02_emit.bp',
    BeamExhaustIdle = '/effects/emitters/air_idle_trail_beam_01_emit.bp',

    Weapons = {
        MainGun2 = Class(TDFOrbitalLightLaserWeapon) {},
        MainGun3 = Class(TDFOrbitalLightLaserWeapon) {},
        MainGun4 = Class(TDFOrbitalLightAntifighterLaserWeapon) {},
        MainGun5 = Class(TSAMLauncher) {},
    },


}


TypeClass = UEFSP0101