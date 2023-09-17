import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

import 'components/notification/notification_service.dart';
import 'screens/on_boarding/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Location().requestService();
   CalendarPlugin().requestPermissions();

  await Hive.initFlutter();
  await Hive.openBox('task_local_db');
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
