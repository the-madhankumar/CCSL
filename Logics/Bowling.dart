class Bowling {
  final int overType; // 1, 2, or 3
  bool fieldShiftUsed = false;
  bool defenseActive = false;
  int defenseBallsRemaining = 0;
  bool powerBlockerUsed = false;
  bool trapUsed = false;
  List<int> trapCards = [];
  List<int> recentBalls = [];
  int noBallCount = 0;
  bool isFreeHit = false;

  Bowling(this.overType);

  // 4.1 – No Ball + Free Hit
  bool checkNoBall(int lastBall, int currentBall) {
    if (lastBall == currentBall) {
      noBallCount++;
      isFreeHit = true;
      return true; 
    }
    isFreeHit = false;
    return false;
  }

  // 4.2 – Defense Mode
  void activateDefenseMode() {
    if (overType >= 2 && !defenseActive) {
      defenseActive = true;
      defenseBallsRemaining = 3;
    }
  }

  int applyDefenseEffect(int batsmanRun) {
    if (!defenseActive) return batsmanRun;

    if (defenseBallsRemaining > 0) {
      defenseBallsRemaining--;
      if (defenseBallsRemaining == 0) {
        defenseActive = false;
      }

      if (batsmanRun == 4 || batsmanRun == 6) {
        return (batsmanRun / 2).floor();
      } else if (batsmanRun == 0 || batsmanRun == 1) {
        return batsmanRun * 2; 
      }
    }

    return batsmanRun;
  }

  // 4.3 – Power Blocker Card
  int applyPowerBlocker(int batsmanRun) {
    if (overType >= 2 &&
        !powerBlockerUsed &&
        (batsmanRun == 4 || batsmanRun == 6)) {
      powerBlockerUsed = true;
      return 0;
    }
    return batsmanRun;
  }

  // 4.4 – Economy Reward Logic
  bool checkEconomyReward(List<int> last3Runs) {
    if (last3Runs.length < 3) return false;
    int sum =
        last3Runs.sublist(last3Runs.length - 3).reduce((a, b) => a + b);
    return sum <= 4;
  }

  // 4.5 – Trap Mode Setup & Check
  void setTrapCards(int card1, int card2) {
    if (!trapUsed) {
      trapCards = [card1, card2];
    }
  }

  bool checkTrapOut(int batsmanCard) {
    if (!trapUsed && trapCards.contains(batsmanCard)) {
      trapUsed = true;
      return true;
    }
    return false;
  }

  // 4.6 – Field Shift Bonus
  bool activateFieldShift() {
    if (overType >= 2 && !fieldShiftUsed) {
      fieldShiftUsed = true;
      return true;
    }
    return false;
  }

  bool isValidFieldShiftCard(int card) {
    return card % 2 == 0; 
  }
}


// Usage Summary:

// checkNoBall(previousBall, currentBall) returns true/false if no-ball.

// applyDefenseEffect(run) returns modified run after applying Defense.

// applyPowerBlocker(run) nullifies first 4 or 6 per game.

// checkEconomyReward(last3Runs) returns true if ≤4 runs in last 3 balls.

// checkTrapOut(batsmanCard) returns true if batsman triggers trap.

// activateFieldShift() enables field shift.

// isValidFieldShiftCard(card) checks whether batsman move is valid.