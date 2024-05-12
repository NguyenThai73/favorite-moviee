// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/user.app.model.dart';

class AccountCubitState extends Equatable {
  final AccountStatus status;
  final UserAppModel userAppModel;
  const AccountCubitState({
    required this.status,
    required this.userAppModel,
  });

  AccountCubitState copyWith({
    AccountStatus? status,
    UserAppModel? userAppModel,
  }) {
    return AccountCubitState(
      status: status ?? this.status,
      userAppModel: userAppModel ?? this.userAppModel,
    );
  }

  @override
  List<Object> get props => [status, userAppModel];
}

enum AccountStatus { initial, loading, success, error }
