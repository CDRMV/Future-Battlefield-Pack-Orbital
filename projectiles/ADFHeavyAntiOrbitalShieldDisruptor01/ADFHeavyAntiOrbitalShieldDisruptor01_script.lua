#
# Aeon sonic 'bolt'
#
local AHAntiOrbitalShieldDisruptorProjectile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOprojectiles.lua').AHAntiOrbitalShieldDisruptorProjectile
ADFHeavyAntiOrbitalShieldDisruptor01 = Class(AHAntiOrbitalShieldDisruptorProjectile) {

		OnImpact = function(self, TargetType, TargetEntity)
			AHAntiOrbitalShieldDisruptorProjectile.OnImpact(self, TargetType, TargetEntity)
			if TargetType == 'Shield' then
			    if self.Data > TargetEntity:GetHealth() then
			        Damage(self, {0,0,0}, TargetEntity, TargetEntity:GetHealth(), 'Normal')
			    else
					Damage(self, {0,0,0}, TargetEntity, self.Data, 'Normal')
		        end
			end				
		end,
}

TypeClass = ADFHeavyAntiOrbitalShieldDisruptor01

