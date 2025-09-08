import 'package:chat_app/constants/const.dart';
import 'package:chat_app/views/cubits/group_unread_msg_cubit/group_unread_msg_cubit.dart';
import 'package:chat_app/views/cubits/one_to_one_state_cubit/one_to_one_state_cubit.dart';
import 'package:chat_app/views/cubits/group_state_cubit/group_state_cubit.dart';
import 'package:chat_app/views/group_page.dart';
import 'package:chat_app/widgets/chat_list_tile_bloc_builder.dart';
import 'package:chat_app/widgets/chats_list.dart';
import 'package:chat_app/widgets/group_list_tile_bloc_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChatsPageBody extends StatefulWidget {
  const AllChatsPageBody({super.key});

  @override
  State<AllChatsPageBody> createState() => _AllChatsPageBodyState();
}

class _AllChatsPageBodyState extends State<AllChatsPageBody> {
  late String currentUserId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser!.email!;
    BlocProvider.of<OneToOneStateCubit>(context)
        .getChatState(currentUserId: currentUserId);
    BlocProvider.of<GroupUnreadMsgCubit>(context)
        .getUnreadMessages(groupId: GroupPage.id, userEmail: currentUserId);
    BlocProvider.of<GroupStateCubit>(context)
        .getLastMessage(groupId: GroupPage.id);
  }

  @override
  Widget build(BuildContext context) {
    var userdata =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var senderEmail = userdata[kSenderEmail];
    var senderUserName = userdata[kSenderUsername];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatsList(senderEmail: senderEmail, senderUserName: senderUserName),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 48, 48, 62),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                GroupListTileBlocBuilder(
                    senderEmail: senderEmail,
                    senderUserName: senderUserName,
                    currentUserId: currentUserId),
                ChatListTileBlocBuilder(
                  senderEmail: senderEmail,
                  senderUserName: senderUserName,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
