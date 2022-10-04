import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.child, this.onPressed})
      : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: child);
  }
}
