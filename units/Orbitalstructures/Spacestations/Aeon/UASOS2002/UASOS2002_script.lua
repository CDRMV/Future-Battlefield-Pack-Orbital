#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AAirFactoryUnit  = import('/lua/aeonunits.lua').AAirFactoryUnit 

UASOS2002 = Class(AAirFactoryUnit) {
    OnStopBeingBuilt = function(self)
        AAirFactoryUnit.OnStopBeingBuilt(self)
        self.Spinners = {
            Spinner1 = CreateRotator(self, 'UASOS1002', 'y', nil, 0, 60, 360):SetTargetSpeed(2),
        }
        for k, v in self.Spinners do
            self.Trash:Add(v)
        end
    end,

}

TypeClass = UASOS2002