#****************************************************************************
#**
#**	File:		/lua/CustomUnits/CustomUnits.lua
#**
#**	Description:	For use with the Sorian AI
#**
#**	Copyright © 2015 Future Battlefield Pack
#**
#****************************************************************************

UnitList = {
--------------------------------------------------------------------------------
-- T1 Land units
--------------------------------------------------------------------------------
T1LandScout = {
	UEF = {'UEL0101a', 50},	    -- MA1 Rabbit
},                                   
T1LandDFTank = {
        UEF = {'UEL0201a', 70},      -- Defender, T1 Medium Tank
        Aeon = {'UAL0201', 50},   
        Cybran = {'URl0303b', 60},   -- Stalker Mk1
},
T1LandAA = {  
        Aeon = {'UAL0104', 50},     --                 
        Cybran = {'URl0104', 50},   -- 
        UEF = {'UEL0104c', 50},      -- 
},
T1LandArtillery = {
	Cybran = {'URL0106b', 65},  -- Raider, T1 Emp Supportbot
	Aeon = {'UAL0103', 50},     --   
        UEF = {'UEL0103a', 70},      -- Sattler, T1 Land Artillery 
},
--------------------------------------------------------------------------------
-- T2 Land units
--------------------------------------------------------------------------------
T2LandDFTank = {
        UEF = {'UEL0106b', 50},      -- Shooter, T2 Medium Aussault Bot
        Aeon = {'UAL0200', 50},     --  Orion, Tech2 Heavy Assault Tank         
},    
T2LandAmphibious = {
        Cybran = {'URL0200', 65},      -- XH-2 Supernova, T2 Hover tank
        UEF = {'UEL0203a', 65},      -- Waterwalker, T2 hover tank
        Aeon = {'UAL0200', 65},     --  Orion, Tech2 Heavy Assault Tank  
},
T2LandAA = {  
        Aeon = {'UAL0104', 50},     --                 
        Cybran = {'URl0107b', 65},   -- Ultra, Tech 2 Escrot Bot
        UEF = {'UEL0104b', 50},      -- 
},
T2LandArtillery = {
        UEF = {'UEL0111b', 40},
        Aeon = {'UAL0111', 50},     
       	Cybran = {'URl0303a', 60},   -- Shockwave, Tech 2 EMP Battery
},
T2AttackTankSorian = {
        Aeon = {'UAL0200', 70},     --  Orion, Tech2 Heavy Assault Tank      
        Cybran = {'URl0303c', 80},   -- Stalker Mk2
        UEF = {'UEL0202a', 90},      -- Johnson, T2 Heavy Tank
        Seraphim = {'XSL0202', 50},           
},    
T2AttackTank = {
        Aeon = {'UAL0202', 60},     --   
        Cybran = {'URl0202', 50},   -- 
        UEF = {'UEL0202b', 50},      -- Striker, T1 Medium Tank
        Seraphim = {'XSL0203', 50},  
},
--------------------------------------------------------------------------------
-- T3 Land units
--------------------------------------------------------------------------------
T3LandBot = { 
        Aeon = {'UAL0303', 25},     -- 
        Cybran = {'URl0303c', 25},   -- Stalker Mk2        
        Seraphim = {'XSL0303', 25}, -- 
        UEF = {'UEL0303b', 70},      -- Titan, T3 Heavy Assault Bot       
},
T3ArmoredAssaultSorian = {
        Aeon = {'XAL0203', 85},     -- 
        Cybran = {'URL0202', 85},   -- 
        Seraphim = {'XSL0303', 50}, -- 
        UEF = {'UEL0202a', 90},      -- Johnson, T2 Heavy Tank               
},
T3MobileShields = {
        Aeon = {'UAL0300', 50},           
},
T3ArmoredAssaultSorian = {
	Aeon = {'UAL0200', 25},       
	Seraphim = {'XSL0307', 50}, 
	UEF = {'UEL0202b', 50},                  
},
T3LandArtillery = {
	Aeon = {'XAL0305', 50},      
	Cybran = {'URl0304', 55},    
	UEF = {'UEL0304c', 55},	    
	Seraphim = {'XSL0305', 50}, 
},
--------------------------------------------------------------------------------
-- Doomsday
--------------------------------------------------------------------------------
T4LandExperimental1 = {
        UEF = {'UEL0401b', 60}, 
},
T4LandExperimental2 = {
        UEF = {'UEL0401b', 80}, 
},
--------------------------------------------------------------------------------
-- T1 Seaunits
--------------------------------------------------------------------------------
T1SeaSub = {
    Cybran = {'urs0100', 65},
},
--------------------------------------------------------------------------------
-- T2 Seaunits
--------------------------------------------------------------------------------
T2SeaSub = {
    Cybran = {'urs0200', 65},
    UEF = {'ues0200', 65},
},
T2SeaDestroyer = {
    Cybran = {'urs0200', 55},
    Aeon = {'uas0200', 65},
},
T2SeaCruiser = {
    UEF = {'ues0200', 55},
    Aeon = {'uas0200', 55},
},
--------------------------------------------------------------------------------
-- T3 Seaunits
--------------------------------------------------------------------------------
T3SeaSub = {
    Cybran = {'urs0200', 45},
    UEF = {'ues0200', 45},
},
T3BattleCruiser = {
    UEF = {'ues0202b', 60},
},
T3SeaBattleship = {
    Cybran = {'urs0300', 60},
},
--------------------------------------------------------------------------------
-- Eurypterit
--------------------------------------------------------------------------------
T4AirExperimental1 = {Cybran = {'URA0404', 70},},
--------------------------------------------------------------------------------
-- T1 Aircraft
--------------------------------------------------------------------------------
T1AirScout ={
    Cybran = {'URA0202', 50},
},
T1AirFighter = {            
    Aeon = {'UAA0100', 70},      
    Cybran = {'URA0100', 70},
    UEF = {'UEA0102b', 70},    
},
T1AirBomber = {
    Cybran = {'URA0211', 70},
    UEF = {'UEA0103b', 70},
}, 
--------------------------------------------------------------------------------
-- T2 Aircraft
--------------------------------------------------------------------------------
T2AirFighter ={
    UEF = {'UEA0102b', 70},
    Aeon = {'UAA0200', 70},
    Cybran = {'URA0200', 70},
},
T2FighterBomber = {
    UEF = {'UEA0102b', 90},               
    Cybran = {'URA0110', 90},
    Aeon = {'UAA0200', 80},    
},
T2AirGunship = {
    Cybran = {'URA0210', 70},
},
T2AirBomber = {
    Cybran = {'URA0211', 70},
    UEF = {'UEA0103b', 70},
},
--------------------------------------------------------------------------------
-- T3 Aircraft
--------------------------------------------------------------------------------
T3AirBomber = {
    Cybran = {'URA0211', 55},
    UEF = {'UEA0103b', 55},
},
T3AirFighter ={
    UEF = {'UEA0303b', 70},
    Aeon = {'UAA0200', 70},
    Cybran = {'URA0200', 70},
},
T3AirTransport = {
    UEF = {'UEA0305b', 70},
},
--------------------------------------------------------------------------------
-- Cybran T2 Groundattack Fighter
--------------------------------------------------------------------------------
T2FighterBomber = {Cybran = {'URA0110', 60},},
--------------------------------------------------------------------------------
-- Buildings 
--------------------------------------------------------------------------------
T3ShieldDefense = {
        UEF =		{'ueb4000', 60}, 
},
T3AirTransport = {
    UEF = {'UEA0305b', 70},
},
--------------------------------------------------------------------------------
-- End
--------------------------------------------------------------------------------
}