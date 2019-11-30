    -- In der originalen blueprint.lua existiert schon eine Funktion mit namen ModBlueprints
    -- Diese funktion speichern wir in OldModBlueprints damit wir die originale funktion überschreiben (hooken) können
    local OldModBlueprints = ModBlueprints

    -- Diese funktion ersetzt die originale ModBlueprints funktion
    function ModBlueprints(all_blueprints)
        -- Zuerste füren wir die originale ModBlueprints funktion aus, die wir oben gesichert haben
        OldModBlueprints(all_blueprints)

        -- Jetzt dursuchen wir alle Unit blueprints ID= unitID, bp= Unitblueprint
        for id,bp in all_blueprints.Unit do
            -- Wenn der Blueprint der Einheit ein Waffenarray hat, suchen wir darin weiter
            if bp.Weapon then
                -- Jetzt durchsuchen wir jede einzelone Waffe der Einheit
                for ik, wep in bp.Weapon do
                    -- Wenn die aktuelle Waffe die RangeCategory UWRC_AntiAir hat, dann haben wir eine Luftverteidigung
                    if wep.RangeCategory == 'UWRC_AntiAir' then
                        -- Wenn die Waffe nicht den Eintrag AntiSpaceshipWeapon hat müssen wir sie umschreiben
                        if not wep.AntiSpaceshipWeapon == true then
                            -- hier wird nun in der Waffe TargetRestrictDisallow mit SPACESHIP erweitert
                            wep.TargetRestrictDisallow = wep.TargetRestrictDisallow .. ', SPACESHIP'
                            
                            
                        end -- if not wep.AntiSpaceshipWeapon == true then
                    end -- if wep.RangeCategory == 'UWRC_AntiAir' then
                end -- for ik, wep in bp.Weapon do
            end -- if bp.Weapon then
        end -- for id,bp in all_blueprints.Unit do
    end -- function ModBlueprints(all_blueprints)
