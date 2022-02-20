#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0102/UEA0102_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Terran Interceptor Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local ADFLaserLightWeapon = import('/lua/aeonweapons.lua').ADFLaserLightWeapon
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon

UAFSF101 = Class(AAirUnit) {
    PlayDestructionEffects = true,
    DamageEffectPullback = 0.25,
    DestroySeconds = 7.5,

    BeamExhaustCruise = '/mods/Future Battlefield Pack Orbital/effects/emitters/aeon_fighter_move_trail_beam_01_emit.bp',
    BeamExhaustIdle = '/mods/Future Battlefield Pack Orbital/effects/emitters/aeon_fighter_move_trail_beam_01_emit.bp',
    BeamExhaustSize = 0.001,
	Weapons = {
        ASFLaser = Class(ADFLaserLightWeapon) {},
		ASPTorpedo = Class(AAAZealotMissileWeapon) {},
    },
}

TypeClass = UAFSF101