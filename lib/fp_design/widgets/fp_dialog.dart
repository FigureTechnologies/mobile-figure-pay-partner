part of fp_design;

class FpDialog {
  FpDialog._();

  /// Foundational design function for displaying dialogs. Only use when [showError],
  /// [showConfirmation], or [showMessage] can't be used
  /// Note: [content] supercedes [message]
  static Future<T?> show<T>(
    BuildContext context, {
    Widget? header,
    String title = 'Figure Pay',
    String? message,
    Widget? content,
    Widget? bottom,
    bool barriedDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barriedDismissible,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Padding(
          padding: EdgeInsets.only(
            top: header == null ? Spacing.medium : Spacing.large,
            left: Spacing.medium,
            right: Spacing.medium,
          ),
          child: Column(
            children: [
              if (header != null) ...[
                header,
                const VerticalSpacer.xLarge(),
              ],
              FpText(
                title,
                style: FpTextStyle.h4,
                color: FpColor.black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        content: content ??
            (message != null
                ? FpText(
                    message,
                    style: FpTextStyle.m,
                    color: FpColor.black,
                    textAlign: TextAlign.center,
                  )
                : null),
        insetPadding: const EdgeInsets.symmetric(horizontal: Spacing.medium),
        contentPadding: EdgeInsets.only(
            top: Spacing.medium,
            bottom: content == null ? Spacing.large : 0.0,
            left: Spacing.medium,
            right: Spacing.medium),
        actions: [
          if (bottom != null) ...[
            Padding(
              padding: const EdgeInsets.all(Spacing.small),
              child: bottom,
            )
          ],
        ],
      ),
    );
  }

  static Future<T?> showError<T>(
    BuildContext context, {
    String title = 'Oops!',
    String? message,
    dynamic error,
    VoidCallback? okAction,
    bool showCancel = false,
  }) {
    return show<T>(
      context,
      barriedDismissible: false,
      title: title,
      message: message ?? 'Unknown Error',
      bottom: Column(
        children: [
          FpPrimaryButton(
            text: 'OK',
            onPressed: () {
              Navigator.of(context).pop();
              okAction?.call();
            },
          ),
          if (showCancel) ...[
            const VerticalSpacer.small(),
            FpTextButton(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            )
          ]
        ],
      ),
    );
  }

  /// Shows user a confirmation dialog and returns the result as a [bool].
  /// [content] supercedes [message]
  static Future<bool> showConfirmation(
    BuildContext context, {
    Widget? header,
    String? title,
    String? message,
    Widget? content,
    String? confirmText,
    String cancelText = 'Cancel',
    Widget? footer,
  }) async {
    final result = await show<bool>(
      context,
      barriedDismissible: false,
      header: header,
      title: title ?? 'Figure Pay',
      message: message,
      content: content,
      bottom: Column(
        children: [
          if (confirmText != null) ...[
            FpPrimaryButton(
              text: confirmText,
              onPressed: () => Navigator.of(context).pop(true),
            ),
            const VerticalSpacer.small(),
          ],
          FpTextButton(
            text: cancelText,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          if (footer != null) ...[
            const VerticalSpacer.small(),
            footer,
          ]
        ],
      ),
    );

    return result ?? false;
  }

  /// Shows an alert message to user. Uses [showConfirmation] under the hood
  /// for consistency
  static Future<void> showMessage(
    BuildContext context, {
    Widget? header,
    String? title,
    required String message,
  }) {
    return showConfirmation(
      context,
      header: header,
      title: title,
      message: message,
      cancelText: 'Close',
    );
  }

  // Below are specific dialogs that are used more than once in various places.
  // Could possible cleanup (move to specific views) as things change/ get cleaned.

  static Future<void> showBiometricsDialog(
      BuildContext context, String authType) {
    return showMessage(
      context,
      title: 'Oops',
      message:
          'Sorry, you need to have $authType enabled on your device in order to use Figure Pay.',
    );
  }
}
