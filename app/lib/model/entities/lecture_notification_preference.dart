import 'package:uni/model/notifications/missing_notification_preference_exception.dart';

class LectureNotificationPreference {
  bool isActive;
  int id;

  LectureNotificationPreference(this.id, this.isActive);

  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'id': id,
    };
  }

  factory LectureNotificationPreference.fromHtml(int id, int isActive) {
    return LectureNotificationPreference(id, isActive == 1 ? true : false);
  }

  @override
  String toString() {
    return 'ID: ' +
        this.id.toString() +
        ' | IsActive: ' +
        this.isActive.toString();
  }

  static bool idIsActive(
      List<LectureNotificationPreference> preferences, int id) {
    for (LectureNotificationPreference p in preferences) {
      if (p.id == id) return p.isActive;
    }
    throw MissingNotificationPreferenceException(
        'Lecture notification preference for lecture with id ' +
            id.toString() +
            ' is not present');
  }
}
