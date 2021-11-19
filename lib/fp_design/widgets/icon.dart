part of fp_design;

class FpIcons {
  static const String account = 'account';
  static const String account_selected = 'account_selected';
  static const String radio_filled = 'radio-filled';
  static const String radio_unfilled = 'radio-unfilled';
  static const String reward = 'reward';
  static const String settings = 'settings';
  static const String shop = 'shop';
  static const String shop_selected = 'shop_selected';
  static const String chevron_right = 'chevron-right';
  static const String back = 'back';
  static const String close = 'close';
  static const String referralBonus = 'referral-bonus';
}

class FpIcon extends StatelessWidget {
  const FpIcon(this.icon, {Key? key, this.color, this.size}) : super(key: key);

  final String icon;

  final Color? color;

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      width: size,
      height: size,
      color: color ?? IconTheme.of(context).color,
    );
  }
}
