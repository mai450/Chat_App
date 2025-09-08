import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'all_users_state.dart';

class AllUsersCubit extends Cubit<AllUsersState> {
  AllUsersCubit() : super(AllUsersInitial());

  CollectionReference allUsers =
      FirebaseFirestore.instance.collection(kUsersCollectionName);
  List<UserModel> allUsersList = [];

  void addUser({required String email, required String senderUserName}) async {
    try {
      allUsers.add({
        kSenderEmail: email,
        kSenderUsername: senderUserName,
      });
    } on Exception catch (e) {
      // TODO
    }
  }

  void getAllUsers() async {
    emit(AllUsersLoading());
    try {
      allUsers
          // .orderBy('userName', descending: false)
          .snapshots()
          .listen((event) {
        allUsersList.clear();
        for (var doc in event.docs) {
          allUsersList.add(UserModel.fromJson(doc));
        }
        emit(AllUsersSuccess(allUsersList: allUsersList));
      });
    } catch (e) {
      emit(AllUsersFailure(errorMessage: e.toString()));
    }
  }

  // Future<ChatModel?> getUser({required String email}) async {
  //   try {
  //     final userName =
  //         await allUsers.where(kSenderEmail, isEqualTo: email).limit(1).get();
  //     if (userName.docs.isNotEmpty) {
  //       return ChatModel.fromJson(userName.docs.first);
  //     } else {
  //       log('No user found with this email.');
  //       return null;
  //     }
  //   } catch (e) {}
  //   return null;
  // }
}
