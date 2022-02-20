#****************************************************************************
#**
#**  File     :  /cdimage/units/URB0302/URB0302_script.lua
#**  Author(s):  David Tomandl
#**
#**  Summary  :  Cybran Tier 3 Air Unit Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ARingplatformUnit = import('/lua/aeonunits.lua').ARingplatformUnit

UABRT100 = Class(ARingplatformUnit) {
	
    StartArmsMoving = function(self)
        ARingplatformUnit.StartArmsMoving(self)
        if not self.ArmSlider1 then
            self.ArmSlider1 = CreateSlider(self, 'B01')
            self.Trash:Add(self.ArmSlider1)
        end
        if not self.ArmSlider2 then
            self.ArmSlider2 = CreateSlider(self, 'B02')
            self.Trash:Add(self.ArmSlider2)
        end
        if not self.ArmSlider3 then
            self.ArmSlider3 = CreateSlider(self, 'B03')
            self.Trash:Add(self.ArmSlider3)
        end
		if not self.ArmSlider4 then
            self.ArmSlider4 = CreateSlider(self, 'B04')
            self.Trash:Add(self.ArmSlider4)
        end
		if not self.ArmSlider5 then
            self.ArmSlider5 = CreateSlider(self, 'B05')
            self.Trash:Add(self.ArmSlider4)
        end
    end,

    MovingArmsThread = function(self)
        ARingplatformUnit.MovingArmsThread(self)
        local dir = 1
        while true do
            if not self.ArmSlider1 then return end
            if not self.ArmSlider2 then return end
            if not self.ArmSlider3 then return end
			if not self.ArmSlider4 then return end
			if not self.ArmSlider5 then return end
			self.ArmSlider1:SetGoal(0, 0.6, 0)
			WaitSeconds(0.5)
			self.ArmSlider2:SetGoal(0, 0.5, 0)
			WaitSeconds(0.5)
			self.ArmSlider3:SetGoal(0, 0.4, 0)
			WaitSeconds(0.5)
			self.ArmSlider4:SetGoal(0, 0.3, 0)
			WaitSeconds(0.5)
			self.ArmSlider5:SetGoal(0, 0.2, 0)
			self.ArmSlider1:SetSpeed(2)
			self.ArmSlider2:SetSpeed(2)
			self.ArmSlider3:SetSpeed(2)
			self.ArmSlider4:SetSpeed(2)
			self.ArmSlider5:SetSpeed(2)
            WaitFor(self.ArmSlider5)
            dir = dir * -1
        end
    end,
    
    StopArmsMoving = function(self)
        ARingplatformUnit.StopArmsMoving(self)
        self.ArmSlider1:SetGoal(0, 0, 0)
        self.ArmSlider2:SetGoal(0, 0, 0)
        self.ArmSlider3:SetGoal(0, 0, 0)
		self.ArmSlider4:SetGoal(0, 0, 0)
		self.ArmSlider5:SetGoal(0, 0, 0)
        self.ArmSlider1:SetSpeed(2)
        self.ArmSlider2:SetSpeed(2)
        self.ArmSlider3:SetSpeed(2)
		self.ArmSlider4:SetSpeed(2)
		self.ArmSlider5:SetSpeed(2)
    end,
}

TypeClass = UABRT100