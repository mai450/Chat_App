import 'package:chat_app/constants/const.dart';

class UserModel {
  final String email;
  final String userName;

  UserModel({required this.email, required this.userName});

  factory UserModel.fromJson(json) {
    return UserModel(
        email: json[kSenderEmail], userName: json[kSenderUsername]);
  }
}
