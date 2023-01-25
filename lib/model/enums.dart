import 'package:table_calendar/table_calendar.dart' as tc
    show StartingDayOfWeek;

enum CalendarDays { monday, tuesday, wednesday, thursday, friday }

extension StartingDayOfWeekX on CalendarDays {
  tc.StartingDayOfWeek toTC() {
    switch (this) {
      case CalendarDays.monday:
        return tc.StartingDayOfWeek.monday;

      case CalendarDays.tuesday:
        return tc.StartingDayOfWeek.tuesday;

      case CalendarDays.wednesday:
        return tc.StartingDayOfWeek.wednesday;

      case CalendarDays.thursday:
        return tc.StartingDayOfWeek.thursday;

      case CalendarDays.friday:
        return tc.StartingDayOfWeek.friday;
    }
  }
}
