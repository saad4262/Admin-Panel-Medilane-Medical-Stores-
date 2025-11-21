// models/notification_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type;
  final String referenceId;
  bool isRead; // Isay final nahi rakhein taake hum update kar sakein
  final Timestamp timestamp;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.referenceId,
    required this.isRead,
    required this.timestamp,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      title: data['title'] ?? 'No Title',
      body: data['body'] ?? 'No Body',
      type: data['type'] ?? 'general',
      referenceId: data['referenceId'] ?? '',
      isRead: data['isRead'] ?? false,
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}