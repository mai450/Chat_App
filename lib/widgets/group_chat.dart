import 'package:chat_app/constants/const.dart';
import 'package:chat_app/views/cubits/group_unread_msg_cubit/group_unread_msg_cubit.dart';
import 'package:chat_app/views/group_page.dart';
import 'package:chat_app/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupChat extends StatelessWidget {
  const GroupChat(
      {super.key, required this.senderEmail, required this.senderUserName});

  final String senderEmail, senderUserName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          UserImage(
            userImg: 'Group',
            onTap: () {
              BlocProvider.of<GroupUnreadMsgCubit>(context).updateLastSeen(
                  groupId: GroupPage.id, kSenderEmail: senderEmail);

              Navigator.pushNamed(context, GroupPage.id, arguments: {
                kSenderEmail: senderEmail.toString(),
                kSenderUsername: senderUserName.toString()
              });
            },
          ),
          Text('Group'),
        ],
      ),
    );
  }
}
