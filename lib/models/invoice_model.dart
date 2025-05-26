import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String postalCode;
  final String orderDate;
  final double totalPrice;
  final String status;
  final String userId;

  OrderModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.orderDate,
    required this.totalPrice,
    required this.status,
    required this.userId,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data, String id, String userId) {
    // Handle Timestamp to String conversion
    String formattedDate = '';
    if (data['orderDate'] is Timestamp) {
      final timestamp = data['orderDate'] as Timestamp;
      formattedDate = timestamp.toDate().toString(); // you can format it further
    } else if (data['orderDate'] is String) {
      formattedDate = data['orderDate'];
    }

    return OrderModel(
      id: id,
      fullName: data['fullName'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      postalCode: data['postalCode'] ?? '',
      orderDate: formattedDate,
      totalPrice: (data['totalPrice'] is int)
          ? (data['totalPrice'] as int).toDouble()
          : (data['totalPrice'] ?? 0.0),
      status: data['status'] ?? 'pending',
      userId: userId,
    );
  }
}
