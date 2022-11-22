class Player {
  String nickname;
  int score;

  Player({
    required this.nickname,
    this.score = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'score': score,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'],
      score: map['score'],
    );
  }
}
