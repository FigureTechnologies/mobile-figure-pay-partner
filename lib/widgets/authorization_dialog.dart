import 'package:flutter/material.dart';

import '../theme.dart';

class FpDialog {
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? description,
    Widget? bottom,
    bool barriedDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: Theme.of(context).colorScheme.black.withOpacity(0.8),
      barrierDismissible: barriedDismissible,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: title != null
            ? Padding(
                padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Theme.of(context).colorScheme.black),
                  textAlign: TextAlign.center,
                ),
              )
            : null,
        content: description != null
            ? Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .medium
                    .copyWith(color: Theme.of(context).colorScheme.black),
                textAlign: TextAlign.center,
              )
            : null,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        contentPadding:
            const EdgeInsets.only(top: 16, bottom: 32, left: 16, right: 16),
        actions: [
          if (bottom != null) ...[
            Padding(
              padding: const EdgeInsets.all(8),
              child: bottom,
            )
          ],
        ],
      ),
    );
  }

  static Future<T?> showAuthorization<T>(
    BuildContext context, {
    required String username,
    required String appName,
    required Function() onAuthorize,
  }) {
    return show<T>(
      context,
      title: 'Authorize $appName',
      description:
          'Continue to allow us to share your username $username with $appName to transfer cash into your pay account.',
      bottom: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Authorize'),
                onPressed: onAuthorize,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            )
          ],
        ),
      ),
    );
  }

  static Future<T?> showError<T>(
    BuildContext context, {
    String title = 'Oops!',
    required String message,
    void Function()? okAction,
    dynamic error,
  }) {
    return show<T>(context,
        barriedDismissible: true,
        title: title,
        description: message,
        bottom: Column(
          children: [
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      okAction?.call();
                    },
                    child: const Text('OK'))),
          ],
        ));
  }
}
