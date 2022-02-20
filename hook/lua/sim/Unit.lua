#****************************************************************************
#**
#**  File     :  /lua/terranweapons.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Terran-specific weapon definitions
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then 

do
	local UnitOld = Unit
	local FBPOEffectTemplates = import('/mods/Future Battlefield Pack Orbital/lua/FBPOEffectTemplates.lua')

	Unit = Class(UnitOld) {
	
	OnTeleportUnit = function(self, teleporter, location, orientation)
	    local myposition = self:GetPosition()
		local id = self:GetEntityId()
	    for num, brain in ArmyBrains do
            local unitList = brain:GetListOfUnits(categories.ANTITELEPORT, false)
            for i, unit in unitList do
                -- If it's an ally, then we skip.
                if IsEnemy(self:GetArmy(), unit:GetArmy()) then
                    local blockerRange = unit.NoTeleDistance
                    if blockerRange then
                        local blockerPosition = unit:GetPosition()
                        local targetDest = VDist2(location[1], location[3], blockerPosition[1], blockerPosition[3])
                        local sourceCheck = VDist2(myposition[1], myposition[3], blockerPosition[1], blockerPosition[3])
                        if blockerRange and blockerRange >= targetDest then
                            FloatingEntityText(id, 'Teleport Destination Scrambled')
                            return
                        elseif blockerRange and blockerRange >= sourceCheck then
                            FloatingEntityText(id, 'Teleport Source Location Scrambled')
                            return
                        end
                    end
                end
            end
        end
	
        if self.TeleportDrain then
            RemoveEconomyEvent( self, self.TeleportDrain)
            self.TeleportDrain = nil
        end
        if self.TeleportThread then
            KillThread(self.TeleportThread)
            self.TeleportThread = nil
        end
        self:CleanupTeleportChargeEffects()
        self.TeleportThread = self:ForkThread(self.InitiateTeleportThread, teleporter, location, orientation)
    end,

    OnFailedTeleport = function(self)
		if EntityCategoryContains(categories.SPACESHIP, self) or EntityCategoryContains(categories.CAPITALSPACESHIP, self) then
	    if self.TeleportDrain then
            RemoveEconomyEvent( self, self.TeleportDrain)
            self.TeleportDrain = nil
        end
        if self.TeleportThread then
            KillThread(self.TeleportThread)
            self.TeleportThread = nil
        end
        self:StopUnitAmbientSound('TeleportLoop')
        self:CleanupHyperspaceChargeEffects()
        self:SetWorkProgress(0.0)
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
		else
        if self.TeleportDrain then
            RemoveEconomyEvent( self, self.TeleportDrain)
            self.TeleportDrain = nil
        end
        if self.TeleportThread then
            KillThread(self.TeleportThread)
            self.TeleportThread = nil
        end
        self:StopUnitAmbientSound('TeleportLoop')
        self:CleanupTeleportChargeEffects()
        self:SetWorkProgress(0.0)
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
		end
    end,

    InitiateTeleportThread = function(self, teleporter, location, orientation)
		if EntityCategoryContains(categories.SPACESHIP, self) or EntityCategoryContains(categories.CAPITALSPACESHIP, self) then
        local tbp = teleporter:GetBlueprint()
        local ubp = self:GetBlueprint()
        self.UnitBeingTeleported = self
        self:SetImmobile(true)
        self:PlayUnitSound('TeleportStart')
        self:PlayUnitAmbientSound('TeleportLoop')
        local bp = self:GetBlueprint().Economy
        local energyCost, time
        if bp then
            local mass = bp.BuildCostMass * (bp.TeleportMassMod or 0.01)
            local energy = bp.BuildCostEnergy * (bp.TeleportEnergyMod or 0.01)
            energyCost = mass + energy
            time = energyCost * (bp.TeleportTimeMod or 0.01)
        end

        #LOG('*UNIT DEBUG: TELEPORTING, energyCost = ', repr(energyCost), ' time = ', repr(time))
        self.TeleportDrain = CreateEconomyEvent(self, energyCost or 100, 0, time or 5, self.UpdateHyperspaceProgress)

        # create teleport charge effect
        self:PlayHyperspaceChargeEffects()

        WaitFor( self.TeleportDrain  ) # Perform fancy Teleportation FX here

        if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain )
            self.TeleportDrain = nil
        end

        self:PlayHyperspaceOutEffects()
        self:CleanupHyperspaceChargeEffects()

        WaitSeconds( 0.1 )

        self:SetWorkProgress(0.0)
        Warp(self, location, orientation)
        self:PlayHyperspaceInEffects()

        WaitSeconds( 0.1 ) # Perform cooldown Teleportation FX here
        #Landing Sound
        #LOG('DROP')
        self:StopUnitAmbientSound('TeleportLoop')
        self:PlayUnitSound('TeleportEnd')
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
        self.TeleportThread = nil
		
		else
		
		local tbp = teleporter:GetBlueprint()
        local ubp = self:GetBlueprint()
        self.UnitBeingTeleported = self
        self:SetImmobile(true)
        self:PlayUnitSound('TeleportStart')
        self:PlayUnitAmbientSound('TeleportLoop')
        local bp = self:GetBlueprint().Economy
        local energyCost, time
        if bp then
            local mass = bp.BuildCostMass * (bp.TeleportMassMod or 0.01)
            local energy = bp.BuildCostEnergy * (bp.TeleportEnergyMod or 0.01)
            energyCost = mass + energy
            time = energyCost * (bp.TeleportTimeMod or 0.01)
        end

        #LOG('*UNIT DEBUG: TELEPORTING, energyCost = ', repr(energyCost), ' time = ', repr(time))
        self.TeleportDrain = CreateEconomyEvent(self, energyCost or 100, 0, time or 5, self.UpdateTeleportProgress)

        # create teleport charge effect
        self:PlayTeleportChargeEffects()

        WaitFor( self.TeleportDrain  ) # Perform fancy Teleportation FX here

        if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain )
            self.TeleportDrain = nil
        end

        self:PlayTeleportOutEffects()
        self:CleanupTeleportChargeEffects()

        WaitSeconds( 0.1 )

        self:SetWorkProgress(0.0)
        Warp(self, location, orientation)
        self:PlayTeleportInEffects()

        WaitSeconds( 0.1 ) # Perform cooldown Teleportation FX here
        #Landing Sound
        #LOG('DROP')
        self:StopUnitAmbientSound('TeleportLoop')
        self:PlayUnitSound('TeleportEnd')
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
        self.TeleportThread = nil
		
		end
    end,
	
	UpdateHyperspaceProgress = function(self, progress)
        #LOG(' UpdatingTeleportProgress ')
        self:SetWorkProgress(progress)
    end,

    PlayHyperspaceChargeEffects = function(self, location, orientation)
        local army = self:GetArmy()
        local bp = self:GetBlueprint()
		local EffectSize = bp.Physics.MeshExtentsX
		local YOffset = 0
		local faction = bp.General.FactionName
		
		if faction == 'UEF' then
        self.TeleportChargeBag = {}
        for k, v in FBPOEffectTemplates.UEFHyperspaceCharge01 do
            local fx = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ + 6)
			fx:ScaleEmitter(EffectSize)
			fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
            self.Trash:Add(fx)
            table.insert( self.TeleportChargeBag, fx)
        end
		elseif faction == 'Cybran' then
        self.TeleportChargeBag = {}
        for k, v in FBPOEffectTemplates.CybranHyperspaceCharge01 do
            local fx = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ + 6)
			fx:ScaleEmitter(EffectSize)
			fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
            self.Trash:Add(fx)
            table.insert( self.TeleportChargeBag, fx)
        end
		elseif faction == 'Aeon' then
        self.TeleportChargeBag = {}
        for k, v in FBPOEffectTemplates.AeonHyperspaceCharge01 do
            local fx = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ + 6)
			fx:ScaleEmitter(EffectSize)
			fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
            self.Trash:Add(fx)
            table.insert( self.TeleportChargeBag, fx)
        end
		elseif faction == 'Seraphim' then
        self.TeleportChargeBag = {}
        for k, v in FBPOEffectTemplates.SeraphimHyperspaceCharge01 do
            local fx = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ + 6)
			fx:ScaleEmitter(EffectSize)
			fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
            self.Trash:Add(fx)
            table.insert( self.TeleportChargeBag, fx)
        end
		else
		self.TeleportChargeBag = {}
        for k, v in EffectTemplate.GenericTeleportCharge01 do
            local fx = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ + 6)
			fx:ScaleEmitter(EffectSize)
			fx:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
            self.Trash:Add(fx)
            table.insert( self.TeleportChargeBag, fx)
        end
		end
    end,

    CleanupHyperspaceChargeEffects = function( self )
        if self.TeleportChargeBag then
            for keys,values in self.TeleportChargeBag do
                values:Destroy()
            end
            self.TeleportChargeBag = {}
        end
    end,

    PlayHyperspaceOutEffects = function(self)
        local army = self:GetArmy()
        local emit = nil
		local bp = self:GetBlueprint()
		local EffectSize = bp.Physics.MeshExtentsX
		local YOffset = bp.Physics.MeshExtentsY / 2
		local faction = bp.General.FactionName
		
		if faction == 'UEF' then
        for k, v in FBPOEffectTemplates.UEFHyperspaceOut01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		elseif faction == 'Cybran' then
        for k, v in FBPOEffectTemplates.CybranHyperspaceOut01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		elseif faction == 'Aeon' then
        for k, v in FBPOEffectTemplates.AeonHyperspaceOut01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		elseif faction == 'Seraphim' then
        for k, v in FBPOEffectTemplates.SeraphimHyperspaceOut01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		else
		for k, v in EffectTemplate.GenericTeleportOut01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		end
    end,


    PlayHyperspaceInEffects = function(self)
        local army = self:GetArmy()
        local bp = self:GetBlueprint()
		local EffectSize = bp.Physics.MeshExtentsX
		local YOffset = bp.Physics.MeshExtentsY / 2
		local faction = bp.General.FactionName
		
		if faction == 'UEF' then
        for k, v in FBPOEffectTemplates.UEFHyperspaceIn01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		elseif faction == 'Cybran' then
        for k, v in FBPOEffectTemplates.CybranHyperspaceIn01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		elseif faction == 'Aeon' then
        for k, v in FBPOEffectTemplates.AeonHyperspaceIn01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		elseif faction == 'Seraphim' then
        for k, v in FBPOEffectTemplates.SeraphimHyperspaceIn01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)
			emit:SetEmitterCurveParam('Y_POSITION_CURVE', 0, YOffset * 2) -- To make effects cover entire height of unit
        end
		else
        for k, v in EffectTemplate.GenericTeleportIn01 do
            emit = CreateAttachedEmitter(self, 0, self.Army, v):OffsetEmitter(0, YOffset, bp.Physics.MeshExtentsZ -9)
			emit:ScaleEmitter(EffectSize)

        end
		end
    end,
	
	}
	end
	

else

do
local UnitOld = Unit
local FBPOEffectUtilities = import('/mods/Future Battlefield Pack Orbital/lua/FBPOEffectUtilities.lua')

Unit = Class(UnitOld) {

    OnTeleportUnit = function(self, teleporter, location, orientation)
	    local myposition = self:GetPosition()
		local id = self:GetEntityId()
		for num, brain in ArmyBrains do
            local unitList = brain:GetListOfUnits(categories.ANTITELEPORT, false)
            for i, unit in unitList do
                -- If it's an ally, then we skip.
                if IsEnemy(self:GetArmy(), unit:GetArmy()) then
                    local blockerRange = unit.NoTeleDistance
                    if blockerRange then
                        local blockerPosition = unit:GetPosition()
                        local targetDest = VDist2(location[1], location[3], blockerPosition[1], blockerPosition[3])
                        local sourceCheck = VDist2(myposition[1], myposition[3], blockerPosition[1], blockerPosition[3])
                        if blockerRange and blockerRange >= targetDest then
                            FloatingEntityText(id, 'Warning: Gravitywell Generator Detected')
                            return
                        elseif blockerRange and blockerRange >= sourceCheck then
                            FloatingEntityText(id, 'Warning: Gravitywell Generator Online')
                            return
                        end
                    end
                end
            end
        end
	
		if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain)
            self.TeleportDrain = nil
        end

        if self.TeleportThread then
            KillThread(self.TeleportThread)
            self.TeleportThread = nil
        end

        self:CleanupTeleportChargeEffects()
        self.TeleportThread = self:ForkThread(self.InitiateTeleportThread, teleporter, location, orientation)
    end,

    OnFailedTeleport = function(self)
		if EntityCategoryContains(categories.SPACESHIP, self) or EntityCategoryContains(categories.CAPITALSPACESHIP, self) then
		if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain)
            self.TeleportDrain = nil
        end

        if self.TeleportThread then
            KillThread(self.TeleportThread)
            self.TeleportThread = nil
        end

        self:StopUnitAmbientSound('TeleportLoop')
        self:CleanupTeleportChargeEffects()
        self:CleanupRemainingTeleportChargeEffects()
        self:SetWorkProgress(0.0)
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
		
		else
		if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain)
            self.TeleportDrain = nil
        end

        if self.TeleportThread then
            KillThread(self.TeleportThread)
            self.TeleportThread = nil
        end

        self:StopUnitAmbientSound('TeleportLoop')
        self:CleanupTeleportChargeEffects()
        self:CleanupRemainingTeleportChargeEffects()
        self:SetWorkProgress(0.0)
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
		end
    end,

    InitiateTeleportThread = function(self, teleporter, location, orientation)
		if EntityCategoryContains(categories.SPACESHIP, self) or EntityCategoryContains(categories.CAPITALSPACESHIP, self) then
		self.UnitBeingTeleported = self
        self:SetImmobile(true)
        self:PlayUnitSound('TeleportStart')
        self:PlayUnitAmbientSound('TeleportLoop')

        local bp = self:GetBlueprint().Economy
        local energyCost, time
        if bp then
            local mass = (bp.TeleportMassCost or bp.BuildCostMass or 1) * (bp.TeleportMassMod or 0.01)
            local energy = (bp.TeleportEnergyCost or bp.BuildCostEnergy or 1) * (bp.TeleportEnergyMod or 0.01)
            energyCost = mass + energy
            time = energyCost * (bp.TeleportTimeMod or 0.01)
        end

        self.TeleportDrain = CreateEconomyEvent(self, energyCost or 100, 0, time or 5, self.UpdateHyperspaceProgress)

        -- Create teleport charge effect
        self:PlayHyperspaceChargeEffects(location, orientation)
        WaitFor(self.TeleportDrain)

        if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain)
            self.TeleportDrain = nil
        end

        self:PlayHyperspaceOutEffects()
        self:CleanupHyperspaceChargeEffects()
        WaitSeconds(0.1)
        self:SetWorkProgress(0.0)
        Warp(self, location, orientation)
        self:PlayHyperspaceInEffects()
        self:CleanupRemainingHyperspaceChargeEffects()

        WaitSeconds(0.1) -- Perform cooldown Teleportation FX here

        -- Landing Sound
        self:StopUnitAmbientSound('TeleportLoop')
        self:PlayUnitSound('TeleportEnd')
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
        self.TeleportThread = nil
		
		else
		
		self.UnitBeingTeleported = self
        self:SetImmobile(true)
        self:PlayUnitSound('TeleportStart')
        self:PlayUnitAmbientSound('TeleportLoop')

        local bp = self:GetBlueprint().Economy
        local energyCost, time
        if bp then
            local mass = (bp.TeleportMassCost or bp.BuildCostMass or 1) * (bp.TeleportMassMod or 0.01)
            local energy = (bp.TeleportEnergyCost or bp.BuildCostEnergy or 1) * (bp.TeleportEnergyMod or 0.01)
            energyCost = mass + energy
            time = energyCost * (bp.TeleportTimeMod or 0.01)
        end

        self.TeleportDrain = CreateEconomyEvent(self, energyCost or 100, 0, time or 5, self.UpdateTeleportProgress)

        -- Create teleport charge effect
        self:PlayTeleportChargeEffects(location, orientation)
        WaitFor(self.TeleportDrain)

        if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain)
            self.TeleportDrain = nil
        end

        self:PlayTeleportOutEffects()
        self:CleanupTeleportChargeEffects()
        WaitSeconds(0.1)
        self:SetWorkProgress(0.0)
        Warp(self, location, orientation)
        self:PlayTeleportInEffects()
        self:CleanupRemainingTeleportChargeEffects()

        WaitSeconds(0.1) -- Perform cooldown Teleportation FX here

        -- Landing Sound
        self:StopUnitAmbientSound('TeleportLoop')
        self:PlayUnitSound('TeleportEnd')
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
        self.TeleportThread = nil
		
		end
    end,

    UpdateHyperspaceProgress = function(self, progress)
        self:SetWorkProgress(progress)
        FBPOEffectUtilities.HyperspaceChargingProgress(self, progress)
    end,

    PlayHyperspaceChargeEffects = function(self, location, orientation, teleDelay)
        FBPOEffectUtilities.PlayHyperspaceChargingEffects(self, location, self.TeleportFxBag, teleDelay)
    end,

    CleanupHyperspaceChargeEffects = function(self)
        FBPOEffectUtilities.DestroyHyperspaceChargingEffects(self, self.TeleportFxBag)
    end,

    CleanupRemainingHyperspaceChargeEffects = function(self)
        FBPOEffectUtilities.DestroyRemainingHyperspaceChargingEffects(self, self.TeleportFxBag)
    end,

    PlayHyperspaceOutEffects = function(self)
        FBPOEffectUtilities.PlayHyperspaceOutEffects(self, self.TeleportFxBag)
    end,

    PlayHyperspaceInEffects = function(self)
        FBPOEffectUtilities.PlayHyperspaceInEffects(self, self.TeleportFxBag)
    end,
}
end

end
