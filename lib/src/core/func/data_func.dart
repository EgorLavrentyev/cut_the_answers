import '../classes/app.dart';
import '../classes/game.dart';

class DataFunc {
  static void setMeReady(bool isReady) async {
    var doc = App.database.collection('game').doc(Game.roomId);

    var me = Game.players
        .firstWhere((element) => element.nickname == Game.myNickname);
    me.isReady = isReady;
    var temp = [];
    for (var player in Game.players) {
      temp.add(player.toMap());
    }
    doc.update({"players": temp});
  }

  static Future<void> setAllReady(bool isReady) async {
    var doc = App.database.collection('game').doc(Game.roomId);
    for (var player in Game.players) {
      player.isReady = isReady;
    }
    var temp = [];
    for (var player in Game.players) {
      temp.add(player.toMap());
    }
    doc.update({"players": temp});
  }
}
