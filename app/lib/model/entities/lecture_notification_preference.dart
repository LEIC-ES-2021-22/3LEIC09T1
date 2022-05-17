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
}
