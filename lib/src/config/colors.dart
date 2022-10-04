import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {


  static const brown = Color(0xff87623A);
  static const backgroundColor = Color(0xffF2DDC6);


  static const MaterialColor materialBrown = MaterialColor(
    0xff87623A, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff87623A),//10%
      100: Color(0xff87623A),//20%
      200: Color(0xff87623A),//30%
      300: Color(0xff87623A),//40%
      400: Color(0xff87623A7),//50%
      500: Color(0xff87623A),//60%
      600: Color(0xff87623A),//70%
      700: Color(0xff87623A),//80%
      800: Color(0xff87623A),//90%
      900: Color(0xff87623A),//100%
    },
  );
}