import 'package:intl/intl.dart';

class BookingUtil {
  BookingUtil._();

  static DateTime getLatestTime(DateTime firstAppt, DateTime secondAppt) {
    return firstAppt.isAfterOrEq(secondAppt) ? firstAppt : secondAppt;
  }

  static DateTime getEarliestTime(DateTime firstAppt, DateTime secondAppt) {
    return firstAppt.isBeforeOrEq(secondAppt) ? firstAppt : secondAppt;
  }

  static String reformat(DateTime dt) {
    return DateFormat.Hm().format(dt);
  }

  static bool checkForDoubleBooking(DateTime firstApptStart,
      DateTime firstApptEnd, DateTime secondApptStart, DateTime secondApptEnd) {
    return getLatestTime(firstApptStart, secondApptStart)
        .isBefore(getEarliestTime(firstApptEnd, secondApptEnd));
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
