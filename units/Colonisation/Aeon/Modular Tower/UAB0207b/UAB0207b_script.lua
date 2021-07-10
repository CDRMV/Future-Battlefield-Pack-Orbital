#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2305/UAB2305_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Tactical Missile Launcher Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AModulaTowerUnit = import('/lua/aeonunits.lua').AModulaTowerUnit

UAB0207b = Class(AModulaTowerUnit) {

    OnStopBeingBuilt = function(self,builder,layer)
        AModulaTowerUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateStorageManip(self, 'Riser', 'ENERGY', 0, 0, 0, 0, .2, 0))
    end,

}
TypeClass = UAB0207b
