// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/user.app.model.dart';

class RegisterCubitState extends Equatable {
  final Status status;
  final UserAppModel userAppModel;
  const RegisterCubitState({
    required this.status,
    required this.userAppModel,
  });

  RegisterCubitState copyWith({
    Status? status,
    UserAppModel? userAppModel,
  }) {
    return RegisterCubitState(
      status: status ?? this.status,
      userAppModel: userAppModel ?? this.userAppModel,
    );
  }

  @override
  List<Object> get props => [status, userAppModel];
}

enum Status { initial, loading, success, error }
