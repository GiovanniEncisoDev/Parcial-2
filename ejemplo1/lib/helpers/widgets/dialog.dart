import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ejemplo1/helpers/extensions/nullable_extension.dart';

class Dialogo {
  Dialogo._();

    static void info(BuildContext context, {
    String title = "Mensaje",
    String message = "",
    String confirmation = "Ok",
    void Function()? onDismiss,
  }) {
    title = "$title :";

    if(confirmation == "Ok") {
      confirmation = confirmation;
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onDismiss?.call();
              },
              child: Text(
                confirmation,
                style: const TextStyle(
                  color: Colors.blue
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showLoadingDialog(
    BuildContext context, {
    String? message, 
    double spinnerSize = 32,
    VoidCallbackAction? dismiss,
    }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (message.exists) ...[
                Text(message!),
                const SizedBox(width: 10),
              ],
              LoadingAnimationWidget.beat(color: Colors.green.shade800, size: spinnerSize),
            ],
          ),
        );
      },
    );
  }
}