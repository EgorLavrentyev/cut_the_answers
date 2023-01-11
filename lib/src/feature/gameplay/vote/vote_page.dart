import 'package:flutter/material.dart';

class VotePage extends StatefulWidget {
  const VotePage(
      {Key? key, required this.firstAnswer, required this.secondAnswer})
      : super(key: key);

  final Map<String, dynamic> firstAnswer;
  final Map<String, dynamic> secondAnswer;

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [Container()],
          )
        ],
      ),
    );
  }
}
