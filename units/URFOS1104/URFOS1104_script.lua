#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAANanoDartWeapon = import('/lua/cybranweapons.lua').CAANanoDartWeapon

URFOS1104 = Class(CAirUnit) {

    Weapons = {
        AAGun = Class(CAANanoDartWeapon) {},
    },
}

TypeClass = URFOS1104