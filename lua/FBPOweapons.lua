#****************************************************************************
#**
#**  File     :  /lua/terranweapons.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Terran-specific weapon definitions
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local CollisionBeams = import('/lua/defaultcollisionbeams.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local GinsuCollisionBeam = CollisionBeams.GinsuCollisionBeam
local OrbitalDeathLaserCollisionBeam = CollisionBeams.OrbitalDeathLaserCollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')

TDFOrbitalLaserWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/flash_02_emit.bp' },
}

TDFOrbitalLightLaserWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/flash_02_emit.bp' },
}

TDFOrbitalLightAntifighterLaserWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/flash_02_emit.bp' },
}

ADFOrbitalLaser = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/reacton_cannon_muzzle_charge_01_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_charge_02_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_charge_03_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_flash_01_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_flash_02_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_flash_03_emit.bp',},
}

ADFHOrbitalLaser = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/reacton_cannon_muzzle_charge_01_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_charge_02_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_charge_03_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_flash_01_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_flash_02_emit.bp',
                           '/effects/emitters/reacton_cannon_muzzle_flash_03_emit.bp',},
}

ASFEnergyDroneWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.CZealotLaunch01,
}

ADFOrbWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/flash_04_emit.bp' },
}

