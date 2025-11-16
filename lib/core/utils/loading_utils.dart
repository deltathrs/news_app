import 'package:flutter/material.dart';

class LoadingUtils {
  static bool _isDialogOpen = false;

  /// Show loading dialog (prevent multiple dialogs)
  static void showLoading(BuildContext context) {
    if (_isDialogOpen) return;
    _isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  /// Hide loading safely
  static void hideLoading(BuildContext context) {
    if (_isDialogOpen) {
      _isDialogOpen = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
