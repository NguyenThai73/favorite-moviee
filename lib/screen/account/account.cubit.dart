// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'dart:io';

import 'package:favorite_movie/model/user.app.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'account.cubit.state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountCubit extends Cubit<AccountCubitState> {
  AccountCubit() : super(AccountCubitState(status: AccountStatus.initial, userAppModel: UserAppModel())) {
    getDataUser();
  }

  getDataUser() async {
    emit(state.copyWith(status: AccountStatus.loading));
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(state.copyWith(
          status: AccountStatus.success,
          userAppModel: UserAppModel(
            id: user.uid,
            email: user.email,
            name: user.displayName,
            image: user.photoURL,
          )));
    } else {
      emit(state.copyWith(status: AccountStatus.error));
    }
  }

  updateImage(String image) async {
    emit(state.copyWith(status: AccountStatus.loading));
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(image);
    getDataUser();
  }

  Future<bool> updateName(String nameNew) async {
    try {
      print("nameNew: $nameNew");
      emit(state.copyWith(status: AccountStatus.loading));
      await FirebaseAuth.instance.currentUser!.updateDisplayName(nameNew);
      getDataUser();
      return true;
    } catch (e) {
      emit(state.copyWith(status: AccountStatus.error));
      return false;
    }
  }

    Future<bool> updatePassword(String namePass) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      await FirebaseAuth.instance.currentUser!.updatePassword(namePass);
      emit(state.copyWith(status: AccountStatus.success));
      return true;
    } catch (e) {
      emit(state.copyWith(status: AccountStatus.error));
      return false;
    }
  }
}

Future<String?> handleUploadImage() async {
  String? fileName;
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null) {
    try {
      String fileName = result.files.first.name;
      String path = result.files.first.path ?? "";
      await FirebaseStorage.instance.ref('avatar/$fileName').putFile(File(path));
      return "https://firebasestorage.googleapis.com/v0/b/favorite-movie-deebf.appspot.com/o/avatar%2F$fileName?alt=media";
    } catch (e) {
      print("Error: $e");
    }
  } else {}
  return fileName;
}
