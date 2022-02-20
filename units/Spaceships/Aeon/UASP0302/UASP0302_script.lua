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
local ADFHOrbitalLaser = FBPOWeaponFile.ADFHOrbitalLaser
local ADFOrbWeapon = FBPOWeaponFile.ADFOrbWeapon
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon

UASP0302 = Class(AAirUnit) {

	Weapons = {
		AOHMainGun = Class(ADFHOrbitalLaser) {},
        OHMainGun = Class(ADFHOrbitalLaser) {},
        PBHMainGun = Class(ADFHOrbitalLaser) {},
		AOOrbGun = Class(ADFOrbWeapon) {},
        ROOrbGun1 = Class(ADFOrbWeapon) {},
        RPBOrbGun1 = Class(ADFOrbWeapon) {},
		ROOrbGun2 = Class(ADFOrbWeapon) {},
        RPBOrbGun2 = Class(ADFOrbWeapon) {},
		ROOrbGun3 = Class(ADFOrbWeapon) {},
        RPBOrbGun3 = Class(ADFOrbWeapon) {},
		OOrbGun = Class(ADFOrbWeapon) {},
        PBOrbGun = Class(ADFOrbWeapon) {},
		OOrbGun1 = Class(ADFOrbWeapon) {},
        PBOrbGun1 = Class(ADFOrbWeapon) {},
		OOrbGun2 = Class(ADFOrbWeapon) {},
        PBOrbGun2 = Class(ADFOrbWeapon) {},
		LOOrbGun1 = Class(ADFOrbWeapon) {},
        LPBOrbGun1 = Class(ADFOrbWeapon) {},
		LOOrbGun2 = Class(ADFOrbWeapon) {},
        LPBOrbGun2 = Class(ADFOrbWeapon) {},
		LOOrbGun3 = Class(ADFOrbWeapon) {},
        LPBOrbGun3 = Class(ADFOrbWeapon) {},
		ASFMissiles = Class(AAAZealotMissileWeapon) {},
    },

    BuildAttachBone = 'UASP0302',

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


TypeClass = UASP0302