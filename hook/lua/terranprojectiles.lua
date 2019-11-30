
local EffectTemplate = import('/lua/EffectTemplates.lua')

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

local EffectTemplate = import('/lua/EffectTemplates.lua')

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


