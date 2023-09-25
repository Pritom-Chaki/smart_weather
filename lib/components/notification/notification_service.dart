import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  // Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //notification initialize
  static Future<void> initialize() async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int? id, String? title, String? body, String? payload) async {});
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await _notificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
    debugPrint("_notificationsPlugin****");
  }
//notification details and design
  static NotificationDetails notificationDetails() {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      "noti_channel_45454_sdssss_54544", "channel_name",
      playSound: true,
      //  sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
      icon: 'mipmap/ic_launcher',
    );

    return NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
  }

  //show notification
  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
    debugPrint("fln.show ****");
  }

  static Future showScheduleNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      "noti_channel_45454_sdssss_54544",
      "channel_name",
      playSound: true,
      //  sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );
    debugPrint("androidPlatformChannelSpecifics ****");
    var noti = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());

    await _notificationsPlugin.periodicallyShow(
        id, title, body, RepeatInterval.everyMinute, noti);
    debugPrint("fln.show ****");
  }
}
