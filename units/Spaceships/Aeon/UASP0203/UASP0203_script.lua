#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local FBPOWeaponFile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOweapons.lua')
local ADFOrbitalLaser = FBPOWeaponFile.ADFOrbitalLaser
local ADFHOrbitalLaser = FBPOWeaponFile.ADFHOrbitalLaser
local Buff = import('/lua/sim/Buff.lua')
local AIUtils = import('/lua/ai/aiutilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

UASP0203 = Class(AAirUnit) {

	Weapons = {
		AOHMainGun = Class(ADFHOrbitalLaser) {},
        OHMainGun = Class(ADFHOrbitalLaser) {},
        PBHMainGun = Class(ADFHOrbitalLaser) {},
		AOLMainGun = Class(ADFOrbitalLaser) {},
        OLMainGun = Class(ADFOrbitalLaser) {},
        PBLMainGun = Class(ADFOrbitalLaser) {},
    },
	
	
    GravityEffects = {
       '/effects/emitters/seraphim_regenerative_aura_01_emit.bp',
    },
	
	OnScriptBitSet = function(self, bit)
        AAirUnit.OnScriptBitSet(self, bit)
		local id = self:GetEntityId()
        if bit == 1 then   
			self:DisableUnitIntel('Sonar')
			self.NoTeleDistance = 60	
        self.GravityEffectsBag = {}
        if self.GravityEffectsBag then
            for k, v in self.GravityEffectsBag do
                v:Destroy()
            end
            self.GravityEffectsBag = {}
        end
        for k, v in self.GravityEffects do
            table.insert(self.GravityEffectsBag, CreateAttachedEmitter(self, 'Spinner01', self:GetArmy(), v):ScaleEmitter(0.4))
        end	
        FloatingEntityText(id, 'Gravitywell Generator activated')		
        end
    end,

    OnScriptBitClear = function(self, bit)
        AAirUnit.OnScriptBitClear(self, bit)
		local id = self:GetEntityId()
        if bit == 1 then 
			self.NoTeleDistance = 0
            if self.GravityEffectsBag then
                for k, v in self.GravityEffectsBag do
                    v:Destroy()
                end
		        self.GravityEffectsBag = {}
		    end
			FloatingEntityText(id, 'Gravitywell Generator deactivated')	
        end
    end,
}


TypeClass = UASP0203