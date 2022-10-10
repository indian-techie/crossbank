import 'dart:developer';

import 'package:crossbank/pages/home_page.dart';
import 'package:crossbank/pages/login_page.dart';
import 'package:crossbank/utils/SharedService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState()  {
    // TODO: implement initState
    var sharedservice= SharedService();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token){
      print("token is $token");
      sharedservice.setFcmToken(token!);
    });
    super.initState();
  }
  // @override
  // Future<void> setState(VoidCallback fn) async {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   await Firebase.initializeApp();

  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     routes: {
       '/':(context)=>const LoginPage()
     },
    );
  }
}


