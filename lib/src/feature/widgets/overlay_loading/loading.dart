import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/colors.dart';
import 'package:job_job_game/src/config/theme.dart';

import 'controller.dart';

class OverlayLoadingWidget extends StatefulWidget {
  const OverlayLoadingWidget({Key? key}) : super(key: key);

  @override
  State<OverlayLoadingWidget> createState() => _OverlayLoadingWidgetState();
}

class _OverlayLoadingWidgetState extends State<OverlayLoadingWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  late final Animation<double> _fadeTransition =
      Tween<double>(begin: 0, end: 1).animate(_controller);

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Timer? timer;

  String dots = "";

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 800), (timer) async {
      dots = "";
      setState(() {});
      await Future.delayed(Duration(milliseconds: 199));
      dots = ".";
      setState(() {});
      await Future.delayed(Duration(milliseconds: 199));
      dots = "..";
      setState(() {});
      await Future.delayed(Duration(milliseconds: 199));
      dots = "...";
      setState(() {});
      await Future.delayed(Duration(milliseconds: 199));
    });
    _controller.forward();
    OverlayLoadingController.controller = _controller;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeTransition,
      child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
          child: Scaffold(
            body: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ожидание\nигроков${dots}",
                  style: AppTextTheme.headline,
                ),
              ],
            )),
          )),
    );
  }
}
