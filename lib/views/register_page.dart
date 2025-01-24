import 'package:chat_app/constants/const.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/views/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'register view';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();

          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        } else {
          showSnackBar(context, 'There was an error, Try Again!');
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/sign_up.png',
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 36,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Please register to login',
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextfield(
                      icon: Icons.person,
                      hintText: 'Email',
                      onChange: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      icon: Icons.lock,
                      hintText: 'Password',
                      obscureText: obscureText,
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
                        },
                      ),
                      onChange: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      buttonText: 'Sign Up',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          // isLoading = true;
                          // setState(() {});
                          // try {
                          //   await Auth().registerAuth(email!, password!);

                          //   Navigator.pushNamed(context, ChatPage.id,
                          //       arguments: email);
                          // } on FirebaseAuthException catch (e) {
                          //   if (e.code == 'weak-password') {
                          //     showSnackBar(context, 'The password is too weak.');
                          //   } else if (e.code == 'email-already-in-use') {
                          //     showSnackBar(context, 'The email already exists');
                          //   }
                          // } catch (e) {
                          //   showSnackBar(context, 'There was an error, Try Again!');
                          // }
                          // isLoading = false;
                          // setState(() {});
                          BlocProvider.of<AuthCubit>(context)
                              .registerAuth(email!, password!);
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have account?',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign in',
                            style:
                                TextStyle(fontSize: 12, color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
