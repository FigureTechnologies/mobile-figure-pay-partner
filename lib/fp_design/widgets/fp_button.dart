part of fp_design;

class FpPrimaryButton extends StatelessWidget {
  const FpPrimaryButton({
    Key? key,
    required this.text,
    this.enabled = true,
    required this.onPressed,
    this.showAlternate = false,
    this.minimumWidth = double.maxFinite,
  }) : super(key: key);

  const FpPrimaryButton.alternate({
    Key? key,
    required this.text,
    this.enabled = true,
    required this.onPressed,
    this.showAlternate = true,
    this.minimumWidth = double.maxFinite,
  }) : super(key: key);

  /// Text to display within the button
  final String text;

  /// Explicit value instead of setting null to [onPressed]
  final bool enabled;

  /// The callback to invoke when the button is pressed.
  final VoidCallback onPressed;

  /// Used to show an alternate version of the button, as per the figma design
  final bool showAlternate;

  /// Useful when working with Flexible/Expandable widgets
  final double minimumWidth;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _buttonStyle(context),
      onPressed: enabled ? onPressed : null,
      child: FpText(text),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    final theme = Theme.of(context);

    return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (showAlternate) {
          return states.contains(MaterialState.disabled)
              ? theme.colorScheme.primary4.withOpacity(0.5)
              : theme.colorScheme.primary4;
        }

        return theme.colorScheme.onPrimary;
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return showAlternate
              ? theme.colorScheme.primary4
              : theme.colorScheme.primary1;
        }

        return states.contains(MaterialState.disabled)
            ? showAlternate
                ? theme.colorScheme.primary6.withOpacity(0.5)
                : theme.colorScheme.primary2.withOpacity(0.4)
            : showAlternate
                ? theme.colorScheme.primary6
                : theme.colorScheme.primary;
      }),
      minimumSize: MaterialStateProperty.all(Size(minimumWidth, 50)),
      splashFactory: InkRipple.splashFactory,
    );
  }
}

class FpSecondaryButton extends StatelessWidget {
  const FpSecondaryButton({
    Key? key,
    required this.text,
    this.enabled = true,
    required this.onPressed,
    this.minimumWidth = double.maxFinite,
  }) : super(key: key);

  /// The text to display within the button.
  final String text;

  /// Explicit value instead of setting null to [onPressed]
  final bool enabled;

  /// The callback to invoke when the button is pressed.
  final VoidCallback onPressed;

  /// Useful when working with Flexible/Expandable widgets
  final double minimumWidth;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _buttonStyle(context),
      onPressed: enabled ? onPressed : null,
      child: FpText(text, style: FpTextStyle.mBold),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    final theme = Theme.of(context);

    return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed) ||
            states.contains(MaterialState.disabled)) {
          return theme.colorScheme.onPrimary;
        }

        return theme.colorScheme.black;
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return theme.colorScheme.black;
        }

        if (states.contains(MaterialState.disabled)) {
          return theme.colorScheme.black.withOpacity(0.3);
        }

        return theme.colorScheme.onPrimary;
      }),
      side: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled)) {
          return BorderSide(
              color: Theme.of(context).colorScheme.black, width: 2);
        }

        return null;
      }),
      minimumSize: MaterialStateProperty.all(Size(minimumWidth, 50)),
      splashFactory: InkRipple.splashFactory,
    );
  }
}

class FpActionButton extends StatelessWidget {
  const FpActionButton({
    Key? key,
    this.child,
    this.enabled = true,
    required this.onPressed,
    this.outlined = false,
  })  : label = null,
        super(key: key);

  /// Helper constructor for creating a button with a label.
  const FpActionButton.withLabel({
    Key? key,
    this.child,
    this.enabled = true,
    required this.onPressed,
    required this.label,
    this.outlined = false,
  }) : super(key: key);

  /// A widget to show in the button. This is typically an [Icon] widget.
  final Widget? child;

  /// Explicit value instead of setting null to [onPressed]
  final bool enabled;

  /// The callback to invoke when the button is Pressed.
  final VoidCallback onPressed;

  /// A label to show underneath the button.
  final Widget? label;

  /// Show the outlined version of the button.
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          elevation: 0.0,
          backgroundColor: outlined
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.primary3,
          shape: outlined
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(56.0)),
                  side: BorderSide(color: Colors.white, width: 1.0),
                )
              : null,
          onPressed: onPressed,
          child: child,
        ),
        if (label != null)
          DefaultTextStyle(
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: label!,
            ),
          ),
      ],
    );
  }
}

class FpTextButton extends StatelessWidget {
  const FpTextButton({
    Key? key,
    required this.text,
    this.enabled = true,
    required this.onPressed,
    this.padding,
    this.minimumSize = const Size(double.maxFinite, 50),
    this.shrinkWrap = false,
  }) : super(key: key);

  const FpTextButton.shrinkWrap({
    Key? key,
    required this.text,
    this.enabled = true,
    required this.onPressed,
    this.padding,
    this.minimumSize = Size.zero,
    this.shrinkWrap = true,
  }) : super(key: key);

  /// The text to display within the button.
  final String text;

  /// Explicit value instead of setting null to [onPressed]
  final bool enabled;

  /// The callback to invoke when the button is pressed.
  final VoidCallback onPressed;

  /// The padding around text
  final EdgeInsetsGeometry? padding;

  /// Mininum size unless [shrinkWrap] is true
  final Size minimumSize;

  /// shrinks total size of button (tappable area) to text size. Usually used
  /// for action items
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          minimumSize: shrinkWrap ? Size.zero : minimumSize,
          padding: shrinkWrap ? EdgeInsets.zero : null,
          tapTargetSize: shrinkWrap ? MaterialTapTargetSize.shrinkWrap : null),
      onPressed: enabled ? onPressed : null,
      child: Padding(
        padding: padding != null ? padding! : EdgeInsets.zero,
        child: FpText(text, style: FpTextStyle.mBold, color: FpColor.primary4),
      ),
    );
  }
}

class FpOutlinedButton extends StatelessWidget {
  const FpOutlinedButton(
    this.text, {
    Key? key,
    this.enabled = true,
    required this.onPressed,
    this.icon,
    this.largeButton = false,
    this.showArrow = false,
    this.center = true,
    this.fpTextStyle,
    this.fpTextColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
  }) : super(key: key);

  final String text;

  /// Explicit value instead of setting null to [onPressed]
  final bool enabled;

  /// The callback to invoke when the button is pressed.
  final VoidCallback onPressed;

  /// An icon to appear to the left of [text]
  final Widget? icon;

  /// A [largeButton] will have Spacing.large padding around them and slightly more rounded corners
  /// else the button will be of a standard height of 50px
  final bool largeButton;

  /// An arrow to appear on the right side of the button
  final bool showArrow;

  /// To center the [text] and [icon]. If [showArrow] is true, that will not be centered
  final bool center;

  final FpTextStyle? fpTextStyle;
  final FpColor? fpTextColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        primary: Colors.white,
        padding: EdgeInsets.zero,
        side: BorderSide(
            color: borderColor ?? Theme.of(context).colorScheme.lightGrey,
            width: borderWidth),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(largeButton ? 8 : 4))),
        minimumSize: const Size(double.maxFinite, 50),
      ),
      onPressed: enabled ? onPressed : null,
      child: Padding(
        padding:
            largeButton ? const EdgeInsets.all(Spacing.large) : EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: center ? Alignment.center : Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      icon ?? Container(),
                      icon != null
                          ? const HorizontalSpacer.medium()
                          : Container(),
                      FpText(
                        text,
                        style: fpTextStyle ?? FpTextStyle.m,
                        color: fpTextColor ?? FpColor.darkGrey,
                      ),
                    ],
                  ),
                ),
                showArrow
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: FpIcon(FpIcons.chevron_right,
                            color: Theme.of(context).colorScheme.darkGrey),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FpGreyButton extends StatelessWidget {
  const FpGreyButton({
    Key? key,
    required this.text,
    this.enabled = true,
    required this.onPressed,
    this.minimumWidth = double.maxFinite,
  }) : super(key: key);

  /// The child to display within the button. This is often just a Text widget.
  final String text;

  /// Explicit value instead of setting null to [onPressed]
  final bool enabled;

  /// The callback to invoke when the button is pressed.
  final VoidCallback onPressed;

  /// Useful when working with Flexible/Expandable widgets
  final double minimumWidth;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _buttonStyle(context),
      onPressed: enabled ? onPressed : null,
      child: FpText(text),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    final theme = Theme.of(context);

    return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        return theme.colorScheme.onPrimary;
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        return states.contains(MaterialState.disabled)
            ? theme.colorScheme.lightGrey.withOpacity(0.4)
            : theme.colorScheme.lightGrey;
      }),
      minimumSize: MaterialStateProperty.all(Size(minimumWidth, 50)),
    );
  }
}
