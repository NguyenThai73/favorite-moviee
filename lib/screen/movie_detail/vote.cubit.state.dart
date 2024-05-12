// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class VoteCubitState extends Equatable {
  final VoteStatus voteStatus;

  const VoteCubitState({
    this.voteStatus = VoteStatus.initial,
  });

  VoteCubitState copyWith({
    VoteStatus? voteStatus,
  }) {
    return VoteCubitState(
      voteStatus: voteStatus ?? this.voteStatus,
    );
  }

  @override
  List<Object?> get props => [voteStatus];
}

enum VoteStatus { initial, loading, success, error }
