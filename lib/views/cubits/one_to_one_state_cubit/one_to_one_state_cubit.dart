import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/const.dart';
import 'package:chat_app/functions/get_chat_id.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'one_to_one_state_state.dart';

class OneToOneStateCubit extends Cubit<OneToOneStateState> {
  OneToOneStateCubit() : super(OneToOneStateStateInitial());

  CollectionReference chatState =
      FirebaseFirestore.instance.collection(kChatCollectionName);

  List<ChatModel> chatStateList = [];

  void getChatState({required String currentUserId}) async {
    emit(OneToOneStateStateLoading());

    try {
      chatState
          .doc(currentUserId)
          .collection(kChatStateCollectionName)
          .orderBy(kLastMessageTime, descending: true)
          .snapshots()
          .listen((event) {
        chatStateList.clear();

        for (var doc in event.docs) {
          chatStateList.add(ChatModel.fromJson(doc));
        }

        emit(OneToOneStateStateSuccess(messages: chatStateList));
      }, onError: (error) {
        log("Firestore listen error: $error");
        emit(OneToOneStateStateFailure());
      });
    } catch (e) {
      emit(OneToOneStateStateFailure());
    }
  }

  void updateUnreadCounter({
    required String senderEmail,
    required String receiverEmail,
  }) async {
    String chatId = getChatId(senderEmail, receiverEmail);

    final senderDocRef = chatState
        .doc(senderEmail)
        .collection(kChatStateCollectionName)
        .doc(chatId);
    final senderDoc = await senderDocRef.get();

    if (senderDoc.exists) {
      await senderDocRef.update({kUnreadCounts: 0});
    }
  }
}
