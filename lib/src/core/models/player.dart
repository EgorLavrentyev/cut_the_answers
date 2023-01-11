class Player {
  String nickname;
  int score;
  bool isReady;
  Map<String, dynamic> answers;

  Player({
    required this.nickname,
    this.score = 0,
    required this.isReady,
    required this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'score': score,
      "isReady": isReady,
      "answers": answers,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'],
      score: map['score'],
      isReady: map['isReady'],
      answers: map['answers'],
    );
  }

  @override
  String toString() {
    return 'Player{nickname: $nickname, score: $score, isReady: $isReady}';
  }
}
