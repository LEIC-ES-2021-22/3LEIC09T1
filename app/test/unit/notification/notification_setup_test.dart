import 'package:flutter_test/flutter_test.dart';
import 'package:uni/controller/notifications/notification_setup.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/lecture_notification_preference.dart';
import 'package:uni/model/entities/notification_data.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'notification_setup.mocks.dart';

@GenerateMocks([Lecture])
void main() {
  group('Notification Setup Helpers Test', () {
    test('shouldScheduleClass test', () {
      final lecture = MockLecture();
      when(lecture.subject).thenReturn('a');
      when(lecture.typeClass).thenReturn('a');
      when(lecture.day).thenReturn(1);
      final List<LectureNotificationPreference> preferences = [
        LectureNotificationPreference(1, true),
        LectureNotificationPreference(2, false),
      ];
      final List<NotificationData> data = [];
      when(lecture.id).thenReturn(1);
      expect(shouldScheduleClass(lecture, data, preferences), isTrue);
      when(lecture.id).thenReturn(2);
      expect(shouldScheduleClass(lecture, data, preferences), isFalse);
      when(lecture.id).thenReturn(3);
      expect(shouldScheduleClass(lecture, data, preferences), isFalse);
    });
  });
}
