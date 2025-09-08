import 'package:chat_app/constants/const.dart';
import 'package:chat_app/views/all_chats_page.dart';
import 'package:chat_app/views/cubits/all_users_cubit/all_users_cubit.dart';
import 'package:chat_app/views/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  static String id = 'register view';

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  String? email, password, senderUserName;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  bool obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<AllUsersCubit>(context).addUser(
              email: email!.toString(),
              senderUserName: senderUserName!.toString());

          Navigator.pushNamed(
            context,
            AllChatsPage.id,
            arguments: {
              kSenderEmail: email!.toString(),
              kSenderUsername: senderUserName!.toString()
            },
          );
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        } else {
          SizedBox();
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
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 36,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Please sign up to login',
                    style: TextStyle(fontSize: 16, color: kPrimaryColor),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomTextfield(
                    controller: userNameController,
                    icon: Icons.person,
                    keyboardType: TextInputType.name,
                    hintText: 'User Name',
                    onChange: (data) {
                      senderUserName = data;
                    },
                  ),
                  const SizedBox(
                    height: 15,
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
                    icon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
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
                    height: 70,
                  ),
                  CustomButton(
                    buttonText: 'Sign Up',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
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
                        isLoading = false;
                        setState(() {});
                        BlocProvider.of<AuthCubit>(context).registerAuth(
                          email!,
                          password!,
                        );
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
                          style: TextStyle(fontSize: 12, color: kPrimaryColor),
                        ),
                      ),
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
