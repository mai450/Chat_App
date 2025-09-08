import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginAuth(String email, String password) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'wrong-password'));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errMessage: e.toString()));
    }
  }

  void obscureText() {
    emit(LoginObscureText());
  }

  Future<void> registerAuth(
    String email,
    String password,
  ) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMessage: 'The password is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errMessage: 'The email already exists'));
      }
    } on Exception catch (e) {
      emit(RegisterFailure(errMessage: e.toString()));
    }
  }

  void logoutAuth() async {
    await FirebaseAuth.instance.signOut();
  }
}
