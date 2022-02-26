local Projectile = import('/lua/sim/projectile.lua').Projectile
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local ModEffectTemplate = import('/mods/Future Battlefield Pack Orbital/lua/FBPOEffectTemplates.lua')

#------------------------------------------------------------------------
#  AEON ORBITAL PROJECTILES
#------------------------------------------------------------------------

ADFRingplatformProjectile = Class(SinglePolyTrailProjectile) {
    DestroyOnImpact = false,
    FxTrails = EffectTemplate.TMissileExhaust02,
    FxTrailOffset = 0,
    BeamName = '/effects/emitters/missile_munition_exhaust_beam_01_emit.bp',

    FxImpactUnit = EffectTemplate.TMissileHit01,
    FxImpactLand = EffectTemplate.TMissileHit01,
    FxImpactProp = EffectTemplate.TMissileHit01,
    FxImpactUnderWater = {},

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        SingleBeamProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

AMAntiOrbitalShieldDisruptorProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonMAntiSpaceshipShieldDisruptor,
	FxTrailScale = 0.7,
    FxImpactShield = EffectTemplate.ASDisruptorHitShield,
    FxImpactUnit = EffectTemplate.ASDisruptorHitUnit01,
    FxImpactProp = EffectTemplate.ASDisruptorHit01,
    FxImpactLand = EffectTemplate.ASDisruptorHit01,
    FxImpactAirUnit = EffectTemplate.ASDisruptorHitUnit01,
    FxImpactNone = EffectTemplate.ASDisruptorHit01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

AHAntiOrbitalShieldDisruptorProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonHAntiSpaceshipShieldDisruptor,
    FxImpactShield = EffectTemplate.ASDisruptorHitShield,
    FxImpactUnit = EffectTemplate.ASDisruptorHitUnit01,
    FxImpactProp = EffectTemplate.ASDisruptorHit01,
    FxImpactLand = EffectTemplate.ASDisruptorHit01,
    FxImpactAirUnit = EffectTemplate.ASDisruptorHitUnit01,
    FxImpactNone = EffectTemplate.ASDisruptorHit01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

ALAntiOrbitalGravitonProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonLAntiSpaceshipWeapon,
	FxTrailScale = 0.3,
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

AMAntiOrbitalGravitonProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonMAntiSpaceshipWeapon,
	FxTrailScale = 0.7,
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

AHAntiOrbitalGravitonProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonHAntiSpaceshipWeapon,
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

AOrbitalGravitonProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonOrbSpaceshipWeapon,
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

APBDeroyDropProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonDeroyDropWeapon,
	FxTrailScale = 1.2,
    FxImpactUnit = EffectTemplate.AOblivionCannonHit01,
    FxImpactProp = EffectTemplate.AOblivionCannonHit01,
    FxImpactLand = EffectTemplate.AOblivionCannonHit01,
    FxImpactWater = EffectTemplate.AOblivionCannonHit01,
    FxImpactNone = EffectTemplate.AOblivionCannonHit01, 
    FxImpactUnderWater = {},
}

APBACUDropProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonDeroyDropWeapon,
	FxTrailScale = 1.2,
    FxImpactUnit = EffectTemplate.AOblivionCannonHit01,
    FxImpactProp = EffectTemplate.AOblivionCannonHit01,
    FxImpactLand = EffectTemplate.AOblivionCannonHit01,
    FxImpactWater = EffectTemplate.AOblivionCannonHit01,
    FxImpactNone = EffectTemplate.AOblivionCannonHit01, 
    FxImpactUnderWater = {},
}

APBGravitonProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonOrbSpaceshipWeapon,
	FxImpactShield = EffectTemplate.AeonDeflectorShieldHit01,
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

ASFLaserProjectile = Class(EmitterProjectile) {

    FxTrails = ModEffectTemplate.AeonOrbSpaceshipWeapon,
	FxTrailScale = 0.1,
	FxUnitHitScale = 0.1,
	FxAirUnitHitScale = 0.1,
	FxPropHitScale = 0.1,
	FxNoneHitScale = 0.1,
	FxLandHitScale = 0.1,

    # Hit Effects
	FxImpactShield = EffectTemplate.AeonDeflectorShieldHit01,
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

AASPZealotTorpedoProjectile = Class(SinglePolyTrailProjectile) {
    PolyTrail = '/effects/emitters/aeon_missile_trail_01_emit.bp',
	PolyTrailOffset = -0.05,
	FxUnitHitScale = 0.1,
	FxAirUnitHitScale = 0.1,
	FxPropHitScale = 0.1,
	FxNoneHitScale = 0.1,
	FxLandHitScale = 0.1,
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactAirUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactNone = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
}


AOrbitalLaser01 = Class(MultiPolyTrailProjectile) {

    FxTrails = ModEffectTemplate.AeonLightSpaceshipWeapon,
	FxTrailScale = 0.4,

    PolyTrails = {
    		'/mods/Future Battlefield Pack Orbital/effects/emitters/orbital_laser_cannon_polytrail_01_emit.bp',
    		'/mods/Future Battlefield Pack Orbital/effects/emitters/orbital_laser_cannon_polytrail_01_emit.bp',
	},
	PolyTrailOffset = {0,0},

    # Hit Effects
	FxImpactShield = EffectTemplate.AeonDeflectorShieldHit01,
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

AHOrbitalLaser01 = Class(MultiPolyTrailProjectile) {

    FxTrails = ModEffectTemplate.AeonHeavySpaceshipWeapon,
	FxTrailScale = 0.4,

    PolyTrails = {
    		'/mods/Future Battlefield Pack Orbital/effects/emitters/orbital_laser_cannon_polytrail_01_emit.bp',
    		'/mods/Future Battlefield Pack Orbital/effects/emitters/orbital_laser_cannon_polytrail_01_emit.bp',
	},
	PolyTrailOffset = {0,0},

    # Hit Effects
	FxImpactShield = EffectTemplate.AeonDeflectorShieldHit01,
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

AEnergyDroneProjectile = Class(SinglePolyTrailProjectile) {
    PolyTrail = '/effects/emitters/default_polytrail_03_emit.bp',

    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactAirUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactNone = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  UEF ORBITAL PROJECTILES
#------------------------------------------------------------------------

TOrbitalLaser01 = Class(MultiPolyTrailProjectile) {

    FxTrails = EffectTemplate.THiroLaserFxtrails,

    PolyTrails = {
    		'/mods/Future Battlefield Pack Orbital/effects/emitters/orbital_laser_cannon_polytrail_01_emit.bp',
    		'/mods/Future Battlefield Pack Orbital/effects/emitters/orbital_laser_cannon_polytrail_01_emit.bp',
	},
	PolyTrailOffset = {0,0},

    # Hit Effects
    FxImpactUnit = EffectTemplate.FireCloudMed01,
    FxImpactProp = EffectTemplate.FireCloudMed01,
    FxImpactLand = EffectTemplate.FireCloudMed01,
    FxImpactAirUnit = EffectTemplate.FireCloudMed01,
    FxImpactNone = EffectTemplate.FireCloudMed01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

TOrbitalLightLaser01 = Class(MultiPolyTrailProjectile) {


    FxTrails = EffectTemplate.TPlasmaGatlingCannonFxTrails,

    PolyTrails = EffectTemplate.TPlasmaGatlingCannonPolyTrails,
    PolyTrailOffset = EffectTemplate.TPlasmaGatlingCannonPolyTrailsOffsets,

    # Hit Effects
    FxImpactUnit = EffectTemplate.FireCloudSml01,
    FxImpactProp = EffectTemplate.FireCloudSml01,
    FxImpactLand = EffectTemplate.FireCloudSml01,
    FxImpactAirUnit = EffectTemplate.FireCloudSml01,
    FxImpactNone = EffectTemplate.FireCloudSml01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

TOrbitalAntifighterLightLaser01 = Class(MultiPolyTrailProjectile) {

    FxTrails = EffectTemplate.TPlasmaGatlingCannonFxTrails,

    PolyTrails = EffectTemplate.TPlasmaGatlingCannonPolyTrails,
    PolyTrailOffset = EffectTemplate.TPlasmaGatlingCannonPolyTrailsOffsets,

    # Hit Effects
    FxImpactUnit = EffectTemplate.FireCloudSml01,
    FxImpactProp = EffectTemplate.FireCloudSml01,
    FxImpactLand = EffectTemplate.FireCloudSml01,
    FxImpactAirUnit = EffectTemplate.FireCloudSml01,
    FxImpactNone = EffectTemplate.FireCloudSml01, 
    FxImpactWater = EffectTemplate.WaterSplash01,
    FxImpactUnderWater = {},
}

TPlasmaTorpedoProjectile = Class(SingleBeamProjectile) {
# Emitter Values
    FxInitial = {},
    TrailDelay = 1,
    FxTrails = {
		'/effects/emitters/miasma_munition_trail_01_emit.bp',
},
    FxTrailOffset = -0.5,

    FxAirUnitHitScale = 0.4,
    FxLandHitScale = 0.4,
    FxUnitHitScale = 0.4,
    FxPropHitScale = 0.4,
    FxImpactUnit = EffectTemplate.TMissileHit02,
    FxImpactAirUnit = EffectTemplate.TMissileHit02,
    FxImpactProp = EffectTemplate.TMissileHit02,    
    FxImpactLand = EffectTemplate.TMissileHit02,
    FxImpactUnderWater = {},
}

TLongdistancePlasmaTorpedoProjectile = Class(SingleBeamProjectile) {
# Emitter Values
    FxInitial = {},
    TrailDelay = 1,
    FxTrails = {
		'/effects/emitters/miasma_munition_trail_01_emit.bp',

},
    FxTrailOffset = -0.5,

    FxAirUnitHitScale = 0.4,
    FxLandHitScale = 0.4,
    FxUnitHitScale = 0.4,
    FxPropHitScale = 0.4,
    FxImpactUnit = EffectTemplate.TMissileHit02,
    FxImpactAirUnit = EffectTemplate.TMissileHit02,
    FxImpactProp = EffectTemplate.TMissileHit02,    
    FxImpactLand = EffectTemplate.TMissileHit02,
    FxImpactUnderWater = {},
}