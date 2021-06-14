#****************************************************************************
#** 
#**  File     :  /cdimage/units/UEC1101/UEC1101_script.lua 
#** 
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandFactoryUnit = import('/lua/terranunits.lua').TLandFactoryUnit
local TShieldStructureUnit = import('/lua/terranunits.lua').TShieldStructureUnit
local TDFHeavyPlasmaGatlingWeapon = import('/lua/terranweapons.lua').TDFHeavyPlasmaGatlingWeapon

UEB0800 = Class(TLandFactoryUnit) {
    Weapons = {
        GatlingCannon = Class(TDFHeavyPlasmaGatlingWeapon){},
    },
}


TypeClass = UEB0800

