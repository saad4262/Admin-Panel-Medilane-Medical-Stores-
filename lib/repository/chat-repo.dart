// // lib/data/repository/chat_repository.dart
// import 'package:adminpanel1medilane/models/chat_room_model.dart';
// import 'package:adminpanel1medilane/models/message_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:adminpanel1medilane/models/chat_room_model.dart';

// class ChatRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  

//   Stream<List<ChatRoom>> getChatRoomsForStore(String storeId) {
//     return _firestore
//         .collection('chat_rooms')
//         .where('participants', arrayContains: storeId)
//         .orderBy('lastMessageTimestamp', descending: true)
//         .snapshots()
//         .asyncMap((snapshot) async {
//       List<ChatRoom> rooms = [];
//       for (var doc in snapshot.docs) {
//         ChatRoom room = ChatRoom.fromSnapshot(doc);
//         String userId = room.participants
//             .firstWhere((id) => id != storeId, orElse: () => '');

//         if (userId.isNotEmpty) {
//           // Yahan user ka naam fetch karein
//           // TODO: Aapko 'users' collection se user ka naam fetch karna hoga

//           room.otherParticipantName = "User $userId"; // Abhi ke liye User ID
//         }
//         rooms.add(room);
//       }
//       return rooms;
//     });
//   }

//   // Real-time messages hasil karne ke liye stream
//   Stream<List<Message>> getMessages(String chatRoomId) {
//     return _firestore
//         .collection('chat_rooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true) // Naye message neeche
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => Message.fromSnapshot(doc)).toList();
//     });
//   }

//   // Message bhejne ka function
//   Future<void> sendMessage(String chatRoomId, Message message) async {
//     try {
//       // 1. Message ko messages sub-collection mein add karein
//       await _firestore
//           .collection('chat_rooms')
//           .doc(chatRoomId)
//           .collection('messages')
//           .add(message.toJson());

//       // 2. Chat room ka 'lastMessage' update karein (List screen ke liye)
//       await _firestore.collection('chat_rooms').doc(chatRoomId).set({
//         'lastMessage': message.text,
//         'lastMessageTimestamp': message.timestamp,
//         'participants': [
//           message.senderID,
//           message.receiverID
//         ] // Ensure participants are set
//       }, SetOptions(merge: true)); // Merge true taake purana data delete na ho
//     } catch (e) {
//       // Yahan error handling (e.g., log to server)
//       print("Error sending message: $e");
//       // Exception throw karein taake controller isay catch kar sake
//       throw Exception("Failed to send message");
//     }
//   }

//   // lib/data/repository/chat_repository.dart MEIN YEH ADD KAREIN
// }


// lib/data/repository/chat_repository.dart
import 'package:adminpanel1medilane/models/chat_room_model.dart';
import 'package:adminpanel1medilane/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ChatRoom>> getChatRoomsForStore(String storeId) {
    return _firestore
        .collection('chat_rooms')
        .where('participants', arrayContains: storeId)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .asyncMap((snapshot) async { // 🛑 'asyncMap' zaroori hai
      List<ChatRoom> rooms = [];
      for (var doc in snapshot.docs) {
        ChatRoom room = ChatRoom.fromSnapshot(doc);
        String userId = room.participants
            .firstWhere((id) => id != storeId, orElse: () => '');

        if (userId.isNotEmpty) {
          
          // ======== 🛑 YAHAN SE NAAM GET HOGA ========
          try {
             // 'users' collection se user ka document fetch karein
             DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
             
             if (userDoc.exists) {
               // 'fullName' ya 'name', jo bhi field aapne rakha hai
               room.otherParticipantName = userDoc.get('username') ?? 'User $userId'; 
             } else {
               room.otherParticipantName = "User $userId"; // Agar user document na mile
             }
          } catch(e) {
             print("Error fetching user name: $e"); // Error console mein print karein
             room.otherParticipantName = "User $userId"; // Error ki soorat mein
          }
          // ===========================================

        }
        rooms.add(room);
      }
      return rooms;
    });
  }

  // Real-time messages hasil karne ke liye stream
  Stream<List<Message>> getMessages(String chatRoomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true) // Naye message neeche
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromSnapshot(doc)).toList();
    });
  }

  // Message bhejne ka function
  Future<void> sendMessage(String chatRoomId, Message message) async {
    try {
      // 1. Message ko messages sub-collection mein add karein
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(message.toJson());

      // 2. Chat room ka 'lastMessage' update karein (List screen ke liye)
      await _firestore.collection('chat_rooms').doc(chatRoomId).set({
        'lastMessage': message.text,
        'lastMessageTimestamp': message.timestamp,
        'participants': [
          message.senderID,
          message.receiverID
        ] // Ensure participants are set
      }, SetOptions(merge: true)); // Merge true taake purana data delete na ho
    } catch (e) {
      print("Error sending message: $e");
      throw Exception("Failed to send message");
    }
  }
}