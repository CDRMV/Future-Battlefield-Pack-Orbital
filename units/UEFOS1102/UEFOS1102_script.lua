#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UEFOS1102 = Class(TAirUnit) {
    Weapons = {
        MainGun5 = Class(TSAMLauncher) {},
    },	
}

TypeClass = UEFOS1102