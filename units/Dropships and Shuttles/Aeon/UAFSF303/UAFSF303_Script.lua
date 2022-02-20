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

UAFSF303 = Class(AAirUnit) {
	Weapons = {
        ASFLaser = Class(ADFLaserLightWeapon) {},
		ASFEnergyDrone = Class(ADFLaserLightWeapon) {},
    },
	
	OnStopBeingBuilt = function(self,builder,layer)
        AAirUnit.OnStopBeingBuilt(self,builder,layer)
		
		local unitsdb = {'ual0202','ual0205','ual0203','ual0111'}
		local randomvalue = math.random(1,5)
        LOG('Prebuild Dropunit')
        local position = self:GetPosition()
		self.Station02 = CreateUnitHPR(unitsdb[randomvalue], self:GetArmy(), position.x, position.y, position.z, 0, 0, 0)
		self.Station02:AttachBoneTo(0, self, 'Prebuild')
		AAirUnit.OnStopBeingBuilt(self,builder,layer)
    end,
	
    OnTransportAttach = function(self, attachBone, unit)
        AAirUnit.OnTransportAttach(self, attachBone, unit)
        if not self.AttachedUnits then
            self.AttachedUnits = {}
        end
        table.insert( self.AttachedUnits, unit )
    end,
    
    OnTransportDetach = function(self, attachBone, unit)
        AAirUnit.OnTransportDetach( self, attachBone, unit )
        if self.AttachedUnits then
            for k,v in self.AttachedUnits do
                if v == unit then
                    self.AttachedUnits[k] = nil
                    break
                end                    
            end
        end
    end,
    
    DestroyedOnTransport = function(self)
        if self.AttachedUnits then
            for k,v in self.AttachedUnits do
                v:Destroy()
            end
        end
    end,

}

TypeClass = UAFSF303