import 'package:chat_app/views/cubits/group_state_cubit/group_state_cubit.dart';
import 'package:chat_app/widgets/group_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupListTileBlocBuilder extends StatelessWidget {
  const GroupListTileBlocBuilder(
      {super.key,
      required this.currentUserId,
      required this.senderEmail,
      required this.senderUserName});

  final String currentUserId, senderEmail, senderUserName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupStateCubit, GroupStateState>(
      builder: (context, state) {
        final lastMsg = BlocProvider.of<GroupStateCubit>(context).chatStateList;

        if (state is GroupStateLastMessage && lastMsg.isNotEmpty) {
          return Column(
            children: [
              GroupListTile(
                  lastMessage: lastMsg.first.lastMessage,
                  lastMessageTime: lastMsg.first.lastMessageTime,
                  lastMessageUserName: lastMsg.first.userName,
                  lastMessageEmail: lastMsg.first.email,
                  currentUserId: currentUserId,
                  senderUserName: senderUserName,
                  senderEmail: senderEmail),
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Divider(
                  color: const Color.fromARGB(255, 90, 90, 90),
                ),
              ),
            ],
          );
        } else if (state is GroupStateLoading) {
          return SizedBox();
        } else {
          return SizedBox();
        }
      },
    );
  }
}
