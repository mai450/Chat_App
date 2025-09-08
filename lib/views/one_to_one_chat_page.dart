import 'package:chat_app/constants/const.dart';
import 'package:chat_app/views/cubits/one_to_one_chat_cubit/one_to_one_chat_cubit.dart';
import 'package:chat_app/views/cubits/one_to_one_state_cubit/one_to_one_state_cubit.dart';
import 'package:chat_app/views/cubits/typing_cubit/typing_cubit.dart';
import 'package:chat_app/widgets/one_to_one_chat_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OneToOneChatPage extends StatefulWidget {
  const OneToOneChatPage({super.key});

  static String id = 'one to one chat page';

  @override
  State<OneToOneChatPage> createState() => _OneToOneChatPageState();
}

class _OneToOneChatPageState extends State<OneToOneChatPage> {
  @override
  Widget build(BuildContext context) {
    var userdata =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var reciverEmail = userdata[kReceiverEmail];
    var senderEmail = userdata[kSenderEmail];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OneToOneChatCubit()
            ..getMessage(senderEmail: senderEmail, receiverEmail: reciverEmail),
        ),
        BlocProvider(create: (context) => OneToOneStateCubit()),
        BlocProvider(create: (context) => TypingCubit()),
      ],
      child: Scaffold(body: OneToOneChatPageBody()),
    );
  }
}
