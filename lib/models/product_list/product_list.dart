class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String details;
  final List<String> quantitiesAvailable;
  final String uid;
  final String category;          // category (analgesic, antibiotic, etc.)
  final String batchNumber;       // batch code
  final String form;              // tablet, capsule, syrup, etc.
  final double price;             // selling price
  final double purchasePrice;     // buying price
  final int quantity;             // available quantity
  final DateTime? expiryDate;      // expiration date
  final DateTime? manufactureDate; // manufacture date
  // final String storeUid; // <- this is important




  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.details,
    required this.quantitiesAvailable,
    required this.uid,
    required this.category,
    required this.batchNumber,
    required this.form,
    required this.price,
    required this.purchasePrice,
    required this.quantity,
     this.expiryDate,
     this.manufactureDate,
     // this.storeName, // <-- add this
    // required this.storeUid,



  });

  // Convert the product to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'details': details,
      'quantitiesAvailable': quantitiesAvailable,

      'uid': uid,
      'category': category,
      'batchNumber': batchNumber,

      'form': form,
      'price': price,
      'purchasePrice': purchasePrice,
      'quantity': quantity,
      'expiryDate': expiryDate,
      'manufactureDate': manufactureDate,
      // 'storeUid': storeUid,
      // 'storeName': storeName, // <-- add this



    };
  }

  // Create a product instance from Firestore data
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      details: map['details'],
      quantitiesAvailable: List<String>.from(map['quantitiesAvailable']),
      uid: map['uid'],
      category: map['category'],
      batchNumber: map['batchNumber'],
      form: map['form'],
      price: map['price'],
      purchasePrice: map['purchasePrice'],
      quantity: map['quantity'],
      expiryDate: map['expiryDate'],
      manufactureDate: map['manufactureDate'],
      // storeUid: map['storeUid'], // <-- add this



    );
  }
}
