// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../view_models/chat/chat_vm.dart';
// import 'message_tile.dart';

// class ChatScreen extends StatelessWidget {
//   final ChatController chatController = Get.put(ChatController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Row(
//         children: [
//           // LEFT SIDEBAR
//           Container(
//             width: 280,
//             color: Colors.white,
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   color: Colors.blue[800],
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: Colors.white,
//                           child: Icon(Icons.person, color: Colors.black),
//                         ),
//                         SizedBox(width: 10,),
//                         Text("Chats" ,style: TextStyle(fontSize: 18,color: Colors.white),),
//                       ],
//                     ),
//                       Icon(Icons.more_vert, color: Colors.white),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView(
//                     children: chatController.messages.keys.map((name) {
//                       return Obx(() {
//                         final isSelected = chatController.selectedPerson.value == name;
//                         return Column(
//                           children: [
//                             Container(
//                               color: isSelected ? Colors.blue[50] : Colors.transparent,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0), // 👈 Inner padding
//                                 child: ListTile(
//                                   contentPadding: EdgeInsets.zero, // prevent double padding
//                                   leading: CircleAvatar(
//                                     backgroundColor: Colors.blue[100],
//                                     child: Text(name[0]),
//                                   ),
//                                   title: Text(
//                                     name,
//                                     style: TextStyle(
//                                       fontWeight:
//                                       isSelected ? FontWeight.bold : FontWeight.normal,
//                                     ),
//                                   ),
//                                   onTap: () => chatController.selectPerson(name),
//                                 ),
//                               ),
//                             ),
//                             Divider(height: 1, thickness: 1),
//                           ],
//                         );
//                       });
//                     }).toList(),
//                   ),
//                 ),

//               ],
//             ),
//           ),

//           // RIGHT CHAT PANEL
//           Expanded(
//             child: Obx(() {
//               final selected = chatController.selectedPerson.value;
//               final messages = chatController.currentMessages;

//               if (selected.isEmpty) {
//                 return Center(
//                   child: Text(
//                     "💬 Select a person to start chatting",
//                     style: TextStyle(fontSize: 18, color: Colors.grey[700]),
//                   ),
//                 );
//               }

//               return Column(
//                 children: [
//                   // Header
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey.shade300),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: Colors.blue[100],
//                           child: Text(selected[0]),
//                         ),
//                         SizedBox(width: 12),
//                         Text(
//                           selected,
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                         Spacer(),
//                         Icon(Icons.search, color: Colors.grey[700]),
//                         SizedBox(width: 12),
//                         Icon(Icons.more_vert, color: Colors.grey[700]),
//                       ],
//                     ),
//                   ),

//                   // Messages
//                   Expanded(
//                     child: Container(
//                       color: Colors.grey[200], // Chat background color
//                       child: Obx(() {
//                         return ListView.builder(
//                           reverse: true, // Naye messages neeche
//                           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                           itemCount: chatController.currentMessages.length,
                          
//                           // YEH DEKHEIN:
//                           itemBuilder: (_, index) {
//                             // 1. Message hasil karein
//                             final message = chatController.currentMessages[index];
                            
//                             // 2. 'isMe' calculate karein
//                             final bool isMe = message.senderID == chatController.storeId;
                            
//                             // 3. 'isMe' ko pass karein
//                             return MessageTile(
//                               message: message,
//                               isMe: isMe, 
//                             );
//                           },

//                         );
//                       }),
//                     ),
//                   ),

//                   // Message Input (mock)
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     color: Colors.white,
//                     child: Row(
//                       children: [
//                         Icon(Icons.insert_emoticon, color: Colors.grey[600]),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text("Type a message...",
//                                 style: TextStyle(color: Colors.grey[600])),
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Icon(Icons.send, color: Colors.blue),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }



// lib/views/web/web_chat_screen.dart
// (Is file ko istemal karein)

import 'package:adminpanel1medilane/view/chat/message_tile.dart';
import 'package:adminpanel1medilane/view_models/web_chatpanel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// SAHI CONTROLLER IMPORT KAREIN
// SAHI MESSAGE TILE IMPORT KAREIN

class WebChatScreen extends StatelessWidget {
  // SAHI CONTROLLER ISTEMAL KAREIN
  final WebChatPanelController controller = Get.put(WebChatPanelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          
          // LEFT SIDEBAR (Firebase se connected)
          Container(
            width: 320,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: Color(0xFF075E54), // Header
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.storefront, color: Color(0xFF075E54)),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "MediLane Inbox",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(Icons.more_vert, color: Colors.white),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8), // Search bar
                  color: Colors.grey[100],
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search chats...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),

                // List of Chats (Firebase se)
                Expanded(
                  child: Obx(() {
                    if (controller.chatRooms.isEmpty) {
                      return Center(child: Text("No chats yet."));
                    }
                    // YEH NAYA LOGIC HAI
                    return ListView.builder(
                      itemCount: controller.chatRooms.length,
                      itemBuilder: (context, index) {
                        final room = controller.chatRooms[index];
                        return Obx(() {
                          final isSelected = controller.selectedChatRoom.value?.id == room.id;
                          return Column(
                            children: [
                              Container(
                                color: isSelected ? Colors.blue[50] : Colors.transparent,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue[100],
                                    child: Text(room.otherParticipantName.isNotEmpty ? room.otherParticipantName[0].toUpperCase() : 'U'),
                                  ),
                                  title: Text(
                                    room.otherParticipantName, // User ka naam
                                    style: TextStyle(
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  subtitle: Text(
                                    room.lastMessage,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () => controller.selectChatRoom(room),
                                ),
                              ),
                              Divider(height: 1, thickness: 1, indent: 70),
                            ],
                          );
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
          ),

          // RIGHT CHAT PANEL
          Expanded(
            child: Obx(() {
              final selectedRoom = controller.selectedChatRoom.value;

              if (selectedRoom == null) {
                return Center(
                  child: Text(
                    "💬 Select a chat to start messaging",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                );
              }

              return Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Text(selectedRoom.otherParticipantName.isNotEmpty ? selectedRoom.otherParticipantName[0].toUpperCase() : 'U'),
                        ),
                        SizedBox(width: 12),
                        Text(
                          selectedRoom.otherParticipantName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Icon(Icons.search, color: Colors.grey[700]),
                        SizedBox(width: 12),
                        Icon(Icons.more_vert, color: Colors.grey[700]),
                      ],
                    ),
                  ),

                  // Messages (Firebase se)
                  Expanded(
                    child: Container(
                      color: Colors.grey[200], // Chat background
                      child: Obx(() {
                        return ListView.builder(
                          reverse: true, // Naye messages neeche
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          itemCount: controller.currentMessages.length,
                          itemBuilder: (_, index) {
                            final message = controller.currentMessages[index];
                            // YEH SAHI LOGIC HAI
                            final isMe = message.senderID == controller.storeId;
                            return MessageTile(
                              message: message,
                              isMe: isMe,
                            );
                          },
                        );
                      }),
                    ),
                  ),

                  // Message Input (REAL)
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.insert_emoticon, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField( // Real TextField
                            controller: controller.textController,
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            onSubmitted: (_) => controller.sendMessage(),
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton( // Real Send Button
                          icon: Icon(Icons.send, color: Colors.blue),
                          onPressed: controller.sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}