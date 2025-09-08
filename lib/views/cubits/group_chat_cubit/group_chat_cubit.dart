import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'group_chat_state.dart';

class GroupChatCubit extends Cubit<GroupChatState> {
  GroupChatCubit() : super(GroupChatInitial());

  CollectionReference group =
      FirebaseFirestore.instance.collection(kGroupCollectionName);

  List<MessageModel> messagesList = [];
  MessageModel? lastMessage;
  void sendMessage(
      {String? message,
      required String email,
      String? url,
      String? senderUserName,
      required String groupId}) async {
    try {
      group.doc(groupId).collection(kCollectionName).add({
        kMessage: message,
        kTime: DateTime.now(),
        kSenderEmail: email,
        kVoice: url,
        kSenderUsername: senderUserName
      });

      final members = await FirebaseFirestore.instance
          .collection(kUsersCollectionName)
          .get();
      List<String> membersEmail = members.docs.map((e) => e.id).toList();
      Map<String, dynamic> lastSeenMap = {};

      for (final member in membersEmail) {
        if (member == email) {
          lastSeenMap[member] = Timestamp.now();
        } else {
          lastSeenMap[member] = Timestamp.fromMillisecondsSinceEpoch(0);
        }
      }

      group
          .doc(groupId)
          .collection(kChatStateCollectionName)
          .doc(klastMessage)
          .set({
        klastMessage: message ?? 'Voice Message',
        kChatId: groupId,
        kReceiverUsername: 'all',
        kReceiverEmail: 'all',
        kSenderUsername: senderUserName,
        kSenderEmail: email,
        kUnreadCounts: FieldValue.increment(1),
        kLastMessageTime: Timestamp.now(),
        kLastSeen: lastSeenMap,
      }, SetOptions(merge: true));
    } on Exception catch (e) {}
  }

  void getMessages({required String groupId}) {
    group
        .doc(groupId)
        .collection(kCollectionName)
        .orderBy(kTime, descending: true)
        .snapshots()
        .listen(
      (event) {
        messagesList.clear();
        for (var doc in event.docs) {
          messagesList.add(MessageModel.fromJson(doc));
        }
        if (messagesList.isNotEmpty) {
          lastMessage = messagesList.first; // الأحدث
        }
        emit(GroupChatSuccess(message: messagesList));
      },
    );
  }
}
