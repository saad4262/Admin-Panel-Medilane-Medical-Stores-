import 'package:get/get.dart';
import '../../models/chat/message_model.dart';

class ChatController extends GetxController {
  RxString selectedPerson = ''.obs;

  Map<String, List<MessageModel>> messages = {
    "Saad": [
      MessageModel(sender: "Ali", text: "Hi there!", isMe: false),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),
      MessageModel(sender: "Me", text: "hwlooo Saad!", isMe: true),

    ],
    "Ahmed": [
      MessageModel(sender: "Ahmed", text: "Hello 👋", isMe: false),
      MessageModel(sender: "Me", text: "Hi Ahmed!", isMe: true),
    ],
  };

  List<MessageModel> get currentMessages =>
      messages[selectedPerson.value] ?? [];

  void selectPerson(String name) {
    selectedPerson.value = name;
  }
}
