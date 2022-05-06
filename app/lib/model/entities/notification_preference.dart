import 'package:logger/logger.dart';

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
      int isActive, int antecedence, String notificationType) {
    return NotificationPreference(
        isActive == 1 ? true : false, antecedence, notificationType);
  }

  @override
  String toString() {
    return 'IsActive: ' +
        this.isActive.toString() +
        ' | Antecedence: ' +
        antecedence.toString() +
        ' | Type: ' +
        this.notificationType;
  }
}
