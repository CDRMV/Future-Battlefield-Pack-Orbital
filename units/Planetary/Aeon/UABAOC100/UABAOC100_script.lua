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

UABAOC100 = Class(AStructureUnit) { 

	Weapons = {
		AOLMainGun = Class(ADFHOrbitalLaser) {},
    },
  
}
TypeClass = UABAOC100
