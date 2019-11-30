#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0102/UEA0102_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Terran Interceptor Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TAirToAirLinkedRailgun = import('/lua/terranweapons.lua').TAirToAirLinkedRailgun

UEFSF100 = Class(TAirUnit) {
    PlayDestructionEffects = true,
    DamageEffectPullback = 0.25,
    DestroySeconds = 7.5,

    BeamExhaustCruise = '/mods/Future Battlefield Pack Orbital/effects/emitters/fighter_move_trail_beam_01_emit.bp',
    BeamExhaustIdle = '/effects/emitters/air_idle_trail_beam_01_emit.bp',
    BeamExhaustSize = 0.001,

    Weapons = {
        LinkedRailGun = Class(TAirToAirLinkedRailgun) {
        },
    },
}

TypeClass = UEFSF100