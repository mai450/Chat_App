import 'dart:developer';

import 'package:chat_app/constants/const.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserModel?> getUser({required String email}) async {
  try {
    final userName = await FirebaseFirestore.instance
        .collection(kUsersCollectionName)
        .where(kSenderEmail, isEqualTo: email)
        .limit(1)
        .get();
    if (userName.docs.isNotEmpty) {
      return UserModel.fromJson(userName.docs.first);
    } else {
      log('No user found with this email.');
      return null;
    }
  } catch (e) {}
  return null;
}
