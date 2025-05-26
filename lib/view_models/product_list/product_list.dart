
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/product_list/product_list.dart';
import 'package:adminpanel1medilane/view_models/product_list/product_list.dart';


class ProductController extends GetxController {
  var searchQuery = ''.obs;
  var filteredProducts = <Product>[].obs;

  var products = <Product>[].obs;
  var selectedQuantities = <String>[].obs;
  final quantitiesOptions = ['20 mg', '30 mg', '50 mg'];

  var selectedImagePath = ''.obs;
  var selectedImageBytes = Uint8List(0).obs;
  var isLoading = false.obs; // Loading state for progress indicator


  var manufactureDate = Rxn<DateTime>();
  var expiryDate = Rxn<DateTime>();
  // Get the current user's UID
  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  void setManufactureDate(DateTime date) {
    manufactureDate.value = date;
  }

  void setExpiryDate(DateTime date) {
    expiryDate.value = date;
  }

  // Method to pick an image
  // Future<void> pickImage() async {
  //   try {
  //     if (kIsWeb) {
  //       FilePickerResult? result = await FilePicker.platform.pickFiles(
  //         type: FileType.image,
  //         allowMultiple: false,
  //         withData: true,
  //       );
  //
  //       if (result != null && result.files.isNotEmpty) {
  //         selectedImageBytes.value = result.files.first.bytes!;
  //         selectedImagePath.value = result.files.first.name;
  //
  //         print('Picked web image: ${selectedImagePath.value}');
  //       } else {
  //         Get.snackbar('Notice', 'No image selected');
  //         print('No file selected on web');
  //       }
  //     } else {
  //       final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //       if (pickedFile != null) {
  //         selectedImagePath.value = pickedFile.path;
  //         print('Picked mobile image: ${selectedImagePath.value}');
  //       } else {
  //         Get.snackbar('Notice', 'No image selected');
  //         print('No image picked on mobile');
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to pick image: $e');
  //     print('Error picking image: $e');
  //   }
  // }



  void updateSearchQuery(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      final lowerQuery = query.toLowerCase();
      final filtered = products.where((product) =>
      product.name.toLowerCase().contains(lowerQuery) ||
          product.id.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery) ||
          product.batchNumber.toLowerCase().contains(lowerQuery)
      ).toList();


      filteredProducts.assignAll(filtered);
    }
  }


  // Future<void> fetchProducts() async {
  //   if (uid == null) {
  //     Get.snackbar('Error', 'User not logged in');
  //     return;
  //   }
  //
  //   try {
  //     isLoading(true);
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('medicalstores')
  //         .doc(uid)
  //         .collection('products')
  //         .get();
  //
  //     products.value = snapshot.docs.map((doc) {
  //       final data = doc.data();
  //       data['id'] = doc.id;
  //       data['name'] = data['name'] ?? '';
  //       data['details'] = data['details'] ?? '';
  //       data['category'] = data['category'] ?? '';
  //       data['batchNumber'] = data['batchNumber'] ?? '';
  //       data['form'] = data['form'] ?? '';
  //       data['imageUrl'] = data['imageUrl'] ?? '';
  //       data['quantitiesAvailable'] = data['quantitiesAvailable'] != null
  //           ? List<String>.from(data['quantitiesAvailable'])
  //           : [];
  //       if (data['expiryDate'] is Timestamp) {
  //         data['expiryDate'] = (data['expiryDate'] as Timestamp).toDate();
  //       }
  //       if (data['manufactureDate'] is Timestamp) {
  //         data['manufactureDate'] = (data['manufactureDate'] as Timestamp).toDate();
  //       }
  //       data['price'] = data['price'] != null ? (data['price'] as double) : 0.0;
  //       data['purchasePrice'] = data['purchasePrice'] != null ? (data['purchasePrice'] as double) : 0.0;
  //       data['quantity'] = data['quantity'] != null ? (data['quantity'] as int) : 0;
  //
  //       return Product.fromMap(data);
  //     }).toList();
  //
  //     // Update filtered list initially to show all
  //     filteredProducts.assignAll(products);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch products: $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }


  // Future<void> pickImage() async {
  //   try {
  //     if (kIsWeb) {
  //       // For Web, use ImagePickerWeb to pick the image and get it as bytes
  //       final pickedFile = await ImagePickerWeb.getImageAsBytes();
  //       if (pickedFile != null) {
  //         selectedImageBytes.value = pickedFile;
  //         selectedImagePath.value = 'image_from_web';  // You can set a default name or modify it
  //       } else {
  //         Get.snackbar('Error', 'No image selected');
  //       }
  //     } else {
  //       // For mobile, use ImagePicker to pick the image from the gallery
  //       final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //       if (pickedFile != null) {
  //         selectedImagePath.value = pickedFile.path;
  //       } else {
  //         Get.snackbar('Error', 'No image selected');
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to pick image: $e');
  //     print('Error picking image: $e');
  //   }
  // }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        selectedImageBytes.value = await pickedFile.readAsBytes();
        selectedImagePath.value = pickedFile.name; // just name on web
      } else {
        selectedImagePath.value = pickedFile.path;
      }
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  // Method to upload image to Firebase Storage
  Future<String> uploadImageToStorage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child('product_images').child(fileName);

    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = ref.putData(
        selectedImageBytes.value,
        SettableMetadata(contentType: 'image/${selectedImagePath.value.split('.').last}',
          // SettableMetadata(contentType: 'image/jpeg'),

        ),
      );
    } else {
      File file = File(selectedImagePath.value);
      uploadTask = ref.putFile(file);
    }
    try {
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Uploaded image URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Upload failed: $e');
      return '';
    }


    // TaskSnapshot snapshot = await uploadTask;
    // String downloadUrl = await snapshot.ref.getDownloadURL();
    // print('Uploaded image URL: $downloadUrl');
    //
    // return downloadUrl;
  }

  // Method to add product
  Future<void> addProduct(String id, String name, String details,String category, String batchNumber, String form, double price, double purchasePrice, int quantity,
      DateTime? expiryDate,  // Add expiryDate parameter
      DateTime? manufactureDate,  // Add manufactureDate parameter
      ) async {
    if (uid == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    if (!kIsWeb && selectedImagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }
    if (kIsWeb && selectedImageBytes.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }

    String imageUrl = await uploadImageToStorage();

    final product = Product(

      id: id,
      name: name,
      imageUrl: imageUrl,
      details: details,
      quantitiesAvailable: selectedQuantities.toList(),
      uid: uid!,  // Store the UID of the medical store/admin user

      category: category,          // e.g., 'Painkiller', 'Antibiotic', etc.
      batchNumber: batchNumber,    // entered manually
      form: form,                  // e.g., 'Tablet', 'Syrup', 'Injection'
      price: price,                // selling price
      purchasePrice: purchasePrice,// price you bought it for (if you track profit margins)
      quantity: quantity,          // total units in stock

      expiryDate: expiryDate,      // Pass nullable DateTime here
      manufactureDate: manufactureDate, // Pass nullable DateTime here
    );

    try {
      // Add product under specific user document in "medicalstores" collection
      final docRef = await FirebaseFirestore.instance
          .collection('medicalstores')
          .doc(uid)
          .collection('products')
          .add(product.toMap());

// Update the product’s internal id to match Firestore document ID
      await docRef.update({'id': docRef.id});

      // Fetch products again to update the list
      await fetchProducts();

      clearSelection();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product: $e');
    }
  }

  // Method to clear selection after adding a product
  void clearSelection() {
    selectedQuantities.clear();
    selectedImagePath.value = '';
    selectedImageBytes.value = Uint8List(0);
    manufactureDate.value = null;
    expiryDate.value = null;
  }

  // Method to toggle quantity selection
  void toggleQuantity(String qty) {
    if (selectedQuantities.contains(qty)) {
      selectedQuantities.remove(qty);
    } else {
      selectedQuantities.add(qty);
    }
  }

  // Method to fetch products for the user
  Future<void> fetchProducts() async {
    if (uid == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      isLoading(true); // Show loading indicator
      final snapshot = await FirebaseFirestore.instance
          .collection('medicalstores')
          .doc(uid)
          .collection('products')
          .get();

      products.value = snapshot.docs.map((doc) {
        final data = doc.data();

        // Handle null values and provide default values
        data['id'] = doc.id;
        data['uid'] = data['uid'] ?? ''; // Default to an empty string if null
        data['name'] = data['name'] ?? ''; // Default to an empty string if null
        data['details'] = data['details'] ?? ''; // Default to an empty string if null
        data['category'] = data['category'] ?? ''; // Default to an empty string if null
        data['batchNumber'] = data['batchNumber'] ?? ''; // Default to an empty string if null
        data['form'] = data['form'] ?? ''; // Default to an empty string if null
        data['imageUrl'] = data['imageUrl'] ?? ''; // Default to an empty string if null
        data['quantitiesAvailable'] = data['quantitiesAvailable'] != null
            ? List<String>.from(data['quantitiesAvailable'])
            : []; // Default to an empty list if null

        // Convert Firestore Timestamp fields to DateTime
        if (data['expiryDate'] is Timestamp) {
          data['expiryDate'] = (data['expiryDate'] as Timestamp).toDate();
        }

        if (data['manufactureDate'] is Timestamp) {
          data['manufactureDate'] = (data['manufactureDate'] as Timestamp).toDate();
        }

        // Handle null values for double fields
        data['price'] = data['price'] != null ? (data['price'] as double) : 0.0; // Default to 0.0 if null
        data['purchasePrice'] = data['purchasePrice'] != null ? (data['purchasePrice'] as double) : 0.0; // Default to 0.0 if null
        data['quantity'] = data['quantity'] != null ? (data['quantity'] as int) : 0; // Default to 0 if null

        // Ensure the required fields are not null when creating the Product instance
        return Product.fromMap(data);
      }).toList();

      filteredProducts.assignAll(products);

    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }
  // Method to delete a product
    Future<void> deleteProduct(String docId) async {
      if (uid == null) {
        Get.snackbar('Error', 'User not logged in');
        return;
      }

      try {
        await FirebaseFirestore.instance
            .collection('medicalstores')  // Collection for medical stores
            .doc(uid)  // Document ID is the user's UID
            .collection('products')  // Subcollection for products
            .doc(docId)  // Document ID for the specific product
            .delete();  // Delete the product document

        products.removeWhere((p) => p.id == docId);
      } catch (e) {
        Get.snackbar('Error', 'Failed to delete product: $e');
      }
    }
}
