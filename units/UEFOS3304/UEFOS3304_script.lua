#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TShieldStructureUnit = import('/lua/terranunits.lua').TShieldStructureUnit

UEFOS3304 = Class(TShieldStructureUnit) {
    ShieldEffects = {
        '/effects/emitters/terran_shield_generator_mobile_01_emit.bp',
        '/effects/emitters/terran_shield_generator_mobile_02_emit.bp',
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TShieldStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Rotator1 = CreateRotator(self, 'Spinner', 'y', nil, 10, 5, 10)
        self.Trash:Add(self.Rotator1)
		self.ShieldEffectsBag = {}
    end,

    OnShieldEnabled = function(self)
        TShieldStructureUnit.OnShieldEnabled(self)
        if self.Rotator1 then
            self.Rotator1:SetTargetSpeed(10)
        end
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 2, self:GetArmy(), v ) )
        end
    end,

    OnShieldDisabled = function(self)
        TShieldStructureUnit.OnShieldDisabled(self)
        self.Rotator1:SetTargetSpeed(0)
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,
}

TypeClass = UEFOS3304