import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errMessage: 'user-not-found'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(errMessage: 'wrong-password'));
          } else {
            emit(LoginFailure(
                errMessage: 'Somthing was wrong ,Please try again'));
          }
        } on Exception catch (e) {
          emit(
              LoginFailure(errMessage: 'Somthing was wrong:  ${e.toString()}'));
        }
      }
    });
  }
}
