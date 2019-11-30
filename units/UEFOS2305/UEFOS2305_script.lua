#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit

UEFOS2305 = Class(TAirUnit) {
    ShieldEffects = {
        '/effects/emitters/terran_shield_generator_mobile_01_emit.bp',
        '/effects/emitters/terran_shield_generator_mobile_02_emit.bp',
    },
    
    OnStopBeingBuilt = function(self,builder,layer)
        TAirUnit.OnStopBeingBuilt(self,builder,layer)
		self.ShieldEffectsBag = {}
    end,
    
    OnShieldEnabled = function(self)
        TAirUnit.OnShieldEnabled(self)
        KillThread( self.DestroyManipulatorsThread )
        if not self.RotatorManipulator then
            self.RotatorManipulator = CreateRotator( self, 'Spinner', 'y' )
            self.Trash:Add( self.RotatorManipulator )
        end
        self.RotatorManipulator:SetAccel( 5 )
        self.RotatorManipulator:SetTargetSpeed( 30 )
        if not self.AnimationManipulator then
            local myBlueprint = self:GetBlueprint()
            #LOG( 'it is ', repr(myBlueprint.Display.AnimationOpen) )
            self.AnimationManipulator = CreateAnimator(self)
            self.AnimationManipulator:PlayAnim( myBlueprint.Display.AnimationOpen )
            self.Trash:Add( self.AnimationManipulator )
        end
        self.AnimationManipulator:SetRate(1)
        
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
        TAirUnit.OnShieldDisabled(self)
        KillThread( self.DestroyManipulatorsThread )
        self.DestroyManipulatorsThread = self:ForkThread( self.DestroyManipulators )
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,
    
    UpgradingState = State(TAirUnit.UpgradingState) {
        Main = function(self)
            self.Rotator1:SetTargetSpeed(0)
            self.Rotator1:SetSpinDown(true)
            TAirUnit.UpgradingState.Main(self)
        end,
        
        
        EnableShield = function(self)
            TAirUnit.EnableShield(self)
        end,
        
        DisableShield = function(self)
            TAirUnit.DisableShield(self)
        end,
    }
}

TypeClass = UEFOS2305