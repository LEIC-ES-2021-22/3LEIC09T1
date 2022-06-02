import 'package:flutter_test/flutter_test.dart';
import 'package:uni/utils/time_zone_utils.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

void main() {
  tz.initializeTimeZones();
  group('calculateDayInNextWeek tests', () {
    test('Less than a week before next date 1', () {
      final tz.TZDateTime now = tz.TZDateTime.local(2022, 05, 27, 12, 30, 13);
      final tz.TZDateTime nextDay = calculateNextDay (
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
      final tz.TZDateTime nextDay = calculateNextDay (
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
    test('Next day is in a different year', () {
      final tz.TZDateTime now = tz.TZDateTime.utc(2022, 12, 31, 12, 30, 13);
      final tz.TZDateTime nextDay = calculateNextDay (
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
      final tz.TZDateTime now = tz.TZDateTime.local(2022, 05, 27, 8, 0, 0);
      final tz.TZDateTime nextDay = calculateNextDay (
          now: now,
          indexDayOfWeek: 4,
          startTimeHours: 9,
          startTimeMinutes: 0,
          antecedence: Duration(minutes: 15)
      );
      expect(nextDay.weekday, nextDay.weekday); //Expects the same day of week
      expect(nextDay.day, 27);
      expect(nextDay.hour, 8);
      expect(nextDay.minute, 45);
      expect(nextDay.year, 2022);
    });
    test('Same day but still can schedule', () {
      final tz.TZDateTime now = tz.TZDateTime.local(2022, 6, 1, 8, 0, 0);
      final tz.TZDateTime nextDay = calculateNextDay (
          now: now,
          indexDayOfWeek: 2,
          startTimeHours: 14,
          startTimeMinutes: 0
      );
      expect(nextDay.weekday, 3); //Expects the same day of week
      expect(nextDay.day, 1);
      expect(nextDay.hour, 14);
      expect(nextDay.minute, 0);
      expect(nextDay.year, 2022);
    });
    test('Same day but still cant schedule', () {
      final tz.TZDateTime now = tz.TZDateTime.local(2022, 6, 1, 12, 0, 0);
      final tz.TZDateTime nextDay = calculateNextDay (
          now: now,
          indexDayOfWeek: 2,
          startTimeHours: 8,
          startTimeMinutes: 0
      );
      expect(nextDay.weekday, 3); //Expects the same day of week
      expect(nextDay.day, 8);
      expect(nextDay.hour, 8);
      expect(nextDay.minute, 0);
      expect(nextDay.year, 2022);
    });
    test('Sends to next week', () {
      final tz.TZDateTime now = tz.TZDateTime.local(2022, 06, 1, 12, 30, 13);
      final tz.TZDateTime nextDay = calculateNextDay (
          now: now,
          indexDayOfWeek: 3,
          startTimeHours: 14,
          startTimeMinutes: 0,
          addedWeeks: 1
      );
      expect(nextDay.weekday, 4); //Expects the same day of week
      expect(nextDay.day, 9);
      expect(nextDay.hour, 14);
      expect(nextDay.minute, 0);
      expect(nextDay.year, 2022);
    });
  });
}
