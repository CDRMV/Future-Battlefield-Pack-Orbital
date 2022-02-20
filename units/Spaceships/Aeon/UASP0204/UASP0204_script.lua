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
local ADFOrbWeapon = FBPOWeaponFile.ADFOrbWeapon

UASP0204 = Class(AAirUnit) {

    BeamExhaustCruise = '/mods/Future Battlefield Pack Orbital/effects/emitters/Aeon_Spaceship_Engine_beam_emit.bp',
    BeamExhaustIdle = '/mods/Future Battlefield Pack Orbital/effects/emitters/Aeon_Spaceship_Engine_trail_emit.bp',

	Weapons = {
		AOHMainGun = Class(ADFHOrbitalLaser) {},
        OHMainGun = Class(ADFHOrbitalLaser) {},
        PBHMainGun = Class(ADFHOrbitalLaser) {},
		AOMainGun = Class(ADFHOrbitalLaser) {},
        OMainGun = Class(ADFHOrbitalLaser) {},
        PBMainGun = Class(ADFHOrbitalLaser) {},
		AOLMainGun = Class(ADFOrbitalLaser) {},
        OLMainGun = Class(ADFOrbitalLaser) {},
        PBLMainGun = Class(ADFOrbitalLaser) {},
		OOrbGun1 = Class(ADFOrbWeapon) {},
        PBOrbGun1 = Class(ADFOrbWeapon) {},
    },
	
	BuildAttachBone = 'UASP0204',

    OnStopBeingBuilt = function(self,builder,layer)
        AAirUnit.OnStopBeingBuilt(self,builder,layer)
        ChangeState(self, self.IdleState)
    end,

    OnFailedToBuild = function(self)
        AAirUnit.OnFailedToBuild(self)
        ChangeState(self, self.IdleState)
    end,

    IdleState = State {
        Main = function(self)
            self:DetachAll(self.BuildAttachBone)
            self:SetBusy(false)
        end,

        OnStartBuild = function(self, unitBuilding, order)
            AAirUnit.OnStartBuild(self, unitBuilding, order)
            self.UnitBeingBuilt = unitBuilding
            ChangeState(self, self.BuildingState)
        end,
    },

    BuildingState = State {
        Main = function(self)
            local unitBuilding = self.UnitBeingBuilt
            self:SetBusy(true)
            local bone = self.BuildAttachBone
            self:DetachAll(bone)
            unitBuilding:HideBone(0, true)
            self.UnitDoneBeingBuilt = false
        end,

        OnStopBuild = function(self, unitBeingBuilt)
            AAirUnit.OnStopBuild(self, unitBeingBuilt)
            ChangeState(self, self.FinishedBuildingState)
        end,
    },

    FinishedBuildingState = State {
        Main = function(self)
            self:SetBusy(true)
            local unitBuilding = self.UnitBeingBuilt
            unitBuilding:DetachFrom(true)
            self:DetachAll(self.BuildAttachBone)
            if self:TransportHasAvailableStorage() then
                self:AddUnitToStorage(unitBuilding)
            else
                local worldPos = self:CalculateWorldPositionFromRelative({0, 0, -20})
                IssueMoveOffFactory({unitBuilding}, worldPos)
                unitBuilding:ShowBone(0,true)
            end
            self:SetBusy(false)
            self:RequestRefreshUI()
            ChangeState(self, self.IdleState)
        end,
    },

}


TypeClass = UASP0204