import 'package:chat_app/views/cubits/all_users_cubit/all_users_cubit.dart';
import 'package:chat_app/views/cubits/group_unread_msg_cubit/group_unread_msg_cubit.dart';
import 'package:chat_app/views/cubits/one_to_one_state_cubit/one_to_one_state_cubit.dart';
import 'package:chat_app/views/cubits/group_state_cubit/group_state_cubit.dart';
import 'package:chat_app/widgets/all_chats_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChatsPage extends StatefulWidget {
  const AllChatsPage({super.key});

  static String id = 'all chats page';

  @override
  State<AllChatsPage> createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllUsersCubit()..getAllUsers(),
        ),
        BlocProvider(
          create: (context) => GroupStateCubit(),
        ),
        BlocProvider(
          create: (context) => OneToOneStateCubit(),
        ),
        BlocProvider(
          create: (context) => GroupUnreadMsgCubit(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(body: AllChatsPageBody()),
      ),
    );
  }
}
