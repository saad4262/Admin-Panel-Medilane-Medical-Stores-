// controllers/notification_controller.dart
import 'package:adminpanel1medilane/models/notification_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Real-time updates ke liye .snapshots() istemal karein
    notifications.bindStream(fetchNotificationsStream());
  }

  // Real-time stream
  Stream<List<NotificationModel>> fetchNotificationsStream() {
    return _firestore
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NotificationModel.fromFirestore(doc))
          .toList();
    });
  }

  // Notification ko "Read" mark karein
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
      // Local list bhi update ho jayegi stream ki wajah se
    } catch (e) {
      print("Error marking as read: $e");
    }
  }

  // TODO: Yahan navigation logic add karein
  void onNotificationTapped(NotificationModel notification) {
    markAsRead(notification.id);
    
    if (notification.type == 'order') {
      // Order screen par navigate karein
      print("Navigating to Order ID: ${notification.referenceId}");
      // Get.to(() => SpecificOrderScreen(orderId: notification.referenceId));
    } else if (notification.type == 'message') {
      // Chat screen par navigate karein
      print("Navigating to Chat ID: ${notification.referenceId}");
      // Get.to(() => WebChatScreen(chatRoomId: notification.referenceId));
    }
  }
}