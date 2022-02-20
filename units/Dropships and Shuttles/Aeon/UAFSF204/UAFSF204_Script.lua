#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0102/UEA0102_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Terran Interceptor Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local ADFLaserLightWeapon = import('/lua/aeonweapons.lua').ADFLaserLightWeapon

UAFSF204 = Class(AAirUnit) {
	
    Weapons = {
	    ASFLaser = Class(ADFLaserLightWeapon) {},
		ASFEnergyDrone = Class(ADFLaserLightWeapon) {},
        RingPlatformDrop = Class(ADFLaserLightWeapon) {},
    },

}

TypeClass = UAFSF204