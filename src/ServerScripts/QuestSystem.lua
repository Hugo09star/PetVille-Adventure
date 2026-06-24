-- PetVille Adventure - Quest System
-- Gerencia missões e recompensas

local QuestSystem = {}
local Constants = require(game.ServerScriptService:WaitForChild("Constants"))

-- ==================== ESTRUTURA DE MISSÃO ====================
local QuestTemplate = {
	id = nil,
	questType = nil,
	title = nil,
	description = nil,
	reward = {
		xp = 0,
		coins = 0,
		items = {},
	},
	progress = 0,
	progressMax = 1,
	completed = false,
	completedTime = nil,
	difficulty = "Normal",
}

-- ==================== MISSÕES PADRÃO ====================
local DefaultQuests = {
	{
		title = "Encontrar 5 Moedas",
		description = "Procure por moedas na floresta",
		questType = "FindItem",
		progressMax = 5,
		reward = {xp = 50, coins = 100},
		difficulty = "Easy",
	},
	{
		title = "Explorar a Caverna Secreta",
		description = "Encontre a entrada da caverna escondida",
		questType = "Explore",
		progressMax = 1,
		reward = {xp = 100, coins = 200},
		difficulty = "Hard",
	},
	{
		title = "Ajudar o Ferreiro",
		description = "O ferreiro da cidade precisa de cristais",
		questType = "HelpNPC",
		progressMax = 3,
		reward = {xp = 75, coins = 150},
		difficulty = "Normal",
	},
}

-- ==================== CRIAR MISSÃO ====================
function QuestSystem.CreateQuest(questType)
	local questData = nil
	
	for _, q in ipairs(DefaultQuests) do
		if q.questType == questType then
			questData = table.clone(q)
			break
		end
	end
	
	if not questData then
		return nil
	end
	
	local quest = table.clone(QuestTemplate)
	quest.id = game.HttpService:GenerateGUID(false)
	quest.questType = questData.questType
	quest.title = questData.title
	quest.description = questData.description
	quest.progressMax = questData.progressMax
	quest.reward = questData.reward
	quest.difficulty = questData.difficulty
	
	return quest
end

-- ==================== ATUALIZAR PROGRESSO ====================
function QuestSystem.UpdateProgress(quest, amount)
	if quest.completed then
		return false, "Missão já completada"
	end
	
	quest.progress = math.min(quest.progress + amount, quest.progressMax)
	
	if quest.progress >= quest.progressMax then
		return QuestSystem.CompleteQuest(quest)
	end
	
	return true, quest
end

-- ==================== COMPLETAR MISSÃO ====================
function QuestSystem.CompleteQuest(quest)
	if quest.completed then
		return false, "Missão já completada"
	end
	
	quest.completed = true
	quest.completedTime = tick()
	
	print("[QuestSystem] Missão completada: " .. quest.title)
	
	return true, quest.reward
end

-- ==================== GET QUESTS DISPONÍVEIS ====================
function QuestSystem.GetAvailableQuests(amount)
	amount = amount or 3
	local quests = {}
	
	for i = 1, amount do
		local randomIndex = math.random(1, #DefaultQuests)
		local questData = DefaultQuests[randomIndex]
		local quest = QuestSystem.CreateQuest(questData.questType)
		
		if quest then
			table.insert(quests, quest)
		end
	end
	
	return quests
end

return QuestSystem