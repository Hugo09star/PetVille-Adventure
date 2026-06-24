-- PetVille Adventure - Pet System
-- Gerencia criação, evolução e habilidades de pets

local PetSystem = {}
local Constants = require(game.ServerScriptService:WaitForChild("Constants"))

-- ==================== ESTRUTURA DE PET ====================
local PetTemplate = {
	id = nil,
	type = nil,
	name = nil,
	level = 1,
	experience = 0,
	health = 100,
	maxHealth = 100,
	hunger = 100,
	happiness = 100,
	evolution = 1,
	abilities = {},
	stats = {
		attack = 10,
		defense = 10,
		speed = 10,
	},
	lastFedTime = 0,
	lastPlayedTime = 0,
}

-- ==================== CRIAR PET ====================
function PetSystem.CreatePet(playerUserId, petType, petName)
	local pet = table.clone(PetTemplate)
	
	pet.id = game.HttpService:GenerateGUID(false)
	pet.type = petType
	pet.name = petName or petType
	pet.abilities = table.clone(Constants.PetAbilities[petType] or {})
	
	-- Configurar stats baseado no tipo
	if petType == Constants.PetTypes.DRAGON then
		pet.stats.attack = 15
		pet.stats.defense = 12
		pet.stats.speed = 14
		pet.maxHealth = 150
	elseif petType == Constants.PetTypes.DOG then
		pet.stats.attack = 12
		pet.stats.defense = 11
		pet.stats.speed = 16
	elseif petType == Constants.PetTypes.CAT then
		pet.stats.attack = 13
		pet.stats.defense = 9
		pet.stats.speed = 18
	end
	
	pet.health = pet.maxHealth
	
	return pet
end

-- ==================== ADICIONAR EXPERIÊNCIA ====================
function PetSystem.AddExperience(pet, amount)
	pet.experience = pet.experience + amount
	
	-- Calcular novo nível
	local xpNeeded = Constants.LevelSystem.XP_PER_LEVEL * (1.1 ^ (pet.level - 1))
	
	if pet.experience >= xpNeeded then
		PetSystem.LevelUp(pet)
	end
	
	return pet
end

-- ==================== SUBIR DE NÍVEL ====================
function PetSystem.LevelUp(pet)
	if pet.level >= Constants.LevelSystem.MAX_LEVEL then
		return pet
	end
	
	pet.level = pet.level + 1
	pet.experience = 0
	
	-- Aumentar stats
	pet.stats.attack = pet.stats.attack + 2
	pet.stats.defense = pet.stats.defense + 1
	pet.stats.speed = pet.stats.speed + 1
	pet.maxHealth = pet.maxHealth + 10
	pet.health = pet.maxHealth
	
	-- Verificar evolução
	for _, evolutionLevel in ipairs(Constants.LevelSystem.EVOLUTION_LEVELS) do
		if pet.level == evolutionLevel then
			PetSystem.EvolveePet(pet)
		end
	end
	
	return pet
end

-- ==================== EVOLUIR PET ====================
function PetSystem.EvolveePet(pet)
	pet.evolution = pet.evolution + 1
	
	-- Aumentos de evolução
	pet.stats.attack = pet.stats.attack * 1.2
	pet.stats.defense = pet.stats.defense * 1.2
	pet.stats.speed = pet.stats.speed * 1.2
	pet.maxHealth = pet.maxHealth * 1.3
	pet.health = pet.maxHealth
	
	print("[PetSystem] " .. pet.name .. " evoluiu para forma " .. pet.evolution .. "!")
	
	return pet
end

-- ==================== ALIMENTAR PET ====================
function PetSystem.FeedPet(pet)
	pet.hunger = math.min(pet.hunger + 30, 100)
	pet.happiness = math.min(pet.happiness + 10, 100)
	pet.lastFedTime = tick()
	
	-- Recupera HP quando alimentado
	pet.health = math.min(pet.health + 15, pet.maxHealth)
	
	return pet
end

-- ==================== BRINCAR COM PET ====================
function PetSystem.PlayWithPet(pet)
	pet.happiness = math.min(pet.happiness + 25, 100)
	pet.hunger = math.max(pet.hunger - 10, 0)
	pet.lastPlayedTime = tick()
	
	return pet
end

-- ==================== DANIFICAR PET ====================
function PetSystem.TakeDamage(pet, damage)
	pet.health = math.max(pet.health - damage, 0)
	
	if pet.health == 0 then
		return true
	end
	
	return false
end

-- ==================== CURAR PET ====================
function PetSystem.Heal(pet, amount)
	pet.health = math.min(pet.health + amount, pet.maxHealth)
	return pet
end

-- ==================== GET INFO ====================
function PetSystem.GetPetInfo(pet)
	return {
		id = pet.id,
		type = pet.type,
		name = pet.name,
		level = pet.level,
		experience = pet.experience,
		health = pet.health,
		maxHealth = pet.maxHealth,
		hunger = pet.hunger,
		happiness = pet.happiness,
		evolution = pet.evolution,
		stats = pet.stats,
	}
end

return PetSystem