local DefaultUnits = import('/lua/defaultunits.lua')
local FactoryUnit = DefaultUnits.FactoryUnit
local StructureUnit = DefaultUnits.StructureUnit
local ModEffectUtil = import('/mods/Future Battlefield Pack Orbital/lua/FBPOEffectUtilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
--------------------------------------------------------------------------------
-- Aeon Colonisation Tower
--------------------------------------------------------------------------------

AModulaTowerUnit = Class(FactoryUnit) {

    BuildAttachBone = 'Attachpoint',

    StartBeingBuiltEffects = function(self, builder, layer)
		FactoryUnit.StartBeingBuiltEffects(self, builder, layer)
    end,
    
    StopBeingBuiltEffects = function(self, builder, layer)
		FactoryUnit.StopBeingBuiltEffects(self, builder, layer)    
    end,
	
    OnCreate = function(self,builder,layer)
        self:AddBuildRestriction(categories.ANTINAVY)
        self:AddBuildRestriction(categories.HYDROCARBON)
        FactoryUnit.OnCreate(self,builder,layer)
    end,

    CreateBlinkingLights = function(self, color)
    end,

    FinishBuildThread = function(self, unitBeingBuilt, order )
        self:SetBusy(true)
        self:SetBlockCommandQueue(true)
        local bp = self:GetBlueprint()
        local bpAnim = bp.Display.AnimationFinishBuildLand
        --self:DestroyBuildRotator()
        if order ~= 'Upgrade' then
            ChangeState(self, self.RollingOffState)
        else
            self:SetBusy(false)
            self:SetBlockCommandQueue(false)
        end
        self.AttachedUnit = unitBeingBuilt
    end,

    StartBuildFx = function(self, unitBeingBuilt)
    end,

    OnDamage = function(self, instigator, amount, vector, damageType)
        FactoryUnit.OnDamage(self, instigator, amount, vector, damageType)
        if self.AttachedUnit and not self.AttachedUnit:IsDead() then
            self.AttachedUnit:OnDamage(instigator, amount * 0.5, vector, damageType)
        end
    end,

    OnScriptBitSet = function(self, bit)
        FactoryUnit.OnScriptBitSet(self, bit)
        if bit == 7 then
            if self.AttachedUnit then
                self.AttachedUnit:Destroy()
            end
            self:SetScriptBit('RULEUTC_SpecialToggle',false)
            IssueClearCommands({self})
        end
    end,

    UpgradingState = State(FactoryUnit.UpgradingState) {
        Main = function(self)
            FactoryUnit.UpgradingState.Main(self)
        end,

        OnStopBuild = function(self, unitBuilding)
            if unitBuilding:GetFractionComplete() == 1 then
                if self.AttachedUnit then
                    self.AttachedUnit:Destroy()
                end
            end
            FactoryUnit.UpgradingState.OnStopBuild(self, unitBuilding)
        end,
    }
}

ASpacestationUnit = Class(FactoryUnit) {
    OnCreate = function(self)
        StructureUnit.OnCreate(self)
        self.BuildingUnit = false
    end,
    
    OnPaused = function(self)
        #When factory is paused take some action
        self:StopUnitAmbientSound( 'ConstructLoop' )
        StructureUnit.OnPaused(self)
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            self:PlayUnitAmbientSound( 'ConstructLoop' )
        end
        StructureUnit.OnUnpaused(self)
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        local aiBrain = GetArmyBrain(self:GetArmy())
        aiBrain:ESRegisterUnitMassStorage(self)
        aiBrain:ESRegisterUnitEnergyStorage(self)
        local curEnergy = aiBrain:GetEconomyStoredRatio('ENERGY')
        local curMass = aiBrain:GetEconomyStoredRatio('MASS')
        if curEnergy > 0.11 and curMass > 0.11 then
            self:CreateBlinkingLights('Green')
            self.BlinkingLightsState = 'Green'
        else
            self:CreateBlinkingLights('Red')
            self.BlinkingLightsState = 'Red'
        end
        StructureUnit.OnStopBeingBuilt(self,builder,layer)
    end,

    ChangeBlinkingLights = function(self, state)
        local bls = self.BlinkingLightsState
        if state == 'Yellow' then
            if bls == 'Green' then
                self:CreateBlinkingLights('Yellow')
                self.BlinkingLightsState = state
            end
        elseif state == 'Green' then
            if bls == 'Yellow' then
                self:CreateBlinkingLights('Green')
                self.BlinkingLightsState = state
            elseif bls == 'Red' then
                local aiBrain = GetArmyBrain(self:GetArmy())
                local curEnergy = aiBrain:GetEconomyStoredRatio('ENERGY')
                local curMass = aiBrain:GetEconomyStoredRatio('MASS')
                if curEnergy > 0.11 and curMass > 0.11 then
                    if self:GetNumBuildOrders(categories.ALLUNITS) == 0 then
                        self:CreateBlinkingLights('Green')
                        self.BlinkingLightsState = state
                    else
                        self:CreateBlinkingLights('Yellow')
                        self.BlinkingLightsState = 'Yellow'
                    end
                end
            end
        elseif state == 'Red' then
            self:CreateBlinkingLights('Red')
            self.BlinkingLightsState = state
        end
    end,

    OnMassStorageStateChange = function(self, newState)
        if newState == 'EconLowMassStore' then
            self:ChangeBlinkingLights('Red')
        else
            self:ChangeBlinkingLights('Green')
        end
    end,

    OnEnergyStorageStateChange = function(self, newState)
        if newState == 'EconLowEnergyStore' then
            self:ChangeBlinkingLights('Red')
        else
            self:ChangeBlinkingLights('Green')
        end
    end,

    OnStartBuild = function(self, unitBeingBuilt, order )
        self:ChangeBlinkingLights('Yellow')
        StructureUnit.OnStartBuild(self, unitBeingBuilt, order )
        self.BuildingUnit = true
        if order != 'Upgrade' then
            ChangeState(self, self.BuildingState)
            self.BuildingUnit = false
        end
        self.FactoryBuildFailed = false
    end,

    OnStopBuild = function(self, unitBeingBuilt, order )
        StructureUnit.OnStopBuild(self, unitBeingBuilt, order )
        local bp = self:GetBlueprint()
        if not self.FactoryBuildFailed then
            self:StopBuildFx()
            self:ForkThread(self.FinishBuildThread, unitBeingBuilt, order )
        end
        self.BuildingUnit = false
    end,

    FinishBuildThread = function(self, unitBeingBuilt, order )
        self:SetBusy(true)
        self:SetBlockCommandQueue(true)
        local bp = self:GetBlueprint()
		if unitBeingBuilt and not unitBeingBuilt:IsDead() and EntityCategoryContains(categories.STARFIGHTER, unitBeingBuilt) then
			unitBeingBuilt:DetachFrom(true)
			self:DetachAll(bp.Display.BuildAttachBone or 0)
			if self:TransportHasAvailableStorage() then
				self:AddUnitToStorage(unitBeingBuilt)
			end
		end
		if unitBeingBuilt and not unitBeingBuilt:IsDead() and EntityCategoryContains(categories.STARBOMBER, unitBeingBuilt) then
			unitBeingBuilt:DetachFrom(true)
			self:DetachAll(bp.Display.BuildAttachBone or 0)
			if self:TransportHasAvailableStorage() then
				self:AddUnitToStorage(unitBeingBuilt)
			end
		end
		if unitBeingBuilt and not unitBeingBuilt:IsDead() and EntityCategoryContains(categories.DROPSHUTTLE, unitBeingBuilt) then
			unitBeingBuilt:DetachFrom(true)
			self:DetachAll(bp.Display.BuildAttachBone or 0)
			if self:TransportHasAvailableStorage() then
				self:AddUnitToStorage(unitBeingBuilt)
			end
		end
		if unitBeingBuilt and not unitBeingBuilt:IsDead() and EntityCategoryContains(categories.TRADESPACESHIP, unitBeingBuilt) then
			unitBeingBuilt:DetachFrom(true)
			self:DetachAll(bp.Display.BuildAttachBone or 0)
			if self:TransportHasAvailableStorage() then
				self:AddUnitToStorage(unitBeingBuilt)
			end
		end
		if unitBeingBuilt and not unitBeingBuilt:IsDead() and EntityCategoryContains(categories.SPACESHIP, unitBeingBuilt) then
		    self:RollOffUnit()
			unitBeingBuilt:DetachFrom(true)
			self:DetachAll(bp.Display.BuildAttachBone or 0)
            ChangeState(self, self.RollingOffState)
		end
        self:DestroyBuildRotator()
        if order != 'Upgrade' then
            ChangeState(self, self.RollingOffState)
        else
            self:SetBusy(false)
            self:SetBlockCommandQueue(false)
        end
    end,

    CheckBuildRestriction = function(self, target_bp)
        if self:CanBuild(target_bp.BlueprintId) then
            return true
        else
            return false
        end
    end,
    
    OnFailedToBuild = function(self)
        self.FactoryBuildFailed = true        
        StructureUnit.OnFailedToBuild(self)
        self:DestroyBuildRotator()
        self:StopBuildFx()
        ChangeState(self, self.IdleState)
    end,

    RollOffUnit = function(self)
        local spin, x, y, z = self:CalculateRollOffPoint()
        local units = { self.UnitBeingBuilt }
        self.MoveCommand = IssueMove(units, Vector(x, y, z))
    end,
    
    CalculateRollOffPoint = function(self)
        local bp = self:GetBlueprint().Physics.RollOffPoints
        local px, py, pz = unpack(self:GetPosition())
        if not bp then return 0, px, py, pz end
        local vectorObj = self:GetRallyPoint()
        local bpKey = 1
        local distance, lowest = nil
        for k, v in bp do
            distance = VDist2(vectorObj[1], vectorObj[3], v.X + px, v.Z + pz)
            if not lowest or distance < lowest then
                bpKey = k
                lowest = distance
            end
        end
        local fx, fy, fz, spin
        local bpP = bp[bpKey]
        local unitBP = self.UnitBeingBuilt:GetBlueprint().Display.ForcedBuildSpin
        if unitBP then
            spin = unitBP
        else
            spin = bpP.UnitSpin
        end
        fx = bpP.X + px
        fy = bpP.Y + py
        fz = bpP.Z + pz
        return spin, fx, fy, fz
    end,
    
    StartBuildFx = function(self, unitBeingBuilt)
        
    end,
    
    StopBuildFx = function(self)
        
    end,

    PlayFxRollOff = function(self)
    end,
    
    PlayFxRollOffEnd = function(self)
        if self.RollOffAnim then        
            self.RollOffAnim:SetRate(-1)
            WaitFor(self.RollOffAnim)
            self.RollOffAnim:Destroy()
            self.RollOffAnim = nil
        end
    end,
    
    CreateBuildRotator = function(self)
        if not self.BuildBoneRotator then
            local spin = self:CalculateRollOffPoint()
            local bp = self:GetBlueprint().Display
            self.BuildBoneRotator = CreateRotator(self, bp.BuildAttachBone or 0, 'y', spin, 10000)
            self.Trash:Add(self.BuildBoneRotator)
        end
    end,
    
    DestroyBuildRotator = function(self)
        if self.BuildBoneRotator then
            self.BuildBoneRotator:Destroy()
            self.BuildBoneRotator = nil
        end
    end,
    
    RolloffBody = function(self)
        self:SetBusy(true)
        self:SetBlockCommandQueue(true)
        self:PlayFxRollOff()
        # Wait until unit has left the factory
        while not self.UnitBeingBuilt:IsDead() and self.MoveCommand and not IsCommandDone(self.MoveCommand) do
            WaitSeconds(0.5)
        end
        self.MoveCommand = nil
        self:PlayFxRollOffEnd()
        self:SetBusy(false)
        self:SetBlockCommandQueue(false)
        ChangeState(self, self.IdleState)
    end,
            
    IdleState = State {

        Main = function(self)
            self:ChangeBlinkingLights('Green')
            self:SetBusy(false)
            self:SetBlockCommandQueue(false)
            self:DestroyBuildRotator()
        end,
    },

    BuildingState = State {

        Main = function(self)
            local unitBuilding = self.UnitBeingBuilt
            local bp = self:GetBlueprint()
            local bone = bp.Display.BuildAttachBone or 0
            self:DetachAll(bone)
            unitBuilding:AttachBoneTo(-2, self, bone)
            self:CreateBuildRotator()
            self:StartBuildFx(unitBuilding)
        end,
    },


    RollingOffState = State {
        Main = function(self)
            self:RolloffBody()
        end,
    },

    OnKilled = function(self, instigator, type, overkillRatio)
        StructureUnit.OnKilled(self, instigator, type, overkillRatio)
        if self.UnitBeingBuilt then
            self.UnitBeingBuilt:Destroy()
        end
    end,
}


ARingplatformUnit = Class(FactoryUnit) {
	
	OnPaused = function(self)
        FactoryUnit.OnPaused(self)
        self:StopArmsMoving()
    end,
    
    OnUnpaused = function(self)
        FactoryUnit.OnUnpaused(self)
        if self:GetNumBuildOrders(categories.ALLUNITS) > 0 and not self:IsUnitState('Upgrading') then
            self:StartArmsMoving()
        end
    end,

    OnStartBuild = function(self, unitBeingBuilt, order )
		FactoryUnit.OnStartBuild(self, unitBeingBuilt, order )
		if order != 'Upgrade' then
            self:StartArmsMoving()
        end
    end,

    OnStopBuild = function(self, unitBeingBuilt, order )
	    FactoryUnit.OnStopBuild(self, unitBeingBuilt, order )
		self:StopArmsMoving()
    end,
    
    OnFailedToBuild = function(self)
		FactoryUnit.OnFailedToBuild(self)
		self:StopArmsMoving()
    end,
	
	StartArmsMoving = function(self)
        self.ArmsThread = self:ForkThread(self.MovingArmsThread)
    end,

    MovingArmsThread = function(self)
    end,
	
	StopArmsMoving = function(self)
        if self.ArmsThread then
            KillThread(self.ArmsThread)
            self.ArmsThread = nil
        end
    end,
}

--------------------------------------------------------------------------------
-- Aeon Laser Fence 

-- Note:
-- I have added an function to recolour the Laser Beam Effect
-- However it only works with FAF (Forged Alliance Forever)
-- So I have integrate an Versioncheck to load the right Create Beam Functions 
--------------------------------------------------------------------------------

local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then

ALaserFenceUnit = Class(ConstructionUnit) {
    OnCreate = function(self,builder,layer)
        ConstructionUnit.OnCreate(self,builder,layer)
    end,
	
	OnStopBeingBuilt = function(self, builder, layer)
        ConstructionUnit.OnStopBeingBuilt(self, builder, layer)
		local bp = self:GetBlueprint()
        local bpAnim = bp.Display.AnimationOpen
 
			
			if bpAnim then		
				if not self.Dead then
				    self.OpenAnim = CreateAnimator(self)
					self.Trash:Add(self.OpenAnim )
                    self.OpenAnim:PlayAnim(bpAnim)
					ModEffectUtil.CreateLaserFenceEffectsSteam(self, builder, {'Effect1', 'Effect2', 'Effect3',}, self.ReclaimEffectsBag)
                end
			end
    end,
}

else

ALaserFenceUnit = Class(ConstructionUnit) {
    OnCreate = function(self,builder,layer)
        ConstructionUnit.OnCreate(self,builder,layer)
    end,
	
	OnStopBeingBuilt = function(self, builder, layer)
        ConstructionUnit.OnStopBeingBuilt(self, builder, layer)
		local bp = self:GetBlueprint()
        local bpAnim = bp.Display.AnimationOpen
 
			
			if bpAnim then		
				if not self.Dead then
				    self.OpenAnim = CreateAnimator(self)
					self.Trash:Add(self.OpenAnim )
                    self.OpenAnim:PlayAnim(bpAnim)
					ModEffectUtil.CreateLaserFenceEffects(self, builder, {'Effect1', 'Effect2', 'Effect3',}, self.ReclaimEffectsBag)
                end
			end
    end,
}

end