import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/colors.dart';
import 'package:job_job_game/src/config/theme.dart';

import '../../core/func/join_func.dart';
import '../lobby/lobby_page.dart';
import '../widgets/button.dart';

class JoinPage extends StatelessWidget {
  JoinPage({Key? key, required this.nickname}) : super(key: key);
  final String nickname;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Введите код комнаты",
            style: AppTextTheme.headline,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
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
          Button(
              onPressed: () async {
                final data = await JoinFunc.connectToSession(
                    context, controller, nickname);
                if (data) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LobbyPage(roomId: controller.text)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Неверный код комнаты!",
                    style: AppTextTheme.button,
                  )));
                }
              },
              child: Text(
                "Присоединиться",
                style: AppTextTheme.button,
              ))
        ],
      ),
    );
  }
}
