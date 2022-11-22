import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/colors.dart';
import 'package:job_job_game/src/core/classes/game.dart';

import '../../config/theme.dart';
import '../../core/classes/app.dart';
import '../../core/models/player.dart';
import '../widgets/button.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  @override
  void initState() {
    App.database
        .collection('game')
        .doc(widget.roomId)
        .snapshots()
        .listen((event) {
      Game.players.clear();
      for (var map in event.data()!["players"]) {
        Game.players.add(Player.fromMap(map));
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ваш код \nкомнаты",
            style: AppTextTheme.headline,
            textAlign: TextAlign.center,
          ),
          Text(
            widget.roomId,
            style: AppTextTheme.headline.copyWith(color: AppColors.brown),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 0.6,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 90, maxCrossAxisExtent: 200),
                itemCount: Game.players.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: "${index + 1}. ",
                                style: const TextStyle(color: Colors.black)),
                            TextSpan(
                                text: Game.players[index].nickname,
                                style: const TextStyle(color: Colors.brown))
                          ]));
                }),
          ),
          Button(
              onPressed: () {},
              child: Text(
                "Начать",
                style: AppTextTheme.button,
              ))
        ],
      ),
    );
  }
}
