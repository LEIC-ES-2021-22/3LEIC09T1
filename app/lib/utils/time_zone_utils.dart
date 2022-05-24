import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart' as tz;

int calculateDelayBetweenDays({
  @required tz.TZDateTime now,
  @required int indexDayOfWeek
}) {
  final nowWeekDayStartingZero = now.weekday - 1;
  return nowWeekDayStartingZero > indexDayOfWeek ?
    (indexDayOfWeek - nowWeekDayStartingZero) % 7:
    7 + indexDayOfWeek - nowWeekDayStartingZero;
}

/// Creates a TZDateTime for the same week day in the next week
/// The week starts on monday which has a value of 0
tz.TZDateTime calculateDayInNextWeek({
  @required tz.TZDateTime now,
  @required int indexDayOfWeek,
  Duration antecedence = Duration.zero,
  int startTimeHours = 1,
  int startTimeMinutes = 0}
  ) {
  final int distance = calculateDelayBetweenDays(
      now: now,
      indexDayOfWeek: indexDayOfWeek
  );
  final tz.TZDateTime date =
  tz.TZDateTime(tz.local, now.year, now.month, now.day)
      .add(Duration(days: distance))
      .add(Duration(hours: startTimeHours))
      .add(Duration(minutes: startTimeMinutes))
      .subtract(antecedence);
  return date;
}