import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xffEE3A57);
const Color kBackgroundColor = Color.fromARGB(255, 33, 33, 44);
// const Color kBackgroundColor = Color.fromARGB(255, 26, 29, 43);

const String kCollectionName = 'Messages';
const String kChatCollectionName = "Chats";
const String kUsersCollectionName = 'AllUsers';
const String kChatStateCollectionName = 'ChatStates';
const String kMessage = 'message';
const String kVoice = 'voice';
const String kSenderEmail = 'SenderEmail';
const String kReceiverEmail = 'ReceiverEmail';
const String kReceiverUsername = 'ReceiverUserName';
const String kSenderUsername = 'SenderUserName';
const String kTime = 'createdAt';
const String kUsers = 'Users';
const String klastMessage = 'lastMessage';
const String kLastMessageTime = 'lastMessageTime';
const String kChatId = 'chatId';
const String kLastSeen = 'lastSeen';
const String kGroupCollectionName = 'Group';
const String kUnreadCounts = 'unreadCounts';
const String kTypingStatus = 'TypingStatus';
const String kisTyping = 'isTyping';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
