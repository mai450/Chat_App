import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageModel.message,
                style: TextStyle(color: Colors.white),
              ),
              Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatTimestamp(messageModel.time),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 176, 176, 176),
                        fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatContainerForFriend extends StatelessWidget {
  const ChatContainerForFriend({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 69, 111, 144),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageModel.message,
                style: TextStyle(color: Colors.white),
              ),
              Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatTimestamp(messageModel.time),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 176, 176, 176),
                        fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
