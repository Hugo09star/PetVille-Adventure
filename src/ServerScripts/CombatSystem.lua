-- PetVille Adventure - Combat System
-- Sistema de combate por turnos

local CombatSystem = {}
local Constants = require(game.ServerScriptService:WaitForChild("Constants"))

-- ==================== ESTRUTURA DE COMBATE ====================
local CombatState = {
	petOne = nil,
	petTwo = nil,
	turn = 1,
	currentPlayer = 1,
	isActive = false,
	startTime = nil,
	winner = nil,
}

-- ==================== INICIAR COMBATE ====================
function CombatSystem.StartCombat(pet1, pet2)
	if not pet1 or not pet2 then
		return false, "Pets não disponíveis"
	end
	
	local combat = table.clone(CombatState)
	combat.petOne = table.clone(pet1)
	combat.petTwo = table.clone(pet2)
	combat.isActive = true
	combat.startTime = tick()
	
	print("[CombatSystem] Combate iniciado: " .. pet1.name .. " vs " .. pet2.name)
	
	return true, combat
end

-- ==================== CALCULAR DANO ====================
local function CalculateDamage(attacker, defender)
	local baseDamage = attacker.stats.attack
	local randomVariance = math.random(0, 100) / 100
	local variance = 0.8 + (randomVariance * 0.4)
	
	local defenseReduction = defender.stats.defense / 100
	local finalDamage = baseDamage * variance * (1 - defenseReduction)
	
	return math.max(finalDamage, 1)
end

-- ==================== EXECUTAR ATAQUE ====================
function CombatSystem.ExecuteAttack(combat, attackerIndex, abilityName)
	if not combat.isActive then
		return false, "Combate não está ativo"
	end
	
	if combat.currentPlayer ~= attackerIndex then
		return false, "Não é a sua vez"
	end
	
	local attacker = attackerIndex == 1 and combat.petOne or combat.petTwo
	local defender = attackerIndex == 1 and combat.petTwo or combat.petOne
	
	local damage = CalculateDamage(attacker, defender)
	
	if abilityName and attacker.abilities[abilityName] then
		damage = damage * 1.5
	end
	
	defender.health = math.max(defender.health - damage, 0)
	
	if defender.health <= 0 then
		combat.winner = attackerIndex
		combat.isActive = false
		return true, {
			success = true,
			damage = damage,
			combatOver = true,
			winner = attacker.name,
		}
	end
	
	combat.currentPlayer = attackerIndex == 1 and 2 or 1
	combat.turn = combat.turn + 1
	
	return true, {
		success = true,
		damage = damage,
		combatOver = false,
	}
end

-- ==================== DEFENDER ====================
function CombatSystem.Defend(combat, playerIndex)
	local pet = playerIndex == 1 and combat.petOne or combat.petTwo
	
	pet.stats.defense = pet.stats.defense * 1.5
	
	task.delay(Constants.Combat.TURN_TIME, function()
		pet.stats.defense = pet.stats.defense / 1.5
	end)
	
	combat.currentPlayer = playerIndex == 1 and 2 or 1
	combat.turn = combat.turn + 1
	
	return true, {success = true, defended = true}
end

-- ==================== FINALIZAR COMBATE ====================
function CombatSystem.EndCombat(combat, winner)
	combat.isActive = false
	combat.winner = winner
	
	local reward = Constants.XPRewards.COMBAT_WIN
	
	print("[CombatSystem] Combate finalizado")
	
	return {
		winner = winner,
		xpReward = reward,
		duration = tick() - combat.startTime,
	}
end

return CombatSystem