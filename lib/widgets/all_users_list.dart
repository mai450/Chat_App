import 'package:chat_app/views/cubits/all_users_cubit/all_users_cubit.dart';
import 'package:chat_app/widgets/all_users_list_bloc_builder.dart';
import 'package:chat_app/widgets/group_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersList extends StatefulWidget {
  const AllUsersList({
    super.key,
    required this.senderEmail,
    required this.senderUserName,
  });
  final String senderEmail, senderUserName;

  @override
  State<AllUsersList> createState() => _AllUsersListState();
}

class _AllUsersListState extends State<AllUsersList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AllUsersCubit>(context).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Row(
          children: [
            GroupChat(
              senderEmail: widget.senderEmail,
              senderUserName: widget.senderUserName,
            ),
            AllUsersListBlocBuilder(
              senderEmail: widget.senderEmail,
              senderUserName: widget.senderUserName,
            ),
          ],
        ));
  }
}
