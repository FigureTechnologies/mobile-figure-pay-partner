import 'package:flutter/material.dart';

import '../theme.dart';

class AuthorizationDialog {
  static Future<T?> show<T>(
    BuildContext context, {
    required String username,
    required String appName,
    required Function() onAuthorize,
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: Theme.of(context).colorScheme.black.withOpacity(0.8),
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          child: Text(
            'Authorize $appName',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).colorScheme.black),
            textAlign: TextAlign.center,
          ),
        ),
        content: Text(
          'Continue to allow us to share your username $username with $appName to transfer cash into your pay account.',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: Theme.of(context).colorScheme.black),
          textAlign: TextAlign.center,
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        contentPadding:
            const EdgeInsets.only(top: 16, bottom: 32, left: 16, right: 16),
        actions: [
          Padding(
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
          )
        ],
      ),
    );
  }
}
