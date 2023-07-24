import 'dart:convert';

import 'package:call_alert/main.dart';
import 'package:call_alert/profile_modal.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'NotificationServices.dart';
import 'constant.dart';
var getToken;
class PushNotification extends StatefulWidget {
  const PushNotification({Key? key}) : super(key: key);

  @override
  State<PushNotification> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  AndroidNotificationSound? androidNotificationSound;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
      notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      _setToken(value);
    });
    _getKey();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android!;
      if (notification != null && android != null) {
        notificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails('1', channel.name,
                    enableLights: true,
                    enableVibration: true,

                    priority: Priority.high,
                    ticker: 'ticker',
                    importance: Importance.high,
                    color: ThemeColor,
                    playSound: true,
                    sound: RawResourceAndroidNotificationSound("notification"),
                    icon: '@mipmap/ic_launcher')));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(" A new onMessgaeOpened event was published");
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android!;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }});
    // Future.delayed(Duration.zero,(){
    //
    // });
  }
  void handleMessage(BuildContext context, message) {
    print("***********************"+message);
    if (message.data['type'] == 'msj') {

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PushNotification()));
    }
  }


  _setToken(key)async{
    final deviceToken = await SharedPreferences.getInstance();
    deviceToken.setString('token', key);
    print("___________________________ $key");
  }
 void _getKey() async {
    print('running');
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.get('token');
    setState(() {
      getToken = key;
    });
    print('YOUR KEY - "$key"');
  }

  String? Token;
var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        //backgroundColor: Color.fromARGB(255, 0, 71, 190),
        title: Text(
            "Call Boot"
        ),


      ),
      body: Column(


        children: [
          SizedBox(height: 15,),
          ProfileModal(image:'assets/Daco.png', username: "User name" ,),
          ProfileModal(image: 'assets/profile.png', username: "Ankita Sharma"),


          // Center(
          //   child: ElevatedButton(
          //     onPressed: () async{
          //       await FirebaseMessaging.instance.subscribeToTopic("myTopic");
          //       notificationServices.getDeviceToken().then((value) async {
          //         _setToken(value);
          //         data = {
          //           'to': getToken,
          //           'priority': 'high',
          //           'notification': {
          //             'title': 'Call Alert',
          //             'body': 'This is calling alert'
          //           },
          //
          //
          //           'data':{
          //             'type':'msj',
          //             'id':'notify'
          //
          //           },
          //
          //         };
          //         var request = await http.post(
          //           Uri.parse('https://fcm.googleapis.com/fcm/send'),
          //           body: jsonEncode(data),
          //
          //           headers: {
          //             'Content-Type': 'application/json; charset=UTF-8',
          //             'Authorization':
          //                 'key=AAAACXmPlL4:APA91bGLvGHvA6lrCtkle1g50iUTCLwYWqeGhEWkP1jGZfp99x6Dmu6nHPsbJC5_yi8MgHijowaKSldK5bXwlhyntJnhE3UeqhcrijE8YAi91Tc6SdF2PtbiIQhl6dNv00qmTyHd9Rbo'
          //           },
          //
          //         );
          //         if(request.statusCode==200){
          //
          //         }
          //       });
          //       // notificationServices.handleMessage(context, data);
          //
          //
          //
          //
          //     }
          //
          //
          //     ,
          //
          //     child: Text("Alert"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
