## 🏏 Cricket Card Strategy League (CCSL)

Cricket Card Strategy League (CCSL) is a **turn-based strategy cricket game** built in **Flutter** that fuses cricket gameplay with card-based logic. Designed to be quick, competitive, and smart — it's more than a game: it's a mental match.

# Project Status : ---IN PROGRESS---

---

### 🎮 Game Overview

Players compete as **batsman and bowler** using cards numbered `0, 1, 2, 3, 4, 6`. Based on chosen formats (1, 2, or 3 overs), players use strategy, bluffing, and predictive logic to outplay opponents.

> Inspired by both cricket tactics and game theory, CCSL turns cricket into a card-based mind game.

---

### 📱 UI Preview

![CCSL UI](https://github.com/the-madhankumar/CCSL/blob/main/INFO/DOCS/UI.png)

---

### 🧠 Key Features

* ⚡ Strategic card play: trap modes, hidden cards, and bluffing
* 🎯 Real-time logic processing with animated UI
* 🎨 Custom-designed UI with bouncing, fading, and tap interactions
* 🔁 Multi-phase turns (select, reveal, result)
* 💾 Stateless and stateful widget management

---

### 🔧 Tech Stack

| Layer       | Tech Used                      |
| ----------- | ------------------------------ |
| Frontend    | Flutter (Dart)                 |
| UI Design   | Google Fonts, Animated Widgets |
| State Logic | Stateful Widgets, Local State  |
| Deployment  | Android/iOS ready              |

---

### 📊 Game Logic Breakdown

| Logic Feature        | Summary Description                                  |
| -------------------- | ---------------------------------------------------- |
| Turn Engine          | State machine handling player moves and transitions  |
| Trap Mode            | Pre-set trap values trigger OUT when matched         |
| Cooldown Enforcement | Prevents repetitive use of power card `6`            |
| Run Streak Bonus     | Sliding window tracks 4 consecutive runs for a boost |
| No Ball + Free Hit   | Bowler repeats → auto run + special next turn        |
| Hidden Card Mechanic | One-use concealed card with opponent guess           |
| Defense Mode         | Temporarily weakens power cards                      |
| Anticipation Bonus   | Predictive gameplay rewards correct guesses          |

---

### 🧮 Data Structures & DSA

| Structure         | Use Case                           |
| ----------------- | ---------------------------------- |
| `List<int>`       | Card history, recent plays         |
| `Set<int>`        | Trap card detection                |
| `Map<String,int>` | Track stats (runs, wickets, usage) |
| `Queue<String>`   | Turn processing per player         |
| `Stack<String>`   | (Optional) Undo or replay system   |

---

### 📘 Rule Book

Official rule book is available here: [📖 View Official Rule Book (PDF)](https://github.com/the-madhankumar/CCSL/blob/main/INFO/DOCS/CCSL%20RULE%20BOOK.pdf)

Includes detailed rules for:

* Overs, innings, match flow
* Batting/bowling power mechanics
* Victory, tie-breakers, and special moves

---

### 🚀 How to Run

1. Clone the repository:

   ```bash
   git clone https://github.com/the-madhankumar/ccsl.git
   cd ccsl
   ```
2. Install dependencies:

   ```bash
   flutter pub get
   ```
3. Run the app:

   ```bash
   flutter run
   ```

---

### 🧑‍💻 Made By

* **Madhan Kumar M.** – Game logic, animations, architecture
* **Vignesh S.** – UI Design, gameplay mechanics, testing

> 🎯 We built this project to blend data structures with interactive gameplay and showcase both technical skills and design talent.

---

### 🌟 What Makes This Stand Out?

* Smart application of **DSA and game logic**
* Interactive animations for better UX
* Scalable and clean Flutter code
* Designed for both mobile platforms
* Industry-ready project that demonstrates teamwork, UI sense, and algorithmic thinking

---

Absolutely, Madhan! Here's the same **Reinforcement Learning Summary** converted into **Markdown** format for your `README.md` file:

---
# 🏏 CCSL Bot — Reinforcement Learning Summary

This bot uses a **lightweight Q-learning algorithm** to simulate strategic card selection in the Cricket Card Strategy League (CCSL).

---

## 🎯 Problem Setting

- **Game**: Turn-based card game where players play `0`, `1`, `2`, `3`, `4`, or `6`.
- **Goal**: Choose the best card for each situation to maximize total runs.
- **Constraints**: Real-world rules like cooldowns, free hit, and power card usage.

### 🧩 State Representation (Compressed)

The state is compressed into 4 key parameters:

| Parameter | Description                      | Values       |
|-----------|----------------------------------|--------------|
| `T`       | Turn number                      | 1 to 6       |
| `P`       | Power cards left (4 or 6)        | 0, 1, or 2   |
| `C`       | Cooldown active (post-6 penalty) | 0 or 1       |
| `F`       | Free hit active                  | 0 or 1       |

The combined format looks like:  
``T{n}_P{n}_C{n}_F{n}``

### 🎬 Action Space

The bot can play one of the following cards:
```

\[0, 1, 2, 3, 4, 6]

```

---

## 🤖 Reinforcement Learning Method: Q-Learning

Q-Learning updates a Q-table of expected rewards based on:

```

Q(s, a) ← Q(s, a) + α * (reward + γ * max(Q(s’, a’)) - Q(s, a))

````

Where:
- `Q(s, a)`: Current Q-value for state `s` and action `a`
- `α (alpha)`: Learning rate (how much we trust new info)
- `γ (gamma)`: Discount factor (importance of future rewards)
- `s'`: Next state
- `a'`: Next best action

---

## 📦 Q-Table Format (Firebase or Local JSON)

Each key is a game state like: `"T3_P1_C1_F0"`

Each value is a map of possible card actions and their learned Q-values:

```json
{
  "T3_P1_C1_F0": {
    "0": 1.0,
    "1": 1.4,
    "2": 2.1,
    "3": 1.3,
    "4": 0.9,
    "6": -5.0
  }
}
````

---

## 🧠 Runtime Flow

1. Game context is mapped to a current state key.
2. Bot selects the action with the highest Q-value from the Q-table.
3. Game engine enforces rules (cooldowns, power usage limits, etc).
4. Bot is trained offline and Q-table updated as needed.

---

## 🧰 Benefits

* ✅ Lightweight and fast
* ✅ Firebase/JSON friendly
* ✅ Expandable to more rules or deeper states
* ✅ Easy to plug into Dart or Flutter apps

---


