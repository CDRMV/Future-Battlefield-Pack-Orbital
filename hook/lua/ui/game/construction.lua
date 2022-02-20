

local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function
	LOG('Future Battlefield Pack Orbital: [unitview.lua '..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. Hooking "UpdateWindow" to add our own unit icons')


local unitGridPages = {
    RULEUTL_Basic = {Order = 0, Label = "<LOC CONSTRUCT_0000>T1"},
    RULEUTL_Advanced = {Order = 1, Label = "<LOC CONSTRUCT_0001>T2"},
    RULEUTL_Secret = {Order = 2, Label = "<LOC CONSTRUCT_0002>T3"},
	RULEUTL_Elite = {Order = 3, Label = "Elite"},
    RULEUTL_Experimental = {Order = 4, Label = "<LOC CONSTRUCT_0003>Exp"},
	RULEUTL_Titan = {Order = 5, Label = "Titan"},
	RULEUTL_Hero = {Order = 6, Label = "Hero"},
    RULEUTL_Munition = {Order = 7, Label = "<LOC CONSTRUCT_0004>Munition"},   # note that this doesn't exist yet
}

local constructionTabs = {'t1','t2','t3','t35','t4','t5','t6','templates'}
local nestedTabKey = {
    t1 = 'construction',
    t2 = 'construction',
    t3 = 'construction',
	t35 = 'construction',
    t4 = 'construction',
	t5 = 'construction',
	t6 = 'construction',
}

function OnNestedTabCheck(self, checked)
    activeTab = self
    for _, tab in controls.tabs do
        if tab != self then
            tab:SetCheck(false, true)
        end
    end
    controls.choices:Refresh(FormatData(sortedOptions[self.ID], nestedTabKey[self.ID] or self.ID))
    SetSecondaryDisplay('buildQueue')
end


function CreateTabs(type)
    local defaultTabOrder = {}
    local desiredTabs = 0
    if type == 'construction' then
        for index, tab in constructionTabs do
            local i = index
            if not controls.tabs[i] then
                controls.tabs[i] = CreateTab(controls.constructionGroup, tab, OnNestedTabCheck)
            end
            controls.tabs[i].ID = tab
            controls.tabs[i].OnRolloverEvent = function(self, event)
            end
            Tooltip.AddControlTooltip(controls.tabs[i], 'construction_tab_'..tab)
            Tooltip.AddControlTooltip(controls.tabs[i].disabledGroup, 'construction_tab_'..tab..'_dis')
        end
        desiredTabs = table.getsize(constructionTabs)
        defaultTabOrder = {t6=1, t5=2, t4=3, t35=4, t3=5, t2=6, t1=7}
    elseif type == 'enhancement' then
        local selection = sortedOptions.selection
        local enhancements = selection[1]:GetBlueprint().Enhancements 
        local enhCommon = import('/lua/enhancementcommon.lua')
        local enhancementPrefixes = {Back = 'b-', LCH = 'la-', RCH = 'ra-'}
        local newTabs = {}
        if enhancements.Slots then
            local tabIndex = 1
            for slotName, slotInfo in enhancements.Slots do
                if not controls.tabs[tabIndex] then
                    controls.tabs[tabIndex] = CreateTab(controls.constructionGroup, nil, OnNestedTabCheck)
                end
                controls.tabs[tabIndex].tooltipKey = enhancementTooltips[slotName]
                controls.tabs[tabIndex].OnRolloverEvent = function(self, event)
                    if event == 'enter' then
                        local existing = enhCommon.GetEnhancements(selection[1]:GetEntityId())
                        if existing[slotName] then
                            local enhancement = enhancements[existing[slotName]]
                            local icon = enhancements[existing[slotName]].Icon
                            local bpID = selection[1]:GetBlueprint().BlueprintId
                            local enhName = existing[slotName]
                            local texture = "/textures/ui/common"..GetEnhancementPrefix(bpID, enhancementPrefixes[slotName]..icon)
                            UnitViewDetail.ShowEnhancement(enhancement, bpID, icon, texture, sortedOptions.selection[1])
                        end
                    elseif event == 'exit' then
                        if existing[slotName] then
                            UnitViewDetail.Hide()
                        end
                    end
                end
                Tooltip.AddControlTooltip(controls.tabs[tabIndex], enhancementTooltips[slotName])
                controls.tabs[tabIndex].ID = slotName
                newTabs[tabIndex] = controls.tabs[tabIndex]
                tabIndex = tabIndex + 1
                sortedOptions[slotName] = {}
                for enhName, enhTable in enhancements do
                    if enhTable.Slot == slotName then
                        enhTable.ID = enhName
                        enhTable.UnitID = selection[1]:GetBlueprint().BlueprintId
                        table.insert(sortedOptions[slotName], enhTable)
                    end
                end
            end
            desiredTabs = table.getsize(enhancements.Slots)
        end
        defaultTabOrder = {Back=1, LCH=2, RCH=3}
    end
    while table.getsize(controls.tabs) > desiredTabs do
        controls.tabs[table.getsize(controls.tabs)]:Destroy()
        controls.tabs[table.getsize(controls.tabs)] = nil
    end
    import(UIUtil.GetLayoutFilename('construction')).LayoutTabs(controls)
    local defaultTab = false
    local numActive = 0
    for _, tab in controls.tabs do
        if sortedOptions[tab.ID] and table.getn(sortedOptions[tab.ID]) > 0 then
            tab:Enable()
            numActive = numActive + 1
            if defaultTabOrder[tab.ID] then
                if not defaultTab or defaultTabOrder[tab.ID] < defaultTabOrder[defaultTab.ID] then
                    defaultTab = tab
                end
            end
        else
            tab:Disable()
        end
    end
    if previousTabSet != type or previousTabSize != numActive then
        if defaultTab then
            defaultTab:SetCheck(true)
        end
        previousTabSet = type
        previousTabSize = numActive
    elseif activeTab then
        activeTab:SetCheck(true)
    end
end

function OnSelection(buildableCategories, selection, isOldSelection)
    if table.getsize(selection) > 0 then
        capturingKeys = false
        #Sorting down units
        local buildableUnits = EntityCategoryGetUnitList(buildableCategories)
        if not isOldSelection then
            previousTabSet = nil
            previousTabSize = nil
            activeTab = nil
            ClearSessionExtraSelectList()
        end
        sortedOptions = {}
        UnitViewDetail.Hide()
        
        local sortDowns = EntityCategoryFilterDown(categories.CONSTRUCTIONSORTDOWN, buildableUnits)
        
		sortedOptions.t1 = EntityCategoryFilterDown(categories.TECH1-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
        sortedOptions.t2 = EntityCategoryFilterDown(categories.TECH2-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
        sortedOptions.t3 = EntityCategoryFilterDown(categories.TECH3-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
		sortedOptions.t35 = EntityCategoryFilterDown(categories.ELITE-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
        sortedOptions.t4 = EntityCategoryFilterDown(categories.EXPERIMENTAL-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
		sortedOptions.t5 = EntityCategoryFilterDown(categories.TITAN-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
		sortedOptions.t6 = EntityCategoryFilterDown(categories.HERO-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
        
        for _, unit in sortDowns do
		    if EntityCategoryContains(categories.HERO, unit) then
                table.insert(sortedOptions.t5, unit)
			elseif EntityCategoryContains(categories.TITAN, unit) then
                table.insert(sortedOptions.t4, unit)
			elseif EntityCategoryContains(categories.EXPERIMENTAL, unit) then
                table.insert(sortedOptions.t35, unit)
            elseif EntityCategoryContains(categories.ELITE, unit) then
                table.insert(sortedOptions.t3, unit)
            elseif EntityCategoryContains(categories.TECH3, unit) then
                table.insert(sortedOptions.t2, unit)
            elseif EntityCategoryContains(categories.TECH2, unit) then
                table.insert(sortedOptions.t1, unit)
            end
        end
        
        if table.getn(buildableUnits) > 0 then
            controls.constructionTab:Enable()
        else
            controls.constructionTab:Disable()
            if BuildMode.IsInBuildMode() then
                BuildMode.ToggleBuildMode()
            end
        end
        
        sortedOptions.selection = selection
        controls.selectionTab:Enable()
        
        local allSameUnit = true
        local bpID = false
        local allMobile = true
        for i, v in selection do
            if allMobile and not v:IsInCategory('MOBILE') then
                allMobile = false
            end
            if allSameUnit and bpID and bpID != v:GetBlueprint().BlueprintId then
                allSameUnit = false
            else
                bpID = v:GetBlueprint().BlueprintId
            end
            if not allMobile and not allSameUnit then
                break
            end
        end
        
        if table.getn(selection) == 1 and selection[1]:GetBlueprint().Enhancements then
            controls.enhancementTab:Enable()
        else
            controls.enhancementTab:Disable()
        end
            
        local templates = Templates.GetTemplates()
        if allMobile and templates and table.getsize(templates) > 0 then
            sortedOptions.templates = {}
            for templateIndex, template in templates do
                local valid = true
                for _, entry in template.templateData do
                    if type(entry) == 'table' then
                        if not table.find(buildableUnits, entry[1]) then
                            valid = false
                            break
                        end
                    end
                end
                if valid then
                    template.templateID = templateIndex
                    table.insert(sortedOptions.templates, template)
                end
            end
        end
        
        if table.getn(selection) == 1 then
            currentCommandQueue = SetCurrentFactoryForQueueDisplay(selection[1])
        else
            currentCommandQueue = {}
            ClearCurrentFactoryForQueueDisplay()
        end
        
        if not isOldSelection then
            if not controls.constructionTab:IsDisabled() then
                controls.constructionTab:SetCheck(true)
            else
                controls.selectionTab:SetCheck(true)
            end
        elseif controls.constructionTab:IsChecked() then
            controls.constructionTab:SetCheck(true)
        elseif controls.enhancementTab:IsChecked() then
            controls.enhancementTab:SetCheck(true)
        else
            controls.selectionTab:SetCheck(true)
        end
        
        prevSelection = selection
        prevBuildCategories = buildableCategories
        prevBuildables = buildableUnits
        import(UIUtil.GetLayoutFilename('construction')).OnSelection(false)
        
        controls.constructionGroup:Show()
        controls.choices:CalcVisible()
        controls.secondaryChoices:CalcVisible()
    else
        if BuildMode.IsInBuildMode() then
            BuildMode.ToggleBuildMode()
        end
        currentCommandQueue = {}
        ClearCurrentFactoryForQueueDisplay()
        import(UIUtil.GetLayoutFilename('construction')).OnSelection(true)
    end
end

function FormatData(unitData, type)
    local retData = {}
    if type == 'construction' then
        local function SortFunc(unit1, unit2)
            local bp1 = __blueprints[unit1].BuildIconSortPriority or __blueprints[unit1].StrategicIconSortPriority
            local bp2 = __blueprints[unit2].BuildIconSortPriority or __blueprints[unit2].StrategicIconSortPriority
            if bp1 >= bp2 then
                return false
            else
                return true
            end
        end
        local sortedUnits = {}
        local sortCategories = {
            categories.SORTCONSTRUCTION,
            categories.SORTECONOMY,
            categories.SORTDEFENSE,
            categories.SORTSTRATEGIC,
            categories.SORTINTEL,
            categories.SORTOTHER,
        }
        local miscCats = categories.ALLUNITS
        local borders = {}
        for i, v in sortCategories do
            local category = v
            local index = i - 1
            local tempIndex = i
            while index > 0 do
                category = category - sortCategories[index]
                index = index - 1
            end
            local units = EntityCategoryFilterDown(category, unitData)
            table.insert(sortedUnits, units)
            miscCats = miscCats - v
        end
        
        table.insert(sortedUnits, EntityCategoryFilterDown(miscCats, unitData))
        
        for i, units in sortedUnits do
            table.sort(units, SortFunc)
            local index = i
            if table.getn(units) > 0 then
                if table.getn(retData) > 0 then
                    table.insert(retData, {type = 'spacer'})
                end
                for unitIndex, unit in units do
                    table.insert(retData, {type = 'item', id = unit})
                end
            end
        end
        CreateExtraControls('construction')
        SetSecondaryDisplay('buildQueue')
    elseif type == 'selection' then
        local sortedUnits = {}
        local lowFuelUnits = {}
        local ids = {}
        for _, unit in unitData do
            local id = unit:GetBlueprint().BlueprintId

            if unit:IsInCategory('AIR') and unit:GetFuelRatio() < .2 and unit:GetFuelRatio() > -1 then
                if not lowFuelUnits[id] then 
                    table.insert(ids, id)
                    lowFuelUnits[id] = {}
                end
                table.insert(lowFuelUnits[id], unit)
            else
                if not sortedUnits[id] then 
                    table.insert(ids, id)
                    sortedUnits[id] = {}
                end
                table.insert(sortedUnits[id], unit)
            end
        end
        
        local displayUnits = true
        if table.getsize(sortedUnits) == table.getsize(lowFuelUnits) then
            displayUnits = false
            for id, units in sortedUnits do
                if lowFuelUnits[id] and not table.equal(lowFuelUnits[id], units) then
                    displayUnits = true
                    break
                end
            end
        end
        if displayUnits then
            for i, v in sortedUnits do
                table.insert(retData, {type = 'unitstack', id = i, units = v})
            end
        end
        for i, v in lowFuelUnits do
            table.insert(retData, {type = 'unitstack', id = i, units = v, lowFuel = true})
        end
        CreateExtraControls('selection')
        SetSecondaryDisplay('attached')
    elseif type == 'templates' then
        table.sort(unitData, function(a,b)
            if a.key and not b.key then
                return true
            elseif b.key and not a.key then
                return false
            elseif a.key and b.key then
                return a.key <= b.key
            elseif a.name == b.name then
                return false
            else
                if LOC(a.name) <= LOC(b.name) then
                    return true
                else
                    return false
                end
            end
        end)
        for _, v in unitData do
            table.insert(retData, {type = 'templates', id = 'template', template = v})
        end
        CreateExtraControls('templates')
        SetSecondaryDisplay('buildQueue')
    else
        #Enhancements
        local existingEnhancements = EnhanceCommon.GetEnhancements(sortedOptions.selection[1]:GetEntityId())
        local slotToIconName = {
            RCH = 'ra',
            LCH = 'la',
            Back = 'b',
        }
        local filteredEnh = {}
        local usedEnhancements = {}
        local restrictList = EnhanceCommon.GetRestricted()
        for index, enhTable in unitData do
            if not string.find(enhTable.ID, 'Remove') then
                local restricted = false
                for _, enhancement in restrictList do
                    if enhancement == enhTable.ID then
                        restricted = true
                        break
                    end
                end
                if not restricted then
                    table.insert(filteredEnh, enhTable)
                end
            end
        end
        local function GetEnhByID(id)
            for i, enh in filteredEnh do
                if enh.ID == id then
                    return enh
                end
            end
        end
        local function FindDependancy(id)
            for i, enh in filteredEnh do
                if enh.Prerequisite and enh.Prerequisite == id then
                    return enh.ID
                end
            end
        end
        local function AddEnhancement(enhTable, disabled)
            local iconData = {
                type = 'enhancement', 
                enhTable = enhTable, 
                unitID = enhTable.UnitID, 
                id = enhTable.ID,
                icon = enhTable.Icon, 
                Selected = false,
                Disabled = disabled,
            }
            if existingEnhancements[enhTable.Slot] == enhTable.ID then
                iconData.Selected = true
            end
            table.insert(retData, iconData)
        end
        for i, enhTable in filteredEnh do
            if not usedEnhancements[enhTable.ID] and not enhTable.Prerequisite then
                AddEnhancement(enhTable, false)
                usedEnhancements[enhTable.ID] = true
                if FindDependancy(enhTable.ID) then
                    local searching = true
                    local curID = enhTable.ID
                    while searching do
                        table.insert(retData, {type = 'arrow'})
                        local tempEnh = GetEnhByID(FindDependancy(curID))
                        local disabled = true
                        if existingEnhancements[enhTable.Slot] == tempEnh.Prerequisite then
                            disabled = false
                        end
                        AddEnhancement(tempEnh, disabled)
                        usedEnhancements[tempEnh.ID] = true
                        if FindDependancy(tempEnh.ID) then
                            curID = tempEnh.ID
                        else
                            searching = false
                            if table.getsize(usedEnhancements) <= table.getsize(filteredEnh)-1 then
                                table.insert(retData, {type = 'spacer'})
                            end
                        end
                    end
                else
                    if table.getsize(usedEnhancements) <= table.getsize(filteredEnh)-1 then
                        table.insert(retData, {type = 'spacer'})
                    end
                end
            end
        end
        CreateExtraControls('enhancement')
        SetSecondaryDisplay('buildQueue')
    end
    import(UIUtil.GetLayoutFilename('construction')).OnTabChangeLayout(type)
    return retData
end


# given a tech level, sets that tech level, returns false if tech level not available
function SetCurrentTechTab(techLevel)
    if techLevel == 1 and GetTabByID('t1'):IsDisabled() then
        return false
    elseif techLevel == 2 and GetTabByID('t2'):IsDisabled() then
        return false
    elseif techLevel == 3 and GetTabByID('t3'):IsDisabled() then
        return false
	elseif techLevel == 3.5 and GetTabByID('t35'):IsDisabled() then
        return false
    elseif techLevel == 4 and GetTabByID('t4'):IsDisabled() then
        return false
	elseif techLevel == 5 and GetTabByID('t5'):IsDisabled() then
        return false
	elseif techLevel == 6 and GetTabByID('t6'):IsDisabled() then
        return false
    elseif techLevel == 7 and GetTabByID('templates'):IsDisabled() then
        return false
    elseif techLevel > 7 or techLevel < 1 then
        return false
    end
    if techLevel == 7 then
        GetTabByID('templates'):SetCheck(true)
    else
        GetTabByID('t'..tostring(techLevel)):SetCheck(true)
    end
    return true
end

function GetCurrentTechTab()
    if GetTabByID('t1'):IsChecked() then
        return 1
    elseif GetTabByID('t2'):IsChecked() then
        return 2
    elseif GetTabByID('t3'):IsChecked() then
        return 3
	elseif GetTabByID('t35'):IsChecked() then
        return 3.5
    elseif GetTabByID('t4'):IsChecked() then
        return 4
	elseif GetTabByID('t5'):IsChecked() then
        return 5
	elseif GetTabByID('t6'):IsChecked() then
        return 6
    elseif GetTabByID('templates'):IsChecked() then
        return 7
    else
        return nil
    end
end

else

local unitGridPages = {
    RULEUTL_Basic = {Order = 0, Label = "<LOC CONSTRUCT_0000>T1"},
    RULEUTL_Advanced = {Order = 1, Label = "<LOC CONSTRUCT_0001>T2"},
    RULEUTL_Secret = {Order = 2, Label = "<LOC CONSTRUCT_0002>T3"},
	RULEUTL_Elite = {Order = 3, Label = "Elite"},
    RULEUTL_Experimental = {Order = 4, Label = "<LOC CONSTRUCT_0003>Exp"},
	RULEUTL_Titan = {Order = 5, Label = "Titan"},
	RULEUTL_Hero = {Order = 6, Label = "Hero"},
    RULEUTL_Munition = {Order = 7, Label = "<LOC CONSTRUCT_0004>Munition"},   # note that this doesn't exist yet
}

local constructionTabs = {'t1','t2','t3','t35','t4','t5','t6','templates'}
local nestedTabKey = {
    t1 = 'construction',
    t2 = 'construction',
    t3 = 'construction',
	t35 = 'construction',
    t4 = 'construction',
	t5 = 'construction',
	t6 = 'construction',
}

function OnNestedTabCheck(self, checked)
    activeTab = self
    for _, tab in controls.tabs do
        if tab ~= self then
            tab:SetCheck(false, true)
        end
    end
    controls.choices:Refresh(FormatData(sortedOptions[self.ID], nestedTabKey[self.ID] or self.ID))
    SetSecondaryDisplay('buildQueue')
end

function CreateTabs(type)
    local defaultTabOrder = {}
    local desiredTabs = 0
    -- Construction tab, this is called before fac templates have been added
    if type == 'construction' and allFactories and options.gui_templates_factory ~= 0 then
        -- nil value would cause refresh issues if templates tab is currently selected
        sortedOptions.templates = {}

        -- Prevent tab autoselection when in templates tab,
        -- Normally triggered when number of active tabs has changed (fac upgrade added/removed from queue)
        local templatesTab = GetTabByID('templates')
        if templatesTab and templatesTab:IsChecked() then
            local numActive = 0
            for _, tab in controls.tabs do
                if sortedOptions[tab.ID] and not table.empty(sortedOptions[tab.ID]) then
                    numActive = numActive + 1
                end
            end
            previousTabSize = numActive
        end
    end
    if type == 'construction' then
        for index, tab in constructionTabs do
            local i = index
            if not controls.tabs[i] then
                controls.tabs[i] = CreateTab(controls.constructionGroup, tab, OnNestedTabCheck)
            end
            controls.tabs[i].ID = tab
            controls.tabs[i].OnRolloverEvent = function(self, event)
            end
            Tooltip.AddControlTooltip(controls.tabs[i], 'construction_tab_' .. tab)
            Tooltip.AddControlTooltip(controls.tabs[i].disabledGroup, 'construction_tab_' .. tab .. '_dis')
        end
        desiredTabs = table.getsize(constructionTabs)
        defaultTabOrder = {t6=1, t5=2, t4=3, t35=4, t3=5, t2=6, t1=7} -- T4 is last because only the Novax can build T4 but not T3
    elseif type == 'enhancement' then
        local selection = sortedOptions.selection
        local enhancements = selection[1]:GetBlueprint().Enhancements
        local enhCommon = import('/lua/enhancementcommon.lua')
        local enhancementPrefixes = {Back = 'b-', LCH = 'la-', RCH = 'ra-'}
        local newTabs = {}
        if enhancements.Slots then
            local tabIndex = 1
            for slotName, slotInfo in enhancements.Slots do
                if not controls.tabs[tabIndex] then
                    controls.tabs[tabIndex] = CreateTab(controls.constructionGroup, nil, OnNestedTabCheck)
                end
                controls.tabs[tabIndex].tooltipKey = enhancementTooltips[slotName]
                controls.tabs[tabIndex].OnRolloverEvent = function(self, event)
                    if event == 'enter' then
                        local existing = enhCommon.GetEnhancements(selection[1]:GetEntityId())
                        if existing[slotName] then
                            local enhancement = enhancements[existing[slotName]]
                            local icon = enhancements[existing[slotName]].Icon
                            local bpID = selection[1]:GetBlueprint().BlueprintId
                            local enhName = existing[slotName]
                            local texture = "/textures/ui/common" .. GetEnhancementPrefix(bpID, enhancementPrefixes[slotName] .. icon)
                            UnitViewDetail.ShowEnhancement(enhancement, bpID, icon, texture, sortedOptions.selection[1])
                        end
                    elseif event == 'exit' then
                        if existing[slotName] then
                            UnitViewDetail.Hide()
                        end
                    end
                end
                Tooltip.AddControlTooltip(controls.tabs[tabIndex], enhancementTooltips[slotName])
                controls.tabs[tabIndex].ID = slotName
                newTabs[tabIndex] = controls.tabs[tabIndex]
                tabIndex = tabIndex + 1
                sortedOptions[slotName] = {}
                for enhName, enhTable in enhancements do
                    if enhTable.Slot == slotName then
                        enhTable.ID = enhName
                        enhTable.UnitID = selection[1]:GetBlueprint().BlueprintId
                        table.insert(sortedOptions[slotName], enhTable)
                    end
                end
            end
            desiredTabs = table.getsize(enhancements.Slots)
        end
        defaultTabOrder = {Back = 1, LCH = 2, RCH = 3}
    elseif type == 'selection' then
        activeTab = nil
    end

    while table.getsize(controls.tabs) > desiredTabs do
        controls.tabs[table.getsize(controls.tabs)]:Destroy()
        controls.tabs[table.getsize(controls.tabs)] = nil
    end

    import(UIUtil.GetLayoutFilename('construction')).LayoutTabs(controls)
    local defaultTab = false
    local numActive = 0
    for _, tab in controls.tabs do
        if sortedOptions[tab.ID] and not table.empty(sortedOptions[tab.ID]) then
            tab:Enable()
            numActive = numActive + 1
            if defaultTabOrder[tab.ID] then
                if not defaultTab or defaultTabOrder[tab.ID] < defaultTabOrder[defaultTab.ID] then
                    defaultTab = tab
                end
            end
        else
            tab:Disable()
        end
    end

    if previousTabSet ~= type or previousTabSize ~= numActive then
        if defaultTab then
            defaultTab:SetCheck(true)
        end
        previousTabSet = type
        previousTabSize = numActive
    elseif activeTab then
        activeTab:SetCheck(true)
    end
end

function FormatData(unitData, type)
    local retData = {}
    if type == 'construction' then
        local function SortFunc(unit1, unit2)
            local bp1 = __blueprints[unit1]
            local bp2 = __blueprints[unit2]
            local v1 = bp1.BuildIconSortPriority or bp1.StrategicIconSortPriority
            local v2 = bp2.BuildIconSortPriority or bp2.StrategicIconSortPriority

            if v1 >= v2 then
                return false
            else
                return true
            end
        end

        local sortedUnits = {}
        local sortCategories = {
            categories.SORTCONSTRUCTION,
            categories.SORTECONOMY,
            categories.SORTDEFENSE,
            categories.SORTSTRATEGIC,
            categories.SORTINTEL,
            categories.SORTOTHER,
        }
        local miscCats = categories.ALLUNITS
        local borders = {}
        for i, v in sortCategories do
            local category = v
            local index = i - 1
            local tempIndex = i
            while index > 0 do
                category = category - sortCategories[index]
                index = index - 1
            end
            local units = EntityCategoryFilterDown(category, unitData)
            table.insert(sortedUnits, units)
            miscCats = miscCats - v
        end

        table.insert(sortedUnits, EntityCategoryFilterDown(miscCats, unitData))

        -- Get function for checking for restricted units
        local IsRestricted = import('/lua/game.lua').IsRestricted

        -- This section adds the arrows in for a build icon which is an upgrade from the
        -- selected unit. If there is an upgrade chain, it will display them split by arrows.
        -- I'm excluding Factories from this for now, since the chain of T1 -> T2 HQ -> T3 HQ
        -- or T1 -> T2 Support -> T3 Support is not supported yet by the code which actually
        -- looks up, stores, and executes the upgrade chain. This needs doing for 3654.
        local unitSelected = sortedOptions.selection[1]
        local isStructure = EntityCategoryContains(categories.STRUCTURE - categories.FACTORY, unitSelected)

        for i, units in sortedUnits do
            table.sort(units, SortFunc)
            local index = i
            if not table.empty(units) then
                if not table.empty(retData) then
                    table.insert(retData, {type = 'spacer'})
                end

                for index, unit in units do
                    -- Show UI data/icons only for not restricted units
                    local restrict = false
                    if not IsRestricted(unit, GetFocusArmy()) then
                        local bp = __blueprints[unit]
                        -- Check if upgradeable structure
                        if isStructure and
                                bp and bp.General and
                                bp.General.UpgradesFrom and
                                bp.General.UpgradesFrom ~= 'none' then

                            restrict = IsRestricted(bp.General.UpgradesFrom, GetFocusArmy())
                            if not restrict then
                                table.insert(retData, {type = 'arrow'})
                            end
                        end

                        if not restrict then
                            table.insert(retData, {type = 'item', id = unit})
                        end
                    end
                end
            end
        end

        CreateExtraControls('construction')
        SetSecondaryDisplay('buildQueue')
    elseif type == 'selection' then
        local sortedUnits = {
            [1] = {cat = "ALLUNITS", units = {}},
            [2] = {cat = "LAND", units = {}},
            [3] = {cat = "AIR", units = {}},
            [4] = {cat = "NAVAL", units = {}},
            [5] = {cat = "STRUCTURE", units = {}},
            [6] = {cat = "SORTCONSTRUCTION", units = {}},
        }

        local lowFuelUnits = {}
        local idleConsUnits = {}

        for _, unit in unitData do
            local id = unit:GetBlueprint().BlueprintId

            if unit:IsInCategory('AIR') and unit:GetFuelRatio() < .2 and unit:GetFuelRatio() > -1 then
                if not lowFuelUnits[id] then
                    lowFuelUnits[id] = {}
                end
                table.insert(lowFuelUnits[id], unit)
            elseif options.gui_seperate_idle_builders ~= 0 and unit:IsInCategory('CONSTRUCTION') and unit:IsIdle() then
                if not idleConsUnits[id] then
                    idleConsUnits[id] = {}
                end
                table.insert(idleConsUnits[id], unit)
            else
                local cat = 0
                for i, t in sortedUnits do
                    if unit:IsInCategory(t.cat) then
                        cat = i
                    end
                end

                if not sortedUnits[cat].units[id] then
                    sortedUnits[cat].units[id] = {}
                end

                table.insert(sortedUnits[cat].units[id], unit)
            end
        end

        local function insertSpacer(didPutUnits)
            if didPutUnits then
                table.insert(retData, {type = 'spacer'})
                return not didPutUnits
            end
        end

        -- Sort selected units into order and insert spaces
        local didPutUnits = false
        for _, t in sortedUnits do
            didPutUnits = insertSpacer(didPutUnits)

            retData, didPutUnits = insertIntoTableLowestTechFirst(t.units, retData, false, false)
        end

        -- Split out low fuel
        didPutUnits = insertSpacer(didPutUnits)
        retData, didPutUnits = insertIntoTableLowestTechFirst(lowFuelUnits, retData, true, false)

        -- Split out idle constructors
        didPutUnits = insertSpacer(didPutUnits)
        retData, didPutUnits = insertIntoTableLowestTechFirst(idleConsUnits, retData, false, true)

        -- Remove trailing spacer if there is one
        if retData[table.getn(retData)].type == 'spacer' then
            table.remove(retData, table.getn(retData))
        end

        CreateExtraControls('selection')
        SetSecondaryDisplay('attached')

        import(UIUtil.GetLayoutFilename('construction')).OnTabChangeLayout(type)
    elseif type == 'templates' then
        table.sort(unitData, function(a, b)
            if a.key and not b.key then
                return true
            elseif b.key and not a.key then
                return false
            elseif a.key and b.key then
                return a.key <= b.key
            elseif a.name == b.name then
                return false
            else
                if LOC(a.name) <= LOC(b.name) then
                    return true
                else
                    return false
                end
            end
        end)
        for _, v in unitData do
            table.insert(retData, {type = 'templates', id = 'template', template = v})
        end
        CreateExtraControls('templates')
        SetSecondaryDisplay('buildQueue')
    else
        -- Enhancements
        local existingEnhancements = EnhanceCommon.GetEnhancements(sortedOptions.selection[1]:GetEntityId())
        local slotToIconName = {
            RCH = 'ra',
            LCH = 'la',
            Back = 'b',
        }
        local filteredEnh = {}
        local usedEnhancements = {}
        local restEnh = EnhanceCommon.GetRestricted()

        -- Filter enhancements based on restrictions
        for index, enhTable in unitData do
            if not restEnh[enhTable.ID] and not string.find(enhTable.ID, 'Remove') then
                table.insert(filteredEnh, enhTable)
            end
        end

        local function GetEnhByID(id)
            for i, enh in filteredEnh do
                if enh.ID == id then
                    return enh
                end
            end
        end

        local function FindDependancy(id)
            for i, enh in filteredEnh do
                if enh.Prerequisite and enh.Prerequisite == id then
                    return enh.ID
                end
            end
        end

        local function AddEnhancement(enhTable, disabled)
            local iconData = {
                type = 'enhancement',
                enhTable = enhTable,
                unitID = enhTable.UnitID,
                id = enhTable.ID,
                icon = enhTable.Icon,
                Selected = false,
                Disabled = disabled,
            }
            if existingEnhancements[enhTable.Slot] == enhTable.ID then
                iconData.Selected = true
            end
            table.insert(retData, iconData)
        end

        for i, enhTable in filteredEnh do
            if not usedEnhancements[enhTable.ID] and not enhTable.Prerequisite then
                AddEnhancement(enhTable, false)
                usedEnhancements[enhTable.ID] = true
                if FindDependancy(enhTable.ID) then
                    local searching = true
                    local curID = enhTable.ID
                    while searching do
                        table.insert(retData, {type = 'arrow'})
                        local tempEnh = GetEnhByID(FindDependancy(curID))
                        local disabled = true
                        if existingEnhancements[enhTable.Slot] == tempEnh.Prerequisite then
                            disabled = false
                        end
                        AddEnhancement(tempEnh, disabled)
                        usedEnhancements[tempEnh.ID] = true
                        if FindDependancy(tempEnh.ID) then
                            curID = tempEnh.ID
                        else
                            searching = false
                            if table.getsize(usedEnhancements) <= table.getsize(filteredEnh) - 1 then
                                table.insert(retData, {type = 'spacer'})
                            end
                        end
                    end
                else
                    if table.getsize(usedEnhancements) <= table.getsize(filteredEnh) - 1 then
                        table.insert(retData, {type = 'spacer'})
                    end
                end
            end
        end
        CreateExtraControls('enhancement')
        SetSecondaryDisplay('buildQueue')
    end
    import(UIUtil.GetLayoutFilename('construction')).OnTabChangeLayout(type)


    if type == 'templates' and allFactories then
        -- Replace Infinite queue with Create template
        Tooltip.AddCheckboxTooltip(controls.extraBtn1, 'save_template')
        if not table.empty(currentCommandQueue) then
            controls.extraBtn1:Enable()
            controls.extraBtn1.OnClick = function(self, modifiers)
                TemplatesFactory.CreateBuildTemplate(currentCommandQueue)
            end
        else
            controls.extraBtn1:Disable()
        end
        controls.extraBtn1.icon.OnTexture = UIUtil.UIFile('/game/construct-sm_btn/template_on.dds')
        controls.extraBtn1.icon.OffTexture = UIUtil.UIFile('/game/construct-sm_btn/template_off.dds')
        if controls.extraBtn1:IsDisabled() then
            controls.extraBtn1.icon:SetTexture(controls.extraBtn1.icon.OffTexture)
        else
            controls.extraBtn1.icon:SetTexture(controls.extraBtn1.icon.OnTexture)
        end
    end

    if type == 'RCH' or type == 'Back' or type == 'LCH' then
        local enhancementQueue = getEnhancementQueue()
        for _, iconData in retData do
            iconData.Disabled = false

            if table.getn(sortedOptions.selection) == 1 then
                for _, enhancement in (enhancementQueue[sortedOptions.selection[1]:GetEntityId()] or {}) do
                    if enhancement.Slot == iconData.enhTable.Slot and enhancement.ID ~= iconData.enhTable.Prerequisite and not string.find(enhancement.ID, 'Remove') then
                        iconData.Disabled = true
                        break
                    end
                end
            else
                iconData.Selected = false
            end
        end

        SetSecondaryDisplay('buildQueue')
    end
    return retData
end


function OnSelection(buildableCategories, selection, isOldSelection)
    buildableCategories = EnhancementQueueFile.ModifyBuildablesForACU(buildableCategories, selection)

    if table.empty(selection) then
        sortedOptions.selection = {}
    end

    if options.gui_templates_factory ~= 0 then
        if table.empty(selection) then
            allFactories = false
        else
            allFactories = true
            for i, v in selection do
                if not v:IsInCategory('FACTORY') then
                    allFactories = false
                    break
                end
            end
        end
    end

    if table.getn(selection) == 1 then
        currentCommandQueue = SetCurrentFactoryForQueueDisplay(selection[1])
    else
        currentCommandQueue = {}
        ClearCurrentFactoryForQueueDisplay()
    end

    if not table.empty(selection) then
        capturingKeys = false
        -- Sorting down units
        local buildableUnits = EntityCategoryGetUnitList(buildableCategories)
        if not isOldSelection then
            previousTabSet = nil
            previousTabSize = nil
            activeTab = nil
            ClearSessionExtraSelectList()
        end
        sortedOptions = {}
        UnitViewDetail.Hide()

        if not selection[1]:IsInCategory('FACTORY') then
            local inQueue = {}
            for _, v in currentCommandQueue or {} do
                inQueue[v.id] = true
            end


            local bpid = __blueprints[selection[1]:GetBlueprint().BlueprintId].General.UpgradesTo
            if bpid then
                while bpid and bpid ~= '' do -- UpgradesTo is sometimes ''??
                    if not inQueue[bpid] then
                        table.insert(buildableUnits, bpid)
                    end
                    bpid = __blueprints[bpid].General.UpgradesTo
                end

                buildableUnits = table.unique(buildableUnits)
            end
        end

        -- Only honour CONSTRUCTIONSORTDOWN if we selected a factory
        local allFactory = true
        for i, v in selection do
            if allFactory and not v:IsInCategory('FACTORY') then
                allFactory = false
            end
        end

        if allFactory then
            local sortDowns = EntityCategoryFilterDown(categories.CONSTRUCTIONSORTDOWN, buildableUnits)
			sortedOptions.t1 = EntityCategoryFilterDown(categories.TECH1-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
			sortedOptions.t2 = EntityCategoryFilterDown(categories.TECH2-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
			sortedOptions.t3 = EntityCategoryFilterDown(categories.TECH3-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
			sortedOptions.t35 = EntityCategoryFilterDown(categories.ELITE-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
			sortedOptions.t4 = EntityCategoryFilterDown(categories.EXPERIMENTAL-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
			sortedOptions.t5 = EntityCategoryFilterDown(categories.TITAN-categories.CONSTRUCTIONSORTDOWN, buildableUnits)
			sortedOptions.t6 = EntityCategoryFilterDown(categories.HERO-categories.CONSTRUCTIONSORTDOWN, buildableUnits)

        for _, unit in sortDowns do
		    if EntityCategoryContains(categories.HERO, unit) then
                table.insert(sortedOptions.t5, unit)
			elseif EntityCategoryContains(categories.TITAN, unit) then
                table.insert(sortedOptions.t4, unit)
			elseif EntityCategoryContains(categories.EXPERIMENTAL, unit) then
                table.insert(sortedOptions.t35, unit)
            elseif EntityCategoryContains(categories.ELITE, unit) then
                table.insert(sortedOptions.t3, unit)
            elseif EntityCategoryContains(categories.TECH3, unit) then
                table.insert(sortedOptions.t2, unit)
            elseif EntityCategoryContains(categories.TECH2, unit) then
                table.insert(sortedOptions.t1, unit)
            end
        end
        elseif EntityCategoryContains(categories.ENGINEER + categories.FACTORY, selection[1]) then
			sortedOptions.t1 = EntityCategoryFilterDown(categories.TECH1, buildableUnits)
			sortedOptions.t2 = EntityCategoryFilterDown(categories.TECH2, buildableUnits)
			sortedOptions.t3 = EntityCategoryFilterDown(categories.TECH3, buildableUnits)
			sortedOptions.t35 = EntityCategoryFilterDown(categories.ELITE, buildableUnits)
			sortedOptions.t4 = EntityCategoryFilterDown(categories.EXPERIMENTAL, buildableUnits)
			sortedOptions.t5 = EntityCategoryFilterDown(categories.TITAN, buildableUnits)
			sortedOptions.t6 = EntityCategoryFilterDown(categories.HERO, buildableUnits)
        else
            sortedOptions.t1 = buildableUnits
        end

        if not table.empty(buildableUnits) then
            controls.constructionTab:Enable()
        else
            controls.constructionTab:Disable()
            if BuildMode.IsInBuildMode() then
                BuildMode.ToggleBuildMode()
            end
        end

        sortedOptions.selection = selection
        controls.selectionTab:Enable()

        local allSameUnit = true
        local bpID = false
        local allMobile = true
        for i, v in selection do
            if allMobile and not v:IsInCategory('MOBILE') then
                allMobile = false
            end
            if allSameUnit and bpID and bpID ~= v:GetBlueprint().BlueprintId then
                allSameUnit = false
            else
                bpID = v:GetBlueprint().BlueprintId
            end
            if not allMobile and not allSameUnit then
                break
            end
        end

        if table.getn(selection) == 1 and selection[1]:GetBlueprint().Enhancements then
            controls.enhancementTab:Enable()
        else
            controls.enhancementTab:Disable()
        end

        local templates = Templates.GetTemplates()
        if allMobile and templates and not table.empty(templates) then
            sortedOptions.templates = {}
            for templateIndex, template in templates do
                local valid = true
                for _, entry in template.templateData do
                    if type(entry) == 'table' then
                        if not table.find(buildableUnits, entry[1]) then
                            valid = false
                            break
                        end
                    end
                end
                if valid then
                    template.templateID = templateIndex
                    table.insert(sortedOptions.templates, template)
                end
            end
        end

        if not isOldSelection then
            if not controls.constructionTab:IsDisabled() then
                controls.constructionTab:SetCheck(true)
            else
                controls.selectionTab:SetCheck(true)
            end
        elseif controls.constructionTab:IsChecked() then
            controls.constructionTab:SetCheck(true)
        elseif controls.enhancementTab:IsChecked() then
            controls.enhancementTab:SetCheck(true)
        else
            controls.selectionTab:SetCheck(true)
        end

        prevSelection = selection
        prevBuildCategories = buildableCategories
        prevBuildables = buildableUnits
        import(UIUtil.GetLayoutFilename('construction')).OnSelection(false)

        controls.constructionGroup:Show()
        controls.choices:CalcVisible()
        controls.secondaryChoices:CalcVisible()
    else
        if BuildMode.IsInBuildMode() then
            BuildMode.ToggleBuildMode()
        end
        currentCommandQueue = {}
        ClearCurrentFactoryForQueueDisplay()
        import(UIUtil.GetLayoutFilename('construction')).OnSelection(true)
    end

    if not table.empty(selection) then
        -- Repeated from original to access the local variables
        local allSameUnit = true
        local bpID = false
        local allMobile = true
        for i, v in selection do
            if allMobile and not v:IsInCategory('MOBILE') then
                allMobile = false
            end
            if allSameUnit and bpID and bpID ~= v:GetBlueprint().BlueprintId then
                allSameUnit = false
            else
                bpID = v:GetBlueprint().BlueprintId
            end
            if not allMobile and not allSameUnit then
                break
            end
        end

        -- Upgrade multiple SCU at once
        if selection[1]:GetBlueprint().Enhancements and allSameUnit then
            controls.enhancementTab:Enable()
        end

        -- Allow all races to build other races templates
        if options.gui_all_race_templates ~= 0 then
            local templates = Templates.GetTemplates()
            local buildableUnits = EntityCategoryGetUnitList(buildableCategories)
            if allMobile and templates and not table.empty(templates) then

                local unitFactionName = selection[1]:GetBlueprint().General.FactionName
                local currentFaction = Factions[ FactionInUnitBpToKey[unitFactionName] ]

                if currentFaction then
                    sortedOptions.templates = {}
                    local function ConvertID(BPID)
                        local prefixes = currentFaction.GAZ_UI_Info.BuildingIdPrefixes or {}
                        for k, prefix in prefixes do
                            local newBPID = string.gsub(BPID, "(%a+)(%d+)", prefix .. "%2")
                            if table.find(buildableUnits, newBPID) then
                                return newBPID
                            end
                        end
                        return false
                    end

                    for templateIndex, template in templates do
                        local valid = true
                        local converted = false
                        for _, entry in template.templateData do
                            if type(entry) == 'table' then
                                if not table.find(buildableUnits, entry[1]) then

                                    entry[1] = ConvertID(entry[1])
                                    converted = true
                                    if not table.find(buildableUnits, entry[1]) then
                                        valid = false
                                        break
                                    end
                                end
                            end
                        end
                        if valid then
                            if converted then
                                template.icon = ConvertID(template.icon)
                            end
                            template.templateID = templateIndex
                            table.insert(sortedOptions.templates, template)
                        end
                    end
                end

                -- Refresh the construction tab to show any new available templates
                if not isOldSelection then
                    if not controls.constructionTab:IsDisabled() then
                        controls.constructionTab:SetCheck(true)
                    else
                        controls.selectionTab:SetCheck(true)
                    end
                elseif controls.constructionTab:IsChecked() then
                    controls.constructionTab:SetCheck(true)
                elseif controls.enhancementTab:IsChecked() then
                    controls.enhancementTab:SetCheck(true)
                else
                    controls.selectionTab:SetCheck(true)
                end
            end
        end
    end

    -- Add valid templates for selection
    if allFactories then
        sortedOptions.templates = {}
        local templates = TemplatesFactory.GetTemplates()
        if templates and not table.empty(templates) then
            local buildableUnits = EntityCategoryGetUnitList(buildableCategories)
            for templateIndex, template in ipairs(templates) do
                local valid = true
                for index, entry in ipairs(template.templateData) do
                    if not table.find(buildableUnits, entry.id) then
                        valid = false
                        -- Allow templates containing factory upgrades & higher tech units
                        if index > 1 then
                            for i = index - 1, 1, -1 do
                                local blueprint = __blueprints[template.templateData[i].id]
                                if blueprint.General.UpgradesFrom ~= 'none' then
                                    -- Previous entry is a (valid) upgrade
                                    valid = true
                                    break
                                end
                            end
                        end
                        break
                    end
                end
                if valid then
                    template.templateID = templateIndex
                    table.insert(sortedOptions.templates, template)
                end
            end
        end

        -- Templates tab enable & refresh
        local templatesTab = GetTabByID('templates')
        if templatesTab then
            templatesTab:Enable()
            if templatesTab:IsChecked() then
                templatesTab:SetCheck(true)
            end
        end
    end
end


# given a tech level, sets that tech level, returns false if tech level not available
function SetCurrentTechTab(techLevel)
    if techLevel == 1 and GetTabByID('t1'):IsDisabled() then
        return false
    elseif techLevel == 2 and GetTabByID('t2'):IsDisabled() then
        return false
    elseif techLevel == 3 and GetTabByID('t3'):IsDisabled() then
        return false
	elseif techLevel == 3.5 and GetTabByID('t35'):IsDisabled() then
        return false
    elseif techLevel == 4 and GetTabByID('t4'):IsDisabled() then
        return false
	elseif techLevel == 5 and GetTabByID('t5'):IsDisabled() then
        return false
	elseif techLevel == 6 and GetTabByID('t6'):IsDisabled() then
        return false
    elseif techLevel == 7 and GetTabByID('templates'):IsDisabled() then
        return false
    elseif techLevel > 7 or techLevel < 1 then
        return false
    end
    if techLevel == 7 then
        GetTabByID('templates'):SetCheck(true)
    else
        GetTabByID('t'..tostring(techLevel)):SetCheck(true)
    end
    return true
end

function GetCurrentTechTab()
    if GetTabByID('t1'):IsChecked() then
        return 1
    elseif GetTabByID('t2'):IsChecked() then
        return 2
    elseif GetTabByID('t3'):IsChecked() then
        return 3
	elseif GetTabByID('t35'):IsChecked() then
        return 3.5
    elseif GetTabByID('t4'):IsChecked() then
        return 4
	elseif GetTabByID('t5'):IsChecked() then
        return 5
	elseif GetTabByID('t6'):IsChecked() then
        return 6
    elseif GetTabByID('templates'):IsChecked() then
        return 7
    else
        return nil
    end
end


	LOG('Future Battlefield Pack Orbital: [unitview.lua '..debug.getinfo(1).currentline..'] - Gameversion is 3652 or newer. No need to insert the unit icons by our own function.')
end -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function


function GetBackgroundTextures(unitID)
    local bp = __blueprints[unitID]
    local validIcons = {land = true, air = true, sea = true, amph = true, orbit = true}
    local icon = "land"
	local Modpath = "/mods/Future Battlefield Pack Orbital"
    if unitID and unitID ~= 'default' then
        if not validIcons[bp.General.Icon] then
            if bp.General.Icon then WARN(debug.traceback(nil, "Invalid icon" .. bp.General.Icon .. " for unit " .. tostring(unitID))) end
            bp.General.Icon = "land"
		else
			icon = bp.General.Icon
		end
    end
	return UIUtil.UIFile(Modpath .. '/icons/units/backgrounds/' .. icon .. '_up.dds'),
			UIUtil.UIFile(Modpath .. '/icons/units/backgrounds/' .. icon .. '_down.dds'),
			UIUtil.UIFile(Modpath .. '/icons/units/backgrounds/' .. icon .. '_over.dds'),
			UIUtil.UIFile(Modpath .. '/icons/units/backgrounds/' .. icon .. '_up.dds')
end


function GetEnhancementPrefix(unitID, iconID)
    local factionPrefix = ''
    if string.sub(unitID, 2, 2) == 'a' then
        factionPrefix = 'aeon-enhancements/' 
    elseif string.sub(unitID, 2, 2) == 'e' then
        factionPrefix = 'uef-enhancements/'
    elseif string.sub(unitID, 2, 2) == 'r' then
        factionPrefix = 'cybran-enhancements/'
    elseif string.sub(unitID, 2, 2) == 's' then
        factionPrefix = 'seraphim-enhancements/'
    end
    local prefix = '/game/' .. factionPrefix .. iconID
    --# If it is a stock icon...
    if not DiskGetFileInfo('/textures/ui/common'..prefix..'_btn_up.dds') then
        --# return a path to shared icons
        local altPathEX =  '/mods/Future Battlefield Pack Orbital/icons/'
        prefix = altPathEX .. factionPrefix .. iconID
    end
    return prefix
end

function GetEnhancementTextures(unitID, iconID)
    local factionPrefix = ''
    if string.sub(unitID, 2, 2) == 'a' then
        factionPrefix = 'aeon-enhancements/' 
    elseif string.sub(unitID, 2, 2) == 'e' then
        factionPrefix = 'uef-enhancements/'
    elseif string.sub(unitID, 2, 2) == 'r' then
        factionPrefix = 'cybran-enhancements/'
    elseif string.sub(unitID, 2, 2) == 's' then
        factionPrefix = 'seraphim-enhancements/'
    end
    
    local prefix = '/game/' .. factionPrefix .. iconID
    --# If it is a stock icon...
    if DiskGetFileInfo('/textures/ui/common'..prefix..'_btn_up.dds') then
        return UIUtil.UIFile(prefix..'_btn_up.dds'),
            UIUtil.UIFile(prefix..'_btn_down.dds'),
            UIUtil.UIFile(prefix..'_btn_over.dds'),
            UIUtil.UIFile(prefix..'_btn_up.dds'),
            UIUtil.UIFile(prefix..'_btn_sel.dds')
    else
        --# return a path to shared icons
        local altPathEX =  '/mods/Future Battlefield Pack Orbital/icons/'
        prefix = altPathEX .. factionPrefix .. iconID
        --# Bypass UIFile as these icons 
        --# are not skinabble!
        return prefix..'_btn_up.dds',
            prefix..'_btn_down.dds',
            prefix..'_btn_over.dds',
            prefix..'_btn_up.dds',
            prefix..'_btn_sel.dds'
    end
end