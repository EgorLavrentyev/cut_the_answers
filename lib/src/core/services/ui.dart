import 'package:flutter/material.dart';

import '../../config/theme.dart';

class Ui {
  static showSnack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      text,
      style: AppTextTheme.button,
    )));
  }
}
