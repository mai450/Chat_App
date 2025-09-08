import 'package:chat_app/constants/const.dart';
import 'package:chat_app/views/cubits/typing_cubit/typing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBarForPrivateChat extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBarForPrivateChat({
    super.key,
    this.senderEmail,
    this.reciverEmail,
    required this.title,
  });

  final String? senderEmail, reciverEmail;
  final String title;

  @override
  State<CustomAppBarForPrivateChat> createState() =>
      _CustomAppBarForPrivateChatState();

  @override
  Size get preferredSize => const Size.fromHeight(85);
}

class _CustomAppBarForPrivateChatState
    extends State<CustomAppBarForPrivateChat> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TypingCubit>(context).getTypingStatus(
      senderEmail: widget.senderEmail!,
      receiverEmail: widget.reciverEmail!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 33),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          ),
          BlocBuilder<TypingCubit, bool>(
            builder: (context, isTyping) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  if (isTyping)
                    const Text(
                      'typing...',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

AppBar customAppBarForGroupChat(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
    ),
    backgroundColor: kPrimaryColor,
    title: Text(
      'Group',
      style: TextStyle(color: Colors.white),
    ),
  );
}
