import 'package:flutter/material.dart';
import 'package:job_job_game/src/core/classes/game.dart';
import 'package:job_job_game/src/feature/gameplay/question/widgets/question_widget.dart';

import '../../../core/classes/app.dart';
import '../../../core/models/player.dart';
import '../../../data/questions/questions.dart';
import '../../widgets/overlay_loading/controller.dart';
import '../answer/answer_page.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final PageController pageController = PageController(keepPage: true);

  late var listen;

  @override
  void initState() {
    var doc = App.database.collection('game').doc(Game.roomId);
    listen = doc.snapshots().listen((event) async {
      Game.players.clear();
      for (var map in event.data()!["players"]) {
        Game.players.add(Player.fromMap(map));
      }
      if (Game.players.every((element) => element.isReady == true)) {
        List<String> temp = Questions.questions.toList();

        temp.shuffle();

        List<Map<String, dynamic>> myQuestions = [];
        for (int i = 0; i < 3; i++) {
          myQuestions.add({temp[i]: ""});
        }
        Game.questions.addAll(myQuestions);

        List<dynamic> availableWords = event.data()!["answerWords"];
        availableWords.shuffle();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnswerPage(
                      availableWords: availableWords
                          .getRange(
                              0,
                              ((availableWords.length / Game.players.length) -
                                      1)
                                  .round())
                          .toList(),
                    )));
        OverlayLoadingController.remove(context);
        listen.cancel();
      }
    });
    super.initState();
  }

  int currentPage = 0;

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
                return QuestionWidget(
                    pageController: pageController,
                    currentPage: currentPage,
                    question: Game.questions[index].keys.first);
              }),
        ),
      ),
    );
  }
}
