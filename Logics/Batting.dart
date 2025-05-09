class BattingState {
  int totalOvers;
  int currentOver = 0;
  int currentBall = 0;

  int totalRuns = 0;
  int validRunStreak = 0;
  bool doubleRunNext = false;

  int powerCardUsage = 0;
  int sixCooldown = 0;

  int hiddenCardUsed = 0;
  bool anticipationBonusUsed = false;
  bool passUsed = false;

  List<String> currentOverCards = [];
  int lastCardPlayed = -1; // Store the last card played to check for consecutive 4 or 6

  BattingState({required this.totalOvers});

  bool canUsePowerCard(String card) {
    // Max 4 power cards per over
    if ((card == "4" || card == "6") && powerCardUsage < 4) {
      if (card == "6" && sixCooldown > 0) return false;
      return true;
    }
    return false;
  }

  int maxPowerCardsThisOver() {
    // Max 4 power cards per over
    return 4;
  }

  void playBall(String cardPlayed, {String? bowlerGuess, String? batsmanPrediction, String? actualBowlerCard}) {
    currentBall++;

    // Check for batsman-out condition (if both cards match)
    if (cardPlayed == actualBowlerCard) {
      throw Exception("You are OUT! Bowler played the same card as you.");
    }

    // Prevent consecutive use of 4 and 6
    if ((lastCardPlayed == 4 && cardPlayed == "6") || (lastCardPlayed == 6 && cardPlayed == "4")) {
      throw Exception("Cannot use 4 and 6 consecutively.");
    }

    // Run logic
    if (cardPlayed == "Pass") {
      if (passUsed) throw Exception("Pass already used.");
      passUsed = true;
      resetStreak();
    } else if (cardPlayed == "Hidden") {
      if (hiddenCardUsed > 0) throw Exception("Hidden card already used.");
      hiddenCardUsed++;
      bool bowlerGuessedCorrectly = (bowlerGuess == cardPlayed);
      if (bowlerGuessedCorrectly) {
        // Score 0
        resetStreak();
      } else {
        totalRuns += 1; // Bonus
        addToStreak();
      }
    } else {
      int run = int.tryParse(cardPlayed) ?? 0;

      if (cardPlayed == "6") sixCooldown = 2;
      if (canUsePowerCard(cardPlayed)) powerCardUsage++;

      if (doubleRunNext) {
        run *= 2;
        doubleRunNext = false;
      }

      totalRuns += run;

      if (run > 0) {
        addToStreak();
      } else {
        resetStreak();
      }

      // Store the last card played to check for consecutive 4 or 6
      if (cardPlayed == "4" || cardPlayed == "6") {
        lastCardPlayed = int.tryParse(cardPlayed) ?? -1;
      }
    }

    // Anticipation Bonus
    if (!anticipationBonusUsed && batsmanPrediction != null && actualBowlerCard != null) {
      if (batsmanPrediction == actualBowlerCard) {
        totalRuns += 2;
        anticipationBonusUsed = true;
      }
    }

    if (sixCooldown > 0) sixCooldown--;

    if (currentBall >= 6) {
      currentBall = 0;
      currentOver++;
      powerCardUsage = 0;
      lastCardPlayed = -1; // Reset last card played at the start of a new over
    }
  }

  void addToStreak() {
    validRunStreak++;
    if (validRunStreak >= 4) {
      doubleRunNext = true;
    }
  }

  void resetStreak() {
    validRunStreak = 0;
    doubleRunNext = false;
  }

  bool isGameOver() {
    return currentOver >= totalOvers;
  }

  String summary() {
    return "Runs: $totalRuns, Over: $currentOver.$currentBall, Power Used: $powerCardUsage, 6-CD: $sixCooldown";
  }
}

