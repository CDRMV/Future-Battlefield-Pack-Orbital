local EffectTemplate = import('/lua/EffectTemplates.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local FBPOEffectTemplate = import('/mods/Future Battlefield Pack Orbital/lua/FBPOEffectTemplates.lua')
local util = import('/lua/utilities.lua')


--------------------------------------------------------------------------------

-- Spaceship FAF Hyperspace Wormhole Effects

--------------------------------------------------------------------------------
-- Note:
-- These Effects replace the Vanilla Teleportation Effects
-- This Code is for FAF (Forged Alliance Forever)
--------------------------------------------------------------------------------

function PlayHyperspaceChargingEffects(unit, TeleportDestination, EffectsBag, teleDelay)
    -- Plays teleport effects for the given unit
    if not unit then
        return
    end

    local bp = unit:GetBlueprint()
    local faction = bp.General.FactionName
    local Yoffset = HyperspaceGetUnitYOffset(unit)

    TeleportDestination = HyperspaceLocationToSurface(TeleportDestination)

    -- Play tele FX at unit location
    if bp.Display.HyperspaceEffects.PlayChargeFxAtUnit ~= false then
        unit:PlayUnitAmbientSound('TeleportChargingAtUnit')

        if faction == 'UEF' then
            -- We recycle the teleport destination effects since they are way more epic
            unit.TeleportChargeBag = {}
            local telefx = FBPOEffectTemplate.UEFHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, 6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
            end

            -- Make steam FX
            local totalBones = unit:GetBoneCount() - 1
            for _, v in EffectTemplate.UnitTeleportSteam01 do
                for bone = 1, totalBones do
                    local emitter = CreateAttachedEmitter(unit, bone, unit.Army, v):SetEmitterParam('Lifetime', 9999) -- Adjust the lifetime so we always teleport before its done

                    table.insert(unit.TeleportChargeBag, emitter)
                    EffectsBag:Add(emitter)
                end
            end
		elseif faction == 'Aeon' then
            -- We recycle the teleport destination effects since they are way more epic
            unit.TeleportChargeBag = {}
            local telefx = FBPOEffectTemplate.AeonHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, 6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
            end

            -- Make steam FX
            local totalBones = unit:GetBoneCount() - 1
            for _, v in EffectTemplate.UnitTeleportSteam01 do
                for bone = 1, totalBones do
                    local emitter = CreateAttachedEmitter(unit, bone, unit.Army, v):SetEmitterParam('Lifetime', 9999) -- Adjust the lifetime so we always teleport before its done

                    table.insert(unit.TeleportChargeBag, emitter)
                    EffectsBag:Add(emitter)
                end
            end
        -- Use a per-bone FX construction rather than wrap-around for the non-UEF factions
        elseif faction == 'Cybran' then
            -- We recycle the teleport destination effects since they are way more epic
            unit.TeleportChargeBag = {}
            local telefx = FBPOEffectTemplate.CybranHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, 6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
            end

            -- Make steam FX
            local totalBones = unit:GetBoneCount() - 1
            for _, v in EffectTemplate.UnitTeleportSteam01 do
                for bone = 1, totalBones do
                    local emitter = CreateAttachedEmitter(unit, bone, unit.Army, v):SetEmitterParam('Lifetime', 9999) -- Adjust the lifetime so we always teleport before its done

                    table.insert(unit.TeleportChargeBag, emitter)
                    EffectsBag:Add(emitter)
                end
            end
        elseif faction == 'Seraphim' then
            -- We recycle the teleport destination effects since they are way more epic
            unit.TeleportChargeBag = {}
            local telefx = FBPOEffectTemplate.SeraphimHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, 6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
            end

            -- Make steam FX
            local totalBones = unit:GetBoneCount() - 1
            for _, v in EffectTemplate.UnitTeleportSteam01 do
                for bone = 1, totalBones do
                    local emitter = CreateAttachedEmitter(unit, bone, unit.Army, v):SetEmitterParam('Lifetime', 9999) -- Adjust the lifetime so we always teleport before its done

                    table.insert(unit.TeleportChargeBag, emitter)
                    EffectsBag:Add(emitter)
                end
            end
        else
            unit.TeleportChargeBag = HyperspaceShowChargeUpFxAtUnit(unit, FBPOEffectTemplate.GenericHyperspaceCharge01, EffectsBag)
        end
    end

    if teleDelay then
        WaitTicks(teleDelay * 10)
    end

    -- Play tele FX at destination, including sounds
    if bp.Display.HyperspaceEffects.PlayChargeFxAtDestination ~= false then
        -- Customized version of PlayUnitAmbientSound() from unit.lua to play sound at target destination
        local sound = 'TeleportChargingAtDestination'
        local sndEnt = false

        unit.TeleportSoundChargeBag = {}
        if sound and bp.Audio[sound] then
            if not unit.AmbientSounds then
                unit.AmbientSounds = {}
            end
            if not unit.AmbientSounds[sound] then
                sndEnt = Entity {}
                unit.AmbientSounds[sound] = sndEnt
                unit.Trash:Add(sndEnt)
                Warp(sndEnt, TeleportDestination) -- Warping sound entity to destination so ambient sound plays there (and not at unit)
                table.insert(unit.TeleportSoundChargeBag, sndEnt)
            end
            unit.AmbientSounds[sound]:SetAmbientSound(bp.Audio[sound], nil)
        end

        -- Using a barebone entity to position effects, it is destroyed afterwards
        local TeleportDestFxEntity = Entity()
        Warp(TeleportDestFxEntity, TeleportDestination)
        unit.TeleportDestChargeBag = {}

        if faction == 'UEF' then
            local telefx = FBPOEffectTemplate.UEFHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateEmitterAtEntity(TeleportDestFxEntity, unit.Army, v):OffsetEmitter(0, bp.Physics.Elevation, 0)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportDestChargeBag, fx)
                EffectsBag:Add(fx)
            end
			TeleportDestFxEntity:Destroy()
		elseif faction == 'Aeon' then
            local telefx = FBPOEffectTemplate.AeonHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateEmitterAtEntity(TeleportDestFxEntity, unit.Army, v):OffsetEmitter(0, bp.Physics.Elevation, 0)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportDestChargeBag, fx)
                EffectsBag:Add(fx)
            end
			TeleportDestFxEntity:Destroy()
        elseif faction == 'Cybran' then
            local telefx = FBPOEffectTemplate.CybranHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateEmitterAtEntity(TeleportDestFxEntity, unit.Army, v):OffsetEmitter(0, bp.Physics.Elevation, 0)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportDestChargeBag, fx)
                EffectsBag:Add(fx)
            end
			TeleportDestFxEntity:Destroy()
        elseif faction == 'Seraphim' then
            local telefx = FBPOEffectTemplate.SeraphimHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateEmitterAtEntity(TeleportDestFxEntity, unit.Army, v):OffsetEmitter(0, bp.Physics.Elevation, 0)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportDestChargeBag, fx)
                EffectsBag:Add(fx)
            end

            TeleportDestFxEntity:Destroy()
        else
            local telefx = FBPOEffectTemplate.GenericHyperspaceCharge02
            for _, v in telefx do
                local fx = CreateEmitterAtEntity(TeleportDestFxEntity, unit.Army, v):OffsetEmitter(0, Yoffset, 0)
                fx:ScaleEmitter(0.01)
                table.insert(unit.TeleportDestChargeBag, fx)
                EffectsBag:Add(fx)
            end

            TeleportDestFxEntity:Destroy()
        end
    end
end

function HyperspaceGetUnitYOffset(unit)
    -- Returns how high to create effects to make the effects appear in the center of the unit
    local bp = unit:GetBlueprint()
    return bp.Display.HyperspaceEffects.FxChargeAtDestOffsetY or ((bp.Physics.MeshExtentsY or bp.SizeY or 2) / 2)
end

function HyperspaceGetUnitSizes(unit)
    -- Returns the sizes of the unit, to be used for teleportation effects
    local bp = unit:GetBlueprint()
    return (bp.Display.HyperspaceEffects.FxSizeX or bp.Physics.MeshExtentsX or bp.SizeX or 1),
           (bp.Display.HyperspaceEffects.FxSizeY or bp.Physics.MeshExtentsY or bp.SizeY or 1),
           (bp.Display.HyperspaceEffects.FxSizeZ or bp.Physics.MeshExtentsZ or bp.SizeZ or 1),
           (bp.Display.HyperspaceEffects.FxOffsetX or bp.CollisionOffsetX or 0),
           (bp.Display.HyperspaceEffects.FxOffsetY or bp.CollisionOffsetY or 0),
           (bp.Display.HyperspaceEffects.FxOffsetZ or bp.CollisionOffsetZ or 0)
end

function HyperspaceLocationToSurface(loc)
    -- Takes the given location, adjust the Y value to the surface height on that location
    local pos = table.copy(loc)
    pos[2] = GetTerrainHeight(pos[1], pos[3]) + GetTerrainTypeOffset(pos[1], pos[3])
    return pos
end

function HyperspaceShowChargeUpFxAtUnit(unit, effectTemplate, EffectsBag)
    -- Creates charge up effects at the unit
    local bp = unit:GetBlueprint()
    local bones = bp.Display.HyperspaceEffects.ChargeFxAtUnitBones or {Bone = 0, Offset = {0, 0, 3}, }
    local bone, ox, oy, oz
    local emitters = {}
    for _, value in bones do
        bone = value.Bone or 0
        ox = value.Offset[1] or 0
        oy = value.Offset[2] or 0
        oz = value.Offset[3] or 0
        for _, v in effectTemplate do
            local fx = CreateEmitterAtBone(unit, bone, unit.Army, v):OffsetEmitter(ox, oy, oz)
            table.insert(emitters, fx)
            EffectsBag:Add(fx)
        end
    end

    return emitters
end

function HyperspaceCreateCybranSphere(unit, location, initialScale)
    -- Creates the sphere used by Cybran teleportation effects
    local bp = unit:GetBlueprint()
    local scale = 1

    local sx, sy, sz = HyperspaceGetUnitSizes(unit)
    local scale = 1.25 * math.max(sx, math.max(sy, sz))
    unit.HyperspaceCybranSphereScale = scale

    local sphere = Entity()
    sphere:SetPosition(location, true)
    sphere:SetMesh('/effects/Entities/CybranTeleport/CybranTeleport_mesh', false)
    sphere:SetDrawScale(initialScale or scale)
    unit.HyperspaceCybranSphere = sphere
    unit.Trash:Add(sphere)

    sphere:SetVizToAllies('Intel')
    sphere:SetVizToEnemies('Intel')
    sphere:SetVizToFocusPlayer('Intel')
    sphere:SetVizToNeutrals('Intel')

    return sphere
end

function HyperspaceChargingProgress(unit, fraction)
    local bp = unit:GetBlueprint()

    if bp.Display.HyperspaceEffects.PlayChargeFxAtDestination ~= false then
        fraction = math.min(math.max(fraction, 0.01), 1)
        local faction = bp.General.FactionName

        if faction == 'UEF' then
            -- Increase rotation of effects as progressing
            if unit.TeleportDestChargeBag then
                local scale = 0.75 + (0.5 * math.max(fraction, 0.01))
                for _, fx in unit.TeleportDestChargeBag do
                    fx:ScaleEmitter(scale)
                end

                -- Scale FX at unit location as well
                for _, fx in unit.TeleportChargeBag do
                    fx:ScaleEmitter(scale)
                end
            end
		elseif faction == 'Aeon' then
            -- Increase rotation of effects as progressing
            if unit.TeleportDestChargeBag then
                local scale = 0.75 + (0.5 * math.max(fraction, 0.01))
                for _, fx in unit.TeleportDestChargeBag do
                    fx:ScaleEmitter(scale)
                end

                -- Scale FX at unit location as well
                for _, fx in unit.TeleportChargeBag do
                    fx:ScaleEmitter(scale)
                end
            end
        elseif faction == 'Cybran' then
            -- Increase size of sphere and effects as progressing
            local scale = math.max(fraction, 0.01) * (unit.HyperspaceCybranSphereScale or 5)
            if unit.HyperspaceCybranSphere then
                unit.HyperspaceCybranSphere:SetDrawScale(scale)
            end
            if unit.TeleportDestChargeBag then
                for _, fx in unit.TeleportDestChargeBag do
                   fx:ScaleEmitter(scale)
                end
            end
        elseif unit.TeleportDestChargeBag then
            -- Increase size of effects as progressing

            local scale = (2 * fraction) - math.pow(fraction, 2)
            for _, fx in unit.TeleportDestChargeBag do
               fx:ScaleEmitter(scale)
            end
        end
    end
end

function PlayHyperspaceOutEffects(unit, EffectsBag)
    -- Fired when the unit is being teleported, just before the unit is taken from its original location
    local bp = unit:GetBlueprint()
    local faction = bp.General.FactionName
    local Yoffset = HyperspaceGetUnitYOffset(unit)

    if bp.Display.HyperspaceEffects.PlayTeleportOutFx ~= false then
        unit:PlayUnitSound('TeleportOut')

        if faction == 'UEF' then
            local scaleX, scaleY, scaleZ = HyperspaceGetUnitSizes(unit)
            local cfx = unit:CreateProjectile('/effects/Entities/UEFBuildEffect/UEFBuildEffect02_proj.bp', 0, 0, 0, nil, nil, nil)
            cfx:SetScale(scaleX, scaleY, scaleZ)
            EffectsBag:Add(cfx)

            CreateLightParticle(unit, -1, unit.Army, 3, 7, 'glow_03', 'ramp_blue_02')
            local templ = unit.TeleportOutFxOverride or FBPOEffectTemplate.UEFHyperspaceOut01
            for _, v in templ do
                CreateEmitterAtEntity(unit, unit.Army, v):OffsetEmitter(0, Yoffset, 0)
            end
		elseif faction == 'Aeon' then
            CreateLightParticle(unit, -1, unit.Army, 3, 7, 'glow_03', 'ramp_purple_02')
            local templ = unit.TeleportOutFxOverride or FBPOEffectTemplate.AeonHyperspaceOut01
            for _, v in templ do
                CreateEmitterAtEntity(unit, unit.Army, v):OffsetEmitter(0, Yoffset, 0)
            end
        elseif faction == 'Cybran' then
            CreateLightParticle(unit, -1, unit.Army, 4, 10, 'glow_02', 'ramp_red_06')
            local templ = unit.TeleportOutFxOverride or FBPOEffectTemplate.CybranHyperspaceOut01
            for _, v in templ do
                CreateEmitterAtEntity(unit, unit.Army, v):OffsetEmitter(0, Yoffset, 0)
            end
        elseif faction == 'Seraphim' then
            CreateLightParticle(unit, -1, unit.Army, 4, 15, 'glow_05', 'ramp_jammer_01')
            local templ = unit.TeleportOutFxOverride or FBPOEffectTemplate.SeraphimHyperspaceOut01
            for _, v in templ do
                CreateEmitterAtEntity(unit, unit.Army, v):OffsetEmitter(0, Yoffset, 0)
            end
        else  -- Aeon or other factions
            local templ = unit.TeleportOutFxOverride or FBPOEffectTemplate.GenericHyperspaceOut01
            for _, v in templ do
                CreateEmitterAtEntity(unit, unit.Army, v)
            end
        end
    end
end

function DoHyperspaceInDamage(unit)
    -- Check for teleport dummy weapon and deal the specified damage. Also show fx.
    local bp = unit:GetBlueprint()
    local Yoffset = HyperspaceGetUnitYOffset(unit)

    local dmg = 0
    local dmgRadius = 0
    local dmgType = 'Normal'
    local dmgFriendly = false
    if bp.Weapon then
        for _, wep in bp.Weapon do
            if wep.Label == 'TeleportWeapon' then
                dmg = wep.Damage or dmg
                dmgRadius = wep.DamageRadius or dmgRadius
                dmgType = wep.DamageType or dmgType
                dmgFriendly = wep.DamageFriendly or dmgFriendly
                break
            end
        end
        if dmg > 0 and dmgRadius > 0 then
            local faction = bp.General.FactionName
            local army = unit.Army
            local templ
            if unit.TeleportInWeaponFxOverride then
                templ = unit.TeleportInWeaponFxOverride
            elseif faction == 'UEF' then
                templ = FBPOEffectTemplate.UEFHyperspaceInWeapon01
			elseif faction == 'Aeon' then
                templ = FBPOEffectTemplate.AeonHyperspaceInWeapon01
            elseif faction == 'Cybran' then
                templ = FBPOEffectTemplate.CybranHyperspaceInWeapon01
            elseif faction == 'Seraphim' then
                templ = FBPOEffectTemplate.SeraphimHyperspaceInWeapon01
            else -- Aeon or other factions
                templ = FBPOEffectTemplate.GenericHyperspaceInWeapon01
            end

            local MeshExtentsY = (bp.Physics.MeshExtentsY or 1)
            for _, v in templ do
                CreateEmitterAtEntity(unit, army, v):OffsetEmitter(0, Yoffset, 0)
            end

            DamageArea(unit, unit:GetPosition(), dmgRadius, dmg, dmgType, dmgFriendly)
        end
    end
end

function CreateHyperspaceSteamFX(unit)
    local totalBones = unit:GetBoneCount() - 1
    for _, v in EffectTemplate.UnitTeleportSteam01 do
        for bone = 1, totalBones do
            CreateAttachedEmitter(unit, bone, unit.Army, v)
        end
    end
end

function PlayHyperspaceInEffects(unit, EffectsBag)
    -- Fired when the unit is being teleported, just after the unit is taken from its original location
    local bp = unit:GetBlueprint()
    local faction = bp.General.FactionName
    local Yoffset = HyperspaceGetUnitYOffset(unit)

    if bp.Display.HyperspaceEffects.PlayTeleportInFx ~= false then
        unit:PlayUnitSound('TeleportIn')
        if faction == 'UEF' then
            local templ = FBPOEffectTemplate.UEFHyperspaceIn01
            for _, v in templ do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, -6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
            end

            local fn = function(unit)
                local bp = unit:GetBlueprint()
                local MeshExtentsY = (bp.Physics.MeshExtentsY or 1)

                unit.TeleportFx_IsInvisible = true
                unit:HideBone(0, true)

                WaitSeconds(0.3)

                unit:ShowBone(0, true)
                unit:ShowEnhancementBones()
                unit.TeleportFx_IsInvisible = false
            end
            local thread = unit:ForkThread(fn)
		elseif faction == 'Aeon' then
            local templ = FBPOEffectTemplate.AeonHyperspaceIn01
            for _, v in templ do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, -6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
            end

            local fn = function(unit)
                local bp = unit:GetBlueprint()
                local MeshExtentsY = (bp.Physics.MeshExtentsY or 1)

                unit.TeleportFx_IsInvisible = true
                unit:HideBone(0, true)

                WaitSeconds(0.3)

                unit:ShowBone(0, true)
                unit:ShowEnhancementBones()
                unit.TeleportFx_IsInvisible = false
            end
            local thread = unit:ForkThread(fn)
        elseif faction == 'Cybran' then
            if not unit.HyperspaceCybranSphere then
                local pos = HyperspaceLocationToSurface(table.copy(unit:GetPosition()))
                pos[2] = pos[2] + Yoffset
                unit.TeleportCybranSphere = HyperspaceCreateCybranSphere(unit, pos)
            end

            local templ = FBPOEffectTemplate.CybranHyperspaceIn01
            local scale = unit.HyperspaceCybranSphereScale or 5
            for _, v in templ do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, -6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
            end

            local fn = function(unit)
                unit.TeleportFx_IsInvisible = true
                unit:HideBone(0, true)

                WaitSeconds(0.3)

                unit:ShowBone(0, true)
                unit:ShowEnhancementBones()
                unit.TeleportFx_IsInvisible = false

                WaitSeconds(0.8)

                if unit.HyperspaceCybranSphere then
                    unit.HyperspaceCybranSphere:Destroy()
                    unit.HyperspaceCybranSphere = false
                end
            end
            local thread = unit:ForkThread(fn)
        elseif faction == 'Seraphim' then
            local fn = function(unit)

                local bp = unit:GetBlueprint()
                local Yoffset = HyperspaceTeleportGetUnitYOffset(unit)

                unit.TeleportFx_IsInvisible = true
                unit:HideBone(0, true)

                local templ = FBPOEffectTemplate.SeraphimHyperspaceIn01
                for _, v in templ do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, -6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
                end

                WaitSeconds (0.3)

                unit:ShowBone(0, true)
                unit:ShowEnhancementBones()
                unit.TeleportFx_IsInvisible = false

                WaitSeconds (0.25)

                for _, v in FBPOEffectTemplate.SeraphimHyperspaceIn02 do
                    CreateEmitterAtEntity(unit, unit.Army, v):OffsetEmitter(0, Yoffset, 0)
                end
            end

            local thread = unit:ForkThread(fn)
        else
            local templ = FBPOEffectTemplate.GenericHyperspaceIn01
            for _, v in templ do
                local fx = CreateAttachedEmitter(unit, 0, unit.Army, v):OffsetEmitter(0, Yoffset, -6)
                fx:ScaleEmitter(0.75)
                fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, Yoffset * 2) -- To make effects cover entire height of unit
                table.insert(unit.TeleportChargeBag, fx)
                EffectsBag:Add(fx)
            end

            DamageArea(unit, unit:GetPosition(), 9, 1, 'Force', true)

            CreateTeleSteamFX(unit)
        end
    end
end

function DestroyHyperspaceChargingEffects(unit, EffectsBag)
    -- Called when charging up is done because successful or cancelled
    if unit.TeleportChargeBag then
        for _, values in unit.TeleportChargeBag do
            values:Destroy()
        end
        unit.TeleportChargeBag = {}
    end
    if unit.TeleportDestChargeBag then
        for _, values in unit.TeleportDestChargeBag do
            values:Destroy()
        end
        unit.TeleportDestChargeBag = {}
    end
    if unit.TeleportSoundChargeBag then -- Emptying the sounds so they stop.
        for _, values in unit.TeleportSoundChargeBag do
            values:Destroy()
        end
        if unit.AmbientSounds then
            unit.AmbientSounds = {} -- For some reason we couldnt simply add this to trash so empyting it like this
        end
        unit.TeleportSoundChargeBag = {}
    end
    EffectsBag:Destroy()

    unit:StopUnitAmbientSound('TeleportChargingAtUnit')
    unit:StopUnitAmbientSound('TeleportChargingAtDestination')
end

function DestroyRemainingHyperspaceChargingEffects(unit, EffectsBag)
    -- Called when we're done teleporting (because succesfull or cancelled)
    if unit.HyperspaceCybranSphere then
        unit.HyperspaceCybranSphere:Destroy()
    end
end

--------------------------------------------------------------------------------

-- Aeon Laserfence FAF Beam Effect

--------------------------------------------------------------------------------
-- Note:
-- I have added an function to recolour the Laser Beam Effect
-- However it only works with FAF (Forged Alliance Forever)
-- The Function: RenameBeamEmitterToColoured(BeamName, ArmyColourIndex) is originally coming from the Nomads Mod
--------------------------------------------------------------------------------

function RenameBeamEmitterToColoured(BeamName, ArmyColourIndex)
    if string.sub(BeamName,-3) == '.bp' then
        return string.sub(BeamName,1,-4) .. math.floor(100*ArmyColourIndex)
    end
    return string.sub(BeamName,1,-6) .. math.floor(100*ArmyColourIndex)
end


function CreateLaserFenceEffects( reclaimer, reclaimed, BuildEffectBones, EffectsBag )
	local army = reclaimer:GetArmy()
    local pos = reclaimed:GetPosition()
    pos[2] = GetSurfaceHeight(pos[1], pos[3])

    local beamEnd = Entity()
    EffectsBag:Add(beamEnd)
    Warp( beamEnd, pos )

    for kBone, vBone in BuildEffectBones do
		for kEmit, vEmit in FBPOEffectTemplate.AeonLaserFenceBeam do
			local beamBp = RenameBeamEmitterToColoured(vEmit, reclaimer.ColourIndex)
			local beamEffect = AttachBeamEntityToEntity(reclaimer, vBone, reclaimed, vBone, army, beamBp )
			EffectsBag:Add(beamEffect)
		end
	end
end

--------------------------------------------------------------------------------

-- Aeon Laserfence Steam Beam Effect

--------------------------------------------------------------------------------
-- Note:
-- Doesn't have the Recolour Function integrated
--------------------------------------------------------------------------------

function CreateLaserFenceEffectsSteam( reclaimer, reclaimed, BuildEffectBones, EffectsBag )
	local army = reclaimer:GetArmy()
    local pos = reclaimed:GetPosition()
    pos[2] = GetSurfaceHeight(pos[1], pos[3])

    local beamEnd = Entity()
    EffectsBag:Add(beamEnd)
    Warp( beamEnd, pos )

    for kBone, vBone in BuildEffectBones do
		for kEmit, vEmit in FBPOEffectTemplate.AeonLaserFenceBeam do
			local beamEffect = AttachBeamEntityToEntity(reclaimer, vBone, reclaimed, vBone, army, vEmit )
			EffectsBag:Add(beamEffect)
		end
	end
end






