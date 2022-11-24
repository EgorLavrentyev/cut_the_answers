import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/theme.dart';
import 'package:job_job_game/src/core/func/gameplay_func.dart';
import 'package:job_job_game/src/feature/widgets/button.dart';

import '../../../../config/colors.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget(
      {Key? key, required this.pageController, required this.currentPage})
      : super(key: key);

  final TextEditingController controller = TextEditingController();
  final PageController pageController;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "В каком деле вы лучше всех?",
          textAlign: TextAlign.center,
          style: AppTextTheme.headline,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: 500,
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
        Button(
            onPressed: () {
              GameplayFunc.separateAnswer(controller.text);
              pageController.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.linear);
            },
            child: Text(
              "Продолжить",
              style: AppTextTheme.button,
            )),
      ],
    );
  }
}
