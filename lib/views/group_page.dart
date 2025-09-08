import 'package:chat_app/views/cubits/group_chat_cubit/group_chat_cubit.dart';
import 'package:chat_app/views/cubits/group_unread_msg_cubit/group_unread_msg_cubit.dart';
import 'package:chat_app/widgets/group_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});
  static String id = 'group page';
  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                GroupChatCubit()..getMessages(groupId: GroupPage.id),
          ),
          BlocProvider(
            create: (context) => GroupUnreadMsgCubit(),
          ),
        ],
        child: Scaffold(
          body: GroupPageBody(),
        ));
  }
}
