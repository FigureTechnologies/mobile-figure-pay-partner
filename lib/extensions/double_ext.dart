import 'package:intl/intl.dart';

extension DoubleExt on double {
  String toCurrency({showCents = true}) =>
      NumberFormat.simpleCurrency(decimalDigits: showCents ? null : 0)
          .format(this);

  int toCoinAmount() => (this * 100).toInt();

  /// set [wholeNumber] to true when the number has already been multiplied by 100
  String toPercentage({bool showDecimals = true, bool wholeNumber = false}) =>
      '${(!wholeNumber ? this * 100 : this).toStringAsFixed(showDecimals ? 2 : 0)}%';

  String toAbbreviatedCurrency() {
    if (this >= 1000000) {
      return '\$' + NumberFormat('##.##').format(this / 1000000) + 'M';
    } else if (this >= 1000) {
      return '\$' + NumberFormat('##.##').format(this / 1000) + 'K';
    }
    return toCurrency(showCents: false);
  }
}

extension Spacing on double {
  static const xSmall = 4.0;
  static const small = 8.0;
  static const medium = 16.0;
  static const large = 24.0;
  static const xLarge = 32.0;
  static const xxLarge = 40.0;
}
