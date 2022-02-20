local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function



LOG('Future Battlefield Pack Orbital: [uiutil.lua '..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. Hooking "UIFile" to add our own unit icons')

local MyUnitIdTable = {

 -- Aeon Elite Land Units

   ual0300x=true, -- Aeon Elite Extermination Bot (Deroy)

 -- Aeon Laserfence

   uab0208=true, -- Aeon Tech 2 Laserfence
   uab0208a=true, -- Aeon Tech 2 Laserfence Short Vertical
   uab0208b=true, -- Aeon Tech 2 Laserfence Short Horizontal
   uab0208c=true, -- Aeon Tech 2 Laserfence Long Vertical
   uab0208d=true, -- Aeon Tech 2 Laserfence Long Horizontal
   
   -- Aeon Modula Tower

   uab0207=true, -- Aeon Tech 2 Foundation Module
   uab0207a=true, -- Aeon Tech 2 Solar Energy Module
   uab0207b=true, -- Aeon Tech 2 Energy Storage Module
   uab0207c=true, -- Aeon Tech 2 Mass Storage Module
   uab0207d=true, -- Aeon Tech 2 Mass Fabricator Module
   uab0207e=true, -- Aeon Tech 2 Habitat Module
   
   -- Aeon Ringplatforms
   uabrt100=true, -- Aeon Tech 1 Ringplatform
   uabrt200=true, -- Aeon Tech 2 Ringplatform
   uabrt300=true, -- Aeon Tech 3 Ringplatform
   
   
      -- Aeon Defense Satellites
   uasos1003=true, -- Aeon Tech 1 Anti Orbital Defense Satellite
   uasos1004=true, -- Aeon Tech 1 Anti Starfighter Defense Satellite
   uasos2003=true, -- Aeon Tech 1 Anti Orbital Defense Satellite (Long Range)
   uasos2004=true, -- Aeon Tech 2 Anti Starfighter Defense Satellite
   uasos2005=true, -- Aeon Tech 2 Anti Orbital Defense Satellite
   uasos3003=true, -- Aeon Tech 3 Multi Defense Satellite
   
     -- Aeon Anti Orbital Cannons

   uabaoc100=true, -- Aeon Tech 1 Anti Orbital Cannon
   uabaoc200=true, -- Aeon Tech 2 Anti Orbital Cannon
   uabaoc300=true, -- Aeon Tech 3 Anti Orbital Cannon
   
        -- Aeon Anti Orbital Support Cannons

   uabaosc100=true, -- Aeon Tech 1 Anti Orbital Shield Disruptor
   uabaosc200=true, -- Aeon Tech 2 Anti Orbital Shield Disruptor
   uabaosc300=true, -- Aeon Tech 3 Anti Orbital Shield Disruptor
   
   -- Aeon Planetary Spaceship Yards

   uab0106=true, -- Aeon Tech 1 Planetary Spaceship Yard
   uab0206=true, -- Aeon Tech 2 Planetary Spaceship Yard
   uab0306=true, -- Aeon Tech 3 Planetary Spaceship Yard
   
  -- Aeon Spacestation

   uasos2002=true, -- Aeon Tech 2 Spacestation
   
   -- Aeon Tradestation and Tradeships

   uasos2006=true, -- Aeon Tech 2 Tradestation
   
   uaspt0200=true, -- Aeon Tech 2 Cargo/Tradeship
   
  -- Aeon Planetary Orbital Spaceship Yards (with Capital)

   uasos1000=true, -- Aeon Tech 1 Orbital Spaceship Yard
   uasos1001=true, -- Aeon Tech 1 Orbital Capital Spaceship Yard
   uasos2000=true, -- Aeon Tech 1 Orbital Spaceship Yard
   uasos2001=true, -- Aeon Tech 1 Orbital Capital Spaceship Yard
   uasos3000=true, -- Aeon Tech 1 Orbital Spaceship Yard
   uasos3001=true, -- Aeon Tech 1 Orbital Capital Spaceship Yard

 -- Aeon Spaceships and Orbitalengineers

   uasp0100=true, -- Aeon Tech 1 Orbital Engineer
   uasp0101=true, -- Aeon Tech 1 Corvette (Spaceship)
   uasp0102=true, -- Aeon Tech 1 Frigate (Spaceship)
   uasp0200=true, -- Aeon Tech 2 Orbital Engineer
   uasp0201=true, -- Aeon Tech 2 Destroyer (Spaceship)
   uasp0202=true, -- Aeon Tech 2 Cruiser (Spaceship)
   uasp0203=true, -- Aeon Tech 2 Interdictor (Spaceship)
   uasp0204=true, -- Aeon Tech 2 Dropshuttle Carrier (Spaceship)
   uasp0205=true, -- Aeon Tech 2 Fleet Support (Spaceship)
   uasp0300=true, -- Aeon Tech 3 Orbital Engineer
   uasp0301=true, -- Aeon Tech 3 Star Carrier (Spaceship)
   uasp0302=true, -- Aeon Tech 3 Star Dreadnought (Spaceship)
   uasp0304=true, -- Aeon Tech 3 Dropshuttle Carrier (Spaceship)
   uasp0404=true, -- Aeon Experimental Dropshuttle Carrier (Spaceship)
   
 -- Aeon Starfighters and -bombers
   uafsf100=true, -- Aeon Tech 1 Basic Starfighter
   uafsf101=true, -- Aeon Tech 1 Basic Starbomber
   
    -- Aeon Shuttles
   uafsf203=true, -- Aeon Tech 2 Drop Shuttle
   uafsf204=true, -- Aeon Tech 2 Ringplatform Drop Shuttle
   uafsf303=true, -- Aeon Tech 3 Drop Shuttle
}

-- Table for new Ability Icons

local MyOrderIdTable = {
-- Hyperspace Drive Icon 

	hyperspace_btn_over=true,
	hyperspace_btn_up=true,
	hyperspace_btn_over_sel=true,
	hyperspace_btn_up_sel=true,
	hyperspace_btn_dis=true,
	hyperspace_btn_dis_sel=true,
	hyperspace_btn_down=true,
	
		
	deflector_btn_over=true,
	deflector_btn_up=true,
	deflector_btn_over_sel=true,
	deflector_btn_up_sel=true,
	deflector_btn_dis=true,
	deflector_btn_dis_sel=true,
	
	deflector2_btn_over=true,
	deflector2_btn_up=true,
	deflector2_btn_over_sel=true,
	deflector2_btn_up_sel=true,
	deflector2_btn_dis=true,
	deflector2_btn_dis_sel=true,
	
	
	gravitywellgen_btn_over=true,
	gravitywellgen_btn_up=true,
	gravitywellgen_btn_over_sel=true,
	gravitywellgen_btn_up_sel=true,
	gravitywellgen_btn_dis=true,
	gravitywellgen_btn_dis_sel=true,
	
	launchsf_btn_over=true,
	launchsf_btn_up=true,
	launchsf_btn_over_sel=true,
	launchsf_btn_up_sel=true,
	launchsf_btn_dis=true,
	launchsf_btn_dis_sel=true,
	
	launchsf2_btn_over=true,
	launchsf2_btn_up=true,
	launchsf2_btn_over_sel=true,
	launchsf2_btn_up_sel=true,
	launchsf2_btn_dis=true,
	launchsf2_btn_dis_sel=true,
	
	producederoy_btn_over=true,
	producederoy_btn_up=true,
	producederoy_btn_over_sel=true,
	producederoy_btn_up_sel=true,
	producederoy_btn_dis=true,
	producederoy_btn_dis_sel=true,
	
	dropderoy_btn_over=true,
	dropderoy_btn_up=true,
	dropderoy_btn_over_sel=true,
	dropderoy_btn_up_sel=true,
	dropderoy_btn_dis=true,
	dropderoy_btn_dis_sel=true,
	
	produceacu_btn_over=true,
	produceacu_btn_up=true,
	produceacu_btn_over_sel=true,
	produceacu_btn_up_sel=true,
	produceacu_btn_dis=true,
	produceacu_btn_dis_sel=true,
	
	dropacu_btn_over=true,
	dropacu_btn_up=true,
	dropacu_btn_over_sel=true,
	dropacu_btn_up_sel=true,
	dropacu_btn_dis=true,
	dropacu_btn_dis_sel=true,
	
	
}


local MyTechlevelIdTable = {
-- Techlevel Icons 

	t5_btn_dis=true,
	t5_btn_down=true,
	t5_btn_over=true,
	t5_btn_selected=true,
	t5_btn_up=true,
	t6_btn_dis=true,
	t6_btn_down=true,
	t6_btn_over=true,
	t6_btn_selected=true,
	t6_btn_up=true,
	t35_btn_dis=true,
	t35_btn_down=true,
	t35_btn_over=true,
	t35_btn_selected=true,
	t35_btn_up=true,
}

	local IconPath = "/Mods/Future Battlefield Pack Orbital"
	local TechlvlIconPath = "/Mods/Future Battlefield Pack Orbital/Icons/Techlevels"
	-- Adds icons to the engeneer/factory buildmenu
	local oldUIFile = UIFile
	function UIFile(filespec)
		local skins = import('/lua/skins/skins.lua').skins
		local visitingSkin = currentSkin()
		local TechlvlIconName = string.gsub(filespec,'.dds','')
		TechlvlIconName = string.gsub(TechlvlIconName,'/mods/Future Battlefield Pack Orbital/icons/Techlevels/','')
		if MyTechlevelIdTable[TechlvlIconName] then
			if visitingSkin == "aeon" then
				local curfile =  TechlvlIconPath .. "/aeon/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
				return curfile
			end
			if visitingSkin == "uef" then
				local curfile =  TechlvlIconPath .. "/uef/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
				return curfile
			end
			if visitingSkin == "cybran" then
				local curfile =  TechlvlIconPath .. "/cybran/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
				return curfile
			end
			if visitingSkin == "seraphim" then
				local curfile =  TechlvlIconPath .. "/seraphim/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
				return curfile
			end
			if visitingSkin == "nomads" then
				local curfile =  TechlvlIconPath .. "/nomads/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
				return curfile
			end
		end
		local OrderIconName = string.gsub(filespec,'.dds','')
		OrderIconName = string.gsub(OrderIconName,'/game/orders/','')
		if MyOrderIdTable[OrderIconName] then
			local curfile =  IconPath .. filespec
			return curfile
		end
		local IconName = string.gsub(filespec,'_icon.dds','')
		IconName = string.gsub(IconName,'/icons/units/','')
		if MyUnitIdTable[IconName] then
			local curfile =  IconPath .. filespec
			return curfile
		end
		return oldUIFile(filespec)
	end

else

local MyTechlevelIdTable = {
-- Techlevel Icons 

	t5_btn_dis=true,
	t5_btn_down=true,
	t5_btn_over=true,
	t5_btn_selected=true,
	t5_btn_up=true,
	t6_btn_dis=true,
	t6_btn_down=true,
	t6_btn_over=true,
	t6_btn_selected=true,
	t6_btn_up=true,
	t35_btn_dis=true,
	t35_btn_down=true,
	t35_btn_over=true,
	t35_btn_selected=true,
	t35_btn_up=true,
}

function UIFile(filespec, checkMods)
    if UIFileBlacklist[filespec] then return filespec end
    local skins = import('/lua/skins/skins.lua').skins
	local TechlvlIconPath = "/Mods/Future Battlefield Pack Orbital/Icons/Techlevels" -- I know there is an mod Check in this Function, but this one here is needed
    local useSkin = currentSkin()
    local currentPath = skins[useSkin].texturesPath
    local origPath = currentPath
	
	-- New Techlevels Patch
	-- Start 
	local TechlvlIconName = string.gsub(filespec,'.dds','')
	TechlvlIconName = string.gsub(TechlvlIconName,'/mods/Future Battlefield Pack Orbital/icons/Techlevels/','')
	if MyTechlevelIdTable[TechlvlIconName] then
		if useSkin == "aeon" then
			local curfile =  TechlvlIconPath .. "/aeon/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
			return curfile
		end
		if useSkin == "uef" then
			local curfile =  TechlvlIconPath .. "/uef/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
			return curfile
		end
		if useSkin == "cybran" then
			local curfile =  TechlvlIconPath .. "/cybran/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
			return curfile
		end
		if useSkin == "seraphim" then
			local curfile =  TechlvlIconPath .. "/seraphim/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
			return curfile
		end
		if useSkin == "nomads" then
			local curfile =  TechlvlIconPath .. "/nomads/game/construct-tech_btn/" .. TechlvlIconName .. ".dds"
			return curfile
		end
	end
	-- End 
	
    if useSkin == nil or currentPath == nil then
        return nil
    end

    if not UIFileCache[currentPath .. filespec] then
        local found = false

        if useSkin == 'default' then
            found = currentPath .. filespec
        else
            while not found and useSkin do
                found = currentPath .. filespec
                if not DiskGetFileInfo(found) then
                    -- Check mods
                    local inmod = false
                    if checkMods then
                        if __active_mods then
                            for id, mod in __active_mods do
                                -- Unit Icons
                                if DiskGetFileInfo(mod.location .. filespec) then
                                    found = mod.location .. filespec
                                    inmod = true
                                    break
                                -- ACU Enhancements
                                elseif DiskGetFileInfo(mod.location .. currentPath .. filespec) then
                                    found = mod.location .. currentPath .. filespec
                                    inmod = true
                                    break
                                end
                            end
                        end
                    end

                    if not inmod then
                        found = false
                        useSkin = skins[useSkin].default
                        if useSkin then
                            currentPath = skins[useSkin].texturesPath
                        end
                    end
                end
            end
        end

        if not found then
            -- don't print error message if "filespec" is a valid path
            if not DiskGetFileInfo(filespec) then
                SPEW('[uiutil.lua, function UIFile()] - Unable to find file:'.. origPath .. filespec)
            end
            found = filespec
        end

        UIFileCache[origPath .. filespec] = found
    end
    return UIFileCache[origPath .. filespec]
end

	LOG('Future Battlefield Pack Orbital: [uiutil.lua '..debug.getinfo(1).currentline..'] - Gameversion is 3652 or newer. No need to insert the unit icons by our own function.')
end -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function