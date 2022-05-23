import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart' as tz;

/// Creates a TZDateTime for the same week day in the next week
/// The week starts on monday
tz.TZDateTime calculateTime({
  @required tz.TZDateTime now,
  @required int indexDayOfWeek,
  int antecedence = 0,
  int startTimeHours = 1,
  int startTimeMinutes = 0}
  ) {
  final int distance = (indexDayOfWeek % 7 - now.weekday) % 7;
  final tz.TZDateTime date =
  tz.TZDateTime(tz.local, now.year, now.month, now.day)
      .add(Duration(days: distance))
      .add(Duration(hours: startTimeHours))
      .add(Duration(
      minutes: startTimeMinutes - antecedence));
  return date;
}