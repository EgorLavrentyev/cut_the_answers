import 'package:flutter/material.dart';
import 'package:job_job_game/src/feature/gameplay/question/widgets/question_widget.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
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
                return QuestionWidget(
                    pageController: pageController, currentPage: currentPage);
              }),
        ),
      ),
    );
  }
}
