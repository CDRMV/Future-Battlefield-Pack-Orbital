#****************************************************************************
#**
#**  File     :  /units/UEOW1102/UEOW1102_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  UEF t2 spaceships
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************


local TAirUnit = import('/lua/terranunits.lua').TAirUnit


local WeaponsFile = import('/lua/terranweapons.lua')
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon
local TIFArtillery01Weapon = import('/Mods/OrbitalWarsMod/hook/lua/modweapons.lua').TIFArtillery01Weapon

local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

UEOW1102  = Class(TAirUnit) {


    
    Weapons = {
		MainGun = Class(TIFArtillery01Weapon) {
		FxMuzzleFlashScale = 8,
        },
        Riotgun01 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        Riotgun02 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        Riotgun03 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        Riotgun04 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        Riotgun05 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        Riotgun06 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },	
        MissileWeapon = Class(TIFCruiseMissileUnpackingLauncher) {
            FxMuzzleFlash = {'/effects/emitters/terran_mobile_missile_launch_01_emit.bp'},
        },		
		HiroCannonFront1 = Class(TDFHiroPlasmaCannon) {},
		HiroCannonFront2 = Class(TDFHiroPlasmaCannon) {},
		HiroCannonFront3 = Class(TDFHiroPlasmaCannon) {},
		HiroCannonFront4 = Class(TDFHiroPlasmaCannon) {},
    },	
	
    MovementAmbientExhaustBones = {
		'Reacteur02',
		'Reacteur01',		
    },

    OnMotionHorzEventChange = function(self, new, old )
		TAirUnit.OnMotionHorzEventChange(self, new, old)
	
		if self.ThrustExhaustTT1 == nil then 
			if self.MovementAmbientExhaustEffectsBag then
				fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
			else
				self.MovementAmbientExhaustEffectsBag = {}
			end
			self.ThrustExhaustTT1 = self:ForkThread(self.MovementAmbientExhaustThread)
		end
		
        if new == 'Stopped' and self.ThrustExhaustTT1 != nil then
			KillThread(self.ThrustExhaustTT1)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
			self.ThrustExhaustTT1 = nil
        end		 
    end,
    
    MovementAmbientExhaustThread = function(self)
		while not self:IsDead() do
			local ExhaustEffects = {
				'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',
			}
			local ExhaustBeam = '/Mods/OrbitalWarsMod/hook/effects/emitters/missile_exhaust_fire_beam_12_emit.bp'
			local army = self:GetArmy()			
			
			for kE, vE in ExhaustEffects do
				for kB, vB in self.MovementAmbientExhaustBones do
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE ))
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateBeamEmitterOnEntity( self, vB, army, ExhaustBeam ))
				end
			end
			
			WaitSeconds(5)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
							
			--WaitSeconds(util.GetRandomFloat(0,3))
		end	
    end,		
	
	
}

TypeClass = UEOW1102 