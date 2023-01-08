class Player {
  String nickname;
  int score;
  bool isReady;

  Player({
    required this.nickname,
    this.score = 0,
    required this.isReady,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'score': score,
      "isReady": isReady,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'],
      score: map['score'],
      isReady: map['isReady'],
    );
  }

  @override
  String toString() {
    return 'Player{nickname: $nickname, score: $score, isReady: $isReady}';
  }
}
