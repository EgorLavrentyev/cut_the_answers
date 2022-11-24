import 'package:flutter/material.dart';
import 'package:job_job_game/src/feature/gameplay/answer/widgets/answer_widget.dart';
import 'package:job_job_game/src/feature/gameplay/question/widgets/question_widget.dart';

class AnswerPage extends StatefulWidget {
  AnswerPage({Key? key}) : super(key: key);

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final PageController pageController = PageController(keepPage: true);

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
                return AnswerWidget(
                    pageController: pageController, currentPage: currentPage);
              }),
        ),
      ),
    );
  }
}
