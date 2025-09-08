import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/views/cubits/one_to_one_state_cubit/one_to_one_state_cubit.dart';
import 'package:chat_app/widgets/chat_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListTileBlocBuilder extends StatelessWidget {
  const ChatListTileBlocBuilder(
      {super.key, required this.senderEmail, required this.senderUserName});
  final String senderEmail, senderUserName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<OneToOneStateCubit, OneToOneStateState>(
        builder: (context, state) {
          List<ChatModel> chatStateList =
              BlocProvider.of<OneToOneStateCubit>(context).chatStateList;
          List filteredList = chatStateList
              .where((element) => element.reciverUserName != senderUserName)
              .toList();

          if (state is OneToOneStateStateSuccess) {
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ChatListTile(
                        index: index,
                        chatStateList: filteredList,
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
              },
            );
          } else if (state is OneToOneStateStateFailure) {
            return Center(child: Text('Failed to load chats'));
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          }
        },
      ),
    );
  }
}
