#****************************************************************************
#**
#**  File     :  /cdimage/units/XEB2402/XEB2402_script.lua
#**  Author(s):  Dru Staltman
#**
#**  Summary  :  UEF Sub Orbital Laser
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit

XSB0104 = Class(SStructureUnit) {   
    DeathThreadDestructionWaitTime = 8,
    
    OnStopBeingBuilt = function(self)
        SStructureUnit.OnStopBeingBuilt(self)
		self.Rotator1 = CreateRotator(self, 'Spinner', 'y', nil, 60, 0, 0)
        self.Trash:Add(self.Rotator1)
        ChangeState( self, self.OpenState )
    end,
    
    OpenState = State() {

        Main = function(self)            
            local newSat = not self.Satellite
            local bp = self:GetBlueprint()
            self.AnimManip = CreateAnimator(self)
            self.AnimManip:PlayAnim( '/units/XEB2402/XEB2402_aopen.sca' )
            self.Trash:Add(self.AnimManip)
            self:PlayUnitSound('MoveArms')
            WaitFor( self.AnimManip )
			
			
            # Attach satellite to unit, play animation, release satellite
            # Create satellite and attach to attachpoint bone
            local location = self:GetPosition('Attachpoint1')
            local army = self:GetArmy()
            self.Trash:Add(CreateAttachedEmitter(self,'XSB2303',army, '/effects/emitters/structure_steam_ambient_01_emit.bp'):OffsetEmitter(0, 0, 0))
            self.Trash:Add(CreateAttachedEmitter(self,'XSB2303',army, '/effects/emitters/structure_steam_ambient_02_emit.bp'):OffsetEmitter(0, 0, 0))
            
            if newSat then
                self.Satellite = CreateUnitHPR('XSSP0100', self:GetArmy(), location[1], location[2], location[3], 0, 0, 0)
                self.Trash:Add(self.Satellite)
                self.Satellite:AttachTo(self, 'Attachpoint1')
            end
            
            #Tell the satellite that we're its parent
            self.Satellite.Parent = self
            
            # Play open animation
            self.AnimManip:PlayAnim( '/units/XEB2402/XEB2402_aopen01.sca' )
            self:PlayUnitSound('LaunchSat')
            WaitFor( self.AnimManip )
			self.Trash:Add(CreateAttachedEmitter(self,'XSB2303',army, '/effects/emitters/uef_orbital_death_laser_launch_01_emit.bp'):OffsetEmitter(0.00, 0.00, 0.00))
			self.Trash:Add(CreateAttachedEmitter(self,'XSB2303',army, '/effects/emitters/uef_orbital_death_laser_launch_02_emit.bp'):OffsetEmitter(0.00, 0.00, 0.00))
			
            # Release unit
            if newSat then
                self.Satellite:DetachFrom()    
            end
        end,
    },   
    
    OnKilled = function(self, instigator, type, overkillRatio)
        if self.Satellite and not self.Satellite:IsDead() and not self.Satellite.IsDying then
            self.Satellite:Kill()
        end
        SStructureUnit.OnKilled(self, instigator, type, overkillRatio)
    end,
    
    OnDestroy = function(self)
        if self.Satellite and not self.Satellite:IsDead() and not self.Satellite.IsDying then
            self.Satellite:Destroy()
        end
        SStructureUnit.OnDestroy(self)
    end,
    
    OnCaptured = function(self, captor)
        if self and not self:IsDead() and self.Satellite and not self.Satellite:IsDead() and captor and not captor:IsDead() and self:GetAIBrain() ~= captor:GetAIBrain() then
            self:DoUnitCallbacks('OnCaptured', captor)
            local newUnitCallbacks = {}
            if self.EventCallbacks.OnCapturedNewUnit then
                newUnitCallbacks = self.EventCallbacks.OnCapturedNewUnit
            end
            local entId = self:GetEntityId()
            local unitEnh = SimUnitEnhancements[entId]
            local captorArmyIndex = captor:GetArmy()
            local captorBrain = false
            
            # For campaigns:
            # We need the brain to ignore army cap when transfering the unit
            # do all necessary steps to set brain to ignore, then un-ignore if necessary the unit cap
            
            if ScenarioInfo.CampaignMode then
                captorBrain = captor:GetAIBrain()
                SetIgnoreArmyUnitCap(captorArmyIndex, true)
            end
            
            #Satellite stuff
            self.Satellite:DoUnitCallbacks('OnCaptured', captor)
            local newSatUnitCallbacks = {}
            if self.Satellite.EventCallbacks.OnCapturedNewUnit then
                newSatUnitCallbacks = self.Satellite.EventCallbacks.OnCapturedNewUnit
            end
            local satId = self:GetEntityId()
            local satEnh = SimUnitEnhancements[satId]
            local sat = ChangeUnitArmy(self.Satellite, captorArmyIndex)
            
            #Unit stuff
            local newUnit = ChangeUnitArmy(self, captorArmyIndex)
            if newUnit then
                newUnit.Satellite = sat
            end
                        
            if ScenarioInfo.CampaignMode and not captorBrain.IgnoreArmyCaps then
                SetIgnoreArmyUnitCap(captorArmyIndex, false)
            end
            
            if unitEnh then
                for k,v in unitEnh do
                    newUnit:CreateEnhancement(v)
                end
            end
            for k,cb in newUnitCallbacks do
                if cb then
                    cb(newUnit, captor)
                end
            end
            
            #Satellite stuff
            if satEnh then
                for k,v in satEnh do
                    sat:CreateEnhancement(v)
                end
            end
            for k,cb in newSatUnitCallbacks do
                if cb then
                    cb(sat, captor)
                end
            end
        end
    end,
}
TypeClass = XSB0104