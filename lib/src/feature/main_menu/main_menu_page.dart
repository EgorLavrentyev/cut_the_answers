import 'package:flutter/material.dart';
import 'dart:math';
import 'package:job_job_game/src/config/theme.dart';
import 'package:job_job_game/src/core/classes/app.dart';
import 'package:job_job_game/src/core/func/join_func.dart';
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
  TextEditingController textEditingController = TextEditingController();

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
                    onPressed:
                        JoinFunc.nicknameValidation(textEditingController)
                            ? () async {
                                await JoinFunc.createSession(
                                    context, textEditingController.text);
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
                  onPressed: JoinFunc.nicknameValidation(textEditingController)
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JoinPage(
                                        nickname: textEditingController.text,
                                      )));
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
