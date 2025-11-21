// // lib/controllers/chat_list_controller.dart (Web specific)
// import 'package:adminpanel1medilane/models/chat_room_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:medilane/controllers/store_auth_controller.dart'; // Store ka AuthController

// class ChatListController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   var chatRooms = <ChatRoom>[].obs;
//   late String storeId;

//   @override
//   void onInit() {
//     super.onInit();
//     // Store ke AuthController se Store ki ID lein
//     // final storeAuthController = Get.find<StoreAuthController>();
//     // storeId = storeAuthController.store.uid;
//     // storeId = "store_xyz"; // TODO: Isay Store Auth se replace karein

//     // chatRooms.bindStream(getChatRooms(storeId));
//     // REAL store user ID
//     final auth = FirebaseAuth.instance;
//     storeId = auth.currentUser!.uid;

//     // Chatrooms stream bind
//     chatRooms.bindStream(getChatRooms(storeId));
//   }

//   Stream<List<ChatRoom>> getChatRooms(String storeId) {
//     return _firestore
//         .collection('chat_rooms')
//         .where(
//           'participants',
//           arrayContains: storeId,
//         ) // Sirf woh chats jin mein store shaamil ho
//         .orderBy('lastMessageTimestamp', descending: true)
//         .snapshots()
//         .map((snapshot) {
//           return snapshot.docs.map((doc) {
//             ChatRoom room = ChatRoom.fromSnapshot(doc);

//             // Yahan hum user ka naam fetch kar sakte hain (lekin yeh advanced hai)
//             // Abhi ke liye hum 'User' hi dikhayenge

//             // TODO: room.otherParticipantName = fetchUserName(room.participants.firstWhere((id) => id != storeId));

//             return room;
//           }).toList();
//         });
//   }
// }
