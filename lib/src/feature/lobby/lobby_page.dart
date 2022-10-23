import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/colors.dart';

import '../../config/theme.dart';
import '../widgets/button.dart';

class LobbyPage extends StatelessWidget {
  const LobbyPage({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

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
            roomId,
            style: AppTextTheme.headline.copyWith(color: AppColors.brown),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 0.6,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 90, maxCrossAxisExtent: 200),
                itemCount: 10,
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
                                text: "Никнейм тут ",
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
