#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirFactoryUnit = import('/lua/aeonunits.lua').AAirFactoryUnit 

UAB0306 = Class(AAirFactoryUnit) {

    OnStopBeingBuilt = function(self)
        AAirFactoryUnit.OnStopBeingBuilt(self)
        self.Spinners = {
            Spinner1 = CreateRotator(self, 'Spinner', 'y', nil, 0, 60, 360):SetTargetSpeed(5),
        }
        for k, v in self.Spinners do
            self.Trash:Add(v)
        end
    end,

}

TypeClass = UAB0306