


import 'package:adminpanel1medilane/res/app_style/app_style.dart';
import 'package:adminpanel1medilane/view_models/auth_vm/auth_vm.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../res/assets/image_assets.dart';
import '../../res/colors/app_color.dart';
import '../../res/media-queries/media_query.dart';
import '../../view_models/dashboard_vm/dashboard_vm.dart';
import '../Invoice/invoice_screen.dart';
import '../chat/chat_screen.dart';
import '../product_list/product_list.dart';


class AdminDashboard extends StatelessWidget {
   AdminDashboard({super.key});

  AuthController3 authController = Get.put(AuthController3());



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);


    final AdminController controller = Get.put(AdminController());
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isFullScreen = constraints.maxWidth > 1300;
        return Scaffold(
          appBar: isFullScreen ? null : AppBar(title: const Text("Medical Store Admin Panel")),
          body: Row(
            children: [
              if (isFullScreen)
                Expanded(
                  flex: 2,
                  child: Drawer(
                    backgroundColor: AppColor.whiteColor,

                    child: Column(
                      children: [
                       DrawerHeader(


                           child: Padding(
                         padding: const EdgeInsets.all(16),
                         child: Row(
                           children: [
                             Image.asset("assets/images/logo.png"),
                             // SizedBox(width: mediaQuery.width(1),),
                             // Text("MediLane",   style: TextStyle(
                             //   fontSize: 20,
                             //   // color: Colors.white,
                             //   fontWeight: FontWeight.bold,
                             // ),)

                             ]
                         ),
                       )



                       ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              menuItem(context,controller, "Dashboard", Icons.dashboard),
                              menuItem(context,controller, "Analytics", Icons.analytics_rounded),
                              menuItem(context,controller, "Invoice", Icons.inventory_outlined),
                              menuItem(context,controller, "Message", Icons.message_sharp),
                              menuItem(context,controller, "Product List", Icons.production_quantity_limits),
                              menuItem(context,controller, "Notification", Icons.notifications),
                              menuItem(context,controller, "Settings", Icons.settings),
                              menuItem(context,controller, "Logout", Icons.logout),

                            ],
                          ),
                        ),
                        // Profile Section at the Bottom
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/images/person1.png"), // Replace with your profile image path
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    authController.user.value?.medicalstoreName ?? "",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),
                                  ),
                                  Text(
                                    "Admin",
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                flex: 8,
                child: Obx(() {
                  return Padding(
                    padding: mediaQuery.paddingAll(2),
                    child: getSelectedScreen(context,controller.selectedMenu.value),
                  );
                }),
              ),
            ],
          ),
          drawer: isFullScreen ? null : Drawer(
            backgroundColor: AppColor.whiteColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: AppColor.blueMain),
                  child: Text("Admin Menu", style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                menuItem(context,controller, "Dashboard", Icons.dashboard),
                menuItem(context,controller, "Analytics", Icons.medical_services),
                menuItem(context,controller, "Invoice", Icons.people),
                menuItem(context,controller, "Message", Icons.bar_chart),
                menuItem(context,controller, "Product List", Icons.bar_chart),

                menuItem(context,controller, "Notification", Icons.logout),
                menuItem(context,controller, "Settings", Icons.logout),
                menuItem(context,controller, "Logout", Icons.logout),

              ],
            ),
          ),
        );
      },
    );
  }

   Widget menuItem(BuildContext context, AdminController controller, String title, IconData icon) {
     final mediaQuery = MediaQueryHelper(context);

     return Obx(() {
       bool isSelected = controller.selectedMenu.value == title;

       return Padding(
         padding: mediaQuery.paddingAll(.25),
         child: ListTile(
           leading: Icon(
             icon,
             color: isSelected ? Color(0xFF605BFF) : Colors.black, // ✅ selected icon color
           ),
           title: Text(
             title,
             style: AppStyle.descriptions.copyWith(
               color: isSelected ? Color(0xFF605BFF) : Colors.black, // ✅ selected text color
               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // optional: bold on select
             ),
           ),
           selected: isSelected,
           selectedTileColor: Color(0xFF605BFF).withOpacity(0.1), // ✅ optional: light background highlight
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(8), // ✅ smoother highlight shape
           ),
           onTap: () => controller.selectedMenu.value = title,
         ),
       );
     });
   }

  Widget getSelectedScreen(BuildContext context,String selectedMenu) {
    switch (selectedMenu) {
      case "Dashboard":
        return dashboardScreen(context);
      case "Invoice":
        return invoiceScreen(context);
      case "Message":
        return ChatScreen();
      case "Product List":
        return ProductScreen();
      case "Logout":
        authController.logout();
        return const SizedBox.shrink();

      default:
        return const Center(child: Text("Welcome"));
    }
  }
  
  Widget invoiceScreen(BuildContext context){
    final mediaQuery = MediaQueryHelper(context);

    return InvoiceScreen();
  }
  
  

  Widget dashboardScreen(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Column(
      children: [
        // Top Row: Dashboard Cards
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _dashboardCard(context,"Total Revenue", "120k+", Icons.attach_money),
            _dashboardCard(context,"Total Order", "10k+", Icons.medical_information),
            _dashboardCard(context,"Total Customers", "350k+", Icons.people),
            _dashboardCard(context,"Pending Delivery", "200k+", Icons.pending),
          ],
        ),
         SizedBox(height: mediaQuery.height(.02),),

        // Main Content: Left and Right Panels
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side: GridView and Orders List
              Expanded(
                flex: 2, // 60% of the width
                child: Column(
                  children: [

                    // GridView for Items

                    Expanded(
                      flex: 2,
                      child: Container(
                        margin:mediaQuery.marginAll(1), // Adds padding around the chart
                        padding: mediaQuery.paddingAll(.6), // Adds inner padding
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12), // Rounded corners for the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3), // Offset for the shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,

                              child: Text(
                                "Analytics",
                                style: AppStyle.descriptions2,
                              ),
                            ),
                             SizedBox(height: mediaQuery.height(5)),
                            Expanded(

                                child: BarChart(
                                  BarChartData(
                                    barGroups: List.generate(12, (index) {
                                      return BarChartGroupData(
                                        x: index,
                                        barRods: [
                                          BarChartRodData(
                                            toY: (index + 1) * 10.0, // Example values for each month
                                            gradient: const LinearGradient(
                                              colors: [Colors.blue, Colors.lightBlueAccent],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                            width: mediaQuery.width(1.3),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ],
                                      );
                                    }),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 60,
                                          getTitlesWidget: (value, meta) {
                                            switch (value.toInt()) {
                                              case 0:
                                                return  Padding(
                                                  padding: mediaQuery.paddingOnly(top: 1),
                                                  child: Text("JAN", style: AppStyle.smallDescriptions),
                                                );
                                              case 1:
                                                return  Padding(
                                                  padding: mediaQuery.paddingOnly(top: 1),
                                                  child: Text("FEB", style: AppStyle.smallDescriptions),
                                                );
                                              case 2:
                                                return  Padding(
                                                  padding: mediaQuery.paddingOnly(top: 1),
                                                  child: Text("MAR", style:AppStyle.smallDescriptions),
                                                );
                                              case 3:
                                                return  Padding(
                                                  padding: mediaQuery.paddingOnly(top: 1),
                                                  child: Text("APR", style: AppStyle.smallDescriptions),
                                                );
                                              case 4:
                                                return  Padding(
                                                  padding: mediaQuery.paddingOnly(top: 1),
                                                  child: Text("MAY", style: AppStyle.smallDescriptions),
                                                );
                                              case 5:
                                                return  Padding(
                                                  padding: mediaQuery.paddingOnly(top: 1),
                                                  child: Text("JUN", style: AppStyle.smallDescriptions),
                                                );
                                              case 6:
                                                return  Padding(
                                                  padding:mediaQuery.paddingOnly(top: 1),
                                                  child: Text("JUL", style: AppStyle.smallDescriptions),
                                                );
                                              case 7:
                                                return  Padding(
                                                  padding: mediaQuery.paddingOnly(top: 1),
                                                  child: Text("AUG", style: AppStyle.smallDescriptions),
                                                );
                                              case 8:
                                                return  Padding(
                                                  padding: mediaQuery.paddingOnly(top: 1),
                                                  child: Text("SEP", style: AppStyle.smallDescriptions),
                                                );
                                              case 9:
                                                return Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Text("OCT", style: AppStyle.smallDescriptions),
                                                );
                                              case 10:
                                                return Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Text("NOV", style: AppStyle.smallDescriptions),
                                                );
                                              case 11:
                                                return Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Text("DEC", style: AppStyle.smallDescriptions),
                                                );
                                              default:
                                                return const Text("");
                                            }
                                          },
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            if (value % 10 == 0) { // Show labels only for values divisible by 10
                                              return Padding(
                                                padding: const EdgeInsets.only(left: 8.0), // Add padding to the left
                                                child: Text(
                                                  "${(value / 10).toInt()}k", // Format the label with 'k'
                                                  style: AppStyle.smallDescriptions
                                                ),
                                              );
                                            }
                                            return const SizedBox.shrink(); // Return empty widget for other values
                                          },
                                          reservedSize: 50, // Reserve space for the labels on the Y-axis
                                        ),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                    ),
                                    gridData: FlGridData(
                                      show: true,
                                      drawHorizontalLine: true,
                                      drawVerticalLine: false,
                                      horizontalInterval:10,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                          color: Colors.grey.shade300,
                                          strokeWidth: 1.5,
                                        );
                                      },
                                    ),
                                    borderData: FlBorderData(show: false),
                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipMargin: 8,
                                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                          return BarTooltipItem(
                                            "${rod.toY.toInt()}k",
                                            const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )


                            ),
                          ],
                        ),
                      ),
                    ),



                    Expanded(
                      flex: 1,
                      child:  Container(
                        margin: mediaQuery.marginAll(1),
                        padding: mediaQuery.paddingAll(.6),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(12), // Rounded corners for the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3), // Offset for the shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Recent Orders",
                                style: AppStyle.descriptions2
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                                child: Column(
                                  children: [
                                    // Heading Row: Displayed Once
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between headings
                                        children:  [
                                          Expanded(child: Text("ID", style: AppStyle.smallDescriptions)),
                                          Expanded(child: Text("Product Name", style: AppStyle.smallDescriptions)),
                                          Expanded(child: Text("Price", style: AppStyle.smallDescriptions)),
                                          Expanded(child: Text("Quantity", style: AppStyle.smallDescriptions)),
                                          Expanded(child: Text("Total Amount", style: AppStyle.smallDescriptions)),
                                        ],
                                      ),
                                    ),

                                    // List Items
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: 15, // Example item count
                                        itemBuilder: (context, index) {
                                          // Mock data for the attributes (replace this with actual data)
                                          final id = "ID-${index + 1}";
                                          final productName = "Brufen";
                                          final price = (index + 1) * 10;
                                          final quantity = index + 1;
                                          final totalAmount = price * quantity;

                                          return Padding(
                                            padding: mediaQuery.paddingSymmetric(vertical: .25,horizontal: .5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between attributes
                                              children: [
                                                Expanded(child: Text("$id", style: AppStyle.extraSmallDescriptions)),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor : Colors.green,
                                                          radius: 20,
                                                          child: Image.asset("assets/images/med1.jpg"),
                                                      ),
                                                       SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          "$productName",
                                                          style: AppStyle.extraSmallDescriptions,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(child: Text("\$${price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 10))),
                                                Expanded(


                                                  child: Text(
                                                    "$quantity",
                                                    style:  AppStyle.extraSmallDescriptions,

                                                    textAlign: TextAlign.justify,
                                                  ),

                                                ),
                                                Expanded(child: Text("\$${totalAmount.toStringAsFixed(2)}", style: AppStyle.extraSmallDescriptions)),
                                              ],
                                            ),

                                          );

                                        },
                                      ),
                                    ),

                                  ],
                                )

                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

               SizedBox(width: mediaQuery.width(2)), // Spacer between left and right sides

              // Right Side: PieChart, LineChart, and Top Selling Products
              Expanded(
                flex: 1, // 40% of the width
                child: Column(
                  children: [
                    // PieChart


                    // LineChart
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: mediaQuery.marginAll(1), // Adds padding around the chart
                        padding: mediaQuery.paddingAll(.6), // Adds inner padding
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Pie Chart Title
                            Align(
                              alignment: Alignment.centerLeft,

                              child: Text(
                                "E-Commerce Overview",
                                style: AppStyle.descriptions2
                              ),
                            ),
                            // const SizedBox(height: 16),
                            // Pie Chart with Labels
                            Expanded(
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 6,
                                  centerSpaceRadius: 50,
                                  sections: [
                                    PieChartSectionData(
                                      value: 40,
                                      title: "Sales",
                                      color: Colors.blue,
                                      radius: 40,

                                      titleStyle: AppStyle.extraSmallDescriptions


                                    ),
                                    PieChartSectionData(
                                      value: 30,
                                      title: "Returns",

                                      color: Colors.red,
                                      radius: 50,
                                      titleStyle: AppStyle.extraSmallDescriptions
                                    ),
                                    PieChartSectionData(
                                      value: 20,
                                      title: "Marketing",
                                      color: Colors.green,
                                      radius: 40,
                                      titleStyle: AppStyle.extraSmallDescriptions
                                    ),
                                    PieChartSectionData(
                                      value: 10,
                                      title: "Shipping",
                                      color: Colors.orange,
                                      radius: 40,
                                      titleStyle: AppStyle.extraSmallDescriptions
                                    ),
                                  ],
                                ),
                              ),
                            ),
                             SizedBox(height: mediaQuery.height(3),),
                            // Labels at Bottom
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 16.0,
                              runSpacing: 12.0,
                              children: [
                                _buildLabel(context,"Sales", Colors.blue),
                                _buildLabel(context,"Returns", Colors.red),
                                _buildLabel(context,"Marketing", Colors.green),
                                _buildLabel(context,"Shipping", Colors.orange),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1, // 1/3 of the right side
                      child:  Container(
                        margin: mediaQuery.marginAll(1), // Adds padding around the chart
                        padding: mediaQuery.paddingAll(.6), // Adds inner padding
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12), // Rounded corners for the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3), // Offset for the shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,

                              child: Text(
                                  "Top Selling Products",
                                  style: AppStyle.descriptions2

                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 5, // Example item count
                                itemBuilder: (context, index) {
                                  return ListTile(

                                    leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 20,
                                      child: Image.asset("assets/images/med2.jpeg"),
                                    ),
                                    title: Text("Panadol",style: AppStyle.extraSmallDescriptions,),
                                    subtitle: Row(
                                      children: [
                                        Icon(Icons.star,size: 14,color: Colors.yellow,),
                                        Icon(Icons.star,size: 14,color: Colors.yellow,),
                                        Icon(Icons.star,size: 14,color: Colors.yellow,),
                                        Icon(Icons.star,size: 14,),
                                        Icon(Icons.star,size: 14,),

                                      ],
                                    ),
                                    trailing: Text("\$${(index + 1) * 10}",style:AppStyle.extraSmallDescriptions,),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget reportsScreen(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Column(
      children: [
         Text("Analytics", style: AppStyle.descriptions2),
         SizedBox(height: mediaQuery.height(.02)),
        Expanded(
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(value: 80, title: "Analytics", color: Colors.blue, radius: 60),
                PieChartSectionData(value: 70, title: "Transactions", color: Colors.green, radius: 50),
                PieChartSectionData(value: 60, title: "Sale", color: Colors.orange, radius: 50),
                PieChartSectionData(value: 50, title: "Distribute", color: Colors.red, radius: 50),
                PieChartSectionData(value: 40, title: "Return", color: Colors.purple, radius: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }


}
Widget _dashboardCard( BuildContext context,String title, String value, IconData icon) {
  final mediaQuery = MediaQueryHelper(context);

  return SizedBox(
    height: mediaQuery.height(16),
    width: mediaQuery.width(16),
    child: Card(
      color: Colors.white,
      elevation: 4,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20), // Removes rounded corners
      ),
      child: Padding(
        padding: mediaQuery.paddingOnly(top: 5,bottom: 2,left: 2,right: 2),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor:Color(0xffEFF5FF),child: Icon(icon, size: 20, color: Color(0xff5B93FF),)),
             SizedBox(width: mediaQuery.width(.8)),

            Column(
              children: [

                Text(value, style: AppStyle.descriptions2),
                 SizedBox(height: mediaQuery.height(.5)),

                Text(title, style: AppStyle.smallDescriptions),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}



Widget _buildLabel(BuildContext context,String text, Color color) {
  final mediaQuery = MediaQueryHelper(context);

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: mediaQuery.width(1),
        height: mediaQuery.height(1),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
       SizedBox(width: mediaQuery.width(.1),),
      Text(
        text,
        style: AppStyle.extraSmallDescriptions
      ),
    ],
  );
}



