# 🃏 SwiftUI CardGame

## 🔍 Overview
The **SwiftUI Card Battle Game** is a simple, fast-paced iOS game developed using **SwiftUI**.  
In this game, a player competes against a computer opponent in a **10-round card battle**, where each round is governed by a **5-second countdown timer**.

Each round, both players draw a random card. The higher card wins the round, and the scores are tracked throughout the game. At the end, the game displays a **summary screen** with final results.

---

## ✨ Features

✅ **Timed Gameplay** – Each round starts after a visible 5-second countdown.  
✅ **Randomized Card Drawing** – Every round uses random cards from a predefined set.  
✅ **Score Tracking** – Displays live score updates for both player and opponent.  
✅ **Dark Mode Support** – Switch themes dynamically during gameplay.  
✅ **Summary Screen** – After 10 rounds, results are shown in a final view.  


---

## 🕹️ How It Works

1. When the game starts, the `GameView` launches a **5-second countdown**.
2. Once the countdown reaches 0:
   - Both the player and the opponent **draw a random card**.
   - Cards are compared using a **predefined strength value**.
   - The winner gets **+1 point**.
3. Cards are cleared after 2 seconds, and the countdown **resets for the next round**.
4. This repeats for **10 rounds**.
5. After the final round, the app navigates to `SummaryView`, which shows:
   - Final score
   - Winner declaration
6. A **Dark Mode toggle** is available throughout the game.


### 💻 Instructions

1. Clone or download the project.
2. Open the `.xcodeproj` or `.xcworkspace` in **Xcode**.
3. Build and run on an **iOS Simulator** or a **physical device**.
4. Enter your player name and choose your side (if available).
5. Start playing and enjoy 10 action-packed rounds!




