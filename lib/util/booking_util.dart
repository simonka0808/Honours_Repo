import 'package:intl/intl.dart';

class BookingUtil {
  BookingUtil._();

  static bool isDoubleBooking(DateTime firstStart, DateTime firstEnd,
      DateTime secondStart, DateTime secondEnd) {
    return getLatestTime(firstStart, secondStart)
        .isBefore(getEarliestTime(firstEnd, secondEnd));
  }

  static DateTime getLatestTime(DateTime first, DateTime second) {
    return first.isAfterOrEq(second) ? first : second;
  }

  static DateTime getEarliestTime(DateTime first, DateTime second) {
    return first.isBeforeOrEq(second) ? first : second;
  }

  static String formatDateTime(DateTime dt) {
    return DateFormat.Hm().format(dt);
  }
}

extension DateTimeExt on DateTime {
  bool isBeforeOrEq(DateTime second) {
    return isBefore(second) || isAtSameMomentAs(second);
  }

  bool isAfterOrEq(DateTime second) {
    return isAfter(second) || isAtSameMomentAs(second);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime get startOfDay => DateTime(year, month, day, 0, 0);
  DateTime get endOfDay => DateTime(year, month, day + 1, 0, 0);
  DateTime startOfDayAppt(DateTime service) =>
      DateTime(year, month, day, service.hour, service.minute);
  DateTime endOfDayAppt(DateTime service) =>
      DateTime(year, month, day, service.hour, service.minute);
}
