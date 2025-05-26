import 'package:flutter/material.dart';
import '../../models/chat/message_model.dart';

class MessageTile extends StatelessWidget {
  final MessageModel message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.green[200] : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(message.isMe ? 12 : 0),
            bottomRight: Radius.circular(message.isMe ? 0 : 12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(1, 1),
              blurRadius: 3,
            ),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
