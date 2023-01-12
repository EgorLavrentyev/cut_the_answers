import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/theme.dart';
import 'package:job_job_game/src/core/classes/app.dart';
import 'package:job_job_game/src/feature/gameplay/answer/answer_page.dart';
import 'package:job_job_game/src/feature/gameplay/question/question_page.dart';
import 'package:job_job_game/src/feature/gameplay/vote/vote_page.dart';
import 'package:job_job_game/src/feature/join/join_page.dart';
import 'package:job_job_game/src/feature/main_menu/main_menu_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await App.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.theme,
         home: MainMenuPage());
  }
}
