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

