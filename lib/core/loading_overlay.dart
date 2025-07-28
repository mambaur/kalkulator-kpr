import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class LoadingOverlay {
  static void show(BuildContext context) {
    OverlayLoadingProgress.start(
      context,
      barrierDismissible: false,
      widget: LoadingAnimationWidget.fourRotatingDots(
        color: Colors.white,
        size: 70,
      ),
    );
  }

  static void hide() {
    OverlayLoadingProgress.stop();
  }
}
