import 'package:call_alert/Registration.dart';
import 'package:call_alert/pushNotification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

GlobalKey<FormState> formkey = GlobalKey<FormState>();

String? onlynumber;
String? newusername;
String newuserPassword = '';
String? newuserEmail;

class _LoginPageState extends State<LoginPage> {
  var loginpressed;
  var _error;
  var Email;
  var Password;

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? emailerror;

  String? passworderror;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor,
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  child: const Text(
                    'Login ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Material(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(80)),
                      color: Color.fromARGB(255, 246, 246, 246),
                      surfaceTintColor: Colors.pink,
                      shadowColor: Colors.green,
                      elevation: 2.0,

                      child: Container(
                        padding: EdgeInsets.only(top: 150, left: 25, right: 25),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Align(
                          alignment: Alignment.center,
                          child: Form(
                            key: _key,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //error display (if any)

                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value!.isEmpty) {
                                            setState(() {
                                              emailerror = "Email can't be empty";
                                            });
                                          }
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            emailerror = null;
                                            _error = null;
                                            Email = value;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Email',
                                        ),
                                      ),
                                    )),
                                const SizedBox(height: 10),
                                if (emailerror != null)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, bottom: 10.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(0),
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Text(
                                                    "$emailerror",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 13),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value!.isEmpty) {
                                            setState(() {
                                              passworderror =
                                                  "Password can't be empty";
                                            });
                                          }
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            passworderror = null;
                                            Password = value;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Password',
                                        ),
                                      ),
                                    )),
                                if (passworderror != null)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, bottom: 10.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(0),
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Text(
                                                    "$passworderror",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 13),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                // rgba(250,254,1,255)
                                Container(
                                  margin: EdgeInsets.only(top: 25,bottom: 10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      // color: Color.fromARGB(255, 255, 255, 18),

                                      borderRadius: BorderRadius.circular(20)),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(vertical: 13),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10)))),
                                    onPressed: () {
                                      if (_key.currentState!.validate()) {}
                                      if (emailerror == null &&
                                          passworderror == null) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PushNotification(),
                                            ));
                                      }
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),


                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationPage(),
                                        ));
                                  },
                                  child: Text('Create a new account'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
