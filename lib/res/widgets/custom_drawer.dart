// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../view_models/auth_vm/auth_vm.dart';
//
// class CustomDrawer extends StatelessWidget {
//
//   AuthController authController = Get.put(AuthController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             decoration: BoxDecoration(color: Colors.green), // Background color
//             currentAccountPicture: CircleAvatar(
//               radius: 40,
//               backgroundImage: authController.profileImage.value.isNotEmpty
//                   ? NetworkImage(authController.profileImage.value)
//                   :  const AssetImage("assets/images/person1.png"),
//               child: authController.profileImage.value.isEmpty
//                   ? const Icon(Icons.person, size: 30)
//                   : null,
//             ),
//             accountName: Obx(() {
//               return Text(
//                 authController.user.value?.username ?? "",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               );
//             }),
//
//
//             accountEmail: Text(authController.user.value?.email ?? ""),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text("Home"),
//             onTap: () {
//               // Navigate to Home
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text("Profile"),
//             onTap: () {
//               // Navigate to Profile
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text("Settings"),
//             onTap: () {
//               // Navigate to Settings
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text("Logout"),
//             onTap: () {
//               // Logout function
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
