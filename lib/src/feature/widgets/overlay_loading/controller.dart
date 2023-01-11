import 'package:flutter/material.dart';

import 'loading.dart';

class OverlayLoadingController {
  static OverlayEntry? overlay;
  static OverlayState? _overlayState;

  static AnimationController? controller;

  static void _insertOverlay(BuildContext context) async {
    _overlayState = Overlay.of(context);
    overlay = OverlayEntry(
        opaque: false, builder: (context) => const OverlayLoadingWidget());
  }

  static void _removeOverlay() {
    if (overlay != null) {
      overlay!.remove();
      overlay = null;
    }
  }

  static void show(BuildContext context) {
    _insertOverlay(context);
    _overlayState!.insert(overlay!);
  }

  static void remove(BuildContext context) async {
    if (controller != null) {
      controller!.reverse();
      await Future.delayed(Duration(milliseconds: 300), () => _removeOverlay());
    } else {
      _removeOverlay();
    }
  }
}
