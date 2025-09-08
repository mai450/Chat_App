import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_page.dart';

import 'package:chat_app/views/cubits/group_chat_cubit/group_chat_cubit.dart';
import 'package:chat_app/views/cubits/group_unread_msg_cubit/group_unread_msg_cubit.dart';
import 'package:chat_app/views/group_page.dart';
import 'package:chat_app/widgets/chat_container.dart';
import 'package:chat_app/widgets/custom_app_bar_for_chats.dart';
import 'package:chat_app/widgets/textfield_for_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPageBody extends StatefulWidget {
  const GroupPageBody({super.key});
  @override
  State<GroupPageBody> createState() => _GroupPageBodyState();
}

class _GroupPageBodyState extends State<GroupPageBody> {
  final ScrollController listController = ScrollController();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userdata =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var email = userdata[kSenderEmail];
    var senderUserName = userdata[kSenderUsername];
    return ChatPage(
      appBar: customAppBarForGroupChat(context),
      textField: TextFieldForMessage(controller: controller),
      controller: controller,
      isGroup: true,
      groupId: GroupPage.id,
      senderEmail: email,
      senderUserName: senderUserName,
      title: 'Group',
      listController: listController,
      child: Expanded(
        child: BlocBuilder<GroupChatCubit, GroupChatState>(
          builder: (context, state) {
            List<MessageModel> messagesList =
                BlocProvider.of<GroupChatCubit>(context).messagesList;
            if (messagesList.isNotEmpty) {
              BlocProvider.of<GroupUnreadMsgCubit>(context)
                  .updateLastSeen(groupId: GroupPage.id, kSenderEmail: email);
            }
            return ListView.builder(
              reverse: true,
              controller: listController,
              itemCount: messagesList.length,
              itemBuilder: (context, index) {
                return messagesList[index].senderEmail == email
                    ? ChatContainer(
                        userName: 'You',
                        key: ValueKey(messagesList[index].time),
                        messageModel: messagesList[index],
                      )
                    : ChatContainerForFriend(
                        key: ValueKey(messagesList[index].time),
                        userName: messagesList[index].userName!,
                        messageModel: messagesList[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
