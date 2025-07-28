# 🏏 CCSL – Cricket Card Strategy League (BOT Edition)

Welcome to **CCSL**, a unique turn-based cricket card game that blends strategic decision-making with the thrilling unpredictability of cricket. In this **BOT Edition**, players compete against an AI-powered opponent in tactical battles using numbered cards that mimic cricket actions — all within a sleek, intuitive UI.

---

## 🎮 About the Game

**Cricket meets Cards.** Each turn is a ball. Each card is a decision. Will you score a 6 or get OUT?

- 📦 Built with **Flutter (Dart)**
- 🤖 Integrated with **Q-Learning-based AI BOT**
- 🎨 UI & animation-driven gameplay with multiple innings and modes
- 🔄 Supports **single-player mode** against intelligent BOT logic

---

## 🚀 Features

### 🧠 BOT Gameplay
- Trained using **Q-learning** algorithm.
- Learns optimal card strategies based on reward-punishment feedback.
- Reacts to player behavior dynamically.

### 🃏 Strategic Card Play
- Cards: `0`, `1`, `2`, `3`, `4`, `6`
- Power Cards (`4`, `6`) limited per over with cooldowns
- Hidden Card Mechanic: BOT guesses your move once per innings
- Run Streak Bonus, Strategic Pass, Anticipation Bonus

### 🏏 Bowling Logic
- BOT sets traps, uses Defense Mode, and enforces No Ball rules
- Power Blocker and Field Shift active based on match format

### 🎯 Game Formats
- 1 Over: Fast-paced (6 balls)
- 2+ Overs: Extended strategic battles
- Custom: User-defined format options
- Super Over: Tiebreaker for drawn matches

---

## 📘 Official Rule Book (BOT-Optimized)

### Batsman Tools:
- **Power Cards**: Max usage limits (2 in 1-over, 4 in 2-over, etc.)
- **Hidden Card**: Play face-down card, BOT guesses (bonus if incorrect)
- **Cooldown Rule**: Can’t use 6 again for next 2 balls
- **Run Streak Bonus**: Every 4 consecutive scoring shots doubles the next
- **Strategic Pass**: Once per innings, skip without getting out
- **Anticipation Bonus**: Predict BOT’s card once to earn +2 runs

### Bowler (BOT) Tools:
- **No Ball**: Repeating card = +1 run + Free Hit
- **Defense Mode**: Halves batsman’s 4s/6s for 3 balls (once per over)
- **Trap Mode**: One-time trap cards cause instant OUT
- **Field Shift**: Forces even-numbered plays (0, 2, 4, 6)
- **Power Blocker**: Nullifies 4/6 if matched (based on overs)

### Match End:
- Match ends when target is chased or innings complete.
- Draws resolved via optional **Super Over**.

---

## 📱 Screenshots

![CCSL UI](https://github.com/the-madhankumar/CCSL/blob/main/INFO/DOCS/UI.png)

### 📘 Rule Book

Official rule book is available here: [📖 View Official Rule Book (PDF)](https://github.com/the-madhankumar/CCSL/blob/main/INFO/DOCS/rule.pdf)

> _(Include relevant in-game screenshots here to showcase UI, card play, scoreboard, etc.)_

---

## 🔧 Technical Stack

- **Flutter (Dart)**
- **State Management**: SetState & Custom Controllers
- **AI Logic**: Q-learning (offline trained policy)
- **UI Toolkit**: Custom animations, gradients, dark mode
- **Storage**: Local (SharedPreferences or Hive optional)


---

## 👥 Contributors

- **🧑‍💻 Madhan Kumar M.**  
  *Lead AI Engineer & Gameplay Architect*  
  Developed the complete gameplay architecture, Q-learning logic, innings transitions, and animation control for AI-driven card simulation.

- **🎨 Vignesh S.**  
  *Principal UI/UX Designer & Gameplay Integration Specialist*  
  Designed and integrated the user experience components, including card selector, HUD panel, mode transitions, and testing feedback loops.

---

## 📜 License

This project is licensed under the MIT License.  
You are free to fork, enhance, or customize CCSL for personal or academic use.

---

## 🎯 Future Enhancements

- Multiplayer Firebase support (PvP mode)
- AI difficulty modes (Easy, Pro, Brutal)
- Tournaments and Leaderboards
- Voice-over commentary and match replays

---

## 🙌 Acknowledgments

- Special thanks to **Flutter**, **Syncfusion**, and **Google Fonts**
- Inspired by real-world cricket dynamics and tactical card games

---

**Play smart. Think like a captain. Win like a strategist.**  
🔥 _CCSL – Where Every Card Counts._
