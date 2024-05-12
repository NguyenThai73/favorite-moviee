// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/ranking.model.dart';

class RankingCubitState extends Equatable {
  final RankingStatus status;
  final List<RankingModel> listRank;
  final List<int> listRankId;
  const RankingCubitState({
    required this.status,
    required this.listRank,
    required this.listRankId,
  });

  RankingCubitState copyWith({RankingStatus? status, List<RankingModel>? listRank, List<int>? listRankId}) {
    return RankingCubitState(
      status: status ?? this.status,
      listRank: listRank ?? this.listRank,
      listRankId: listRankId ?? this.listRankId,
    );
  }

  @override
  List<Object> get props => [status, listRank, listRank.length, listRankId, listRankId.length];
}

enum RankingStatus { initial, loadging, success, error }
