// import 'package:flutter/material.dart';
// import '../../models/chat/message_model.dart';

// // class MessageTile extends StatelessWidget {
// //   final MessageModel message;

// //   const MessageTile({super.key, required this.message});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Align(
// //       alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
// //       child: Container(
// //         margin: EdgeInsets.symmetric(vertical: 4),
// //         padding: EdgeInsets.all(12),
// //         constraints: BoxConstraints(maxWidth: 300),
// //         decoration: BoxDecoration(
// //           color: message.isMe ? Colors.green[200] : Colors.white,
// //           borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(12),
// //             topRight: Radius.circular(12),
// //             bottomLeft: Radius.circular(message.isMe ? 12 : 0),
// //             bottomRight: Radius.circular(message.isMe ? 0 : 12),
// //           ),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.shade300,
// //               offset: Offset(1, 1),
// //               blurRadius: 3,
// //             ),
// //           ],
// //         ),
// //         child: Text(
// //           message.text,
// //           style: TextStyle(fontSize: 15),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // lib/views/widgets/message_tile.dart

// // Apne message model ko import karein
// // lib/views/widgets/message_tile.dart
// import 'package:flutter/material.dart';

// // 🛑 FIX: YEH IMPORT SAHI KAREIN
// // Ghalat import (jo aapke paas ho sakta hai): import 'package:medilane/models/message_model.dart';
// // Sahi import (Admin Panel ke project se):
// import 'package:adminpanel1medilane/models/message_model.dart'; 

// class MessageTile extends StatelessWidget {
//   final Message message;
//   final bool isMe; 

//   const MessageTile({
//     super.key, 
//     required this.message,
//     required this.isMe 
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4),
//         padding: EdgeInsets.all(12),
//         constraints: BoxConstraints(maxWidth: 400), 
//         decoration: BoxDecoration(
//           color: isMe ? Colors.green[100] : Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(12),
//             topRight: Radius.circular(12),
//             bottomLeft: Radius.circular(isMe ? 12 : 0),
//             bottomRight: Radius.circular(isMe ? 0 : 12),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               offset: Offset(1, 1),
//               blurRadius: 2,
//             ),
//           ],
//         ),
//         child: Text(
//           message.text,
//           style: TextStyle(fontSize: 15, color: Colors.black87),
//         ),
//       ),
//     );
//   }
// }

// lib/views/widgets/message_tile.dart
import 'package:flutter/material.dart';
import 'package:adminpanel1medilane/models/message_model.dart';
import 'package:intl/intl.dart'; // 1. YEH IMPORT ADD KAREIN

class MessageTile extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageTile({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: isMe ? Colors.green[100] : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(isMe ? 12 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
        
        // 2. CHILD KO TEXT SE COLUMN BANAYEIN
        child: Column(
          // 3. Alignment set karein taake time bhi text ke saath align ho
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // 4. Message Text
            Text(
              message.text,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 5), // Text aur time ke darmiyan thora gap
            
            // 5. YAHAN TIME SHOW KAREIN
            Text(
              // message.timestamp ko DateTime mein convert kar ke format karein
              DateFormat('h:mm a').format(message.timestamp.toDate()),
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}