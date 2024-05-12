// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:favorite_movie/constants/share.preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/user.app.model.dart';
import 'login.cubit.state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  LoginCubit() : super(const LoginCubitState(status: LoginStatus.initial));

  Future<UserAppModel?> login() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        print(user.uid.toString());
        emit(state.copyWith(status: LoginStatus.success));
        AppSharedPreferences.saveLogin(emailController.text, passwordController.text);
        return UserAppModel(
          id: user.uid,
          email: user.email,
          name: user.displayName,
          image: user.photoURL,
        );
      } else {
        emit(state.copyWith(status: LoginStatus.error));
        return null;
      }
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error));
      print("Loi: $e");
      return null;
    }
  }

  void registerSucces({required String email}) {
    emit(state.copyWith(status: LoginStatus.initial));
    emailController.text = email;
    emit(state.copyWith(status: LoginStatus.registerSuccess));
  }
}
