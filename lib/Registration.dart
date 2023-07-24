import 'package:call_alert/Login.dart';
import 'package:call_alert/pushNotification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

GlobalKey<FormState> formkey = GlobalKey<FormState>();

String? onlynumber;
String? newusername;
String newuserPassword = '';
String? newuserEmail;

class _RegistrationPageState extends State<RegistrationPage> {
  String? phoneNumber;
  String? numbererror;
  String? nameerror;
  String? emailerror;
  String? passworderror;
  String? confirmpassworderror;
  String? newuserconfirmPassword;
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
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                Stack(
                  children: [
                    Material(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(80)),
                      color: Color.fromARGB(255, 246, 246, 246),
                      elevation: 2.0,

                      child: Container(
                        padding: EdgeInsets.only(top: 80, left: 25, right: 25),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,

                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value!.isEmpty) {
                                          setState(() {
                                            nameerror = "Name can't be empty";
                                          });
                                        } else if (value!.length < 3) {
                                          setState(() {
                                            nameerror = "Too short name";
                                          });
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          nameerror = null;
                                          newusername = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Name',
                                      ),
                                    ),
                                  )),
                              if (nameerror != null)
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
                                                  "$nameerror",
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
                              SizedBox(height: 10),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        var emailValidator =
                                            EmailValidator.validate(value!);
                                        if (value == null || value!.isEmpty) {
                                          setState(() {
                                            emailerror = "Email can't be empty";
                                          });
                                        } else if (emailValidator != true) {
                                          print(EmailValidator.validate(value!));
                                          setState(() {
                                            emailerror = "Invalid email address";
                                          });
                                        }
                                      },
                                      onChanged: ((value) {
                                        setState(() {
                                          emailerror = null;
                                          newuserEmail = value;
                                        });
                                      }),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Email',
                                      ),
                                    ),
                                  )),
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
                              SizedBox(height: 10),
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
                                            passworderror =
                                                "Enter a valid password";
                                          });
                                        }
                                        if (value!.length < 8) {
                                          passworderror =
                                              "password should be 8 character";
                                        }
                                      },
                                      obscureText: true,
                                      onChanged: (value) {
                                        setState(() {
                                          newuserPassword = value;
                                          passworderror = null;
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
                              if (newuserPassword.length > 7)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: TextFormField(
                                              initialValue:
                                                  newuserconfirmPassword,
                                              validator: (value) {
                                                if (value == null ||
                                                    value!.isEmpty) {
                                                  setState(() {
                                                    confirmpassworderror =
                                                        "Enter a valid password";
                                                  });
                                                }
                                                if (value != newuserPassword) {
                                                  setState(() {
                                                    confirmpassworderror =
                                                        "Password does not match";
                                                  });
                                                }
                                              },
                                              obscureText: true,
                                              onChanged: (value) {
                                                setState(() {
                                                  newuserconfirmPassword = value;
                                                  confirmpassworderror = null;
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                labelText: 'Confirm Password',
                                              ),
                                            ),
                                          )),
                                      if (confirmpassworderror != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3, bottom: 10.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.all(0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                100,
                                                        child: Text(
                                                          "$confirmpassworderror",
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
                                    ],
                                  ),
                                ),
                              SizedBox(height: 10),
                              Container(
                                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Mobile Number',
                                    ),
                                    initialValue: onlynumber,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        numbererror = "Field can't be empty";
                                      }
                                      if (value!.contains(',')) {
                                        numbererror =
                                            "Invalid input. Please enter numbers only";
                                      }
                                      if (value.contains('.')) {
                                        numbererror =
                                            "Invalid input. Please enter numbers only";
                                      }
                                      if (value.contains('-')) {
                                        numbererror =
                                            "Invalid input. Please enter numbers only";
                                      }
                                      if (value.contains(' ')) {
                                        numbererror =
                                            "Invalid input. Please enter numbers only without any spaces";
                                      }

                                      if (value.length < 10) {
                                        numbererror =
                                            "Please enter full 10 digit number";
                                      }
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        onlynumber = value;
                                        numbererror = null;
                                      });
                                    },
                                  )),
                              if (numbererror != null)
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
                                                  "$numbererror",
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
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
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
                                    if (formkey.currentState!.validate()) {}
                                    if (nameerror == null &&
                                        emailerror == null &&
                                        passworderror == null &&
                                        nameerror == null) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PushNotification(),
                                          ));
                                    }
                                  },
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, ),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                                        },
                                        child: const Text(
                                            'Already have an account?')),
                                  ),
                                ],
                              ),
                            ],
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
