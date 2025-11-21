// lib/models/chat_room_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final Timestamp lastMessageTimestamp;
  
  // Extra data jo humein chahiye
  String otherParticipantName; // Store ko user ka naam dikhane ke liye

  ChatRoom({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTimestamp,
    this.otherParticipantName = 'User', // Default
  });

  factory ChatRoom.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
      id: doc.id,
      participants: List<String>.from(data['participants'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTimestamp: data['lastMessageTimestamp'] ?? Timestamp.now(),
    );
  }
}