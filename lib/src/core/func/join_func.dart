import 'dart:math';

import 'package:flutter/material.dart';
import 'package:job_job_game/src/core/classes/game.dart';
import 'package:job_job_game/src/core/models/player.dart';
import 'package:job_job_game/src/feature/gameplay/question/question_page.dart';

import '../../feature/join/join_page.dart';
import '../../feature/lobby/lobby_page.dart';
import '../classes/app.dart';

class JoinFunc {
  static nicknameValidation(TextEditingController textEditingController) {
    if (textEditingController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static getRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  static createSession(context, String nickname) async {
    String roomId = getRandomString(4);
    Game.myNickname = nickname;
    App.database.collection('game').doc(roomId).set({
      "roomId": roomId,
      "players": [
        {
          "nickname": nickname,
          "score": 0,
        }
      ],
      "questions": [],
    });
    final snapshot = await App.database.collection('game').doc(roomId).get();
    print(snapshot.data()!["players"]);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LobbyPage(roomId: roomId)));
  }

  static connectToSession(BuildContext context,
      TextEditingController textEditingController, String nickname) async {
    Game.myNickname = nickname;
    String roomId = textEditingController.text;
    final doc = App.database.collection('game').doc(roomId);

    final snapshot = await doc.get();
    print(snapshot.data());
    if (snapshot.exists) {
      // for (var map in snapshot.data()!["players"]) {
      //   Game.players.add(Player.fromMap(map));
      // }

      doc.set({
        "roomId": roomId,
        "players": [
          ...snapshot.data()!["players"],
          {
            "nickname": nickname,
            "score": 0,
          }
        ],
        "questions": [],
      });

      return true;
    } else {
      return false;
    }
  }
}
