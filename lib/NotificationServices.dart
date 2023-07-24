
import 'package:call_alert/pushNotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
String? token;
class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  void requestNotificationPermission() async {

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
        badge: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisinal permission");
    } else {
      print("User denied permission");
    }
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title.toString());
      print(message.notification?.body.toString());
    });
  }

  Future<String> getDeviceToken() async {
    token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("tttttttttttttttt");
    if (message.data['type'] == 'msj') {

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PushNotification()));
    }


  }
}
