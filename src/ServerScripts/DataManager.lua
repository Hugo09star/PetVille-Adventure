-- PetVille Adventure - Data Manager
-- Gerencia salvamento e carregamento de dados do jogador

local DataManager = {}
local Constants = require(game.ServerScriptService:WaitForChild("Constants"))

local PlayerData = {}

-- ==================== ESTRUTURA DE DADOS ====================
local PlayerDataTemplate = {
	userId = nil,
	username = nil,
	level = 1,
	experience = 0,
	coins = 500,
	gems = 10,
	pets = {},
	activePet = nil,
	quests = {},
	completedQuests = {},
	inventory = {},
	lastSave = nil,
}

-- ==================== CRIAR NOVO JOGADOR ====================
function DataManager.CreatePlayerData(userId, username)
	local playerData = table.clone(PlayerDataTemplate)
	playerData.userId = userId
	playerData.username = username
	playerData.lastSave = tick()
	
	PlayerData[userId] = playerData
	
	print("[DataManager] Novo jogador criado: " .. username)
	
	return playerData
end

-- ==================== CARREGAR DADOS ====================
function DataManager.LoadPlayerData(userId)
	if PlayerData[userId] then
		return PlayerData[userId]
	end
	
	return DataManager.CreatePlayerData(userId, "Player_" .. userId)
end

-- ==================== SALVAR DADOS ====================
function DataManager.SavePlayerData(userId)
	if not PlayerData[userId] then
		return false, "Jogador não encontrado"
	end
	
	PlayerData[userId].lastSave = tick()
	
	print("[DataManager] Dados salvos para: " .. PlayerData[userId].username)
	
	return true
end

-- ==================== ADICIONAR PET ====================
function DataManager.AddPet(userId, pet)
	local playerData = DataManager.LoadPlayerData(userId)
	
	if not playerData.pets then
		playerData.pets = {}
	end
	
	table.insert(playerData.pets, pet)
	
	if not playerData.activePet then
		playerData.activePet = pet.id
	end
	
	return true
end

-- ==================== GET PET ATIVO ====================
function DataManager.GetActivePet(userId)
	local playerData = DataManager.LoadPlayerData(userId)
	
	if not playerData.activePet then
		return nil
	end
	
	for _, pet in ipairs(playerData.pets) do
		if pet.id == playerData.activePet then
			return pet
		end
	end
	
	return nil
end

-- ==================== ADICIONAR MOEDAS ====================
function DataManager.AddCoins(userId, amount)
	local playerData = DataManager.LoadPlayerData(userId)
	playerData.coins = playerData.coins + amount
	return playerData.coins
end

-- ==================== REMOVER MOEDAS ====================
function DataManager.RemoveCoins(userId, amount)
	local playerData = DataManager.LoadPlayerData(userId)
	
	if playerData.coins < amount then
		return false, "Moedas insuficientes"
	end
	
	playerData.coins = playerData.coins - amount
	return true
end

-- ==================== OBTER INFO DO JOGADOR ====================
function DataManager.GetPlayerInfo(userId)
	local playerData = DataManager.LoadPlayerData(userId)
	
	return {
		userId = playerData.userId,
		username = playerData.username,
		level = playerData.level,
		coins = playerData.coins,
		gems = playerData.gems,
		petCount = #playerData.pets,
		activePetId = playerData.activePet,
		lastSave = playerData.lastSave,
	}
end

return DataManager