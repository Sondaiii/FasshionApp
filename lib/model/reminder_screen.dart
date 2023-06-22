import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Reminder {
  Reminder.init();

  static Reminder instances = Reminder.init();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void init() async {
    tz.initializeTimeZones();
    _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/logo');
    final initializationSettings = const InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<NotificationDetails> _notificationsDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', "Fashion App",
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true);

    return NotificationDetails(android: androidNotificationDetails);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> showNotifications() async {
    flutterLocalNotificationsPlugin.show(
        1, "FASHION APP", "You Have Outfit Today🏆", await _notificationsDetails());
  }
  Future<void> showNotificationsWelcome() async {
    flutterLocalNotificationsPlugin.show(
        1, "FASHION APP", "Have a nice day🏆", await _notificationsDetails());
  }

  Future<void> showReminderNotification() async {
    flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "FASHION APP", "You Have Outfit Today🏆",

        tz.TZDateTime.from(
            DateTime.now().add(Duration(seconds: 1)), tz.local),
        await _notificationsDetails(),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
