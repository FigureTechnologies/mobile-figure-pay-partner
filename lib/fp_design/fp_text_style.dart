part of fp_design;

/// Figma Typopgraphy Text Styles
enum FpTextStyle {
  h0,
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  h7,
  m,
  mBold,
  s,
  sBold,
  xs,
  xsBold,
  caption
}

mixin FpTextStyleMixin on Widget {
  FpTextStyle get style;

  TextStyle? textStyle(BuildContext context, {FpTextStyle? altStyle}) {
    final theme = Theme.of(context);

    switch (altStyle ?? style) {
      case FpTextStyle.h0:
        return theme.textTheme.headline0;
      case FpTextStyle.h1:
        return theme.textTheme.headline1;
      case FpTextStyle.h2:
        return theme.textTheme.headline2;
      case FpTextStyle.h3:
        return theme.textTheme.headline3;
      case FpTextStyle.h4:
        return theme.textTheme.headline4;
      case FpTextStyle.h5:
        return theme.textTheme.headline5;
      case FpTextStyle.h6:
        return theme.textTheme.headline6;
      case FpTextStyle.h7:
        return theme.textTheme.headline7;
      case FpTextStyle.m:
        return theme.textTheme.medium;
      case FpTextStyle.mBold:
        return theme.textTheme.mediumBold;
      case FpTextStyle.s:
        return theme.textTheme.small;
      case FpTextStyle.sBold:
        return theme.textTheme.smallBold;
      case FpTextStyle.xs:
        return theme.textTheme.extraSmall;
      case FpTextStyle.xsBold:
        return theme.textTheme.extraSmallBold;
      case FpTextStyle.caption:
        return theme.textTheme.caption;
    }
  }
}
