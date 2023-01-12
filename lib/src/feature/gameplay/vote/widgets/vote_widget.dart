import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/theme.dart';

import '../../../../config/colors.dart';
import '../../../../core/classes/app.dart';
import '../../../../core/classes/game.dart';

class VoteWidget extends StatefulWidget {
  const VoteWidget({Key? key, required this.answer, required this.nickname})
      : super(key: key);
  final MapEntry answer;
  final String nickname;

  @override
  State<VoteWidget> createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {

  bool isTapped = false;


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: !isTapped || Game.myNickname == widget.nickname ? () {
        var doc = App.database.collection('game').doc(Game.roomId);
       var player = Game.players.firstWhere((element) => element.nickname == widget.nickname);
       player.score++;
        var temp = [];
        for (var player in Game.players) {
          temp.add(player.toMap());
        }
        doc.update({"players": temp});
        setState(() {
          isTapped = true;
        });
      } : null,
      child: Opacity(
        opacity: isTapped || Game.myNickname == widget.nickname ? 0.3 : 1,
        child: Container(
            decoration: BoxDecoration(
                border: const Border.fromBorderSide(
                    BorderSide(color: AppColors.brown, width: 4)),
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.only(bottom: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.brown,
                  ),
                  child: Center(
                      child: Text(
                    widget.answer.key,
                    textAlign: TextAlign.center,
                    style: AppTextTheme.headline
                        .copyWith(fontSize: 16, color: Colors.white),
                  ))),
              Text(widget.answer.value,
                  textAlign: TextAlign.center,
                  style: AppTextTheme.headline.copyWith(fontSize: 16)),
            ])),
      ),
    );
  }
}
