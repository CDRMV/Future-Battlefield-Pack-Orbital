#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ASpacestationUnit  = import('/lua/aeonunits.lua').ASpacestationUnit
local FBPOWeaponFile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOweapons.lua')
local ADFOrbitalLaser = FBPOWeaponFile.ADFOrbitalLaser
local Buff = import('/lua/sim/Buff.lua')

UASOS2002 = Class(ASpacestationUnit) {

	Weapons = {
		AOHMainGun = Class(ADFOrbitalLaser) {},
		AOHMainGun2 = Class(ADFOrbitalLaser) {},
		AOHMainGun3 = Class(ADFOrbitalLaser) {},
		AOHMainGun4 = Class(ADFOrbitalLaser) {},
		AOHMainGun5 = Class(ADFOrbitalLaser) {},
		AOHMainGun6 = Class(ADFOrbitalLaser) {},
		AOHMainGun7 = Class(ADFOrbitalLaser) {},
		AOHMainGun8 = Class(ADFOrbitalLaser) {},
		AOHMainGun9 = Class(ADFOrbitalLaser) {},
		AOHMainGun10 = Class(ADFOrbitalLaser) {},
		AOHMainGun11 = Class(ADFOrbitalLaser) {},
		AOHMainGun12 = Class(ADFOrbitalLaser) {},
		AOHMainGun13 = Class(ADFOrbitalLaser) {},
		AOHMainGun14 = Class(ADFOrbitalLaser) {},
		AOHMainGun15 = Class(ADFOrbitalLaser) {},
		AOHMainGun16 = Class(ADFOrbitalLaser) {},
		ASFMissiles = Class(ADFOrbitalLaser) {},
		ACUDrop = Class(ADFOrbitalLaser) {},
    },

    OnCreate = function(self)
        ASpacestationUnit.OnCreate(self)
        self:SetCapturable(false)
        self:SetupBuildBones()
		self:SetWeaponEnabledByLabel('AOHMainGun', false)
		self:SetWeaponEnabledByLabel('AOHMainGun2', false)
		self:SetWeaponEnabledByLabel('AOHMainGun3', false)
		self:SetWeaponEnabledByLabel('AOHMainGun4', false)
		self:SetWeaponEnabledByLabel('AOHMainGun5', false)
		self:SetWeaponEnabledByLabel('AOHMainGun6', false)
		self:SetWeaponEnabledByLabel('AOHMainGun7', false)
		self:SetWeaponEnabledByLabel('AOHMainGun8', false)
		self:SetWeaponEnabledByLabel('AOHMainGun9', false)
		self:SetWeaponEnabledByLabel('AOHMainGun10', false)
		self:SetWeaponEnabledByLabel('AOHMainGun11', false)
		self:SetWeaponEnabledByLabel('AOHMainGun12', false)
		self:SetWeaponEnabledByLabel('AOHMainGun13', false)
		self:SetWeaponEnabledByLabel('AOHMainGun14', false)
		self:SetWeaponEnabledByLabel('AOHMainGun15', false)
		self:SetWeaponEnabledByLabel('AOHMainGun16', false)
		self:SetWeaponEnabledByLabel('ASFMissiles', false)
		self:SetWeaponEnabledByLabel('ACUDrop', false)
		self:HideBone('ASFUpgrade1', true)
        self:HideBone('ASFUpgrade2', true)    
        self:HideBone('Defense1', true)
        self:HideBone('Defense2', true)        
        self:HideBone('Defense3', true)   
        self:HideBone('B01', true)
        self:HideBone('B02', true)        
        self:HideBone('Core', true)    
        self:HideBone('Yard', true)
        self:HideBone('Sensors1', true)        
        self:HideBone('Sensors2', true)   
        self:HideBone('Star', true)   	
        self:HideBone('ACU_Launcher', true)
		self:RemoveCommandCap('RULEUCC_TRANSPORT')
		self:RemoveToggleCap('RULEUTC_ProductionToggle')
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
    end,
	
	OnStopBeingBuilt = function(self,builder,layer)
        ASpacestationUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetCapturable(false)
        self:SetupBuildBones()
		self:SetWeaponEnabledByLabel('AOHMainGun', false)
		self:SetWeaponEnabledByLabel('AOHMainGun2', false)
		self:SetWeaponEnabledByLabel('AOHMainGun3', false)
		self:SetWeaponEnabledByLabel('AOHMainGun4', false)
		self:SetWeaponEnabledByLabel('AOHMainGun5', false)
		self:SetWeaponEnabledByLabel('AOHMainGun6', false)
		self:SetWeaponEnabledByLabel('AOHMainGun7', false)
		self:SetWeaponEnabledByLabel('AOHMainGun8', false)
		self:SetWeaponEnabledByLabel('AOHMainGun9', false)
		self:SetWeaponEnabledByLabel('AOHMainGun10', false)
		self:SetWeaponEnabledByLabel('AOHMainGun11', false)
		self:SetWeaponEnabledByLabel('AOHMainGun12', false)
		self:SetWeaponEnabledByLabel('AOHMainGun13', false)
		self:SetWeaponEnabledByLabel('AOHMainGun14', false)
		self:SetWeaponEnabledByLabel('AOHMainGun15', false)
		self:SetWeaponEnabledByLabel('AOHMainGun16', false)
		self:SetWeaponEnabledByLabel('ASFMissiles', false)
		self:SetWeaponEnabledByLabel('ACUDrop', false)
		self:HideBone('ASFUpgrade1', true)
        self:HideBone('ASFUpgrade2', true)    
        self:HideBone('Defense1', true)
        self:HideBone('Defense2', true)        
        self:HideBone('Defense3', true)   
        self:HideBone('B01', true)
        self:HideBone('B02', true)        
        self:HideBone('Core', true)    
        self:HideBone('Yard', true)
        self:HideBone('Sensors1', true)        
        self:HideBone('Sensors2', true)   
        self:HideBone('Star', true)   	
        self:HideBone('ACU_Launcher', true)
		self:RemoveCommandCap('RULEUCC_TRANSPORT')
		self:RemoveToggleCap('RULEUTC_ProductionToggle')
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
    end,
	
	CreateEnhancement = function(self, enh)
		local bp = self:GetBlueprint().Enhancements[enh]
        ASpacestationUnit.CreateEnhancement(self, enh)
        if enh == 'OrbitalSpaceshipYard' then
		    local bp = self:GetBlueprint().Enhancements[enh]
            if not bp then return end
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
			if not Buffs['YardAdditions'] then
                BuffBlueprint {
                    Name = 'YardAdditions',
                    DisplayName = 'Yard Additions',
                    BuffType = 'YardAdditions',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
                        BuildRate = {
                            Add = bp.NewBuildRate,
                            Mult = 1.0,
                        },
						MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'YardAdditions')
        elseif enh == 'OrbitalSpaceshipYardRemove' then
		    local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
			if Buff.HasBuff(self, 'YardAdditions') then
                Buff.RemoveBuff(self, 'YardAdditions')
            end
		elseif enh == 'HangarBay' then
		    local bp = self:GetBlueprint().Enhancements[enh]
            if not bp then return end
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
			self:AddCommandCap('RULEUCC_TRANSPORT')
			if not Buffs['HangarAdditions'] then
                BuffBlueprint {
                    Name = 'HangarAdditions',
                    DisplayName = 'Hangar Additions',
                    BuffType = 'HangarAdditions',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
                        BuildRate = {
                            Add = bp.NewBuildRate,
                            Mult = 1.0,
                        },
						MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'HangarAdditions')
        elseif enh == 'HangarBayRemove' then
		    local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
			self:RemoveCommandCap('RULEUCC_TRANSPORT')
			if Buff.HasBuff(self, 'HangarAdditions') then
                Buff.RemoveBuff(self, 'HangarAdditions')
            end
		elseif enh == 'AdvancedHangarBay' then
		    local bp = self:GetBlueprint().Enhancements[enh]
            if not bp then return end
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
				if not Buffs['HangarAdditions2'] then
                BuffBlueprint {
                    Name = 'HangarAdditions2',
                    DisplayName = 'Hangar Additions2',
                    BuffType = 'HangarAdditions2',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
                        BuildRate = {
                            Add = bp.NewBuildRate,
                            Mult = 1.0,
                        },
						MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'HangarAdditions2')
        elseif enh == 'AdvancedHangarBayRemove' then
		    local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
			self:RemoveCommandCap('RULEUCC_TRANSPORT')
			if Buff.HasBuff(self, 'HangarAdditions2') then
                Buff.RemoveBuff(self, 'HangarAdditions2')
            end
		elseif enh == 'AntiStarFighter' then
			self:SetWeaponEnabledByLabel('ASFMissiles', true)
        elseif enh == 'AntiStarFighterRemove' then
			self:SetWeaponEnabledByLabel('ASFMissiles', false)
		elseif enh == 'AntiOrbital1' then
			self:SetWeaponEnabledByLabel('AOHMainGun', true)
			self:SetWeaponEnabledByLabel('AOHMainGun2', true)
			self:SetWeaponEnabledByLabel('AOHMainGun3', true)
			self:SetWeaponEnabledByLabel('AOHMainGun4', true)
			self:SetWeaponEnabledByLabel('AOHMainGun9', true)
			self:SetWeaponEnabledByLabel('AOHMainGun10', true)
			self:SetWeaponEnabledByLabel('AOHMainGun11', true)
			self:SetWeaponEnabledByLabel('AOHMainGun12', true)
        elseif enh == 'AntiOrbital1Remove' then
			self:SetWeaponEnabledByLabel('AOHMainGun', false)
			self:SetWeaponEnabledByLabel('AOHMainGun2', false)
			self:SetWeaponEnabledByLabel('AOHMainGun3', false)
			self:SetWeaponEnabledByLabel('AOHMainGun4', false)
			self:SetWeaponEnabledByLabel('AOHMainGun9', false)
			self:SetWeaponEnabledByLabel('AOHMainGun10', false)
			self:SetWeaponEnabledByLabel('AOHMainGun11', false)
			self:SetWeaponEnabledByLabel('AOHMainGun12', false)
		elseif enh == 'AntiOrbital2' then
			self:SetWeaponEnabledByLabel('AOHMainGun5', true)
			self:SetWeaponEnabledByLabel('AOHMainGun6', true)
			self:SetWeaponEnabledByLabel('AOHMainGun7', true)
			self:SetWeaponEnabledByLabel('AOHMainGun8', true)
			self:SetWeaponEnabledByLabel('AOHMainGun13', true)
			self:SetWeaponEnabledByLabel('AOHMainGun14', true)
			self:SetWeaponEnabledByLabel('AOHMainGun15', true)
			self:SetWeaponEnabledByLabel('AOHMainGun16', true)
        elseif enh == 'AntiOrbital2Remove' then
			self:SetWeaponEnabledByLabel('AOHMainGun5', false)
			self:SetWeaponEnabledByLabel('AOHMainGun6', false)
			self:SetWeaponEnabledByLabel('AOHMainGun7', false)
			self:SetWeaponEnabledByLabel('AOHMainGun8', false)
			self:SetWeaponEnabledByLabel('AOHMainGun13', false)
			self:SetWeaponEnabledByLabel('AOHMainGun14', false)
			self:SetWeaponEnabledByLabel('AOHMainGun15', false)
			self:SetWeaponEnabledByLabel('AOHMainGun16', false)
		elseif enh == 'Sensors1' then
			if not Buffs['ImprovedSensors'] then
                BuffBlueprint {
                    Name = 'ImprovedSensors',
                    DisplayName = 'Improved Sensors',
                    BuffType = 'ImprovedSensors',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
                        RadarRadius = {
                            Add = bp.NewRadarRadius,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'ImprovedSensors')
        elseif enh == 'Sensors1Remove' then
			if Buff.HasBuff(self, 'ImprovedSensors') then
                Buff.RemoveBuff(self, 'ImprovedSensors')
            end
		elseif enh == 'ACUDrop' then
			self:AddCommandCap('RULEUCC_SiloBuildTactical')
			self:AddCommandCap('RULEUCC_Tactical')
			self:SetWeaponEnabledByLabel('ACUDrop', true)
			if not Buffs['ACUDropAdditions'] then
                BuffBlueprint {
                    Name = 'ACUDropAdditions',
                    DisplayName = 'ACU Drop Additions',
                    BuffType = 'ACUDropAdditions',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
                        BuildRate = {
                            Add = bp.NewBuildRate,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'ACUDropAdditions')
        elseif enh == 'ACUDropRemove' then
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
			self:RemoveCommandCap('RULEUCC_SiloBuildTactical')
			self:RemoveCommandCap('RULEUCC_Tactical')
			self:SetWeaponEnabledByLabel('ACUDrop', false)
			if Buff.HasBuff(self, 'ACUDropAdditions') then
                Buff.RemoveBuff(self, 'ACUDropAdditions')
            end
		elseif enh == 'StarGenerator' then
		    self:CreateShield(bp)
            self:SetEnergyMaintenanceConsumptionOverride(bp.MaintenanceConsumptionPerSecondEnergy or 0)
            self:SetMaintenanceConsumptionActive()
			if not Buffs['StarGeneratorAdditions'] then
                BuffBlueprint {
                    Name = 'StarGeneratorAdditions',
                    DisplayName = 'Star Generator Additions',
                    BuffType = 'StarGeneratorAdditions',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
						MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'StarGeneratorAdditions')
        elseif enh == 'StarGeneratorRemove' then
		     self:DestroyShield()
            self:SetMaintenanceConsumptionInactive()
			if Buff.HasBuff(self, 'StarGeneratorAdditions') then
                Buff.RemoveBuff(self, 'StarGeneratorAdditions')
            end
		elseif enh == 'Dyson' then
			self:CreateShield(bp)
            self:SetEnergyMaintenanceConsumptionOverride(bp.MaintenanceConsumptionPerSecondEnergy or 0)
            self:SetMaintenanceConsumptionActive()
			if not Buffs['DysonAdditions'] then
                BuffBlueprint {
                    Name = 'DysonAdditions',
                    DisplayName = 'Dyson Additions',
                    BuffType = 'DysonAdditions',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
						MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'DysonAdditions')
        elseif enh == 'DysonRemove' then
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
			self:DestroyShield()
            self:SetMaintenanceConsumptionInactive()
			if Buff.HasBuff(self, 'DysonAdditions') then
                Buff.RemoveBuff(self, 'DysonAdditions')
            end
		elseif enh == 'Tradeport' then
			local bp = self:GetBlueprint().Enhancements[enh]
            if not bp then return end
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
			self:RemoveBuildRestriction(cat)
			self:AddCommandCap('RULEUCC_TRANSPORT')
			if not Buffs['TradeportAdditions'] then
                BuffBlueprint {
                    Name = 'TradeportAdditions',
                    DisplayName = 'Tradeport Additions',
                    BuffType = 'TradeportAdditions',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
						MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'TradeportAdditions')
        elseif enh == 'TradeportRemove' then
			local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
			self:RemoveCommandCap('RULEUCC_TRANSPORT')
			if Buff.HasBuff(self, 'TradeportAdditions') then
                Buff.RemoveBuff(self, 'TradeportAdditions')
            end
		elseif enh == 'MassFab' then
        ChangeState(self, self.OpenState)
		self:AddToggleCap('RULEUTC_ProductionToggle')
				if not Buffs['MassFabAdditions'] then
                BuffBlueprint {
                    Name = 'MassFabAdditions',
                    DisplayName = 'MassFab Additions',
                    BuffType = 'MassFabAdditions',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
						MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'MassFabAdditions')
        elseif enh == 'MassFabRemove' then
		self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER1SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER2SPACESTATIONORBITALSPACESHIPYARD + categories.BUILTBYTIER1ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALHANGARBAY + categories.BUILTBYTIER2ORBITALTRADEPORT) )
		self:RemoveToggleCap('RULEUTC_ProductionToggle')
			if Buff.HasBuff(self, 'MassFabAdditions') then
                Buff.RemoveBuff(self, 'MassFabAdditions')
            end
		end
    end,

    OpenState = State {
        Main = function(self)
			if self.AmbientEffects then
				self.AmbientEffects:Destroy()
				self.AmbientEffects = nil
			end
			
            if not self.Rotator then
                self.Rotator = {
					CreateRotator(self, 'Fab1', 'y', nil, 0, 20, 0),
					CreateRotator(self, 'Fab2', 'y', nil, 0, -20, 0),
				},
                self.Trash:Add(self.Rotator)
            else
                self.Rotator:SetSpinDown(false)
            end
            self.Goal = Random(120,300)
            
            # Ambient effects
			self.AmbientEffects = CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/aeon_t1_massfab_ambient_01_emit.bp')
			self.Trash:Add(self.AmbientEffects)

            while not self:IsDead() do
                # spin clockwise
                if not self.Clockwise then
                    self.Rotator:SetTargetSpeed(self.Goal)
                    self.Clockwise = true
                else
                    self.Rotator:SetTargetSpeed(-self.Goal)
                    self.Clockwise = false
                end
                WaitFor(self.Rotator)

                # slow down to change directions
                self.Rotator:SetTargetSpeed(0)
                WaitFor(self.Rotator)
                self.Rotator:SetSpeed(0)
                self.Goal = Random(120,300)
            end
        end,

        OnProductionPaused = function(self)
            ASpacestationUnit.OnProductionPaused(self)
            ChangeState(self, self.InActiveState)
        end,
    },

    InActiveState = State {
        Main = function(self)
			if self.AmbientEffects then
				self.AmbientEffects:Destroy()
				self.AmbientEffects = nil
			end
			
            if self.Open then
                if self.Clockwise == true then
                    self.Rotator:SetSpinDown(true)
                    self.Rotator:SetTargetSpeed(self.Goal)
                else
                    self.Rotator:SetTargetSpeed(0)
                    WaitFor(self.Rotator)
                    self.Rotator:SetSpinDown(true)
                    self.Rotator:SetTargetSpeed(self.Goal)
                end
                WaitFor(self.Rotator)
            end
            if self.Open then
                self.AnimManip:SetRate(-1)
                self.Open = false
                WaitFor(self.AnimManip)
            end
        end,

        OnProductionUnpaused = function(self)
            ASpacestationUnit.OnProductionUnpaused(self)
            ChangeState(self, self.OpenState)
        end,
    },
}

TypeClass = UASOS2002