import 'package:chat_app/constants/const.dart';
import 'package:chat_app/widgets/settings_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String senderUserName;
  final String senderEmail;
  const CustomAppBar(
      {super.key, required this.senderUserName, required this.senderEmail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            'Chats',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: SettingsPage(
                      senderUserName: senderUserName,
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: kPrimaryColor,
              child: Text(
                senderUserName[0].toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
