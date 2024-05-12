// ignore_for_file: unused_field, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:favorite_movie/model/ranking.model.dart';
import 'package:favorite_movie/model/user.vote.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ranking.cubit.state.dart';

class RankingCubit extends Cubit<RankingCubitState> {
  final firebaseRank = FirebaseFirestore.instance.collection("rank");
  final firebaseAuth = FirebaseAuth.instance;
  RankingCubit()
      : super(const RankingCubitState(
          status: RankingStatus.initial,
          listRank: [],
          listRankId: [],
        )) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: RankingStatus.loadging));
    List<RankingModel> listRankingGet = [];
    List<int> listRankIdGet = [];
    try {
      QuerySnapshot<Map<String, dynamic>> dataQuery = await firebaseRank.orderBy("point", descending: true).get();

      if (dataQuery.docs.isNotEmpty) {
        for (var element in dataQuery.docs) {
          RankingModel rankingModel = RankingModel.fromMap(
            element.data(),
          );
          listRankingGet.add(rankingModel);
          listRankIdGet.add(rankingModel.id ?? 0);
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    emit(state.copyWith(
      status: RankingStatus.success,
      listRank: listRankingGet,
      listRankId: listRankIdGet,
    ));
  }

  addPointRank(MovieModel model) async {
    var checkContains = false;
    var indextContains = 0;
    for (var i = 0; i < state.listRankId.length; i++) {
      if (model.id == state.listRankId[i]) {
        checkContains = true;
        indextContains = i;
        break;
      }
    }
    if (checkContains) {
      var pointNoew = state.listRank[indextContains].point ?? 0;
      firebaseRank.doc(model.id.toString()).set(state.listRank[indextContains].copyWith(point: pointNoew + 10).toMap());
    } else {
      var ranknew = RankingModel.fromMap(model.toMap());
      firebaseRank.doc(model.id.toString()).set(ranknew.copyWith(point: 10).toMap());
    }
    await addVoterUser(model);
    getData();
  }

  addVoterUser(MovieModel model) async {
    var user = firebaseAuth.currentUser;
    var databaseVoters = await firebaseRank.doc(model.id.toString()).collection("userVote").doc(user?.uid.toString()).get();
    if (databaseVoters.exists) {
      UserVoteModel userVoteModel = UserVoteModel.fromMap(databaseVoters.data() ?? {});
      int pointcurrent = userVoteModel.point ?? 0;
      firebaseRank
          .doc(model.id.toString())
          .collection("userVote")
          .doc(user?.uid.toString())
          .set(userVoteModel.copyWith(point: pointcurrent + 10).toMap());
    } else {
      firebaseRank.doc(model.id.toString()).collection("userVote").doc(user?.uid.toString()).set(UserVoteModel(
            image: user?.photoURL,
            name: user?.displayName,
            email: user?.email,
            id: user?.uid,
            point: 10,
          ).toMap());
    }
  }
}
