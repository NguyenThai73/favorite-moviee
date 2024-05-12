// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_movie/model/ranking.model.dart';
import 'package:favorite_movie/model/user.vote.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'voters.cubit.state.dart';

class VotersCubit extends Cubit<VotersCubitState> {
  final firebaseRank = FirebaseFirestore.instance.collection("rank");
  final RankingModel rankingModel;
  bool isFirst = true;
  VotersCubit({required this.rankingModel})
      : super(VotersCubitState(
          status: VotersStatus.initial,
          listVoter: [],
        )) {
    getData();
  }

  getData() async {
    emit(state.copyWith(status: VotersStatus.loading));
    List<UserVoteModel> listVoters = [];
    var queryVoters = await firebaseRank.doc(rankingModel.id.toString()).collection("userVote").get();
    for (var element in queryVoters.docs) {
      listVoters.add(UserVoteModel.fromMap(element.data()));
    }
    emit(state.copyWith(status: VotersStatus.success, listVoter:listVoters));
  }
}
