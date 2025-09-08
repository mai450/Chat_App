import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/views/cubits/one_to_one_state_cubit/one_to_one_state_cubit.dart';
import 'package:chat_app/views/cubits/typing_cubit/typing_cubit.dart';
import 'package:chat_app/widgets/chat_page.dart';
import 'package:chat_app/views/cubits/one_to_one_chat_cubit/one_to_one_chat_cubit.dart';
import 'package:chat_app/widgets/chat_container.dart';
import 'package:chat_app/widgets/custom_app_bar_for_chats.dart';
import 'package:chat_app/widgets/textfield_for_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OneToOneChatPageBody extends StatefulWidget {
  const OneToOneChatPageBody({super.key});

  @override
  State<OneToOneChatPageBody> createState() => _OneToOneChatPageBodyState();
}

class _OneToOneChatPageBodyState extends State<OneToOneChatPageBody> {
  final ScrollController listController = ScrollController();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userdata =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var reciverEmail = userdata[kReceiverEmail];
    var senderEmail = userdata[kSenderEmail];
    var reciverUserName = userdata[kReceiverUsername];
    var senderUserName = userdata[kSenderUsername];

    return ChatPage(
      appBar: CustomAppBarForPrivateChat(
        title: reciverUserName.toString(),
        reciverEmail: reciverEmail.toString(),
        senderEmail: senderEmail.toString(),
      ),
      textField: TextFieldForMessage(
        controller: controller,
        onChanged: (value) {
          BlocProvider.of<TypingCubit>(context).setTypingStatus(
              senderEmail: senderEmail!,
              receiverEmail: reciverEmail!,
              isTyping: value.isNotEmpty);
        },
      ),
      controller: controller,
      isGroup: false,
      title: reciverUserName.toString(),
      senderEmail: senderEmail.toString(),
      reciverEmail: reciverEmail.toString(),
      reciverUserName: reciverUserName.toString(),
      senderUserName: senderUserName.toString(),
      listController: listController,
      child: Expanded(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover)),
          child: BlocBuilder<OneToOneChatCubit, OneToOneChatState>(
            builder: (context, state) {
              List<MessageModel> messagesList =
                  BlocProvider.of<OneToOneChatCubit>(context).messageList;
              if (messagesList.isNotEmpty) {
                BlocProvider.of<OneToOneStateCubit>(context)
                    .updateUnreadCounter(
                  receiverEmail: reciverEmail,
                  senderEmail: senderEmail,
                );
              }
              return ListView.builder(
                reverse: true,
                controller: listController,
                itemCount: messagesList.length,
                itemBuilder: (context, index) {
                  return messagesList[index].senderEmail == senderEmail
                      ? ChatContainer(
                          key: ValueKey(messagesList[index].time),
                          messageModel: messagesList[index],
                        )
                      : ChatContainerForFriend(
                          key: ValueKey(messagesList[index].time),
                          messageModel: messagesList[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
