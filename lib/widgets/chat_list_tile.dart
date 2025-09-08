import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/views/one_to_one_chat_page.dart';
import 'package:chat_app/widgets/user_image.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile(
      {super.key,
      required this.senderUserName,
      required this.senderEmail,
      required this.chatStateList,
      required this.index});

  final String senderUserName, senderEmail;

  final List chatStateList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: chatStateList[index].reciverUserName != senderUserName
          ? UserImage(
              userImg: chatStateList[index].reciverUserName![0].toUpperCase())
          : UserImage(userImg: chatStateList[index].userName[0]),
      title: chatStateList[index].reciverUserName != senderUserName
          ? Text(chatStateList[index].reciverUserName!,
              style: TextStyle(
                fontSize: 18,
              ))
          : Text(chatStateList[index].userName),
      subtitle: Text(
        chatStateList[index].lastMessage ?? '',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color.fromARGB(255, 124, 124, 124),
          fontSize: 14,
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Text(
              formatDate(chatStateList[index].lastMessageTime),
              style: TextStyle(color: const Color.fromARGB(255, 124, 124, 124)),
            ),
            const SizedBox(
              height: 3,
            ),
            if (chatStateList[index].unreadCounts != 0 &&
                chatStateList[index].reciverUserName != senderUserName)
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red,
                child: Text(chatStateList[index].unreadCounts!.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, OneToOneChatPage.id, arguments: {
          kSenderEmail: senderEmail,
          kSenderUsername: senderUserName,
          kReceiverEmail: chatStateList[index].reciverEmail,
          kReceiverUsername: chatStateList[index].reciverUserName
        });
      },
    );
  }
}
