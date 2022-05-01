class NotificationPreference {
  bool isActive;
  int antecedence;
  String notificationType;

  NotificationPreference(
      this.isActive, this.antecedence, this.notificationType);

  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'antecedence': antecedence,
      'notificationType': notificationType,
    };
  }

  factory NotificationPreference.fromHtml(
      bool isActive, int antecedence, String notificationType) {
    return NotificationPreference(true, 10, 'class');
  }
}
