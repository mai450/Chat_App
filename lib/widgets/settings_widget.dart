import 'package:chat_app/constants/const.dart';
import 'package:chat_app/views/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.senderUserName,
  });
  final String senderUserName;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: kPrimaryColor,
                  child: Text(
                    senderUserName.toString()[0].toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(senderUserName.toString(), style: TextStyle(fontSize: 18)),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                BlocProvider.of<AuthCubit>(context).logoutAuth();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.id, (_) => false);
              },
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Logout'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
