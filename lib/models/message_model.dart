import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chat_app/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessageModel {
  final String? message;
  final String? voice;
  final String senderEmail;
  final Timestamp time;
  final String? userName;

  String? localPath;
  PlayerController? playerController;

  MessageModel({
    required this.time,
    this.message,
    this.voice,
    required this.senderEmail,
    this.userName,
    this.localPath,
    this.playerController,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
        message: json[kMessage],
        voice: json[kVoice],
        senderEmail: json[kSenderEmail],
        time: json[kTime],
        userName: json[kSenderUsername]);
  }
}

String formatTime(Timestamp? timestamp) {
  if (timestamp == null) return '';
  DateTime dateTime = timestamp.toDate();
  return DateFormat('h:mm a').format(dateTime);
}

String formatDate(Timestamp? timestamp) {
  if (timestamp == null) return '';
  DateTime dateTime = timestamp.toDate();
  return DateFormat('dd/MM/yyyy').format(dateTime);
}
