import 'dart:developer';

import 'package:chat_app/constants/const.dart';
import 'package:chat_app/functions/get_user.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/views/all_chats_page.dart';
import 'package:chat_app/views/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  static String id = 'Login view';

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;
  bool isLoading = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          // ChatModel? user = await BlocProvider.of<AllUsersCubit>(context)
          //     .getUser(email: email!.toString());

          UserModel? user = await getUser(email: email.toString());
          log(user!.userName.toString());
          Navigator.pushReplacementNamed(context, AllChatsPage.id, arguments: {
            kSenderEmail: email!.toString(),
            kSenderUsername: user.userName.toString()
          });
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        } else {
          SizedBox();
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 36,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Please sign in to continue',
                    style: TextStyle(fontSize: 16, color: kPrimaryColor),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomTextfield(
                    controller: emailController,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    onChange: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextfield(
                    controller: passwordController,
                    obscureText: obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    icon: Icons.lock,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                        //BlocProvider.of<AuthCubit>(context).obscureText();
                      },
                    ),
                    hintText: 'Password',
                    onChange: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  CustomButton(
                    buttonText: 'Sign in',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        // try {
                        //   await Auth().loginAuth(email!, password!);
                        //   Navigator.pushNamed(context, ChatPage.id,
                        //       arguments: email);
                        // } on FirebaseAuthException catch (e) {
                        //   if (e.code == 'user-not-found') {
                        //     showSnackBar(
                        //         context, 'No user found for that email.');
                        //   } else if (e.code == 'wrong-password') {
                        //     showSnackBar(context, 'Wrong password');
                        //   }
                        // } catch (e) {
                        //   showSnackBar(context, 'There was an error, Try Again!');
                        // }

                        isLoading = false;
                        setState(() {});

                        // BlocProvider.of<AuthBloc>(context).add(
                        //     LoginEvent(email: email!, password: password!));

                        BlocProvider.of<AuthCubit>(context).loginAuth(
                          email!,
                          password!,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have account? ',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          emailController.clear();
                          passwordController.clear();
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 12, color: kPrimaryColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
