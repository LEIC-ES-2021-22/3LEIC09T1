import 'package:flutter_test/flutter_test.dart';
import 'package:uni/utils/time_zone_utils.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

void main() {
  tz.initializeTimeZones();
  group('calculateDayInNextWeek tests', () {
    test('Less than a week before next date 1', () {
      final tz.TZDateTime now = tz.TZDateTime.local(2022, 05, 27, 12, 30, 13);
      final tz.TZDateTime nextDay = calculateDayInNextWeek(
          now: now,
          indexDayOfWeek: 1,
          startTimeHours: 14,
          startTimeMinutes: 0
      );
      expect(nextDay.weekday, nextDay.weekday); //Expects the same day of week
      expect(nextDay.day, 31);
      expect(nextDay.hour, 14);
      expect(nextDay.minute, 0);
      expect(nextDay.year, 2022);
    });
    test('Less than a week before next date 2', () {
      final tz.TZDateTime now = tz.TZDateTime.local(2022, 05, 27, 12, 30, 13);
      final tz.TZDateTime nextDay = calculateDayInNextWeek(
          now: now,
          indexDayOfWeek: 0,
          startTimeHours: 14,
          startTimeMinutes: 0
      );
      expect(nextDay.weekday, nextDay.weekday); //Expects the same day of week
      expect(nextDay.day, 30);
      expect(nextDay.hour, 14);
      expect(nextDay.minute, 0);
      expect(nextDay.year, 2022);
    });
    test('More than a week before next date', () {
      final tz.TZDateTime now = tz.TZDateTime.utc(2022, 05, 24, 12, 30, 13);
      final tz.TZDateTime nextDay = calculateDayInNextWeek(
          now: now,
          indexDayOfWeek: 4,
          startTimeHours: 14,
          startTimeMinutes: 0
      );
      expect(nextDay.weekday, nextDay.weekday); //Expects the same day of week
      expect(nextDay.day, 3);
      expect(nextDay.hour, 14);
      expect(nextDay.minute, 0);
      expect(nextDay.year, 2022);
    });
    test('Next day is in a different year', () {
      final tz.TZDateTime now = tz.TZDateTime.utc(2022, 12, 31, 12, 30, 13);
      final tz.TZDateTime nextDay = calculateDayInNextWeek(
          now: now,
          indexDayOfWeek: 4,
          startTimeHours: 14,
          startTimeMinutes: 0
      );
      expect(nextDay.weekday, nextDay.weekday); //Expects the same day of week
      expect(nextDay.day, 6);
      expect(nextDay.hour, 14);
      expect(nextDay.minute, 0);
      expect(nextDay.year, 2023);
    });
    test('Antecedence changes hours', () {
      final tz.TZDateTime now = tz.TZDateTime.local(2022, 05, 27, 12, 30, 13);
      final tz.TZDateTime nextDay = calculateDayInNextWeek(
          now: now,
          indexDayOfWeek: 4,
          startTimeHours: 9,
          startTimeMinutes: 0,
          antecedence: Duration(minutes: 15)
      );
      expect(nextDay.weekday, nextDay.weekday); //Expects the same day of week
      expect(nextDay.day, 3);
      expect(nextDay.hour, 8);
      expect(nextDay.minute, 45);
      expect(nextDay.year, 2022);
    });
    test('Notification is at the same day as now', () {
      final tz.TZDateTime now = tz.TZDateTime.utc(2022, 05, 23, 11, 0, 30);
      final tz.TZDateTime nextDay = calculateDayInNextWeek(
          now: now,
          indexDayOfWeek: 4,
          startTimeHours: 14,
          startTimeMinutes: 0
      );
    });
  });
}