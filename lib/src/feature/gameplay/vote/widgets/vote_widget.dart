import 'package:flutter/material.dart';

import '../../../../config/colors.dart';

class VoteWidget extends StatefulWidget {
  const VoteWidget({Key? key, required this.answer}) : super(key: key);
  final Map<String, dynamic> answer;

  @override
  State<VoteWidget> createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      Container(
          decoration: BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: AppColors.brown, width: 4)),
              borderRadius: BorderRadius.circular(15)),
      child: Text(widget.answer.keys.first)
      )
    ]));
  }
}
