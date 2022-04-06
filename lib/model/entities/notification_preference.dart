class NotificationPreference {
  bool isActive;
  int antecedence;

  NotificationPreference(this.isActive, this.antecedence);

  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'antecedence': antecedence,
    };
  }
}
