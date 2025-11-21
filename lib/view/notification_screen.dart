// views/notification_screen.dart
import 'package:adminpanel1medilane/view_models/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // pubspec.yaml mein 'intl' package add karein

class NotificationScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const Center(child: Text("No notifications found."));
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];

            return Card(
              // Unread messages ko highlight karein
              color: notification.isRead ? Colors.white : Colors.blue.shade50,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: notification.type == 'order'
                      ? Colors.green.shade100
                      : Colors.blue.shade100,
                  child: Icon(
                    notification.type == 'order'
                        ? Icons.receipt_long
                        : Icons.chat_bubble_outline,
                    color: notification.type == 'order'
                        ? Colors.green
                        : Colors.blue,
                  ),
                ),
                title: Text(
                  notification.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body), // "Saad sent you a message"
                      SizedBox(height: 5),
                      Text(
                        // Time ko format karein
                        DateFormat('dd MMM, h:mm a')
                            .format(notification.timestamp.toDate()),
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                isThreeLine: true,
                onTap: () => controller.onNotificationTapped(notification),
              ),
            );
          },
        );
      }),
    );
  }
}