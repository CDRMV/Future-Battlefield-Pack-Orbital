#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandFactoryUnit = import('/lua/seraphimunits.lua').SLandFactoryUnit
local WeaponFile = import('/lua/seraphimweapons.lua')


XSOS1000 = Class(SLandFactoryUnit) {

    OnCreate = function(self)
        SLandFactoryUnit.OnCreate(self)
        self.Rotator1 = CreateRotator(self, 'XSB0101', 'y', nil, 5, 0, 0)
        self.Trash:Add(self.Rotator1)
    end,

    OnKilled = function(self, instigator, type, overkillRatio)
        self.Rotator1:SetSpeed(0)
        SLandFactoryUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

    Weapons = {
    },	
}

TypeClass = XSOS1000