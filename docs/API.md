# 📚 API Reference - PetVille Adventure

## PetSystem

### CreatePet(playerUserId, petType, petName)
Cria um novo pet para o jogador.

**Parâmetros:**
- `playerUserId` (string): ID único do jogador
- `petType` (string): Tipo do pet (Dragon, Dog, Cat, Rabbit, Bird, Wolf)
- `petName` (string): Nome customizado do pet

**Retorno:**
```lua
{
  id = "unique-id",
  type = "Dragon",
  name = "Inferno",
  level = 1,
  experience = 0,
  health = 150,
  maxHealth = 150,
  hunger = 100,
  happiness = 100,
  stats = {attack = 15, defense = 12, speed = 14}
}
```

### AddExperience(pet, amount)
Adiciona experiência ao pet.

**Parâmetros:**
- `pet` (table): Objeto do pet
- `amount` (number): Quantidade de XP

**Retorno:**
- `pet` (table): Pet atualizado

### LevelUp(pet)
Sobe o nível do pet (chamado automaticamente).

**Retorno:**
- `pet` (table): Pet com nível aumentado

### EvolveePet(pet)
Evolui o pet para a próxima forma.

**Retorno:**
- `pet` (table): Pet evoluído com stats aumentados

### FeedPet(pet)
Alimenta o pet (aumenta fome, felicidade, HP).

**Retorno:**
- `pet` (table): Pet alimentado

### PlayWithPet(pet)
Brinca com o pet (aumenta felicidade, diminui fome).

**Retorno:**
- `pet` (table): Pet atualizado

### TakeDamage(pet, damage)
Aplica dano ao pet.

**Retorno:**
- `fainted` (boolean): Se o pet desmaiou

### Heal(pet, amount)
Cura o pet.

**Retorno:**
- `pet` (table): Pet curado

---

## QuestSystem

### CreateQuest(questType)
Cria uma nova missão.

**Parâmetros:**
- `questType` (string): Tipo (FindItem, Explore, DefeatEnemy, HelpNPC, Collect)

**Retorno:**
```lua
{
  id = "quest-id",
  title = "Encontrar 5 Moedas",
  description = "Procure moedas na floresta",
  questType = "FindItem",
  progressMax = 5,
  progress = 0,
  reward = {xp = 50, coins = 100},
  difficulty = "Easy"
}
```

### UpdateProgress(quest, amount)
Atualiza progresso da missão.

**Retorno:**
- `success` (boolean)
- `quest` (table ou reward): Missão atualizada ou recompensa

### CompleteQuest(quest)
Completa a missão.

**Retorno:**
- `success` (boolean)
- `reward` (table): Recompensa da missão

### GetAvailableQuests(amount)
Retorna missões disponíveis.

**Retorno:**
- `quests` (table array): Lista de missões

---

## CombatSystem

### StartCombat(pet1, pet2)
Inicia um combate entre dois pets.

**Retorno:**
```lua
{
  petOne = pet1,
  petTwo = pet2,
  turn = 1,
  isActive = true,
  winner = nil
}
```

### ExecuteAttack(combat, attackerIndex, abilityName)
Executa um ataque no combate.

**Parâmetros:**
- `combat` (table): Estado do combate
- `attackerIndex` (number): 1 ou 2
- `abilityName` (string, opcional): Nome da habilidade

**Retorno:**
```lua
{
  success = true,
  damage = 25,
  combatOver = false,
  attackerHP = 125,
  defenderHP = 75
}
```

### Defend(combat, playerIndex)
Defende-se no próximo ataque.

**Retorno:**
- `success` (boolean)
- `info` (table): Informações da defesa

### EndCombat(combat, winner)
Finaliza o combate.

**Retorno:**
```lua
{
  winner = 1,
  xpReward = 50,
  duration = 45.2
}
```

---

## DataManager

### LoadPlayerData(userId)
Carrega dados do jogador.

**Retorno:**
```lua
{
  userId = "123",
  username = "Player",
  level = 1,
  coins = 500,
  gems = 10,
  pets = {},
  activePet = nil,
  inventory = {}
}
```

### SavePlayerData(userId)
Salva dados do jogador.

**Retorno:**
- `success` (boolean)

### AddPet(userId, pet)
Adiciona pet ao jogador.

**Retorno:**
- `success` (boolean)

### GetActivePet(userId)
Retorna o pet ativo do jogador.

### SetActivePet(userId, petId)
Define qual pet é o ativo.

### AddCoins(userId, amount)
Adiciona moedas.

**Retorno:**
- `totalCoins` (number)

### RemoveCoins(userId, amount)
Remove moedas.

**Retorno:**
- `success` (boolean ou message)

### AddInventoryItem(userId, itemType, itemData)
Adiciona item ao inventário.

**Retorno:**
- `success` (boolean)

### CompleteQuest(userId, questId)
Marca quest como completada.

### GetPlayerInfo(userId)
Retorna informações resumidas do jogador.

---

## Constantes (Constants.lua)

```lua
Constants.PetTypes.DRAGON      -- "Dragon"
Constants.PetTypes.DOG         -- "Dog"
Constants.PetTypes.CAT         -- "Cat"

Constants.QuestTypes.FIND_ITEM -- "FindItem"
Constants.QuestTypes.EXPLORE   -- "Explore"

Constants.XPRewards.QUEST_COMPLETE  -- 100
Constants.XPRewards.COMBAT_WIN      -- 50
Constants.XPRewards.EXPLORE_AREA    -- 25

Constants.LevelSystem.MAX_LEVEL     -- 100
Constants.LevelSystem.XP_PER_LEVEL  -- 1000
```

---

**Última atualização:** Junho 2026