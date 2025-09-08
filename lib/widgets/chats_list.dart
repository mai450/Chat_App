import 'package:chat_app/widgets/all_users_list.dart';
import 'package:chat_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ChatsList extends StatelessWidget {
  const ChatsList(
      {super.key, required this.senderEmail, required this.senderUserName});

  final String senderEmail, senderUserName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: Column(
        children: [
          CustomAppBar(
              senderUserName: senderUserName, senderEmail: senderEmail),
          SizedBox(
            height: 15,
          ),
          AllUsersList(
            senderEmail: senderEmail,
            senderUserName: senderUserName,
          ),
        ],
      ),
    );
  }
}
