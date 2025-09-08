import 'package:chat_app/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? chatId;
  final String? lastMessage;
  final Timestamp? lastMessageTime;
  final int? unreadCounts;
  final String email;
  final String userName;
  final String? reciverUserName;
  final String? reciverEmail;
  ChatModel(
      {this.chatId,
      this.lastMessage,
      this.lastMessageTime,
      this.unreadCounts,
      required this.email,
      required this.userName,
      this.reciverUserName,
      this.reciverEmail});

  factory ChatModel.fromJson(json) {
    return ChatModel(
        chatId: json[kChatId],
        lastMessage: json[klastMessage],
        lastMessageTime: json[kLastMessageTime],
        unreadCounts: json[kUnreadCounts],
        email: json[kSenderEmail],
        userName: json[kSenderUsername],
        reciverUserName: json[kReceiverUsername],
        reciverEmail: json[kReceiverEmail]);
  }
}
