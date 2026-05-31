# 🕹️ Project Arcade Roblox

> *A portfolio project by San , 10 classic arcade games rebuilt inside a 3D world engine.*

---
Copyright (c) 2025 Sam (Liehel)

This project is licensed under CC BY-NC-ND 4.0.
You may view and study this code freely.
You may NOT distribute, sell, or modify this work
without explicit written permission from the author.

Full license: https://creativecommons.org/licenses/by-nc-nd/4.0/

---
## 🎯 What is this project?

**Project Arcade Roblox** is a game world built inside Roblox Studio where the player can find and play **10 different arcade games**, 7 of them are classic 2D games recreated inside a 3D engine, and the last 3 are original 3D games with multiplayer support.

The main goal of this project is simple: **keep the player inside the world for at least 8 minutes**, moving from game to game instead of leaving after just one. Each game is a mini-arcade machine the player can walk up to and interact with.

> 📄 *Full technical documentation will be uploaded soon in a separate document.*

---

## 🌍 The Idea

Most Roblox games try to keep the player in one activity. This project works differently, it creates a **small arcade world** where every machine is a different challenge. The player is free to try all of them and compete for a top 10 spot on each global leaderboard.

This is also a **portfolio and learning project**, not a commercial game. All donations inside the game go to support a future project called **ANNA**, planned for Unreal Engine.

> ⚠️ **No transactions make the game easier.** All purchases are optional support only.

---
## 🎯 Target Player

This game is made for **casual players** who just want to have a good time.

The ideal player is someone who enjoys wandering around a small world, trying a mini-game for a few minutes, watching other players, or simply exploring the island without any pressure. No ranking stress, no grinding, no complex mechanics to learn.

The project takes inspiration from games like **"Are You OK?"**, where the experience itself is the point, not the competition. A player can spend 8 minutes jumping between arcade machines, or spend those same 8 minutes just walking around the map doing nothing. Both are valid.

**This game is for:**
- 🕹️ Casual players who enjoy simple and fun mini-games
- 🌍 Explorers who like discovering small details in a game world
- 😂 Meme game enjoyers who appreciate weird and charming experiences
- 👀 Observers who just like watching the chaos around them

**This game is NOT for:**
- ❌ Competitive players looking for ranked matches
- ❌ Players who need a deep story or complex progression
- ❌ Speedrunners or min-maxers

## 🎮 The Games

### 2D Classic Games (7 games)

| # | Game Name | Genre / Mechanic | Key Feature |
|---|-----------|-------------|-------------|
| 1 | 🐍 **Oxybelis** | Snake | Circular buffer, O(1) logic |
| 2 | 🐦 **Avis Toucan** | Flappy Bird | Gravity tuning, "game feel" |
| 3 | 🧱 **Resilio** | Arkanoid | Vector reflection, power-ups |
| 4 | 🦊 **Foxy Fruit** | Pac-Man | BFS ghost AI (4 behaviors) |
| 5 | 🚀 **Firmament Defender** | Space Invaders | Swarm logic, shields |
| 6 | ☄️ **Firmament Siege** | Asteroids | Inertia physics, 360° movement |
| 7 | 🍊 **Juice Cutter** | Fruit Ninja | Recipe system, line-segment collision |

---

### 3D Original Games (3 games)

| # | Game Name | Genre / Mechanic | Key Feature |
|---|-----------|-------------|-------------|
| 8 | 🧀 **Turris Casei** | Stack | Block slicing math, multiplayer |
| 9 | 🚀 **Tap And Hold** | Tiao Yi Tiao | Parabolic jump physics, multiplayer |
| 10 | 🔵 **ImNotASphere** | Marble games | Moving platforms, power-ups, multiplayer |

---

## 👥 Multiplayer Private Rooms Only

The multiplayer mode in this game works with **PIN codes only**.

A player cannot join any room unless they have the PIN from someone they already know , a friend, a classmate, or someone they are talking to outside the game. There are no public lobbies and no random matchmaking.

If an unwanted player somehow joins a room, the **room admin can remove them at any time**.

> **Why this design?**
> This game is played by a young audience. Keeping multiplayer private is a deliberate safety decision , not a technical limitation. The goal is that if two players want to compete against each other, they need to actually communicate first and share the PIN themselves.

**How it works in practice:**
- 🔑 One player creates a room and receives a **4-digit PIN**
- 📲 That player shares the PIN outside the game (chat, voice call, message)
- 🚪 Only players with that PIN can enter the room
- 🛡️ The room admin can **kick any player** at any time

This project is not interested in PvP between strangers. If players want to compete, they need to know each other first.
---

## 🏆 Global Leaderboards

Every game has a **Top 10 global scoreboard** powered by Roblox DataStore. Ties are broken by completion time. Scores are saved permanently online.

---

## ⚙️ Technical Notes

```
🗂️ Structure:   ServerScriptService / ReplicatedStorage / StarterPlayer
🔧 Language:    Lua / Luau
🛠️ Sync tool:   Rojo 7.7 (VS Code ↔ Roblox Studio)
📦 Repo:        Source code available in /src folder
🎮 Game file:   ññññññ.rbxl (full compiled game)
```

### ⚠️ If you open the project:

- The **game logic, server scripts, and modules will work correctly**
- The **2D image assets** (like the Avis Toucan bird sprites) may not display, those image IDs are linked to the developer's personal Roblox account
- To run the full game with all visuals, open the `.rbxl` file directly in Roblox Studio

---

## 📁 Repository Structure

```
📦 Project-Arcade-Roblox
 ┣ 📂 src
 ┃ ┣ 📂 server       ← All server-side scripts
 ┃ ┣ 📂 client       ← All local scripts (UI, controls, rendering)
 ┃ ┗ 📂 shared       ← Modules (game logic, physics, leaderboards)
 ┣ 📄 default.project.json   ← Rojo configuration
 ┣ 📄 ññññññ.rbxl            ← Full compiled Roblox game file
 ┗ 📄 README.md
```

---

## 🔮 What Comes Next

This project is the foundation for learning game development. The next step is **Project ANNA** , a larger, original game planned for **Unreal Engine**, using everything learned here about game logic, player retention, and multiplayer systems.

---

## 📊 Current Status

| Area | Progress |
|------|----------|
| 🧠 Game Logic | ![100%](https://img.shields.io/badge/Logic-100%25-brightgreen) |
| 🎮 Gameplay | ![90%](https://img.shields.io/badge/Gameplay-90%25-green) |
| 🎨 Graphics  | ![0%](https://img.shields.io/badge/Graphics-0%25-lightgrey) |
| 📱 Mobile Support | ![100%](https://img.shields.io/badge/Logic-100%25-brightgreen) |
| 🎮 Xbox Support |![100%](https://img.shields.io/badge/Logic-100%25-brightgreen) |
| 🎮 Playstation Support |![100%](https://img.shields.io/badge/Logic-100%25-brightgreen) |


---

<div align="center">

*Made with patience, lots of DataStore debugging, and caffeine.*

**[▶ Play on Roblox](#)** &nbsp;|&nbsp; **[📄 Full Documentation — Coming Soon](#)**

</div>
