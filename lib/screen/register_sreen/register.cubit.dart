// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:favorite_movie/model/user.app.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register.cubit.state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPasswordController = TextEditingController();

  RegisterCubit() : super(RegisterCubitState(status: Status.initial, userAppModel: UserAppModel()));

  register() async {
    emit(state.copyWith(status: Status.loading));
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? user = userCredential.user;
      await user!.updateProfile(displayName: nameController.text);
      emit(state.copyWith(status: Status.success));
      
    } catch (e) {
      print("Erorr: $e");
      emit(state.copyWith(status: Status.error));
    }
  }
}
