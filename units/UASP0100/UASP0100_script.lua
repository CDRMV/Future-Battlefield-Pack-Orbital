#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AConstructionUnit = import('/lua/aeonunits.lua').AConstructionUnit

UASP0100 = Class(AConstructionUnit) {

    BeamExhaustCruise = '/effects/emitters/air_move_trail_beam_02_emit.bp',
    BeamExhaustIdle = '/effects/emitters/air_idle_trail_beam_01_emit.bp',

}


TypeClass = UASP0100