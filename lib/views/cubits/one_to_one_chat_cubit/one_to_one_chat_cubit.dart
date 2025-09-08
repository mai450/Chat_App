import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/const.dart';
import 'package:chat_app/functions/get_chat_id.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'one_to_one_chat_state.dart';

class OneToOneChatCubit extends Cubit<OneToOneChatState> {
  OneToOneChatCubit() : super(OneToOneChatInitial());

  CollectionReference chats =
      FirebaseFirestore.instance.collection(kChatCollectionName);

  List<MessageModel> messageList = [];

  void setOneToOneMessage({
    required String senderEmail,
    required String receiverEmail,
    required String receiverUserName,
    required String senderUserName,
    String? message,
    String? url,
  }) async {
    try {
      String chatId = getChatId(senderEmail, receiverEmail);

      await chats.doc(chatId).collection(kCollectionName).add(
        {
          kMessage: message,
          kTime: DateTime.now(),
          kSenderEmail: senderEmail,
          kReceiverEmail: receiverEmail,
          kReceiverUsername: receiverUserName,
          kVoice: url,
          kSenderUsername: null,
        },
      );

      await Future.wait([
        chats
            .doc(senderEmail)
            .collection(kChatStateCollectionName)
            .doc(chatId)
            .set({
          klastMessage: message ?? 'Voice Message',
          kLastMessageTime: DateTime.now(),
          kChatId: chatId,
          kReceiverUsername: receiverUserName,
          kReceiverEmail: receiverEmail,
          kSenderUsername: senderUserName,
          kSenderEmail: senderEmail,
          kUnreadCounts: 0,
        }, SetOptions(merge: true)),
        chats
            .doc(receiverEmail)
            .collection(kChatStateCollectionName)
            .doc(chatId)
            .set({
          klastMessage: message ?? 'Voice Message',
          kLastMessageTime: DateTime.now(),
          kChatId: chatId,
          kSenderUsername: receiverUserName,
          kReceiverUsername: senderUserName,
          kSenderEmail: receiverEmail,
          kReceiverEmail: senderEmail,
          kUnreadCounts: FieldValue.increment(1),
        }, SetOptions(merge: true))
      ]);
    } on Exception catch (e) {
      emit(OneToOneChatFailure(errMessage: e.toString()));
    }
  }

  void getMessage(
      {required String senderEmail, required String receiverEmail}) {
    emit(OneToOneChatLoading());
    try {
      final chatId = getChatId(senderEmail, receiverEmail);
      chats
          .doc(chatId)
          .collection(kCollectionName)
          .orderBy(kTime, descending: true)
          .snapshots()
          .listen(
        (event) {
          messageList.clear();
          for (var doc in event.docs) {
            messageList.add(MessageModel.fromJson(doc));
          }
          emit(OneToOneChatSuccess(messagesList: messageList));
        },
      );
    } on Exception catch (e) {
      emit(OneToOneChatFailure(errMessage: e.toString()));
    }
  }
}
