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
local CleanShieldBag = function(self) if self.ShieldEffect then self.ShieldEffect:Destroy() self.ShieldEffect = nil end end

UASP0101 = Class(AAirUnit) {
	
	Weapons = {
		AOMainGun = Class(ADFOrbitalLaser) {},
        OMainGun = Class(ADFOrbitalLaser) {},
        PBMainGun = Class(ADFOrbitalLaser) {},
    },
	
	    CreateShield = function(self, shieldSpec)
        AAirUnit.CreateShield(self, shieldSpec)
        local bp = self:GetBlueprint()                  
        self.MyShield.CollisionSizeX = bp.SizeX / 2 + 1 
        self.MyShield.CollisionSizeY = bp.SizeY / 2 + 1 
        self.MyShield.CollisionSizeZ = bp.SizeZ / 2 + 1 

        self.MyShield.ImpactVals = {
            self.MyShield.CollisionSizeZ * 0.55,
            self.MyShield.CollisionSizeZ * -0.6422,
            self.MyShield.CollisionSizeZ * -0.3211,
            self.MyShield.CollisionSizeX * 0.9433,
        }

        self.MyShield.CollisionCenterX = (bp.CollisionOffsetX or 0)
        self.MyShield.CollisionCenterY = (bp.CollisionOffsetY or 0) + 2
        self.MyShield.CollisionCenterZ = (bp.CollisionOffsetZ or 0)
        local oldCreateShieldMesh = self.MyShield.CreateShieldMesh
        self.MyShield.CreateShieldMesh = function(self)
            oldCreateShieldMesh(self)
            self:SetCollisionShape( 'Box', self.CollisionCenterX, self.CollisionCenterY, self.CollisionCenterZ, self.CollisionSizeX, self.CollisionSizeY, self.CollisionSizeZ)
        end

        self.MyShield.CreateImpactEffect = function(self, vector)
            --------------------------------------------------------------------
            -- Centre the vector so we can do comparisons
            --------------------------------------------------------------------
            local heading = self:GetHeading()
            local v = {}
            if heading ~= 0 then
                local hsin = math.sin(heading)
                local hcos = math.cos(heading)
                v[2] = vector[2]
                if heading > 0 then
                    v[1] = vector[1] * hcos + vector[3] * hsin
                    v[3] = vector[1] * hsin - vector[3] * hcos
                elseif heading < 0 then
                    v[1] = vector[1] * hcos - vector[3] * hsin
                    v[3] = vector[1] * hsin + vector[3] * hcos
                end
            end
            --Just in case heading was 0
            if not v[1] then v = vector end

            --------------------------------------------------------------------
            -- Side check function
            --------------------------------------------------------------------
            local getSide = function(v, cutoff)
                --2.65
                if v[1] < - (cutoff or 0) then
                    return 'left'
                elseif v[1] > (cutoff or 0) then
                    return 'right'
                elseif cutoff then
                    return 'top'
                else
                    return 'below'
                end
            end

            --------------------------------------------------------------------
            -- Pick the impact mesh
            --------------------------------------------------------------------
            -- The numbers within assume the unit hasn't been scaled,
            -- and I can't be aresed to make them dynamic
            --------------------------------------------------------------------

            local impactmeshbp = self.ImpactMeshBp
            if v[3] > self.ImpactVals[1] then
                --impactmeshbp = impactmeshbp .. 'back_mesh'
            elseif v[3] < self.ImpactVals[2] then
                --impactmeshbp = impactmeshbp .. 'front_mesh'
			elseif v[3] < self.ImpactVals[3] then
                --impactmeshbp = impactmeshbp .. getSide(v) .. '1_mesh'
            elseif v[3] < 0 then
                --impactmeshbp = impactmeshbp .. getSide(v) .. '2_mesh'
            elseif v[3] <= self.ImpactVals[1] then
                --impactmeshbp = impactmeshbp .. getSide(v,self.ImpactVals[4]) .. '3_mesh'
            end

            --------------------------------------------------------------------
            -- Mostly, but not quite, normal function with vector orientation off
            --------------------------------------------------------------------
            local army = self:GetArmy()
            local Entity = import('/lua/sim/Entity.lua').Entity
            local ImpactMesh = Entity { Owner = self.Owner }
            Warp( ImpactMesh, self:GetPosition())
            for k, v in self.ImpactEffects do
                CreateEmitterAtBone( ImpactMesh, 0, army, v )--:OffsetEmitter(0,0,OffsetLength)
            end
            WaitTicks(5)
            WaitTicks(45)
            ImpactMesh:Destroy()
        end
    end,

}


TypeClass = UASP0101