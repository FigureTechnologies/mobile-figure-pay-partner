part of fp_design;

/// Figma Typopgraphy Text Styles
enum FpColor {
  // greys
  white,
  light,
  lightGrey,
  midGrey,
  grey,
  darkGrey,
  black,
  // functional
  positive,
  error,
  warning,
  // primary
  primary1,
  primary2,
  primary3,
  primary4,
  primary5,
  primary6,
  // secondary
  secondary1,
  secondary2,
  // accent
  lime,
}

mixin FpColorMixin on Widget {
  FpColor? get color;

  Color? getColor(BuildContext context, {FpColor? altColor}) {
    final theme = Theme.of(context);

    switch (altColor ?? color) {
      case FpColor.white:
        return theme.colorScheme.white;
      case FpColor.light:
        return theme.colorScheme.light;
      case FpColor.lightGrey:
        return theme.colorScheme.lightGrey;
      case FpColor.midGrey:
        return theme.colorScheme.midGrey;
      case FpColor.grey:
        return theme.colorScheme.grey;
      case FpColor.darkGrey:
        return theme.colorScheme.darkGrey;
      case FpColor.black:
        return theme.colorScheme.black;
      case FpColor.positive:
        return theme.colorScheme.positive;
      case FpColor.error:
        return theme.colorScheme.error;
      case FpColor.warning:
        return theme.colorScheme.warning;
      case FpColor.primary1:
        return theme.colorScheme.primary1;
      case FpColor.primary2:
        return theme.colorScheme.primary2;
      case FpColor.primary3:
        return theme.colorScheme.primary3;
      case FpColor.primary4:
        return theme.colorScheme.primary4;
      case FpColor.primary5:
        return theme.colorScheme.primary5;
      case FpColor.primary6:
        return theme.colorScheme.primary6;
      case FpColor.secondary1:
        return theme.colorScheme.secondary;
      case FpColor.secondary2:
        return theme.colorScheme.secondaryVariant;
      case FpColor.lime:
        return theme.colorScheme.lime;
      default:
        return null;
    }
  }
}
