import 'package:chat_app/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessageModel {
  final String message;
  final String id;
  final Timestamp time;

  MessageModel({
    required this.time,
    required this.message,
    required this.id,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
        message: json[kMessage], id: json[kId], time: json[kTime]);
  }
}

String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return DateFormat('h:mm a').format(dateTime);
}
