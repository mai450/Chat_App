import 'package:chat_app/constants/const.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.userImg, this.onTap});
  final String userImg;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Text(
          userImg[0].toUpperCase(),
          style: TextStyle(color: kPrimaryColor, fontSize: 24),
        ),
      ),
    );
  }
}
