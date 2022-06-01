import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart' as tz;

/// Creates a TZDateTime for the same week day in the next week
/// The week starts on monday which has a value of 0
tz.TZDateTime calculateNextDay({
  @required tz.TZDateTime now,
  @required int indexDayOfWeek,
  Duration antecedence = Duration.zero,
  int startTimeHours = 1,
  int startTimeMinutes = 0,
  int addedWeeks = 0}
    ) {
  final int distanceInDays = (indexDayOfWeek - (now.weekday - 1)) % 7;
  tz.TZDateTime date =
  tz.TZDateTime(tz.local, now.year, now.month, now.day)
      .add(Duration(days: distanceInDays))
      .add(Duration(hours: startTimeHours))
      .add(Duration(minutes: startTimeMinutes))
      .subtract(antecedence)
      .add(Duration(hours: addedWeeks * 168));
  if (date.isBefore(now)) {
    date = date.add(Duration(hours: 168));
  }
  return date;
}
