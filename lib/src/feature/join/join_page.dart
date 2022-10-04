import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/colors.dart';
import 'package:job_job_game/src/config/theme.dart';

import '../widgets/button.dart';

class JoinPage extends StatelessWidget {
  JoinPage({Key? key}) : super(key: key);
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
              onPressed: () {
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
