#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2305/UAB2305_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Tactical Missile Launcher Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local FBPOWeaponFile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOweapons.lua')
local ADFHOrbitalLaser = FBPOWeaponFile.ADFHOrbitalLaser
local ADFDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFDisruptorCannonWeapon

UABAOSC100 = Class(AStructureUnit) { 
    Weapons = {
        AOSDLMainGun = Class(ADFDisruptorCannonWeapon) {
            CreateProjectileAtMuzzle = function(self, Muzzle)
                local proj = ADFDisruptorCannonWeapon.CreateProjectileAtMuzzle(self, Muzzle)
                local data = self:GetBlueprint().DamageToShields
                if proj and not proj:BeenDestroyed() then
                    proj:PassData(data)
                end
            end,
          }
    },
}
TypeClass = UABAOSC100
