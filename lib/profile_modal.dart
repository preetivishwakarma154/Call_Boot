import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:call_alert/constant.dart';
import 'package:call_alert/pushNotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:call_alert/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'NotificationServices.dart';
class ProfileModal extends StatefulWidget {
  const ProfileModal({Key? key, required this.image, required this.username}) : super(key: key);
  final String image,username;

  @override
  State<ProfileModal> createState() => _ProfileModalState();
}

class _ProfileModalState extends State<ProfileModal> {



  final player = AudioCache();
  void shownotification() async{
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("notification-alert", "notifier",
        priority: Priority.max, importance: Importance.max,
    sound: RawResourceAndroidNotificationSound("notification.wav"),playSound: true,enableVibration: true,audioAttributesUsage: AudioAttributesUsage.notification);
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: "notification.wav");
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await notificationsPlugin.show(0, "Sample Notification", "Notification Details",
        notificationDetails);
  }
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
                    color: Colors.blue,
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
      }
    });
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
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      padding:EdgeInsets.all(10),

      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 243, 243, 243),

      ),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          CircleAvatar(
            radius: 35,
            child: Image(
              image: AssetImage(
                  widget.image,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(widget.username,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),),
          Padding(
            padding: EdgeInsets.only(left: 20),

            child: Container(
              height: 40,
              width: 75,

              decoration: BoxDecoration(
                  color: ThemeColor,
                borderRadius: BorderRadius.circular(30)
              ),

              child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.call),
                style:ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,backgroundColor: Colors.white,
                ),
                  onPressed: () async{
                    await FirebaseMessaging.instance.subscribeToTopic("myTopic");
                    notificationServices.getDeviceToken().then((value) async {
                      _setToken(value);
                      data = {
                        'to': getToken,
                        'priority': 'high',
                        'notification': {
                          'title': 'Call Alert',
                          'body': 'This is calling alert'
                        },


                        'data':{
                          'type':'msj',
                          'id':'notify'

                        },

                      };
                      var request = await http.post(
                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),

                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization':
                          'key=AAAACXmPlL4:APA91bGLvGHvA6lrCtkle1g50iUTCLwYWqeGhEWkP1jGZfp99x6Dmu6nHPsbJC5_yi8MgHijowaKSldK5bXwlhyntJnhE3UeqhcrijE8YAi91Tc6SdF2PtbiIQhl6dNv00qmTyHd9Rbo'
                        },

                      );
                      if(request.statusCode==200){

                      }
                    });
                    // notificationServices.handleMessage(context, data);




                  }),
            ),
          )

        ],
      ),
    );
  }
}
