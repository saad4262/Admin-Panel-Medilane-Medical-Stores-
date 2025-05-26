// import 'package:adminpanel1medilane/view/dashboard/dashboard.dart';
// import 'package:adminpanel1medilane/view/login/login_screen1.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import 'firebase_options.dart';
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform
//
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//
//       ),
//       home: const AdminPanelApp(),
//     );
//   }
// }
//
// class AdminPanelApp extends StatelessWidget {
//   const AdminPanelApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       // theme: ThemeData.dark(),
//       home: const AdminDashboard(),
//     );
//   }
// }



import 'package:adminpanel1medilane/view/login/login_screen1.dart';
import 'package:adminpanel1medilane/view/dashboard/dashboard.dart';
import 'package:adminpanel1medilane/view_models/auth_vm/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: FirebaseOptions(apiKey: "AIzaSyA4FZnKhOzVO24b4bieRHRuk_0I9wywN2Q",
    //   authDomain: "medilane-8bdc2.firebaseapp.com",
    //   projectId: "medilane-8bdc2",
    //   storageBucket: "medilane-8bdc2.appspot.com",
    //   messagingSenderId: "642155354036",
    //   appId: "1:642155354036:web:1a491506f2a8b5f8b744e1",)

  );

  // Initialize AuthController using Get.put()
  Get.put(AuthController3());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  AuthWrapper(),
    );
  }
}
