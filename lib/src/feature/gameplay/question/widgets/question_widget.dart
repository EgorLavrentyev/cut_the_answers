import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/theme.dart';
import 'package:job_job_game/src/core/classes/game.dart';
import 'package:job_job_game/src/core/func/gameplay_func.dart';
import 'package:job_job_game/src/feature/widgets/button.dart';

import '../../../../config/colors.dart';
import '../../../../core/classes/app.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget(
      {Key? key,
      required this.pageController,
      required this.currentPage,
      required this.question})
      : super(key: key);

  final TextEditingController controller = TextEditingController();
  final PageController pageController;
  final int currentPage;
  final String question;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            question,
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
                  "${currentPage + 1}/3",
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
                if(currentPage != 2)
                  {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 500), curve: Curves.linear);
                  }
                else if (currentPage == 2)
                  {
                   var me = Game.players.firstWhere((element) => element.nickname == Game.myNickname);
                   me.isReady = true;
                   doc.update({"players": Game.players});
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
