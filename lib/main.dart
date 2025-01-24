import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:chat_app/views/blocs/bloc/auth_bloc.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/views/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/views/login_page.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SplashPage.id: (context) => SplashPage(),
          LoginPage.id: (context) => const LoginPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: SplashPage.id,
      ),
    );
  }
}
