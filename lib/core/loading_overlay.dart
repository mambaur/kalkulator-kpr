import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class LoadingOverlay {
  static show(BuildContext context) {
    return OverlayLoadingProgress.start(
      context,
      barrierDismissible: false,
      widget: LoadingAnimationWidget.fourRotatingDots(
        color: Colors.white,
        size: 70,
      ),
    );
  }

  static hide() {
    return OverlayLoadingProgress.stop();
  }
}
