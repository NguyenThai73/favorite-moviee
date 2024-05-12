// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteCubit extends Cubit<FavoriteCubitState> {
  final firebaseClould = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  FavoriteCubit() : super(FavoriteCubitState(status: FavoriteStatus.initial, listFavorite: [], listFavoriteModel: []));
  getData() async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    var queryBlock = await firebaseClould.collection("favorites").doc(firebaseAuth.currentUser?.uid ?? "").collection("data").get();
    List<MovieModel> listData = [];
    List<int> listDataId = [];
    for (var element in queryBlock.docs) {
      MovieModel movieModel = MovieModel.fromMap(element.data());
      listData.add(movieModel);
      listDataId.add(movieModel.id ?? 0);
    }
    emit(state.copyWith(status: FavoriteStatus.success, listFavorite: listDataId, listFavoriteModel: listData));
  }

  void handleFavorite({required MovieModel movie}) {
    if (movie.id != null) {
      emit(state.copyWith(status: FavoriteStatus.loading));
      if (state.listFavorite.contains(movie.id)) {
        var index = 0;
        for (var i = 0; i < state.listFavorite.length; i++) {
          if (state.listFavorite[i] == movie.id!) {
            index = i;
          }
        }
        state.listFavorite.removeAt(index);
        state.listFavoriteModel.removeAt(index);
        removeFavorite(movie);
      } else {
        state.listFavorite.add(movie.id ?? 0);
        state.listFavoriteModel.add(movie);
        addFavorite(movie);
      }
      emit(state.copyWith(status: FavoriteStatus.success, listFavorite: state.listFavorite, listFavoriteModel: state.listFavoriteModel));
    }
  }

  addFavorite(MovieModel movieModel) {
    firebaseClould.collection("favorites").doc(firebaseAuth.currentUser?.uid ?? "").collection("data").doc(movieModel.id.toString()).set(
          movieModel.toMap(),
        );
  }

  removeFavorite(MovieModel movieModel) {
    firebaseClould.collection("favorites").doc(firebaseAuth.currentUser?.uid ?? "").collection("data").doc(movieModel.id.toString()).delete();
  }
}

class FavoriteCubitState extends Equatable {
  final FavoriteStatus status;
  List<int> listFavorite;
  List<MovieModel> listFavoriteModel;

  FavoriteCubitState({
    required this.status,
    required this.listFavorite,
    required this.listFavoriteModel,
  });

  FavoriteCubitState copyWith({
    FavoriteStatus? status,
    List<int>? listFavorite,
    List<MovieModel>? listFavoriteModel,
  }) {
    return FavoriteCubitState(
      status: status ?? this.status,
      listFavorite: listFavorite ?? this.listFavorite,
      listFavoriteModel: listFavoriteModel ?? this.listFavoriteModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listFavorite,
        listFavorite.length,
        listFavoriteModel,
        listFavoriteModel.length,
      ];
}

enum FavoriteStatus { initial, loading, success, error }
