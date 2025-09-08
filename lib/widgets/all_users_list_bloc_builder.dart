import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/views/cubits/all_users_cubit/all_users_cubit.dart';
import 'package:chat_app/views/one_to_one_chat_page.dart';
import 'package:chat_app/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersListBlocBuilder extends StatelessWidget {
  const AllUsersListBlocBuilder(
      {super.key, required this.senderEmail, required this.senderUserName});

  final String senderEmail, senderUserName;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<AllUsersCubit, AllUsersState>(
      builder: (context, state) {
        List<UserModel> allUsersList =
            BlocProvider.of<AllUsersCubit>(context).allUsersList;
        List filteredList = allUsersList
            .where((element) =>
                element.userName.toLowerCase() != senderUserName.toLowerCase())
            .toList();
        return ListView.builder(
            itemCount: filteredList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserImage(
                        userImg: filteredList[index].userName,
                        onTap: () {
                          Navigator.pushNamed(context, OneToOneChatPage.id,
                              arguments: {
                                kSenderEmail: senderEmail,
                                kSenderUsername: senderUserName,
                                kReceiverEmail: filteredList[index].email,
                                kReceiverUsername: filteredList[index].userName
                              });
                        },
                      ),
                      Text(filteredList[index].userName)
                    ]),
              );
            });
      },
    ));
  }
}
