import 'package:chat_app/views/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static String id = 'splash view';
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    navigateToLoginPage();
  }

  navigateToLoginPage() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, LoginPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
            ),
          ],
        ),
      ),
    );
  }
}
