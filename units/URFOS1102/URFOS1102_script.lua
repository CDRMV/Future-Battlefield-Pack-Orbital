#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CMobileKamikazeBombWeapon = import('/lua/cybranweapons.lua').CMobileKamikazeBombWeapon

URFOS1102 = Class(CAirUnit) {

    Weapons = {
		
        Suicide = Class(CMobileKamikazeBombWeapon) {        
			OnFire = function(self)			
				#disable death weapon
				self.unit:SetDeathWeaponEnabled(false)
				CMobileKamikazeBombWeapon.OnFire(self)
			end,
        },
    },

}

TypeClass = URFOS1102