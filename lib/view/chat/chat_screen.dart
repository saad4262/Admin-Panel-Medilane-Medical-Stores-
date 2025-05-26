import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/chat/chat_vm.dart';
import 'message_tile.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // LEFT SIDEBAR
          Container(
            width: 280,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.blue[800],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                        SizedBox(width: 10,),
                        Text("Chats" ,style: TextStyle(fontSize: 18,color: Colors.white),),
                      ],
                    ),
                      Icon(Icons.more_vert, color: Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: chatController.messages.keys.map((name) {
                      return Obx(() {
                        final isSelected = chatController.selectedPerson.value == name;
                        return Column(
                          children: [
                            Container(
                              color: isSelected ? Colors.blue[50] : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0), // 👈 Inner padding
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero, // prevent double padding
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue[100],
                                    child: Text(name[0]),
                                  ),
                                  title: Text(
                                    name,
                                    style: TextStyle(
                                      fontWeight:
                                      isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  onTap: () => chatController.selectPerson(name),
                                ),
                              ),
                            ),
                            Divider(height: 1, thickness: 1),
                          ],
                        );
                      });
                    }).toList(),
                  ),
                ),

              ],
            ),
          ),

          // RIGHT CHAT PANEL
          Expanded(
            child: Obx(() {
              final selected = chatController.selectedPerson.value;
              final messages = chatController.currentMessages;

              if (selected.isEmpty) {
                return Center(
                  child: Text(
                    "💬 Select a person to start chatting",
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
                          child: Text(selected[0]),
                        ),
                        SizedBox(width: 12),
                        Text(
                          selected,
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

                  // Messages
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        itemCount: messages.length,
                        itemBuilder: (_, index) => MessageTile(
                          message: messages[index],
                        ),
                      ),
                    ),
                  ),

                  // Message Input (mock)
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.insert_emoticon, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text("Type a message...",
                                style: TextStyle(color: Colors.grey[600])),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.send, color: Colors.blue),
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
