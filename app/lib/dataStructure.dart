class Player {
  final String name;
  final String? currentCard;
  final int? score;
  final bool? isDone;

  Player({
    required this.name,
    this.currentCard,
    this.score,
    this.isDone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'currentCard': currentCard,
      'score': score,
      'isDone': isDone,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] ?? '',
      currentCard: json['currentCard'],
      score: json['score'],
      isDone: json['isDone'],
    );
  }
}

class Game {
  final String gameId;
  final String status; // waiting / started / finished
  final Map<String, Player> players; // uid1, uid2 → Player
  final String? winner;

  Game({
    required this.gameId,
    required this.status,
    required this.players,
    this.winner,
  });

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'status': status,
      'players': players.map((key, player) => MapEntry(key, player.toJson())),
      'winner': winner,
    };
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    final playerMap = Map<String, dynamic>.from(json['players'] ?? {});
    final parsedPlayers = playerMap.map<String, Player>(
      (key, value) => MapEntry(key, Player.fromJson(Map<String, dynamic>.from(value))),
    );

    return Game(
      gameId: json['gameId'] ?? '',
      status: json['status'] ?? 'waiting',
      players: parsedPlayers,
      winner: json['winner'],
    );
  }
}
