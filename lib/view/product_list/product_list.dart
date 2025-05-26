import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../res/app_style/app_style.dart';
import '../../res/colors/app_color.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/widgets/custom_button.dart';
import '../../view_models/product_list/product_list.dart';


class ProductScreen extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final detailsController = TextEditingController();
  final categoryController = TextEditingController(); // Added category controller
  final batchController = TextEditingController(); // Added batch number controller
  final formController = TextEditingController(); // Added form controller
  final priceController = TextEditingController(); // Added price controller
  final purchasePriceController = TextEditingController(); // Added purchase price controller
  final quantityController = TextEditingController(); // Added quantity controller
  DateTime? expiryDate;
  DateTime? manufactureDate;

  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Fetch products when the screen is built
    controller.fetchProducts();
    final mediaQuery = MediaQueryHelper(context);


    return Scaffold(

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Product List",style: AppStyle.headings2,),
              Row(
                children: [
                  Container(
                    width: 200, // Adjust width as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(12), // Circular border
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Optional shadow for better visibility
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        controller.updateSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search ",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),


                        suffixIcon: Icon(Icons.search,color: Colors.grey,size: 20,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12), // Matching circular border
                          borderSide: BorderSide.none, // Remove default border
                        ),
                        filled: true,
                        fillColor: Colors.white, // Background color inside text field
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      // onChanged: (value) => filterSearch(value),
                    ),
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton.icon(

                    onPressed: () => _showAddProductDialog(context),

                  icon: Icon(Icons.add, color: Colors.white), // White icon color for contrast
                    label: Text(
                      "Add Product",
                      style: TextStyle(color: Colors.white), // White text color for contrast
                    ),
                    style: ElevatedButton.styleFrom(

                      backgroundColor: Color(0xff605BFF), // Blue background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Circular border radius
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust padding
                    ),
                  ),


                ],
              ),

            ],
          ),
SizedBox(height: mediaQuery.height(3),),
          Obx(() {
            return controller.filteredProducts.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,

                        child: Container(
                          height: mediaQuery.height(70),
                          child: DataTable(


                            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                            columnSpacing: 20,
                            dataRowHeight: 80,
                            dividerThickness: 1, // thickness of the line between rows


                            headingTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            columns: [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Image')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Quantities')),
                              DataColumn(label: Text('Details')),
                              DataColumn(label: Text('category')),
                              DataColumn(label: Text('batchNumber')),
                              DataColumn(label: Text('form')),
                              DataColumn(label: Text('price')),
                              DataColumn(label: Text('purchasePrice')),
                              DataColumn(label: Text('quantity')),
                              DataColumn(label: Text('expiryDate')),
                              DataColumn(label: Text('manufactureDate')),
                              DataColumn(label: Text('Actions')),


                            ],
                            rows: controller.filteredProducts.map((product) {
                              print(product.imageUrl); // ✅ Print it separately

                              return DataRow(
                                  cells: [
                                DataCell(
                                    Text(
                                  product.id,
                                  style: AppStyle.descriptions.copyWith(fontSize: 10,fontWeight: FontWeight.bold),
                                )),

                                    DataCell(
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.grey[200],
                                        child: ClipOval(  // Ensure the image stays within the circle
                                          child: Image.network(
                                            product.imageUrl,
                                            fit: BoxFit.cover,  // Use BoxFit.cover to fill the CircleAvatar
                                            width: double.infinity,  // Make sure the image occupies the full space of the CircleAvatar
                                            height: double.infinity, // Make sure the image occupies the full space of the CircleAvatar
                                          ),
                                        ),
                                      ),
                                    ),

                                    DataCell(Text(
                                  product.name,
                                  style: AppStyle.descriptions.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
                                )),
                                DataCell(Text(
                                  product.quantitiesAvailable.join(', '),
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.details,
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.category,
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.batchNumber,
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.form ?? '',
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.price?.toString() ?? '0',
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.purchasePrice?.toString() ?? '0',
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.quantity?.toString() ?? '0',
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.expiryDate?.toString() ?? '',
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),
                                DataCell(Text(
                                  product.manufactureDate?.toString() ?? '',
                                  style: AppStyle.descriptions.copyWith(fontSize: 10),
                                )),



                                DataCell(ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[50],
                                    foregroundColor: Colors.red,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: Icon(Icons.delete),
                                  label: Text('Delete'),
                                  onPressed: () => controller.deleteProduct(product.id),
                                )),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.add),
      //   label: Text('Add Product'),
      //   onPressed: () => _showAddProductDialog(context),
      // ),
    );
  }

  // Function to show the Add Product Dialog
  void _showAddProductDialog(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    Get.defaultDialog(
      radius: 10,
      title: 'Add Product',
      titleStyle: AppStyle.headings2,
      content: Container(
        height: mediaQuery.height(80),

        width: mediaQuery.width(40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // First Row with two fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: idController,
                      decoration: InputDecoration(
                        hintText: "Enter ID",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),



                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefixIcon: Icon(Icons.inventory_outlined,color: Colors.grey,),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade300),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Enter Medicine Name",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),



                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefixIcon: Icon(Icons.medical_information,color: Colors.grey,),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Second Row with two fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: detailsController,
                      decoration: InputDecoration(
                        hintText: "Enter Category",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),



                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefixIcon: Icon(Icons.details,color: Colors.grey,),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade300),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        hintText: "Enter Category",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),



                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefixIcon: Icon(Icons.category,color: Colors.grey,),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Third Row with two fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(

                      child: TextField(
                        controller: batchController,
                        decoration: InputDecoration(
                          hintText: "Enter batch number",
                          hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),



                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          prefixIcon: Icon(Icons.batch_prediction,color: Colors.grey,),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red.shade300),
                          ),
                        ),

                      ),
                    ),


                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: formController,
                      decoration: InputDecoration(
                        hintText: "Form (e.g. Tablet, Syrup)",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),



                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefixIcon: Icon(Icons.medical_information,color: Colors.grey,),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade300),
                        ),
                      ),

                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Fourth Row with two fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        hintText: "Enter Price",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),


                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefixIcon: Icon(Icons.price_change_rounded,color: Colors.grey,),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade300),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: purchasePriceController,
                      decoration: InputDecoration(
                        hintText: "Enter Purchased Price",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),


                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefixIcon: Icon(Icons.price_change_sharp,color: Colors.grey,),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade300),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Fifth Row with two fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        hintText: "Enter Stock Quantity",
                        hintStyle: AppStyle.descriptions.copyWith(color: Colors.grey),



                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefixIcon: Icon(Icons.inventory,color: Colors.grey,),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red.shade300),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  // Leave this empty for spacing if no second field in this row
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final selectedExpiryDate = await showDatePicker(
                        context: Get.context!,
                        initialDate: controller.expiryDate.value ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (selectedExpiryDate != null) {
                        controller.setExpiryDate(selectedExpiryDate);
                      }
                    },
                    icon: const Icon(Icons.event_available, color: Colors.white),
                    label: Text(
                      controller.expiryDate.value == null
                          ? 'Select Expiry Date'
                          : DateFormat('yyyy-MM-dd').format(controller.expiryDate.value!),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.greenMain, // premium color for expiry button
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black45,
                    ),
                  ),
                  SizedBox(width: 10),

      ElevatedButton.icon(
      onPressed: () async {
    final selectedManufactureDate = await showDatePicker(
    context: Get.context!,
    initialDate: controller.manufactureDate.value ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    );

    if (selectedManufactureDate != null) {
    controller.setManufactureDate(selectedManufactureDate);
    }
    },
      icon: const Icon(Icons.calendar_today, color: Colors.white),
      label: Text(
        controller.manufactureDate.value == null
            ? 'Select Manufacture Date'
            : DateFormat('yyyy-MM-dd').format(controller.manufactureDate.value!),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.greenMain, // primary color
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        shadowColor: Colors.black45,
      ),
    ),

                ],
              ),
              SizedBox(height: 10),


              // Image Picker
              Obx(() {
                if (kIsWeb) {
                  return controller.selectedImageBytes.value.isEmpty
                      ? ElevatedButton(onPressed: controller.pickImage, child: Text('Pick Image'))
                      : Image.memory(controller.selectedImageBytes.value, height: 100);
                } else {
                  return controller.selectedImagePath.value.isEmpty
                      ? ElevatedButton(onPressed: controller.pickImage, child: Text('Pick Image'))
                      : Image.file(File(controller.selectedImagePath.value), height: 100);
                }
              }),
              SizedBox(height: 20),

              // Select Quantities
              Text('Select Quantities',style: AppStyle.descriptions,),
              SizedBox(height: 20),

              Obx(() => Wrap(
                spacing: 12.0,
                runSpacing: 8.0,
                children: controller.quantitiesOptions.map((qty) {
                  final isSelected = controller.selectedQuantities.contains(qty);
                  return ChoiceChip(

                    label: Text(
                      qty,
                      style: AppStyle.descriptions.copyWith(color: isSelected ? AppColor.whiteColor : AppColor.blueMain,
                      )
                    ),
                    selected: isSelected,
                    selectedColor: AppColor.blueMain, // premium selected color
                    backgroundColor:Color(0xffF5F4F8),  // background when not selected
                    elevation: 4,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isSelected ? AppColor.blueMain : Color(0xffF5F4F8),
                        width: 1.5,
                      ),
                    ),
                    checkmarkColor: AppColor.whiteColor,
                    onSelected: (selected) {
                      controller.toggleQuantity(qty);
                    },
                    pressElevation: 6,
                  );
                }).toList(),
              )),
              SizedBox(height: 20),


              // Save Button
              SizedBox(
                width: double.infinity,
                child:Obx(() =>  CustomButton(

                  text: "Add",


                  onPressed: () async {
                    // Check if fields are filled properly before adding product
                    if (idController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        detailsController.text.isEmpty ||
                        categoryController.text.isEmpty ||
                        batchController.text.isEmpty ||
                        formController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        purchasePriceController.text.isEmpty ||
                        quantityController.text.isEmpty ||
                        controller.expiryDate.value == null ||
                        controller.manufactureDate.value == null) {
                      Get.snackbar('Error', 'All fields must be filled!');
                      return;
                    }


                    await controller.addProduct(
                      idController.text.trim(),
                      nameController.text.trim(),
                      detailsController.text.trim(),
                      categoryController.text.trim(),
                      batchController.text.trim(),
                      formController.text.trim(),
                      double.parse(priceController.text.trim()),
                      double.parse(purchasePriceController.text.trim()),
                      int.parse(quantityController.text.trim()),
                      controller.expiryDate.value,
                      controller.manufactureDate.value,


                    );

                    // Clear controllers after saving the product
                    idController.clear();
                    nameController.clear();
                    detailsController.clear();
                    categoryController.clear();
                    batchController.clear();
                    formController.clear();
                    priceController.clear();
                    purchasePriceController.clear();
                    quantityController.clear();
                    Get.back();  // Close the dialog
                  },

                  isLoading: controller.isLoading.value,
                  color: AppColor.greenMain,
                  textColor: AppColor.whiteColor,
                  borderRadius: 12,
                  isFullWidth: false,
                  height: mediaQuery.height(7),
                  width: mediaQuery.width(70),
                )),

                // child: ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 14),
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                //   ),
                //   onPressed: authController.isLoading.value
                //       ? null
                //       : authController.handleAuth,
                //   child: authController.isLoading.value
                //       ? const CircularProgressIndicator(color: Colors.white)
                //       : Text(
                //     authController.isLogin.value ? "Login" : "Sign Up",
                //     style: const TextStyle(fontSize: 16),
                //   ),
                // ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

