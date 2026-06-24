# 📚 API Reference

## PetSystem

### CreatePet(playerUserId, petType, petName)
Cria um novo pet para o jogador.

### AddExperience(pet, amount)
Adiciona experiência ao pet.

### LevelUp(pet)
Sobe o nível do pet.

### EvolveePet(pet)
Evolui o pet para a próxima forma.

### FeedPet(pet)
Alimenta o pet (aumenta fome, felicidade, HP).

### PlayWithPet(pet)
Brinca com o pet (aumenta felicidade, diminui fome).

### TakeDamage(pet, damage)
Aplica dano ao pet.

### Heal(pet, amount)
Cura o pet.

---

## QuestSystem

### CreateQuest(questType)
Cria uma nova missão.

### UpdateProgress(quest, amount)
Atualiza progresso da missão.

### CompleteQuest(quest)
Completa a missão.

### GetAvailableQuests(amount)
Retorna missões disponíveis.

---

## CombatSystem

### StartCombat(pet1, pet2)
Inicia um combate entre dois pets.

### ExecuteAttack(combat, attackerIndex, abilityName)
Executa um ataque no combate.

### Defend(combat, playerIndex)
Defende-se no próximo ataque.

### EndCombat(combat, winner)
Finaliza o combate.

---

## DataManager

### LoadPlayerData(userId)
Carrega dados do jogador.

### SavePlayerData(userId)
Salva dados do jogador.

### AddPet(userId, pet)
Adiciona pet ao jogador.

### GetActivePet(userId)
Retorna o pet ativo do jogador.

### AddCoins(userId, amount)
Adiciona moedas.

### RemoveCoins(userId, amount)
Remove moedas.

### GetPlayerInfo(userId)
Retorna informações resumidas do jogador.

---
**Última atualização:** Junho 2026