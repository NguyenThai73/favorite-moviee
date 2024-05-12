// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/user.vote.model.dart';

class VotersCubitState extends Equatable {
  VotersStatus status;
  List<UserVoteModel> listVoter;
  VotersCubitState({
    required this.status,
    required this.listVoter,
  });

  VotersCubitState copyWith({
    VotersStatus? status,
    List<UserVoteModel>? listVoter,
  }) {
    return VotersCubitState(
      status: status ?? this.status,
      listVoter: listVoter ?? this.listVoter,
    );
  }

  @override
  List<Object> get props => [status, listVoter, listVoter.length];
}

enum VotersStatus { initial, loading, success, error }
