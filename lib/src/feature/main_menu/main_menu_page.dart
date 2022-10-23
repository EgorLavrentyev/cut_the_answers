import 'package:flutter/material.dart';
import 'dart:math';
import 'package:job_job_game/src/config/theme.dart';
import 'package:job_job_game/src/core/classes/app.dart';
import 'package:job_job_game/src/feature/join/join_page.dart';

import '../../config/colors.dart';
import '../lobby/lobby_page.dart';
import '../widgets/button.dart';

class MainMenuPage extends StatefulWidget {
  MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  getRandomString(int length) {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  bool nicknameValidation() {
    if (textEditingController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  TextEditingController textEditingController = TextEditingController();

  createSession() async {
    String roomId = getRandomString(4);
/*    App.database.collection('game').doc(roomId).set({
      "user": roomId,
    });
    final snapshot = await App.database.collection('game').doc(roomId).get();
    print(snapshot.data());*/
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LobbyPage(roomId: roomId)));
  }

  connectToSession(BuildContext context) async {
    /*final snapshot = await App.database
                      .collection('game')
                      .doc(textEditingController.text)
                      .get();
                  print(snapshot.data());*/
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => JoinPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Введите свой никнейм",
            style: AppTextTheme.button.copyWith(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: textEditingController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.brown, width: 4),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.brown, width: 4),
                    borderRadius: BorderRadius.circular(15)),
                /*border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.brown, width: 3),
                      borderRadius: BorderRadius.circular(15))*/
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Button(
                    onPressed: nicknameValidation()
                        ? () async {
                            await createSession();
                          }
                        : null,
                    child: Text(
                      "Создать",
                      style: AppTextTheme.button,
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Button(
                  onPressed: nicknameValidation()
                      ? () {
                          connectToSession(context);
                        }
                      : null,
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
