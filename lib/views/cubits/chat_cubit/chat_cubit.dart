import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionName);

  List<MessageModel> messagesList = [];
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({kMessage: message, kTime: DateTime.now(), kId: email});
    } on Exception catch (e) {}
  }

  void getMessages() {
    messages.orderBy(kTime, descending: true).snapshots().listen(
      (event) {
        messagesList.clear();
        for (var doc in event.docs) {
          messagesList.add(MessageModel.fromJson(doc));
        }
        emit(ChatSuccess(message: messagesList));
      },
    );
  }
}
