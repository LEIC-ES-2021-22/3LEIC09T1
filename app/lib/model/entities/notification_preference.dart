import 'package:meta/meta.dart';

class NotificationPreference {
  static final DEFAULT_ANTECEDENCE = 10;
  bool isActive;
  int antecedence;
  String notificationType;

  NotificationPreference({
    @required this.isActive,
    @required this.antecedence,
    @required this.notificationType
  });

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
        isActive: isActive == 1 ? true : false,
        antecedence: antecedence,
        notificationType: notificationType
    );
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
