library Constants;

const navPersonalArea = 'Área Pessoal';
const navSchedule = 'Horário';
const navExams = 'Mapa de Exames';
const navStops = 'Autocarros';
const navAbout = 'Sobre';
const navBugReport = 'Bugs e Sugestões';
const navLogOut = 'Terminar sessão';
const navNotificationArea = 'Notificações';

const faculties = [
  'faup',
  'fbaup',
  'fcup',
  'fcnaup',
  'fadeup',
  'fdup',
  'fep',
  'feup',
  'ffup',
  'flup',
  'fmup',
  'fmdup',
  'fpceup',
  'icbas'
];

enum NotificationChannel {
  classNotif,
  tuitionNotif
}

extension NotificationChannelData on NotificationChannel {
  static const channelIds = {
    NotificationChannel.classNotif: '0',
    NotificationChannel.tuitionNotif: '1'
  };

  static const channelNames = {
    NotificationChannel.classNotif: 'Aulas',
    NotificationChannel.tuitionNotif: 'Pagamento de propinas'
  };

  static const channelDescriptions = {
    NotificationChannel.classNotif: 'Informam a hora e sala em que decorrerão as proximas aulas',
    NotificationChannel.tuitionNotif: 'Informam a data da próxima propina a ser paga'
  };

  String get channelName => channelNames[this];
  String get channelId => channelIds[this];
  String get channelDesc => channelDescriptions[this];
}
