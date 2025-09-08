import 'dart:developer';

import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/views/cubits/group_unread_msg_cubit/group_unread_msg_cubit.dart';
import 'package:chat_app/views/group_page.dart';
import 'package:chat_app/widgets/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupListTile extends StatelessWidget {
  final String senderEmail;
  final String senderUserName;
  final String? lastMessage;
  final String? lastMessageUserName;
  final String? lastMessageEmail;
  final String? currentUserId;
  final Timestamp? lastMessageTime;

  const GroupListTile(
      {super.key,
      required this.senderEmail,
      required this.senderUserName,
      required this.lastMessage,
      this.lastMessageUserName,
      this.lastMessageTime,
      this.currentUserId,
      this.lastMessageEmail});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserImage(userImg: 'G'),
      title: Text(
        'Group',
        style: TextStyle(fontSize: 18),
      ),
      subtitle: lastMessage != null && lastMessageUserName != null
          ? Text(
              senderUserName == lastMessageUserName
                  ? 'You: $lastMessage'
                  : '$lastMessageUserName: $lastMessage',
              style: TextStyle(
                  color: const Color.fromARGB(255, 124, 124, 124),
                  fontSize: 16),
            )
          : null,
      trailing: lastMessageTime != null
          ? Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Text(
                    formatDate(lastMessageTime),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 124, 124, 124)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  BlocBuilder<GroupUnreadMsgCubit, GroupUnreadMsgState>(
                    builder: (context, state) {
                      if (state is GroupUnreadMsgCount &&
                          state.count > 0 &&
                          lastMessageEmail != currentUserId) {
                        log('lastMessageEmail: $lastMessageEmail ,currentUserId: $currentUserId');
                        log(' ${state.count.toString()}');
                        return CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 12,
                          child: Text(
                            state.count.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        );
                      } else {
                        return SizedBox(); // لا تظهر شيء+
                      }
                    },
                  )
                ],
              ),
            )
          : null,
      onTap: () async {
        BlocProvider.of<GroupUnreadMsgCubit>(context)
            .getUnreadMessages(groupId: GroupPage.id, userEmail: senderEmail);

        Navigator.pushNamed(context, GroupPage.id, arguments: {
          kSenderEmail: senderEmail.toString(),
          kSenderUsername: senderUserName.toString()
        });
      },
    );
  }
}
