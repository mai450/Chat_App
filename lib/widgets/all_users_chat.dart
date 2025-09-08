import 'package:chat_app/constants/const.dart';
import 'package:chat_app/views/cubits/one_to_one_chat_cubit/one_to_one_chat_cubit.dart';
import 'package:chat_app/views/one_to_one_chat_page.dart';
import 'package:chat_app/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersListTile extends StatelessWidget {
  const AllUsersListTile(
      {super.key,
      required this.allUsersList,
      required this.index,
      required this.senderEmail,
      required this.senderUserName});
  final List allUsersList;
  final int index;
  final String senderEmail, senderUserName;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          UserImage(userImg: allUsersList[index].userName[0].toUpperCase()),
      title: Text(
        allUsersList[index].userName,
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        BlocProvider.of<OneToOneChatCubit>(context).getMessage(
            senderEmail: senderEmail.toString(),
            receiverEmail: allUsersList[index].email);
        Navigator.pushNamed(context, OneToOneChatPage.id, arguments: {
          kSenderEmail: senderEmail,
          kSenderUsername: senderUserName,
          kReceiverEmail: allUsersList[index].email,
          kReceiverUsername: allUsersList[index].userName
        });
      },
    );
  }
}
