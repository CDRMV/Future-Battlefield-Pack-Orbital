#
# Aeon sonic 'bolt'
#
local AMAntiOrbitalShieldDisruptorProjectile = import('/mods/Future Battlefield Pack Orbital/lua/FBPOprojectiles.lua').AMAntiOrbitalShieldDisruptorProjectile
ADFMediumAntiOrbitalShieldDisruptor01 = Class(AMAntiOrbitalShieldDisruptorProjectile) {

		OnImpact = function(self, TargetType, TargetEntity)
			AMAntiOrbitalShieldDisruptorProjectile.OnImpact(self, TargetType, TargetEntity)
			if TargetType == 'Shield' then
			    if self.Data > TargetEntity:GetHealth() then
			        Damage(self, {0,0,0}, TargetEntity, TargetEntity:GetHealth(), 'Normal')
			    else
					Damage(self, {0,0,0}, TargetEntity, self.Data, 'Normal')
		        end
			end				
		end,

}

TypeClass = ADFMediumAntiOrbitalShieldDisruptor01

