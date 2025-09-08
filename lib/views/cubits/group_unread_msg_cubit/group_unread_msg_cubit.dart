import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'group_unread_msg_state.dart';

class GroupUnreadMsgCubit extends Cubit<GroupUnreadMsgState> {
  GroupUnreadMsgCubit() : super(GroupUnreadMsgInitial());
  CollectionReference group =
      FirebaseFirestore.instance.collection(kGroupCollectionName);
  List groupState = [];

  void getUnreadMessages({required String groupId, required String userEmail}) {
    group
        .doc(groupId)
        .collection(kChatStateCollectionName)
        .doc(klastMessage)
        .snapshots()
        .listen((doc) async {
      if (!doc.exists) {
        emit(GroupUnreadMsgCount(count: 0));
        return;
      }

      final lastSeen = doc[kLastSeen]?[userEmail] as Timestamp? ??
          Timestamp.fromMillisecondsSinceEpoch(0);

      group
          .doc(groupId)
          .collection(kCollectionName)
          .where(kTime, isGreaterThan: lastSeen)
          .where(kSenderEmail, isNotEqualTo: userEmail)
          .orderBy(kSenderEmail)
          .snapshots()
          .listen((snapshot) {
        emit(GroupUnreadMsgCount(count: snapshot.docs.length));
      });
    });
  }

  void updateLastSeen({required String groupId, required String kSenderEmail}) {
    emit(GroupUnreadMsgCount(count: 0));

    group
        .doc(groupId)
        .collection(kChatStateCollectionName)
        .doc(klastMessage)
        .set({
      kLastSeen: {
        kSenderEmail: FieldValue.serverTimestamp(),
      },
    }, SetOptions(merge: true));
  }
}
