import 'package:chat_app/constants/const.dart';

import 'package:chat_app/views/blocs/bloc/auth_bloc.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String id = 'Login view';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
        // else if (state is LoginObscureText) {
        //   obscureText = !obscureText;
        // }
        else {
          showSnackBar(context, 'There was an error, Try Again!');
          isLoading = false;
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
                    SvgPicture.asset(
                      'assets/sign_in.svg',
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Login',
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
                      obscureText: obscureText,
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
                      height: 50,
                    ),
                    CustomButton(
                      buttonText: 'Sign in',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          // isLoading = true;
                          // setState(() {});
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

                          // isLoading = false;
                          // setState(() {});

                          BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(email: email!, password: password!));
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
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            'Sign Up',
                            style:
                                TextStyle(fontSize: 12, color: kPrimaryColor),
                          ),
                        )
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
