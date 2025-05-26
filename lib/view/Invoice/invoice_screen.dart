//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../res/app_style/app_style.dart';
//
// class InvoiceScreen extends StatefulWidget {
//   @override
//   _InvoiceScreenState createState() => _InvoiceScreenState();
// }
//
// class _InvoiceScreenState extends State<InvoiceScreen> {
//   TextEditingController searchController = TextEditingController();
//   List<Map<String, dynamic>> invoices = [
//     {
//       "id": "#INV001",
//       "name": "John Doe",
//       "email": "john@example.com",
//       "date": "28 Mar 2025",
//       "time": "10:30 AM",
//       "status": "Complete"
//     },
//     {
//       "id": "#INV002",
//       "name": "Emma Watson",
//       "email": "emma@example.com",
//       "date": "29 Mar 2025",
//       "time": "12:45 PM",
//       "status": "Pending"
//     },
//     {
//       "id": "#INV002",
//       "name": "Emma Watson",
//       "email": "emma@example.com",
//       "date": "29 Mar 2025",
//       "time": "12:45 PM",
//       "status": "Pending"
//     },{
//       "id": "#INV002",
//       "name": "Emma Watson",
//       "email": "emma@example.com",
//       "date": "29 Mar 2025",
//       "time": "12:45 PM",
//       "status": "Pending"
//     },{
//       "id": "#INV002",
//       "name": "Emma Watson",
//       "email": "emma@example.com",
//       "date": "29 Mar 2025",
//       "time": "12:45 PM",
//       "status": "Pending"
//     },{
//       "id": "#INV002",
//       "name": "Emma Watson",
//       "email": "emma@example.com",
//       "date": "29 Mar 2025",
//       "time": "12:45 PM",
//       "status": "Pending"
//     },{
//       "id": "#INV002",
//       "name": "Emma Watson",
//       "email": "emma@example.com",
//       "date": "29 Mar 2025",
//       "time": "12:45 PM",
//       "status": "Pending"
//     },{
//       "id": "#INV002",
//       "name": "Emma Watson",
//       "email": "emma@example.com",
//       "date": "29 Mar 2025",
//       "time": "12:45 PM",
//       "status": "Pending"
//     },
//
//     {
//       "id": "#INV003",
//       "name": "Mike Johnson",
//       "email": "mike@example.com",
//       "date": "29 Mar 2025",
//       "time": "02:15 PM",
//       "status": "Complete"
//     },
//   ];
//
//   List<Map<String, dynamic>> filteredInvoices = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredInvoices = invoices;
//   }
//
//   void filterSearch(String query) {
//     // setState(() {
//     //   filteredInvoices = invoices
//     //       .where((invoice) =>
//     //   invoice["name"].toLowerCase().contains(query.toLowerCase()) ||
//     //       invoice["id"].toLowerCase().contains(query.toLowerCase()))
//     //       .toList();
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Invoice List",style: AppStyle.descriptions2,),
//                 Row(
//                   children: [
//                     Container(
//                       width: 200, // Adjust width as needed
//                       decoration: BoxDecoration(
//                         color: Colors.white, // Background color
//                         borderRadius: BorderRadius.circular(12), // Circular border
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2), // Optional shadow for better visibility
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: TextField(
//                         controller: searchController,
//                         decoration: InputDecoration(
//                           hintText: "Search ",
//                           hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),
//
//
//                           suffixIcon: Icon(Icons.search,color: Colors.grey,size: 20,),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12), // Matching circular border
//                             borderSide: BorderSide.none, // Remove default border
//                           ),
//                           filled: true,
//                           fillColor: Colors.white, // Background color inside text field
//                           contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                         ),
//                         onChanged: (value) => filterSearch(value),
//                       ),
//                     ),
//                     SizedBox(width: 20,),
//                     ElevatedButton.icon(
//
//                       onPressed: () {
//                         // Navigate to Add Invoice Screen
//                       },
//                       icon: Icon(Icons.add, color: Colors.white), // White icon color for contrast
//                       label: Text(
//                         "Add New Invoice",
//                         style: TextStyle(color: Colors.white), // White text color for contrast
//                       ),
//                       style: ElevatedButton.styleFrom(
//
//                         backgroundColor: Color(0xff605BFF), // Blue background
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12), // Circular border radius
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust padding
//                       ),
//                     ),
//
//
//                   ],
//                 ),
//
//               ],
//             ),
//             // Add New Invoice Button
//             SizedBox(height: 15),
//
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header Row
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
//                     // color: Colors.grey[200], // Light background for better visibility
//                     child: Row(
//                       children: [
//                         SizedBox(width: 50, child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
//                         Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
//                         Expanded(child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
//                         Expanded(child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold))),
//                         SizedBox(width: 120, child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
//                         SizedBox(width: 15, child: Icon(Icons.delete)), // Menu Icon
//                       ],
//                     ),
//                   ),
//
//                   // **Expanded widget wrapping ListView.builder**
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: filteredInvoices.length,
//                       itemBuilder: (context, index) {
//                         final invoice = filteredInvoices[index];
//                         return Card(
//
//                           color: Colors.white,
//                           elevation: 2,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 16,horizontal: 20), // Row padding
//                             decoration: BoxDecoration(
//                               border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
//                               borderRadius: BorderRadius.circular(10)
//                             ),
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 8), // Column padding
//                                   child: Text(invoice["id"].substring(4)),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 8),
//                                     child: Row(
//                                       children: [
//                                         CircleAvatar(
//                                           child: Icon(Icons.person),
//                                         ),
//                                         SizedBox(width: 8),
//                                         Text(invoice["name"]),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 8),
//                                     child: Text(invoice["email"]),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 8),
//                                     child: Text(invoice["date"]),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 160,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                                     decoration: BoxDecoration(
//                                       color: invoice["status"] == "Complete"
//                                           ? Colors.green.withOpacity(0.2)
//                                           : Colors.orange.withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Text(
//                                       invoice["status"],
//                                       style: TextStyle(
//                                         color: invoice["status"] == "Complete"
//                                             ? Colors.green
//                                             : Colors.orange,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 12), // Adjust padding for menu icon
//                                   child: Icon(Icons.more_vert),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }




  // import 'package:cloud_firestore/cloud_firestore.dart';
  // import 'package:firebase_auth/firebase_auth.dart';
  // import 'package:flutter/cupertino.dart';
  // import 'package:flutter/material.dart';
  // import 'package:get/get.dart';
  // import 'package:get/get_core/src/get_main.dart';
  // import 'package:get/get_rx/src/rx_types/rx_types.dart';
  // import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
  //
  // import 'package:cloud_firestore/cloud_firestore.dart';
  // import 'package:firebase_auth/firebase_auth.dart';
  // import 'package:get/get.dart';

// import '../../models/product_list/product_list.dart';
//
// class InvoiceController extends GetxController with GetSingleTickerProviderStateMixin {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//
//   RxList<Map<String, dynamic>> orders = RxList([]);
//   RxList<Map<String, dynamic>> invoices = RxList([]);
//
//
//   var filteredProducts = <Product>[].obs;
//   var isLoading = false.obs; // Loading state for progress indicator
//
//   RxBool isLoadingOrders = false.obs;
//   RxBool isLoadingInvoices = false.obs;
//
//   late TabController tabController;
//
//   String? get medicalStoreUid => _auth.currentUser?.uid;
//   String? get uid => medicalStoreUid;
//
//   @override
//   void onInit() {
//     super.onInit();
//     tabController = TabController(length: 2, vsync: this);
//     fetchProducts(); // fetch products on init
//
//     fetchInvoices();
//   }
//
//   @override
//   void onClose() {
//     tabController.dispose();
//     super.onClose();
//   }
//
//   Future<void> fetchOrdersForUser(String userUid) async {
//     isLoadingOrders.value = true;
//     try {
//       final snapshot = await _firestore
//           .collection('users')
//           .doc(userUid)
//           .collection('orders')
//           .orderBy('date', descending: true)
//           .get();
//
//       orders.value = snapshot.docs.map((doc) {
//         return {
//           'orderId': doc.id,
//           'userUid': userUid,
//           ...doc.data(),
//         };
//       }).toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch orders: $e');
//     } finally {
//       isLoadingOrders.value = false;
//     }
//   }
//
//   var products = <Product>[].obs;
//
//
//
//   Future<void> fetchProducts() async {
//     if (uid == null) {
//       Get.snackbar('Error', 'User not logged in');
//       return;
//     }
//
//     try {
//       isLoading(true); // Show loading indicator
//       final snapshot = await FirebaseFirestore.instance
//           .collection('medicalstores')
//           .doc(uid)
//           .collection('products')
//           .get();
//
//       products.value = snapshot.docs.map((doc) {
//         final data = doc.data();
//
//         // Handle null values and provide default values
//         data['id'] = doc.id;
//         data['name'] = data['name'] ?? ''; // Default to an empty string if null
//         data['details'] = data['details'] ?? ''; // Default to an empty string if null
//         data['category'] = data['category'] ?? ''; // Default to an empty string if null
//         data['batchNumber'] = data['batchNumber'] ?? ''; // Default to an empty string if null
//         data['form'] = data['form'] ?? ''; // Default to an empty string if null
//         data['imageUrl'] = data['imageUrl'] ?? ''; // Default to an empty string if null
//         data['quantitiesAvailable'] = data['quantitiesAvailable'] != null
//             ? List<String>.from(data['quantitiesAvailable'])
//             : []; // Default to an empty list if null
//
//         // Convert Firestore Timestamp fields to DateTime
//         if (data['expiryDate'] is Timestamp) {
//           data['expiryDate'] = (data['expiryDate'] as Timestamp).toDate();
//         }
//
//         if (data['manufactureDate'] is Timestamp) {
//           data['manufactureDate'] = (data['manufactureDate'] as Timestamp).toDate();
//         }
//
//         // Handle null values for double fields
//         data['price'] = data['price'] != null ? (data['price'] as double) : 0.0; // Default to 0.0 if null
//         data['purchasePrice'] = data['purchasePrice'] != null ? (data['purchasePrice'] as double) : 0.0; // Default to 0.0 if null
//         data['quantity'] = data['quantity'] != null ? (data['quantity'] as int) : 0; // Default to 0 if null
//
//         // Ensure the required fields are not null when creating the Product instance
//         return Product.fromMap(data);
//       }).toList();
//
//       filteredProducts.assignAll(products);
//
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch products: $e');
//     } finally {
//       isLoading(false); // Hide loading indicator
//     }
//   }
//   // New method: creates separate invoices grouped by medical store (adminId)
//   Future<void> createInvoicesForOrder({
//     required String userUid,
//     required String orderId,
//   }) async {
//     try {
//       final orderDoc = await _firestore
//           .collection('users')
//           .doc(userUid)
//           .collection('orders')
//           .doc(orderId)
//           .get();
//
//       if (!orderDoc.exists) {
//         Get.snackbar('Error', 'Order not found');
//         return;
//       }
//
//       final orderData = orderDoc.data()!;
//       final List<dynamic> allProducts = orderData['products'] ?? [];
//
//       if (allProducts.isEmpty) {
//         Get.snackbar('Info', 'No products found in order');
//         return;
//       }
//
//       // Group products by adminId
//       Map<String, List<Map<String, dynamic>>> productsByAdmin = {};
//
//       for (var product in allProducts) {
//         final adminId = product['adminId'] ?? 'unknown';
//         final productWithId = Map<String, dynamic>.from(product);
//         productWithId['productId'] = product['productId'] ?? 'unknown';
//
//         if (productsByAdmin.containsKey(adminId)) {
//           productsByAdmin[adminId]!.add(productWithId);
//         } else {
//           productsByAdmin[adminId] = [productWithId];
//         }
//       }
//
//       // Create invoice for each medical store group
//       for (var entry in productsByAdmin.entries) {
//         final adminId = entry.key;
//         final products = entry.value;
//
//         // Calculate total price for this admin's products
//         double totalPrice = 0.0;
//         for (var product in products) {
//           final price = product['price'] ?? 0.0;
//           final quantity = product['quantity'] ?? 0;
//           totalPrice += price * quantity;
//         }
//
//         final invoiceData = {
//           'invoiceNumber': 'INV-$orderId-$adminId',
//           'orderId': orderId,
//           'userUid': userUid,
//           'date': DateTime.now().toIso8601String(),
//           'totalPrice': totalPrice,
//           'status': 'pending',
//           'products': products,
//           'adminId': adminId,
//         };
//
//         await _firestore
//             .collection('medicalstores')
//             .doc(adminId)
//             .collection('invoices')
//             .doc(orderId) // Consider generating a new ID if multiple invoices for same order per store are needed
//             .set(invoiceData);
//       }
//
//       Get.snackbar('Success', 'Invoices created for all medical stores involved');
//
//       fetchInvoices();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create invoices: $e');
//     }
//   }
//
//   Future<void> fetchInvoices() async {
//     final uid = medicalStoreUid;
//     if (uid == null) return;
//
//     isLoadingInvoices.value = true;
//     try {
//       final snapshot = await _firestore
//           .collection('medicalstores')
//           .doc(uid)
//           .collection('invoices')
//           .orderBy('date', descending: true)
//           .get();
//
//       invoices.value = snapshot.docs.map((doc) {
//         return {
//           'invoiceId': doc.id,
//           ...doc.data(),
//         };
//       }).toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch invoices: $e');
//     } finally {
//       isLoadingInvoices.value = false;
//     }
//   }
// }
//
//
//
//
// class InvoiceListPage extends StatelessWidget {
//   final InvoiceController controller = Get.put(InvoiceController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoices'),
//       ),
//       body: Obx(() {
//         if (controller.isLoadingInvoices.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.invoices.isEmpty) {
//           return Center(child: Text('No invoices found'));
//         }
//
//         return ListView.separated(
//           padding: EdgeInsets.all(12),
//           itemCount: controller.invoices.length,
//           separatorBuilder: (_, __) => Divider(),
//           itemBuilder: (context, index) {
//             final invoice = controller.invoices[index];
//
//             return ListTile(
//               leading: Icon(Icons.receipt_long, color: Colors.blueAccent),
//               title: Text(invoice['invoiceNumber'] ?? 'Invoice #${invoice['invoiceId']}'),
//               subtitle: Text(
//                 'Date: ${invoice['date'] != null ? DateTime.parse(invoice['date']).toLocal().toString().split(' ')[0] : 'N/A'}\n'
//                     'Total: \$${(invoice['totalPrice'] ?? 0).toStringAsFixed(2)}\n'
//                     'Status: ${invoice['status'] ?? 'unknown'}',
//                 style: TextStyle(fontSize: 13),
//               ),
//               isThreeLine: true,
//               trailing: Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 // You can navigate to invoice detail page here
//                 Get.snackbar('Invoice Tapped', 'Invoice ID: ${invoice['invoiceId']}');
//               },
//             );
//           },
//         );
//       }),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.refresh),
//         onPressed: () {
//           controller.fetchInvoices();
//         },
//       ),
//     );
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/invoice_model.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllOrdersFromAllUsers();
  }

  Future<void> fetchAllOrdersFromAllUsers() async {
    try {
      final usersSnapshot = await _firestore.collection('users').get();

      List<OrderModel> allOrders = [];

      for (var userDoc in usersSnapshot.docs) {
        String userId = userDoc.id;

        final ordersSnapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('orders')
            .get();

        for (var doc in ordersSnapshot.docs) {
          final data = doc.data();
          final order = OrderModel.fromMap(data, doc.id, userId);
          allOrders.add(order);
        }
      }

      orders.assignAll(allOrders);
      print("✅ Total Orders Fetched: ${orders.length}");
    } catch (e) {
      print('❌ Error fetching all user orders: $e');
    }
  }
}



class InvoiceScreen extends StatelessWidget {
  final InvoiceController controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    controller.fetchAllOrdersFromAllUsers();
    return Scaffold(
      appBar: AppBar(title: const Text("All Orders")),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return const Center(child: Text("No orders found."));
        }

        return ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final OrderModel order = controller.orders[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(order.fullName),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone: ${order.phone}"),
                      Text("City: ${order.city}"),
                      Text("Address: ${order.address}"),
                      Text("Postal Code: ${order.postalCode}"),
                      Text("Total: \$${order.totalPrice.toStringAsFixed(2)}"),
                      Text("Status: ${order.status}"),
                      Text("Date: ${order.orderDate}"),
                      Text("UserID: ${order.userId}"),
                    ],
                  ),
                ),
                isThreeLine: true,
                trailing: const Icon(Icons.receipt_long),
              ),
            );
          },
        );
      }),
    );
  }
}
