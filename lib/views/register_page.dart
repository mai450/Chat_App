import 'package:chat_app/views/cubits/all_users_cubit/all_users_cubit.dart';
import 'package:chat_app/widgets/register_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'register view';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AllUsersCubit(),
        child: RegisterPageBody(),
      ),
    );
  }
}
