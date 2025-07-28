import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum SnackbarType { success, warning, failure }

class CustomSnackbar {
  static void flushbar(BuildContext context,
      {String? title, String? message, SnackbarType? type}) {
    Color? color = Colors.green.shade700;

    if (type == SnackbarType.warning) {
      color = Colors.orange;
    }

    if (type == SnackbarType.failure) {
      color = Colors.red.shade700;
    }

    Flushbar(
      backgroundColor: Theme.of(context).cardColor,
      // boxShadows: [],
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 7,
          offset: const Offset(1, 3),
        )
      ],
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
      flushbarStyle: FlushbarStyle.FLOATING,
      messageColor: Theme.of(context).textTheme.titleLarge?.color,
      titleColor: Colors.black,
      title: title,
      message: message ?? '',
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: color,
      ),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: color,
    ).show(context);
  }
}
