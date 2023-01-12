import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import '../../../core/classes/game.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Поздравляем ${Game.players[0].nickname} с победой!", textAlign: TextAlign.center, style: AppTextTheme.headline.copyWith(fontSize: 24),),
        SizedBox(height: 50,),
          for(var player in Game.players)
            Text("${player.nickname}, голосов: ${player.score}",  style: AppTextTheme.headline.copyWith(fontSize: 16))
        ],
      ),
    );
  }
}
