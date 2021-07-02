local DefaultUnits = import('/lua/defaultunits.lua')
local FactoryUnit = DefaultUnits.FactoryUnit
local StructureUnit = DefaultUnits.StructureUnit
local ModEffectUtil = import('/mods/Future Battlefield Pack Orbital/lua/FBPOEffectUtilities.lua')

--------------------------------------------------------------------------------
-- Aeon Colonisation Tower
--------------------------------------------------------------------------------

AModulaTowerUnit = Class(FactoryUnit) {

    BuildAttachBone = 'Attachpoint',

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

--------------------------------------------------------------------------------
-- Aeon Laser Fence
--------------------------------------------------------------------------------

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