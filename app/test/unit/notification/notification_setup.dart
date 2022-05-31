import 'package:flutter_test/flutter_test.dart';
import 'package:uni/controller/notifications/notification_setup.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/lecture_notification_preference.dart';
import 'package:uni/model/entities/notification_data.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([Lecture])
void main() {
  group('Notification Setup Helpers Test', () {
    test('shouldScheduleClass test', () {
      Lecture lecture1 = Lecture(
          'CPD', 'typeClass', 1, 2, 'B111', 'AOR', '3LEIC01', 0, 0, 2, 0);
      Lecture lecture2 = Lecture(
          'ES', 'typeClass', 1, 2, 'B111', 'AOR', '3LEIC02', 2, 0, 4, 0);
      List<LectureNotificationPreference> preferences = [
        LectureNotificationPreference(lecture1.id, true),
        LectureNotificationPreference(lecture2.id, false),
      ];
      List<NotificationData> data = [];

      expect(shouldScheduleClass(lecture1, data, preferences), isTrue);
      expect(shouldScheduleClass(lecture2, data, preferences), isFalse);
    });
  });
}
