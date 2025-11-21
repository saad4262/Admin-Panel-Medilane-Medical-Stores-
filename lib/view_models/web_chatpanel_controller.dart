// lib/controllers/web_chat_panel_controller.dart
import 'dart:async';

import 'package:adminpanel1medilane/models/chat_room_model.dart'; // Aapka path
import 'package:adminpanel1medilane/models/message_model.dart';
import 'package:adminpanel1medilane/repository/chat-repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:medilane/models/chat_room_model.dart';

class WebChatPanelController extends GetxController {
  final ChatRepository _repository = ChatRepository();
  final TextEditingController textController = TextEditingController();

  late String storeId;

  var chatRooms = <ChatRoom>[].obs;
  var selectedChatRoom = Rx<ChatRoom?>(null);
  var currentMessages = <Message>[].obs;
  StreamSubscription? _messageStreamSubscription;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // storeId = "store_xyz"; // TODO: Isay Store Auth se replace karein
  //   // chatRooms.bindStream(getChatRooms(storeId));
  //     // REAL store user ID
  // final auth = FirebaseAuth.instance;
  // storeId = auth.currentUser!.uid;
  // // Chatrooms stream bind
  // chatRooms.bindStream(getChatRooms(storeId));
  // }
  // lib/controllers/web_chat_panel_controller.dart

  @override
  void onInit() {
    super.onInit();

    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser; // Null check

    if (user != null) {
      storeId = user.uid;

      // ================ DEBUGGING TEST ================
      // Apni browser console check karein (F12 dabayein)
      // Wahan yeh ID print honi chahiye

      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print("ADMIN PANEL LOGGED IN WITH ID: $storeId");
      print("DATABASE EXPECTS ID: ID9F9Xm... (clinix@gmail.com)");
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

      // ================================================

      chatRooms.bindStream(getChatRooms(storeId));
    } else {
      print("WebChatPanelController Error: Admin user not logged in!");
    }
  }

  Stream<List<ChatRoom>> getChatRooms(String storeId) {
    // Make sure yeh function repository mein mojood hai
    return _repository.getChatRoomsForStore(storeId);
  }

  void selectChatRoom(ChatRoom room) {
    _messageStreamSubscription?.cancel();
    selectedChatRoom.value = room;

    _messageStreamSubscription = _repository.getMessages(room.id).listen((
      messages,
    ) {
      currentMessages.value = messages;
    });
  }

  void sendMessage() async {
    String text = textController.text.trim();
    if (text.isEmpty || selectedChatRoom.value == null) return;

    final room = selectedChatRoom.value!;

    String receiverId = room.participants.firstWhere(
      (id) => id != storeId,
      orElse: () => '',
    );
    if (receiverId.isEmpty) return; // Agar receiver na mile toh

    final Message message = Message(
      id: '',
      senderID: storeId,
      receiverID: receiverId,
      text: text,
      timestamp: Timestamp.now(),
      status: 'sent',
    );

    textController.clear();

    try {
      await _repository.sendMessage(room.id, message);
    } catch (e) {
      Get.snackbar("Error", "Message failed to send.");
    }
  }

  @override
  void onClose() {
    textController.dispose();
    _messageStreamSubscription?.cancel();
    super.onClose();
  }
}
