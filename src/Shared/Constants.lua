-- PetVille Adventure - Constantes Globais
-- Arquivo compartilhado entre servidor e cliente

local Constants = {}

-- ==================== PET TYPES ====================
Constants.PetTypes = {
	DRAGON = "Dragon",
	DOG = "Dog",
	CAT = "Cat",
	RABBIT = "Rabbit",
	BIRD = "Bird",
	WOLF = "Wolf",
}

-- ==================== PET ABILITIES ====================
Constants.PetAbilities = {
	Dragon = {
		name = "Voar",
		description = "Voa alto no céu",
		cooldown = 10,
		duration = 5,
	},
	Dog = {
		name = "Corrida Rápida",
		description = "Corre 2x mais rápido",
		cooldown = 15,
		duration = 8,
	},
	Cat = {
		name = "Salto Alto",
		description = "Salta muito mais alto",
		cooldown = 8,
		duration = 3,
	},
	Rabbit = {
		name = "Super Pulo",
		description = "Pula 3x mais alto",
		cooldown = 12,
		duration = 4,
	},
	Bird = {
		name = "Voo Rápido",
		description = "Voa rapidamente",
		cooldown = 10,
		duration = 6,
	},
	Wolf = {
		name = "Sentidos Aguçados",
		description = "Detecta itens raros",
		cooldown = 20,
		duration = 10,
	},
}

-- ==================== WORLD AREAS ====================
Constants.Areas = {
	FOREST = "Forest",
	CITY = "City",
	CAVE = "SecretCave",
	PORTAL = "Portal",
	HOME = "Home",
}

-- ==================== QUEST TYPES ====================
Constants.QuestTypes = {
	FIND_ITEM = "FindItem",
	DEFEAT_ENEMY = "DefeatEnemy",
	HELP_NPC = "HelpNPC",
	EXPLORE = "Explore",
	COLLECT = "Collect",
}

-- ==================== XP REWARDS ====================
Constants.XPRewards = {
	QUEST_COMPLETE = 100,
	COMBAT_WIN = 50,
	EXPLORE_AREA = 25,
	FIND_TREASURE = 75,
	LEVEL_UP_BONUS = 200,
}

-- ==================== LEVEL SYSTEM ====================
Constants.LevelSystem = {
	MAX_LEVEL = 100,
	XP_PER_LEVEL = 1000,
	EVOLUTION_LEVELS = {10, 25, 50, 75, 100},
}

-- ==================== ITEMS ====================
Constants.Items = {
	FOOD = "Food",
	POTION = "Potion",
	TREASURE = "Treasure",
	CRYSTAL = "Crystal",
	GEM = "Gem",
}

-- ==================== COMBAT ====================
Constants.Combat = {
	BASE_DAMAGE = 10,
	BASE_HEALTH = 100,
	COMBAT_DURATION = 30,
	TURN_TIME = 3,
}

-- ==================== CURRENCIES ====================
Constants.Currencies = {
	COINS = "Coins",
	GEMS = "Gems",
	CRYSTALS = "Crystals",
}

-- ==================== TIME SETTINGS ====================
Constants.Time = {
	QUEST_TIMEOUT = 600,
	SAVE_INTERVAL = 60,
	RESPAWN_TIME = 30,
}

-- ==================== COLORS ====================
Constants.Colors = {
	PRIMARY = Color3.fromRGB(100, 200, 255),
	SUCCESS = Color3.fromRGB(0, 255, 100),
	DANGER = Color3.fromRGB(255, 50, 50),
	WARNING = Color3.fromRGB(255, 200, 0),
	INFO = Color3.fromRGB(100, 150, 255),
}

return Constants