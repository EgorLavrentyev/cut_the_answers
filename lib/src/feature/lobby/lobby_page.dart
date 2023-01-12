import 'dart:math';

import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/colors.dart';
import 'package:job_job_game/src/core/classes/game.dart';
import 'package:job_job_game/src/core/services/ui.dart';
import 'package:job_job_game/src/data/questions/questions.dart';

import '../../config/theme.dart';
import '../../core/classes/app.dart';
import '../../core/models/player.dart';
import '../gameplay/question/question_page.dart';
import '../widgets/button.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late var listen;

  @override
  void initState() {
    listen = App.database
        .collection('game')
        .doc(widget.roomId)
        .snapshots()
        .listen((event) async {
          Game.roomId = widget.roomId;
      Game.players.clear();
      for (var map in event.data()!["players"]) {
        Game.players.add(Player.fromMap(map));
      }
      setState(() {});
      if (event.data()!["start"] == true) {

        List<String> temp = Questions.questions.toList();

        temp.shuffle();

        List<Map<String, dynamic>> myQuestions = [];
        for (int i = 0; i < 3; i++) {
          myQuestions.add({temp[i]: ""});
        }
        Game.questions.addAll(myQuestions);
        // doc.update({
        //   "questions": [
        //     {Game.myNickname: Game.questions},
        //     ...event.data()!["questions"],
        //   ]
        // });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => QuestionPage()));
        listen.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ваш код \nкомнаты",
                style: AppTextTheme.headline,
                textAlign: TextAlign.center,
              ),
              Text(
                widget.roomId,
                style: AppTextTheme.headline.copyWith(color: AppColors.brown),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                    // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    //     mainAxisExtent: 90, maxCrossAxisExtent: 200),
                    itemCount: Game.players.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(left: 5),
                        child: RichText(
                            softWrap:false,
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "${index + 1}. ",
                                      style: const TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: Game.players[index].nickname,
                                      style: const TextStyle(color: Colors.brown))
                                ])),
                      );
                    }),
              ),
              Button(
                  onPressed: () async {
                    if (Game.players.length >= 2) {
                      final doc =
                          App.database.collection('game').doc(widget.roomId);
                      final snapshot = await doc.get();
                      doc.set({
                        "roomId": widget.roomId,
                        "players": snapshot.data()!["players"],
                        "start": true,
                        "questions": [],
                        "answerWords": [],
                      });
                    } else {
                      Ui.showSnack(context, "Играть одному не интересно!");
                    }
                  },
                  child: Text(
                    "Начать",
                    style: AppTextTheme.button,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
