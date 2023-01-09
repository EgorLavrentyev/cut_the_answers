import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/theme.dart';
import 'package:job_job_game/src/core/classes/game.dart';
import 'package:job_job_game/src/core/func/gameplay_func.dart';
import 'package:job_job_game/src/data/questions/questions.dart';
import 'package:job_job_game/src/feature/widgets/button.dart';

import '../../../../config/colors.dart';

class AnswerWidget extends StatefulWidget {
  AnswerWidget(
      {Key? key,
      required this.pageController,
      required this.currentPage,
      required this.question,
      required this.availableWords})
      : super(key: key);

  final PageController pageController;
  final int currentPage;
  final String question;
  final List<dynamic> availableWords;

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  List<String> answerWords = [];

  late List<dynamic> availableWords = widget.availableWords;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.question,
          textAlign: TextAlign.center,
          style: AppTextTheme.headline.copyWith(fontSize: 20),
        ),
        DragTarget<String>(
          onWillAccept: (value) => !answerWords.contains(value),
          onAccept: (value) {
            setState(() {
              answerWords.add(value);
              availableWords.remove(value);
            });
          },
          builder: (BuildContext context, List<Object?> candidateData,
              List<dynamic> rejectedData) {
            return Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.brown, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Wrap(
                  children: [
                    for (var item in answerWords)
                      Draggable<String>(
                        data: item,
                        childWhenDragging: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.transparent, width: 2)),
                            child: Text(
                              item,
                              style: TextStyle(color: Colors.transparent),
                            )),
                        feedback: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.brown, width: 2)),
                            child: Material(
                                color: Colors.transparent, child: Text(item))),
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.brown, width: 2)),
                            child: Text(item)),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        DragTarget<String>(
          onWillAccept: (value) => !availableWords.contains(value),
          onAccept: (value) {
            setState(() {
              availableWords.add(value);
              answerWords.remove(value);
            });
          },
          builder: (BuildContext context, List<Object?> candidateData,
              List<dynamic> rejectedData) {
            return Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.brown, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Wrap(
                  children: [
                    for (var item in availableWords)
                      Draggable<String>(
                        data: item,
                        childWhenDragging: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.transparent, width: 2)),
                            child: Text(
                              item,
                              style: TextStyle(color: Colors.transparent),
                            )),
                        feedback: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.brown, width: 2)),
                            child: Material(
                                color: Colors.transparent, child: Text(item))),
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.brown, width: 2)),
                            child: Text(item)),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        Button(
            onPressed: () {
              //GameplayFunc.separateAnswer(controller.text);
              widget.pageController.nextPage(
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
