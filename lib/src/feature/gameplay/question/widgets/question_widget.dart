import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/theme.dart';
import 'package:job_job_game/src/core/classes/game.dart';
import 'package:job_job_game/src/core/func/gameplay_func.dart';
import 'package:job_job_game/src/feature/gameplay/answer/answer_page.dart';
import 'package:job_job_game/src/feature/widgets/button.dart';

import '../../../../config/colors.dart';
import '../../../../core/classes/app.dart';
import '../../../../core/models/player.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget(
      {Key? key,
      required this.pageController,
      required this.currentPage,
      required this.question})
      : super(key: key);

  final PageController pageController;
  final int currentPage;
  final String question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final TextEditingController controller = TextEditingController();

  late var listen;
  @override
  void initState() {
    var doc = App.database
        .collection('game')
        .doc(Game.roomId);
    listen = doc
        .snapshots()
        .listen((event) async {
      Game.players.clear();
      for (var map in event.data()!["players"]) {
        Game.players.add(Player.fromMap(map));
      }
      if (Game.players.every((element) => element.isReady == true)){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerPage()));
        listen.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.question,
            textAlign: TextAlign.center,
            style: AppTextTheme.headline.copyWith(fontSize: 20),
          ),
          SizedBox(height: 50,),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                //width: 400,
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                  controller: controller,
                  maxLines: null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.brown, width: 4),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.brown, width: 4),
                        borderRadius: BorderRadius.circular(15)),
                    /*border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.brown, width: 3),
                            borderRadius: BorderRadius.circular(15))*/
                  ),
                ),
              ),

              Container(
                //width: 400,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.brown,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Center(
                    child: Text(
                  "${widget.currentPage + 1}/3",
                  style: AppTextTheme.button,
                )),
              )
            ],
          ),
          SizedBox(height: 50,),

          Button(
              onPressed: () {
                var doc = App.database
                  .collection('game')
                  .doc(Game.roomId);


                var words = GameplayFunc.separateAnswer(controller.text.trim());
                words.shuffle();
                doc.update({"answerWords": FieldValue.arrayUnion(words)});
                if(widget.currentPage != 2)
                  {
                    widget.pageController.nextPage(
                        duration: Duration(milliseconds: 500), curve: Curves.linear);
                  }
                else if (widget.currentPage == 2)
                  {

                   var me = Game.players.firstWhere((element) => element.nickname == Game.myNickname);
                   me.isReady = true;
                   var temp = [];
                   for (var player in Game.players) {
                     temp.add(player.toMap());
                   }
                   doc.update({"players": temp});
                  }
              },
              child: Text(
                "Продолжить",
                style: AppTextTheme.button,
              )),
        ],
      ),
    );
  }
}
