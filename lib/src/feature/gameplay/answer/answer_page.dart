import 'dart:math';

import 'package:flutter/material.dart';
import 'package:job_job_game/src/core/func/data_func.dart';
import 'package:job_job_game/src/feature/gameplay/answer/widgets/answer_widget.dart';
import 'package:job_job_game/src/feature/gameplay/question/widgets/question_widget.dart';
import 'package:job_job_game/src/feature/gameplay/vote/vote_page.dart';

import '../../../core/classes/app.dart';
import '../../../core/classes/game.dart';
import '../../../core/models/player.dart';
import '../../../data/questions/questions.dart';
import '../../widgets/overlay_loading/controller.dart';

class AnswerPage extends StatefulWidget {
  AnswerPage({Key? key, required this.availableWords}) : super(key: key);

  final List<dynamic> availableWords;

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final PageController pageController = PageController(keepPage: true);

  int currentPage = 0;
  late var listen;

  @override
  void initState() {
    DataFunc.setAllReady(false);
    var doc = App.database.collection('game').doc(Game.roomId);
    listen = doc.snapshots().listen((event) async {
      Game.players.clear();
      for (var map in event.data()!["players"]) {
        Game.players.add(Player.fromMap(map));
      }
      if (Game.players.every((element) => element.isReady == true)) {
        print("ALL IS READY");
        var answers = {};
        for (int i = 0; i < Game.players.length; i++) {
          answers.addAll({
            event.data()!["players"][i]["nickname"]: event.data()!["players"][i]
                ["answers"]
          });
        }
        print(answers);
        OverlayLoadingController.remove(context);
        listen.cancel();
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => VotePage(
        //             firstAnswer: firstAnswer, secondAnswer: secondAnswer)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: 3,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return AnswerWidget(
                    pageController: pageController,
                    currentPage: currentPage,
                    availableWords: widget.availableWords,
                    question: Game.questions[index + 3].keys.first);
              }),
        ),
      ),
    );
  }
}
