# 🎮 Design Document - PetVille Adventure

## Visão Geral

**PetVille Adventure** é um jogo Roblox que combina **Adopt Me** (cuidar de pets) com **RPG de Aventura** (exploração e missões).

## Objetivos Principais

1. ✅ Oferecer experiência única de cuidar e aventurar com pets
2. ✅ Sistema de progressão profundo (leveling, evolução)
3. ✅ Mundo aberto explorável com múltiplas áreas
4. ✅ Sistema de combate por turnos equilibrado
5. ✅ Economia de jogo robusta (moedas, gemas, itens)

## Pilares de Design

### 1. **Pets com Personalidade**
- Cada tipo tem habilidades únicas
- Pets ganham experiência e evoluem
- Relação emocional (fome, felicidade)

### 2. **Exploração Recompensadora**
- 4 áreas principais + portais secretos
- Tesouro escondido em locais específicos
- NPCs com quests variadas

### 3. **Progressão Significativa**
- Leveling crescente (cap: 100)
- Evoluções em marcos específicos
- Upgrades de casa

### 4. **Combate Estratégico**
- Sistema por turnos
- Tipo de habilidades importa
- Risk vs Reward

## Mecânicas Principais

### Pet System
```
Pet {
  Tipo: Dragon, Dog, Cat, Rabbit, Bird, Wolf
  Level: 1-100 (com exponential XP)
  Evolução: 5 formas diferentes
  Stats: Attack, Defense, Speed
  Habilidades: Únicas por tipo
  Necessidades: Fome, Felicidade
}
```

### Quest System
```
Tipos de Quests:
- FindItem: Procure itens no mapa
- Explore: Visite novas áreas
- DefeatEnemy: Vença combates
- HelpNPC: Ajude personagens
- Collect: Colecione recursos
```

### Combat System
```
Mecânica:
- Por turnos
- 2 pets se enfrentam
- Ações: Ataque, Habilidade, Defender
- Vencedor ganha XP
```

## Progressão de Nível

| Nível | XP Necessária | Evento |
|-------|---------------|--------|
| 1-10  | 1000 cada     | Primeira Evolução |
| 11-25 | 1100 cada     | Segunda Evolução |
| 26-50 | 1210 cada     | Terceira Evolução |
| 51-75 | 1331 cada     | Quarta Evolução |
| 76-100| 1464 cada     | Evolução Final |

## Áreas do Mapa

### 🌲 Floresta
- Recursos: Maçãs, Flores, Pedras
- NPCs: Colhedor, Alquimista
- Perigos: Animais fracos

### 🏙️ Cidade
- Comerciantes
- Ferreiro (upgrades)
- Pouso seguro

### 🕳️ Caverna Secreta
- Boss único
- Tesouro épico
- Entrada escondida

### 🚀 Portais
- Mundos alternativos
- Eventos especiais
- Mobs únicos

## Economia

### Moedas (Coins)
- Moeda padrão
- Obtida por quests, vendas, combates
- Usada em compras simples

### Gemas (Gems)
- Moeda premium
- Mais rara
- Upgrades especiais

### Itens
- Comida, Poções, Cristais
- Recursos para crafting
- Decorações

## Balanceamento

### XP por Atividade
- Quest fácil: 50 XP
- Quest normal: 100 XP
- Quest difícil: 200 XP
- Combate vencido: 50 XP
- Exploração: 25 XP

### Dano em Combate
```
Damage = (Attacker.Attack * Variance) * (1 - Defender.Defense/100)
Variance = 0.8 - 1.2 (aleatório)
Habilidade = Dano * 1.5
```

## Futuras Expansões

- 🔄 Trading entre jogadores
- 👥 Clãs/Guildas
- 🏆 Ranking PvP
- 🌍 Mais áreas
- 🎭 Sistema de aparência customizável
- 🎵 Eventos sazonais

---

**Última atualização:** Junho 2026