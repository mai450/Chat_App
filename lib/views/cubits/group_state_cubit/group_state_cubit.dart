import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'group_state_state.dart';

class GroupStateCubit extends Cubit<GroupStateState> {
  GroupStateCubit() : super(GroupStateInitial());

  CollectionReference group =
      FirebaseFirestore.instance.collection(kGroupCollectionName);
  List<ChatModel> chatStateList = [];
  void getLastMessage({required String groupId}) async {
    emit(GroupStateLoading());
    try {
      group
          .doc(groupId)
          .collection(kChatStateCollectionName)
          .orderBy(kLastMessageTime, descending: true)
          .snapshots()
          .listen((event) {
        chatStateList.clear();
        for (var doc in event.docs) {
          chatStateList.add(ChatModel.fromJson(doc));
        }

        emit(GroupStateLastMessage(message: chatStateList));
      });
    } on Exception catch (e) {
      // TODO
    }
  }
}
