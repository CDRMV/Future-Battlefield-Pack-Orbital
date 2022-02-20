#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0303/UAL0303_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Siege Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local AeonWeapons = import('/lua/aeonweapons.lua')
local ADFLaserHighIntensityWeapon = AeonWeapons.ADFLaserHighIntensityWeapon
local ADFCannonOblivionWeapon = AeonWeapons.ADFCannonOblivionWeapon
local AIFArtilleryMiasmaShellWeapon = import('/lua/aeonweapons.lua').AIFArtilleryMiasmaShellWeapon
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon
local Buff = import('/lua/sim/Buff.lua')

UAL0300X = Class(AWalkingLandUnit) {    
    Weapons = {
        FrontTurret01 = Class(ADFCannonOblivionWeapon) {},
		LegTurret01 = Class(ADFLaserHighIntensityWeapon) {},
		LUpgradeTurret01 = Class(ADFLaserHighIntensityWeapon) {},
		RUpgradeTurret01 = Class(ADFLaserHighIntensityWeapon) {},
		LUpgradeTurret02 = Class(ADFLaserHighIntensityWeapon) {},
		RUpgradeTurret02 = Class(ADFLaserHighIntensityWeapon) {},
		LUpgradeTurret03 = Class(ADFLaserHighIntensityWeapon) {},
		RUpgradeTurret03 = Class(ADFLaserHighIntensityWeapon) {},
		LUpgradeTurret04 = Class(ADFLaserHighIntensityWeapon) {},
		RUpgradeTurret04 = Class(ADFLaserHighIntensityWeapon) {},
		LUpgradeMissileBattery = Class(AAAZealotMissileWeapon) {},
		RUpgradeMissileBattery = Class(AAAZealotMissileWeapon) {},
		LUpgradeAAMissileBattery = Class(AAAZealotMissileWeapon) {},
		RUpgradeAAMissileBattery = Class(AAAZealotMissileWeapon) {},
		LArt = Class(AIFArtilleryMiasmaShellWeapon) {},
		RArt = Class(AIFArtilleryMiasmaShellWeapon) {},
    },
	
	OnCreate = function(self)
        AWalkingLandUnit.OnCreate(self)
        self:SetCapturable(false)
        self:SetupBuildBones()
		self:SetWeaponEnabledByLabel('LUpgradeTurret01', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret01', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret02', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret02', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret03', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret03', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret04', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret04', false)
		self:SetWeaponEnabledByLabel('LUpgradeMissileBattery', false)
		self:SetWeaponEnabledByLabel('RUpgradeMissileBattery', false)
		self:SetWeaponEnabledByLabel('LUpgradeAAMissileBattery', false)
		self:SetWeaponEnabledByLabel('RUpgradeAAMissileBattery', false)
		self:SetWeaponEnabledByLabel('LArt', false)
		self:SetWeaponEnabledByLabel('RArt', false)
        self:HideBone('L_Upgrade', true)   	
        self:HideBone('R_Upgrade', true)
		self:HideBone('LTurret_Barrel', true)   	
        self:HideBone('RTurret_Barrel', true)
    end,
	
	OnStopBeingBuilt = function(self,builder,layer)
        AWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
		self:SetWeaponEnabledByLabel('LUpgradeTurret01', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret01', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret02', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret02', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret03', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret03', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret04', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret04', false)
		self:SetWeaponEnabledByLabel('LUpgradeAAMissileBattery', false)
		self:SetWeaponEnabledByLabel('RUpgradeAAMissileBattery', false)
		self:SetWeaponEnabledByLabel('LUpgradeMissileBattery', false)
		self:SetWeaponEnabledByLabel('RUpgradeMissileBattery', false)
		self:SetWeaponEnabledByLabel('LArt', false)
		self:SetWeaponEnabledByLabel('RArt', false)
		self:HideBone('L_Upgrade', true)   	
        self:HideBone('R_Upgrade', true)
		self:HideBone('LTurret_Barrel', true)   	
        self:HideBone('RTurret_Barrel', true)
    end,
	
	CreateEnhancement = function(self, enh)
		local bp = self:GetBlueprint().Enhancements[enh]
        AWalkingLandUnit.CreateEnhancement(self, enh)
        if enh == 'LMissileBattery' then
		self:SetWeaponEnabledByLabel('LUpgradeMissileBattery', true)
		self:AddToggleCap('RULEUTC_WeaponToggle')
        elseif enh == 'LMissileBatteryRemove' then
		self:SetWeaponEnabledByLabel('LUpgradeMissileBattery', false)
		self:RemoveToggleCap('RULEUTC_WeaponToggle')
		elseif enh == 'RMissileBattery' then
		self:SetWeaponEnabledByLabel('RUpgradeMissileBattery', true)
        elseif enh == 'RMissileBatteryRemove' then
		self:SetWeaponEnabledByLabel('RUpgradeMissileBattery', false)
		elseif enh == 'LEnergyBlaster' then
		self:SetWeaponEnabledByLabel('LUpgradeTurret01', true)
		self:SetWeaponEnabledByLabel('LUpgradeTurret02', true)
		self:SetWeaponEnabledByLabel('LUpgradeTurret03', true)
		self:SetWeaponEnabledByLabel('LUpgradeTurret04', true)
        elseif enh == 'LEnergyBlasterRemove' then
		self:SetWeaponEnabledByLabel('LUpgradeTurret01', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret02', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret03', false)
		self:SetWeaponEnabledByLabel('LUpgradeTurret04', false)
		elseif enh == 'LArtillery' then
		self:SetWeaponEnabledByLabel('LArt', true)
		elseif enh == 'LArtilleryRemove' then
		self:SetWeaponEnabledByLabel('LArt', false)
		elseif enh == 'REnergyBlaster' then
		self:SetWeaponEnabledByLabel('RUpgradeTurret01', true)
		self:SetWeaponEnabledByLabel('RUpgradeTurret02', true)
		self:SetWeaponEnabledByLabel('RUpgradeTurret03', true)
		self:SetWeaponEnabledByLabel('RUpgradeTurret04', true)
        elseif enh == 'REnergyBlasterRemove' then
		self:SetWeaponEnabledByLabel('RUpgradeTurret01', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret02', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret03', false)
		self:SetWeaponEnabledByLabel('RUpgradeTurret04', false)
		elseif enh == 'RArtillery' then
		self:SetWeaponEnabledByLabel('RArt', true)
		elseif enh == 'RArtilleryRemove' then
		self:SetWeaponEnabledByLabel('RArt', false)
        elseif enh == 'Shield' then
            self:AddToggleCap('RULEUTC_ShieldToggle')
            self:SetEnergyMaintenanceConsumptionOverride(bp.MaintenanceConsumptionPerSecondEnergy or 0)
            self:SetMaintenanceConsumptionActive()
            self:CreatePersonalShield(bp)
        elseif enh == 'ShieldRemove' then
            self:DestroyShield()
            self:SetMaintenanceConsumptionInactive()
            self:RemoveToggleCap('RULEUTC_ShieldToggle')
        elseif enh == 'ShieldHeavy' then
            self:AddToggleCap('RULEUTC_ShieldToggle')
            self:ForkThread(self.CreateHeavyShield, bp)
        elseif enh == 'ShieldHeavyRemove' then
            self:DestroyShield()
            self:SetMaintenanceConsumptionInactive()
            self:RemoveToggleCap('RULEUTC_ShieldToggle')
		elseif enh == 'Armor' then
		if not Buffs['DeroyArmorPlatingUpgrade1'] then
                BuffBlueprint {
                    Name = 'DeroyArmorPlatingUpgrade1',
                    DisplayName = 'Deroy Armor Plating Imrovement',
                    BuffType = 'DeroyArmorPlatingUpgrade1',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
						Regenerate = {
                            Add = bp.NewRegenerate,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'DeroyArmorPlatingUpgrade1')
        elseif enh == 'ArmorRemove' then
			if Buff.HasBuff(self, 'DeroyArmorPlatingUpgrade1') then
                Buff.RemoveBuff(self, 'DeroyArmorPlatingUpgrade1')
            end
        elseif enh == 'Armor2' then
		if not Buffs['DeroyArmorPlatingUpgrade2'] then
                BuffBlueprint {
                    Name = 'DeroyArmorPlatingUpgrade2',
                    DisplayName = 'Deroy Armor Plating Imrovement',
                    BuffType = 'DeroyArmorPlatingUpgrade2',
                    Stacks = 'STACKS',
                    Duration = -1,
                    Affects = {
                        MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
						Regenerate = {
                            Add = bp.NewRegenerate,
                            Mult = 1.0,
                        },
                    },
                }
            end
		Buff.ApplyBuff(self, 'DeroyArmorPlatingUpgrade2')
        elseif enh == 'Armor2Remove' then
		    if Buff.HasBuff(self, 'DeroyArmorPlatingUpgrade2') then
                Buff.RemoveBuff(self, 'DeroyArmorPlatingUpgrade2')
            end
		end
    end,
	
	OnScriptBitSet = function(self, bit)
        AWalkingLandUnit.OnScriptBitSet(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('LUpgradeMissileBattery', true)
			self:SetWeaponEnabledByLabel('RUpgradeMissileBattery', true)
			self:SetWeaponEnabledByLabel('LUpgradeAAMissileBattery', false)
			self:SetWeaponEnabledByLabel('RUpgradeAAMissileBattery', false)
            self:GetWeaponManipulatorByLabel('LUpgradeMissileBattery'):SetHeadingPitch( self:GetWeaponManipulatorByLabel('LUpgradeAAMissileBattery'):GetHeadingPitch() )
			self:GetWeaponManipulatorByLabel('RUpgradeMissileBattery'):SetHeadingPitch( self:GetWeaponManipulatorByLabel('RUpgradeAAMissileBattery'):GetHeadingPitch() )
        end
    end,

    OnScriptBitClear = function(self, bit)
        AWalkingLandUnit.OnScriptBitClear(self, bit)
        if bit == 1 then 
			self:SetWeaponEnabledByLabel('LUpgradeMissileBattery', false)
			self:SetWeaponEnabledByLabel('RUpgradeMissileBattery', false)
            self:SetWeaponEnabledByLabel('LUpgradeAAMissileBattery', true)
			self:SetWeaponEnabledByLabel('RUpgradeAAMissileBattery', true)
            self:GetWeaponManipulatorByLabel('LUpgradeAAMissileBattery'):SetHeadingPitch( self:GetWeaponManipulatorByLabel('LUpgradeMissileBattery'):GetHeadingPitch() )
			self:GetWeaponManipulatorByLabel('RUpgradeAAMissileBattery'):SetHeadingPitch( self:GetWeaponManipulatorByLabel('RUpgradeMissileBattery'):GetHeadingPitch() )
        end
    end,
	
	CreateHeavyShield = function(self, bp)
        WaitTicks(1)
        self:CreatePersonalShield(bp)
        self:SetEnergyMaintenanceConsumptionOverride(bp.MaintenanceConsumptionPerSecondEnergy or 0)
        self:SetMaintenanceConsumptionActive()
    end,

}

TypeClass = UAL0300X