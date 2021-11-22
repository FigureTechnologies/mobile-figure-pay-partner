import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  // ex. Aug 2021
  String toAbbrMonthYear({bool local = true}) =>
      DateFormat.yMMM().format(local ? toLocal() : this);

  // ex. Aug 04 or Fri, Aug 04
  String toAbbrMonthDay({bool local = true, bool weekday = false}) =>
      DateFormat(weekday ? 'MMMEd' : 'MMMd').format(local ? toLocal() : this);

  // ex. Aug
  String toAbbrMonth() => DateFormat('MMM').format(this);

  // ex. 8/4/2021
  // abrYear 08/04/21
  String toMonthDate({bool local = true, bool abrYear = false}) => abrYear
      ? DateFormat('MM/dd/yy').format(local ? toLocal() : this)
      : DateFormat.yMd().format(local ? toLocal() : this);

  // ex. Aug 4, 2021 or Fri, Aug 4, 2021
  String toMonthDayYear({bool local = true, bool weekday = false}) =>
      DateFormat(weekday ? 'yMMMEd' : 'yMMMd').format(local ? toLocal() : this);

  // ex. 2021-08-04
  String toSimpleIso8061() => DateFormat('yyyy-MM-dd').format(this);
}
