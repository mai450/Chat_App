import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xff1B374D);
const String kCollectionName = 'Messages';
const String kMessage = 'message';
const String kTime = 'createdAt';
const String kId = 'id';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
