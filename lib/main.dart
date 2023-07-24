
import 'dart:ui';
import 'package:call_alert/Registration.dart';
import 'package:call_alert/pushNotification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channal", "High_Importance Notificaion",
    description: "This channal is used for importance notification",
    importance: Importance.high,


    playSound: true);

Future<void> _firebaseMessageingBackgroundHandler(message)async{
 await Firebase.initializeApp();
  print("A bg message just showed up : ${message}");
}

 Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
MaterialColor primeColor = MaterialColor(0xFF0047be, color);
MaterialColor accentColor = MaterialColor(0xFF0047be, color);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageingBackgroundHandler);

  await notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);


  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true,
  );

  InitializationSettings settings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosSettings,
  );
  bool? intilized = await notificationsPlugin.initialize(settings);

  print("Notification: $intilized");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // color: Color.fromARGB(255, 0, 71, 190),
      theme: ThemeData(primarySwatch: primeColor,

          ),
      home: RegistrationPage(),
    );
  }
}
