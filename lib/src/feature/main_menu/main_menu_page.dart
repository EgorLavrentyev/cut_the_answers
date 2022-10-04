import 'package:flutter/material.dart';
import 'dart:math';
import 'package:job_job_game/src/config/theme.dart';
import 'package:job_job_game/src/core/classes/app.dart';
import 'package:job_job_game/src/feature/join/join_page.dart';

import '../widgets/button.dart';

class MainMenuPage extends StatelessWidget {
  MainMenuPage({Key? key}) : super(key: key);

  getRandomString(int length) {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  TextEditingController textEditingController = TextEditingController();

  createSession() async {
    String roomId = getRandomString(4);
    App.database.collection('game').doc(roomId).set({
      "user": roomId,
    });
    final snapshot = await App.database.collection('game').doc(roomId).get();
    print(snapshot.data());
  }

  connectToSession(BuildContext context) async {
    /*final snapshot = await App.database
                      .collection('game')
                      .doc(textEditingController.text)
                      .get();
                  print(snapshot.data());*/
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => JoinPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Button(
                    onPressed: () async {
                      await createSession();
                    },
                    child: Text(
                      "Создать",
                      style: AppTextTheme.button,
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Button(
                  onPressed: () {
                    connectToSession(context);
                  },
                  child: Text(
                    "Присоединиться",
                    style: AppTextTheme.button,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
