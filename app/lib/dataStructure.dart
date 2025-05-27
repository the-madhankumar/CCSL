class GamePlayer {
  final String username;
  final String team;
  final int wickets;
  final int overs;
  final int score;
  final List<String> deck;
  final List<String> usedCards;
  final bool isBatting;
  final String status;

  GamePlayer({
    required this.username,
    required this.team,
    required this.wickets,
    required this.overs,
    required this.score,
    required this.deck,
    required this.usedCards,
    required this.isBatting,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'team': team,
      'wickets': wickets,
      'overs': overs,
      'score': score,
      'deck': deck,
      'usedCards': usedCards,
      'isBatting': isBatting,
      'status': status,
    };
  }

  factory GamePlayer.fromJson(Map<String, dynamic> json) {
    return GamePlayer(
      username: json['username'],
      team: json['team'],
      wickets: json['wickets'],
      overs: json['overs'],
      score: json['score'],
      deck: List<String>.from(json['deck']),
      usedCards: List<String>.from(json['usedCards']),
      isBatting: json['isBatting'],
      status: json['status'],
    );
  }
}

class Game {
  final String status;
  final int createdAt;
  final int lastActivity;
  final int currentOver;
  final int currentBall;
  final String? currentBatsman;
  final Map<String, GamePlayer> players; // key is uid
  final String? winner;

  Game({
    required this.status,
    required this.createdAt,
    required this.lastActivity,
    required this.currentOver,
    required this.currentBall,
    this.currentBatsman,
    required this.players,
    this.winner,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'createdAt': createdAt,
      'lastActivity': lastActivity,
      'currentOver': currentOver,
      'currentBall': currentBall,
      'currentBatsman': currentBatsman,
      'players': players.map((key, value) => MapEntry(key, value.toJson())),
      'winner': winner,
    };
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    final playersMap = Map<String, GamePlayer>.from(
      json['players'].map(
        (key, value) => MapEntry(
          key,
          GamePlayer.fromJson(Map<String, dynamic>.from(value)),
        ),
      ),
    );

    return Game(
      status: json['status'],
      createdAt: json['createdAt'],
      lastActivity: json['lastActivity'],
      currentOver: json['currentOver'],
      currentBall: json['currentBall'],
      currentBatsman: json['currentBatsman'],
      players: playersMap,
      winner: json['winner'],
    );
  }
}
