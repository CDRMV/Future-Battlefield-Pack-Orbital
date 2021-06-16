#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AConstructionUnit = import('/lua/aeonunits.lua').AConstructionUnit

UASP0300 = Class(AConstructionUnit) {

    BeamExhaustCruise = '/effects/emitters/air_move_trail_beam_02_emit.bp',
    BeamExhaustIdle = '/effects/emitters/air_idle_trail_beam_01_emit.bp',

	OnCreate = function(self)
		AConstructionUnit.OnCreate(self)
        self.Spinners = {
            Spinner1 = CreateRotator(self, 'Spinner', 'y', nil, 0, 60, 360):SetTargetSpeed(90),
        }
        for k, v in self.Spinners do
            self.Trash:Add(v)
        end
    end,

}


TypeClass = UASP0300