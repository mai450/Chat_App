import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/const.dart';
import 'package:chat_app/functions/get_chat_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'typing_state.dart';

class TypingCubit extends Cubit<bool> {
  TypingCubit() : super(false);

  CollectionReference chats =
      FirebaseFirestore.instance.collection(kChatCollectionName);
  Timer? timer;

  void setTypingStatus(
      {required String senderEmail,
      required String receiverEmail,
      required bool isTyping}) {
    final chatId = getChatId(senderEmail, receiverEmail);

    if (isTyping) {
      chats.doc(chatId).collection(kTypingStatus).doc(senderEmail).set({
        kisTyping: true,
      });

      timer?.cancel();

      timer = Timer(const Duration(seconds: 3), () {
        chats.doc(chatId).collection(kTypingStatus).doc(senderEmail).set({
          kisTyping: false,
        });
      });
    } else {
      timer?.cancel();
      chats.doc(chatId).collection(kTypingStatus).doc(senderEmail).set({
        kisTyping: false,
      });
    }
  }

  void getTypingStatus({
    required String senderEmail,
    required String receiverEmail,
  }) {
    final chatId = getChatId(senderEmail, receiverEmail);

    chats
        .doc(chatId)
        .collection(kTypingStatus)
        .doc(receiverEmail)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        emit(event.data()?[kisTyping] ?? false);
      } else {
        emit(false);
      }
    });
  }
}
