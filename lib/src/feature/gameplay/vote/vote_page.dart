import 'package:flutter/material.dart';
import 'package:job_job_game/src/feature/gameplay/vote/widgets/vote_widget.dart';

class VotePage extends StatelessWidget {
  const VotePage({Key? key, required this.answers}) : super(key: key);

  final List<Map<String, dynamic>> answers;


  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GridView.builder(
              itemCount: answers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
                itemBuilder: (context, index){
                  return VoteWidget();
                })));
  }

