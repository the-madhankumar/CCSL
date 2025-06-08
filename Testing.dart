// import 'Logics/Bowling.dart';

// void main(){

//   // Test case for checkNoBall
//   final List<Map<List<int>, bool>> noBallTestCases = [
//   {[2, 2]: true},   // lastBall == currentBall
//   {[1, 2]: false},
//   {[4, 4]: true},
//   {[3, 5]: false},
//   {[6, 6]: true},
//   {[0, 0]: true},
//   {[7, 3]: false},
//   {[9, 9]: true},
//   {[8, 1]: false},
//   {[5, 5]: true},
// ];

// Map<Symbol, List<int>> Issues = {}; 

// Bowling bowling = Bowling(4);

// for (int i = 0; i < noBallTestCases.length; i++) {
//   int lastBall = noBallTestCases[i].keys.first[0];
//   int currentBall = noBallTestCases[i].keys.first[1];
//   bool result = bowling.checkNoBall(lastBall, currentBall);
  
//   if (result != noBallTestCases[i].values.first) {
//     if (!Issues.containsKey(#noBallTestCases)) {
//       Issues[#noBallTestCases] = [];
//     }
//     Issues[#noBallTestCases]?.add(i); 
//   }
// }

// //defenseMode
// bowling.defenseBallsRemaining = 10;
// bowling.defenseActive = true;
// final List<Map<int, int>> defenseEffectTestCases = [
//   {4: 2},
//   {6: 3},
//   {1: 2},
//   {0: 0},
//   {2: 2},
//   {5: 5},
//   {6: 3},
//   {1: 2},
//   {0: 0},
//   {3: 3},
// ];

// for (int i = 0; i < defenseEffectTestCases.length; i++) {
//   int batsmanRun = defenseEffectTestCases[i].keys.first;
//   int result = bowling.applyDefenseEffect(batsmanRun);
//   if (result != defenseEffectTestCases[i].values.first) {
//     if (!Issues.containsKey(#defenseEffectTestCases)) {
//       Issues[#defenseEffectTestCases] = [];
//     }
//     Issues[#defenseEffectTestCases]?.add(i); 
//   }
// }

// //powerBlocker
// final List<Map<int, int>> powerBlockerTestCases = [
//   {4: 0},
//   {6: 0},
//   {2: 2},
//   {1: 1},
//   {3: 3},
//   {5: 5},
//   {6: 6},
//   {4: 4},
//   {0: 0},
//   {1: 1},
// ];
// for (int i = 0; i < powerBlockerTestCases.length; i++) {
//   bowling.overType = 4;
//   int batsmanRun = powerBlockerTestCases[i].keys.first;
//   int result = bowling.applyPowerBlocker(batsmanRun);
  
//   if (result != powerBlockerTestCases[i].values.first) {
//     if (!Issues.containsKey(#powerBlockerTestCases)) {
//       Issues[#powerBlockerTestCases] = [];
//     }
//     Issues[#powerBlockerTestCases]?.add(i); 
//   }
// }

// //economyReward
// final List<Map<List<int>, bool>> economyRewardTestCases = [
//   {[1, 2, 1]: true},
//   {[0, 0, 0]: true},
//   {[1, 1, 1]: true},
//   {[2, 2, 2]: false},
//   {[1, 1, 2]: true},
//   {[4, 0, 0]: true},
//   {[2, 2, 1]: false},
//   {[1, 3, 0]: true},
//   {[6, 0, 0]: false},
//   {[1, 2, 2]: false},
// ];
// for (int i = 0; i < economyRewardTestCases.length; i++) {
//   List<int> last3Runs = economyRewardTestCases[i].keys.first;
//   bool result = bowling.checkEconomyReward(last3Runs);
  
//   if (result != economyRewardTestCases[i].values.first) {
//     if (!Issues.containsKey(#economyRewardTestCases)) {
//       Issues[#economyRewardTestCases] = [];
//     }
//     Issues[#economyRewardTestCases]?.add(i); 
//   }
// }

// //TrapOut
// bowling.trapCards = [3, 7];
// final List<Map<int, bool>> trapOutTestCases = [
//   {3: true},
//   {7: false},
//   {2: false},
//   {5: false},
//   {8: false},
//   {3: false},
//   {7: false},
//   {9: false},
//   {6: false},
//   {4: false},
// ];
// for (int i = 0; i < trapOutTestCases.length; i++) {
//   int batsmanCard = trapOutTestCases[i].keys.first;
//   bool result = bowling.checkTrapOut(batsmanCard);
  
//   if (result != trapOutTestCases[i].values.first) {
//     if (!Issues.containsKey(#trapOutTestCases)) {
//       Issues[#trapOutTestCases] = [];
//     }
//     Issues[#trapOutTestCases]?.add(i); 
//   }
// }

// //fieldShift
// final List<Map<int, bool>> fieldShiftActivationTestCases = [
//   {2: true},
//   {3: false},
//   {1: false},
//   {2: false},
//   {3: false},
//   {1: false},
//   {2: false},
//   {3: false},
//   {2: false},
//   {3: false},
// ];
// for (int i = 0; i < fieldShiftActivationTestCases.length; i++) {
//   int overType = fieldShiftActivationTestCases[i].keys.first;
//   bowling.overType = overType;
//   bool result = bowling.activateFieldShift();
  
//   if (result != fieldShiftActivationTestCases[i].values.first) {
//     if (!Issues.containsKey(#fieldShiftActivationTestCases)) {
//       Issues[#fieldShiftActivationTestCases] = [];
//     }
//     Issues[#fieldShiftActivationTestCases]?.add(i); 
//   }
// }

// //fieldShift
// final List<Map<int, bool>> fieldShiftCardTestCases = [
//   {2: true},
//   {3: false},
//   {4: true},
//   {5: false},
//   {6: true},
//   {7: false},
//   {8: true},
//   {9: false},
//   {10: true},
//   {11: false},
// ];
// for (int i = 0; i < fieldShiftCardTestCases.length; i++) {
//   int card = fieldShiftCardTestCases[i].keys.first;
//   bool result = bowling.isValidFieldShiftCard(card);
  
//   if (result != fieldShiftCardTestCases[i].values.first) {
//     if (!Issues.containsKey(#fieldShiftCardTestCases)) {
//       Issues[#fieldShiftCardTestCases] = [];
//     }
//     Issues[#fieldShiftCardTestCases]?.add(i); 
//   }
// }

// //Analytics
// Map<dynamic, dynamic> Analytics = {};

// for (var issue in Issues.entries) {
//   Analytics[issue.key] = {
//     'failureRate': (issue.value.length / 10 * 100), // assuming 10 test cases
//     'failedIndexes': issue.value
//   };
// }

// for (var issue in Analytics.entries) {
//   String iss = issue.key.toString();
//   double failureRate = issue.value['failureRate'];
//   List<int> failedIndexes = issue.value['failedIndexes'];

//   print("$iss : $failureRate% failed at indexes: $failedIndexes");
// }

// }


/////////////////////////////////
//  Second Data Structure test //
/////////////////////////////////

// import './app/lib/dataStructure.dart';
// void main() {
//   final game = Game(
//     status: 'waiting',
//     createdAt: 1699410000,
//     lastActivity: 1699413600,
//     currentOver: 0,
//     currentBall: 0,
//     currentBatsman: null,
//     players: {
//       'uid1': GamePlayer(
//         username: 'Madhan',
//         team: 'Chennai Strikers',
//         wickets: 0,
//         overs: 0,
//         score: 0,
//         deck: ['card01', 'card04', 'card07'],
//         usedCards: [],
//         isBatting: true,
//         status: 'active',
//       ),
//       'uid2': GamePlayer(
//         username: 'Gokul',
//         team: 'Mumbai Chargers',
//         wickets: 0,
//         overs: 0,
//         score: 0,
//         deck: ['card02', 'card05', 'card09'],
//         usedCards: [],
//         isBatting: false,
//         status: 'inactive',
//       ),
//     },
//     winner: null,
//   );

//   final gameJson = game.toJson();
//   print(gameJson); 
// }

import 'dart:math';
import 'dart:io';

import './Logics/Batting.dart';
import './Logics/Bowling.dart';

void main() {
  String player1 = "Vignesh";
  String player2 = "Madhan";

  print('\nEnter number of Wickets:');
  int no_of_wickets = int.parse(stdin.readLineSync()!);

  print('\nEnter number of Overs:');
  int no_of_overs = int.parse(stdin.readLineSync()!);

  // Initialize batting and bowling states for both players
  BattingState player1BattingState = BattingState(totalOvers: no_of_overs);
  Bowling player1BowlingState = Bowling(no_of_overs); // overType in Bowling refers to total overs in the game
  List<int> player1RecentBalls = []; // To track for No Ball and Economy Reward

  BattingState player2BattingState = BattingState(totalOvers: no_of_overs);
  Bowling player2BowlingState = Bowling(no_of_overs); // overType in Bowling refers to total overs in the game
  List<int> player2RecentBalls = []; // To track for No Ball and Economy Reward

  bool isPlayer1BattingCurrentInnings = Random().nextBool(); // Determines who bats first

  int player1Score = 0;
  int player2Score = 0;

  print('\n🧢 Toss Result: ${isPlayer1BattingCurrentInnings ? "$player1 is batting first" : "$player2 is batting first"}');

  // Helper function to get player input (card, bowler guess, batsman prediction)
  Map<String, String> getPlayerInput(String currentPlayerName, String opponentPlayerName, BattingState battingState) {
    print('\n$currentPlayerName is Batting | $opponentPlayerName is Bowling');

    stdout.write('$currentPlayerName, enter your card (0, 1, 2, 3, 4, 6, Pass, Hidden): ');
    String batsmanCardInput = stdin.readLineSync()!;

    String? bowlerGuess;
    if (batsmanCardInput.toLowerCase() == "hidden") {
      stdout.write('$opponentPlayerName, guess the hidden card (0, 1, 2, 3, 4, 6): ');
      bowlerGuess = stdin.readLineSync()!;
    }

    String? batsmanPrediction;
    stdout.write('$currentPlayerName, predict bowler\'s card (0, 1, 2, 3, 4, 6) for Anticipation Bonus (or leave blank): ');
    batsmanPrediction = stdin.readLineSync();
    if (batsmanPrediction != null && batsmanPrediction.isEmpty) {
      batsmanPrediction = null;
    }

    stdout.write('$opponentPlayerName, enter your bowling card (0, 1, 2, 3, 4, 6): ');
    String bowlerCard = stdin.readLineSync()!;

    return {
      'batsmanCard': batsmanCardInput,
      'bowlerCard': bowlerCard,
      'bowlerGuess': bowlerGuess ?? '',
      'batsmanPrediction': batsmanPrediction ?? ''
    };
  }

  // Function to simulate an innings
  void simulateInnings(String battingPlayer, String bowlingPlayer, BattingState battingState, Bowling bowlingState, List<int> recentBalls, Function(int) updateScore) {
    int wicketsFallen = 0;
    
    // Trap Mode setup (can be done once at the start of the innings for the bowler)
    if (bowlingState.trapCards.isEmpty) {
        print('\n${bowlingPlayer}, set your two trap cards (e.g., 3 4): ');
        List<String> trapInput = stdin.readLineSync()!.split(' ');
        if (trapInput.length == 2) {
          bowlingState.setTrapCards(int.parse(trapInput[0]), int.parse(trapInput[1]));
          print('Trap cards set: ${bowlingState.trapCards}');
        } else {
          print('Invalid trap card input. Skipping trap setup.');
        }
    }

    while (!battingState.isGameOver() && wicketsFallen < no_of_wickets) {
      print('\n--- Over ${battingState.currentOver + 1}.${battingState.currentBall + 1} ---');
      
      // Check for Bowling abilities before cards are played
      // Field Shift Bonus activation
      if (bowlingState.overType >= 2 && !bowlingState.fieldShiftUsed) {
        stdout.write('${bowlingPlayer}, do you want to activate Field Shift Bonus (y/n)? ');
        String fieldShiftChoice = stdin.readLineSync()!.toLowerCase();
        if (fieldShiftChoice == 'y') {
          if (bowlingState.activateFieldShift()) {
            print('Field Shift Bonus activated! Batsman can only play even cards for next 3 balls.');
          } else {
            print('Field Shift Bonus cannot be activated now.');
          }
        }
      }

      // Defense Mode activation
      if (bowlingState.overType >= 2 && !bowlingState.defenseActive) {
        stdout.write('${bowlingPlayer}, do you want to activate Defense Mode (y/n)? ');
        String defenseChoice = stdin.readLineSync()!.toLowerCase();
        if (defenseChoice == 'y') {
          bowlingState.activateDefenseMode();
          print('Defense Mode activated! Lasts for 3 balls.');
        }
      }

      // Check for Economy Reward before the ball is played
      if (recentBalls.length >= 3 && bowlingState.checkEconomyReward(recentBalls.sublist(recentBalls.length - 3))) {
        print('${bowlingPlayer} earns Economy Reward! ${battingPlayer} is forced to play 0 or 1.');
        // This rule needs to be enforced on the batsman's input logic, which is outside the current scope of `playBall` method.
        // For this simulation, we'll just print the message. In a real game, you'd restrict input.
      }


      Map<String, String> inputs = getPlayerInput(battingPlayer, bowlingPlayer, battingState);
      String batsmanCard = inputs['batsmanCard']!;
      String bowlerCard = inputs['bowlerCard']!;
      String bowlerGuess = inputs['bowlerGuess']!;
      String batsmanPrediction = inputs['batsmanPrediction']!;

      int parsedBatsmanCard = int.tryParse(batsmanCard) ?? -1; // -1 for non-numeric cards
      int parsedBowlerCard = int.tryParse(bowlerCard) ?? -1;

      bool isOut = false;
      String outReason = '';
      int runsScoredOnThisBall = 0;

      // Apply Field Shift Effect
      if (bowlingState.fieldShiftUsed && bowlingState.isValidFieldShiftCard(battingState.currentBall + 1)) { // Check if field shift is active for current ball
        if (parsedBatsmanCard != -1 && parsedBatsmanCard % 2 != 0) {
          isOut = true;
          outReason = 'due to Field Shift Bonus (played an odd card)';
        }
      }

      // No Ball Condition
      bool isNoBall = false;
      if (recentBalls.isNotEmpty && parsedBowlerCard != -1) {
        isNoBall = bowlingState.checkNoBall(recentBalls.last, parsedBowlerCard);
        if (isNoBall) {
          print('🚨 No Ball! +1 run to ${battingPlayer}. Next ball is a Free Hit.');
          battingState.totalRuns += 1; // +1 run for no ball
          runsScoredOnThisBall = 1; // Mark 1 run for no ball
        }
      }

      // Trap Mode Check
      if (!isOut && bowlingState.checkTrapOut(parsedBatsmanCard)) {
        isOut = true;
        outReason = 'caught in a Trap!';
      }

      // Check for OUT condition (same card played)
      if (!isOut && parsedBatsmanCard == parsedBowlerCard && !bowlingState.isFreeHit) {
        isOut = true;
        outReason = 'Bowler played the same card as you.';
      }

      if (isOut) {
        print('💥 $battingPlayer is OUT $outReason');
        wicketsFallen++;
        battingState.resetStreak(); // Reset streak on out
      } else {
        try {
          // Play the ball in BattingState
          battingState.playBall(batsmanCard, bowlerGuess: bowlerGuess, batsmanPrediction: batsmanPrediction, actualBowlerCard: bowlerCard);

          // Calculate runs for this ball, considering bowling effects
          runsScoredOnThisBall = int.tryParse(batsmanCard) ?? 0;
          if (batsmanCard.toLowerCase() == "hidden" && bowlerGuess != batsmanCard) {
            runsScoredOnThisBall = 1; // Hidden card bonus
          }

          // Apply Bowling effects
          runsScoredOnThisBall = bowlingState.applyDefenseEffect(runsScoredOnThisBall);
          runsScoredOnThisBall = bowlingState.applyPowerBlocker(runsScoredOnThisBall);

          // Update total runs in BattingState based on final runs
          // Note: The BattingState.playBall already adds initial runs. We need to adjust if bowling effects modify it.
          // This requires a more direct integration or modification to BattingState.playBall to take bowling effects into account.
          // For simplicity, I'll calculate the difference and apply it to totalRuns.
          int runsBeforeBowlingEffects = int.tryParse(batsmanCard) ?? 0;
          if (batsmanCard.toLowerCase() == "hidden" && bowlerGuess != batsmanCard) {
             runsBeforeBowlingEffects = 1;
          }
          
          if (battingState.doubleRunNext && (batsmanCard != "Pass" && batsmanCard != "Hidden" && parsedBatsmanCard != 0)) {
            runsBeforeBowlingEffects *= 2; // This is a bit tricky as doubleRunNext is set AFTER a ball is played.
                                          // It should apply to the *next* ball. So we need to manage this state carefully.
          }
          
          // Re-evaluate how runs are added to totalRuns to avoid double counting or incorrect application of bowling effects.
          // The current BattingState.playBall() method adds runs directly.
          // A better approach would be to calculate the final runs here and then add to BattingState.totalRuns
          // after all effects (batting and bowling) are applied.

          // For now, let's assume `playBall` only calculates the base run and we apply bowling effects afterwards.
          // This means we might need to modify `playBall` to return the base run before adding to `totalRuns`.
          // Or, we adjust `totalRuns` here after applying bowling effects.

          // Let's modify BattingState.playBall to return the base runs scored.
          // (This would require a change in the BattingState class methods provided)

          // Alternative: Directly calculate the run here and then update the batting state.
          // This would mean 'playBall' would primarily handle state transitions like streak, cooldown, etc.,
          // and the score update would be managed here after all calculations.

          // Given the current structure, I'll calculate the actual run and then reflect it in totalRuns.
          // This means `totalRuns` in BattingState will be updated based on the *final* run after bowling effects.
          int initialRunsAddedByBattingState = int.tryParse(batsmanCard) ?? 0;
          if (batsmanCard.toLowerCase() == "hidden" && bowlerGuess != batsmanCard) {
            initialRunsAddedByBattingState = 1; // Hidden card bonus
          } else if (batsmanCard.toLowerCase() == "pass") {
            initialRunsAddedByBattingState = 0;
          }

          // Adjust total runs in BattingState: subtract original added, then add final calculated run.
          battingState.totalRuns -= initialRunsAddedByBattingState; // Remove the run that playBall added
          battingState.totalRuns += runsScoredOnThisBall; // Add the run after bowling effects

          // Add to recent balls for bowling logic
          recentBalls.add(runsScoredOnThisBall);
          if (recentBalls.length > 3) {
            recentBalls.removeAt(0); // Keep only last 3 for economy reward
          }
          
          updateScore(runsScoredOnThisBall);
          print('Runs Scored: $runsScoredOnThisBall');
          print(battingState.summary());
        } on Exception catch (e) {
          print('🚫 Error: ${e.toString().replaceAll('Exception: ', '')}');
          // If an exception occurs (e.g., consecutive 4/6, pass used), it counts as a dot ball or a specific penalty.
          // For simplicity here, we'll just move to the next ball without scoring runs.
          // In a real game, you might want to define specific penalties for such violations.
          battingState.resetStreak();
        }
      }

      // Manually manage ball and over increment if playBall throws an exception
      if (!battingState.isGameOver() && wicketsFallen < no_of_wickets) {
          // The BattingState.playBall() already increments currentBall and currentOver.
          // So no need to increment here unless playBall failed to execute.
          // However, if an OUT happens before playBall completes, we might need to manually advance the ball.
          // Let's assume playBall always advances the ball count unless an OUT occurs before it.
      }
    }
    print('--- End of Innings for ${battingPlayer} ---');
    print('Total Wickets Fallen: $wicketsFallen out of $no_of_wickets');
  }

  // --- Innings 1 ---
  print('\n--- Innings 1 ---');
  if (isPlayer1BattingCurrentInnings) {
    simulateInnings(player1, player2, player1BattingState, player2BowlingState, player2RecentBalls, (runs) => player1Score += runs);
  } else {
    simulateInnings(player2, player1, player2BattingState, player1BowlingState, player1RecentBalls, (runs) => player2Score += runs);
  }

  print("\n📊 --- Score after Innings 1 ---");
  print("$player1: ${player1BattingState.totalRuns} runs");
  print("$player2: ${player2BattingState.totalRuns} runs");

  // Reset states for the second innings if needed (e.g., power card usage per innings, hidden card, pass)
  // Note: Some bowling abilities are per game (e.g., trap), some per over (defense).
  // This might require re-initializing BattingState and Bowling for a true 'innings' reset,
  // or adding reset methods to them. For simplicity, we'll just flip batting/bowling roles.
  
  // --- Innings 2 ---
  print('\n--- Innings 2 ---');
  isPlayer1BattingCurrentInnings = !isPlayer1BattingCurrentInnings; // Switch roles
  if (isPlayer1BattingCurrentInnings) {
    print('$player1 is now Batting. Target to chase: ${player2BattingState.totalRuns + 1} runs.');
    simulateInnings(player1, player2, player1BattingState, player2BowlingState, player2RecentBalls, (runs) => player1Score += runs);
  } else {
    print('$player2 is now Batting. Target to chase: ${player1BattingState.totalRuns + 1} runs.');
    simulateInnings(player2, player1, player2BattingState, player1BowlingState, player1RecentBalls, (runs) => player2Score += runs);
  }

  print("\n📊 --- Final Scores ---");
  print("$player1: ${player1BattingState.totalRuns} runs");
  print("$player2: ${player2BattingState.totalRuns} runs");

  if (player1BattingState.totalRuns > player2BattingState.totalRuns) {
    print("\n🎉 $player1 wins!");
  } else if (player2BattingState.totalRuns > player1BattingState.totalRuns) {
    print("\n🎉 $player2 wins!");
  } else {
    print("\n🤝 Match Drawn!");
  }
}