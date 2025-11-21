// lib/models/message_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderID;
  final String receiverID;
  final String text;
  final Timestamp timestamp;
  
  // Yeh local state ke liye hai (Firebase mein save nahi hoga)
  String status; 

  Message({
    required this.id,
    required this.senderID,
    required this.receiverID,
    required this.text,
    required this.timestamp,
    this.status = 'sent', // Default 'sent'
  });

  // Firebase se data lene ke liye
  factory Message.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Message msg = Message(
      id: doc.id,
      senderID: data['senderID'] ?? '',
      receiverID: data['receiverID'] ?? '',
      text: data['text'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
    
    // Status check (Pending/Sent)
    msg.status = doc.metadata.hasPendingWrites ? 'pending' : 'sent';
    return msg;
  }

  // Firebase ko data bhejne ke liye
  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'text': text,
      'timestamp': timestamp,
    };
  }
}