import 'package:chat_app/constants/const.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:chat_app/views/all_chats_page.dart';
import 'package:chat_app/views/blocs/bloc/auth_bloc.dart';
import 'package:chat_app/views/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/views/group_page.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:chat_app/views/one_to_one_chat_page.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:chat_app/views/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: kBackgroundColor),
        routes: {
          SplashPage.id: (context) => SplashPage(),
          LoginPage.id: (context) => const LoginPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          AllChatsPage.id: (context) => const AllChatsPage(),
          GroupPage.id: (context) => GroupPage(),
          OneToOneChatPage.id: (context) => OneToOneChatPage(),
        },
        initialRoute: SplashPage.id,
      ),
    );
  }
}
