import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';
import 'package:workmanager/workmanager.dart';

import 'components/notification/notification_service.dart';
import 'screens/on_boarding/splash_screen.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    LocalNotificationService.showBigTextNotification(
      title: "Work Manager Title ",
      body: "Work Manager Body",
    );
    // // initialise the plugin of flutterlocalnotifications.
    // FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
    //
    // // app_icon needs to be a added as a drawable
    // // resource to the Android head project.
    // var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var IOS = new IOSInitializationSettings();
    //
    // // initialise settings for both Android and iOS device.
    // var settings = new InitializationSettings(android, IOS);
    // flip.initialize(settings);
    // _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Location().requestService();
  CalendarPlugin().requestPermissions();
  FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();
  await Hive.initFlutter();
  await Hive.openBox('task_local_db');
  Workmanager().initialize(

      // The top level function, aka callbackDispatcher
      callbackDispatcher,

      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true);
  // Periodic task registration
  Workmanager().registerPeriodicTask(
    "2",

    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",

    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: const Duration(minutes: 15),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    LocalNotificationService.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Weather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
