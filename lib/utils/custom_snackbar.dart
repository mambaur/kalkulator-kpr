import 'package:flutter/material.dart';

enum SnackbarType { success, warning, failure }

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    SnackbarType? type,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: type == SnackbarType.success
              ? Colors.green.shade700
              : type == SnackbarType.warning
                  ? Colors.orange
                  : Colors.red.shade700,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
                type == SnackbarType.success
                    ? Icons.check_circle_outline
                    : type == SnackbarType.warning
                        ? Icons.info_outline
                        : Icons.error_outline,
                color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(message,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(vertical: 20),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
