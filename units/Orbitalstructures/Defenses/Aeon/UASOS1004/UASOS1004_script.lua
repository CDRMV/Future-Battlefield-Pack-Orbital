#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit  = import('/lua/aeonunits.lua').AAirUnit 
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon

UASOS1004 = Class(AAirUnit) {
	Weapons = {
		ASFMissiles = Class(AAAZealotMissileWeapon) {},
    },
}

TypeClass = UASOS1004