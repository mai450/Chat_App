import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/build_audio_message.dart';
import 'package:chat_app/widgets/build_message.dart';
import 'package:flutter/material.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    super.key,
    required this.messageModel,
    this.userName,
  });
  final String? userName;
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
          child: messageModel.message != null
              ? buildTextMessage(messageModel: messageModel, userName: userName)
              : messageModel.voice != null
                  ? BuildAudioMessage(
                      messageModel: messageModel,
                      userName: userName,
                    )
                  : SizedBox(height: 40, child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class ChatContainerForFriend extends StatelessWidget {
  const ChatContainerForFriend({
    super.key,
    required this.messageModel,
    this.userName,
  });
  final String? userName;

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
              color: const Color.fromARGB(255, 64, 64, 64),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
          child: messageModel.message != null
              ? buildTextMessage(messageModel: messageModel, userName: userName)
              : messageModel.voice != null
                  ? BuildAudioMessage(
                      messageModel: messageModel,
                      //userName: userName,
                    )
                  : SizedBox(height: 40, child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
