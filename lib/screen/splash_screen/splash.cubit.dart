// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/share.preferences.dart';
import 'splash.cubit.state.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit() : super(const SplashCubitState(status: SplashStatus.initial)) {
    checkLogin();
  }
  checkLogin() async {
    try {
      var checkLogin = await AppSharedPreferences.checkLogin();
      if (checkLogin) {
        var email = await AppSharedPreferences.getEmail();
        var pass = await AppSharedPreferences.getPass();
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
        User? user = userCredential.user;
        if (user != null) {
          emit(state.copyWith(status: SplashStatus.home));
        } else {
          emit(state.copyWith(status: SplashStatus.login));
        }
      } else {
        emit(state.copyWith(status: SplashStatus.login));
      }
    } catch (e) {
      emit(state.copyWith(status: SplashStatus.login));
    }
  }
}
