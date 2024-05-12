// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/movie.model.dart';

class HomeCubitState extends Equatable {
  final Status status;
  final List<MovieModel> listTrendingDay;
  final List<MovieModel> listTrendingWeek;
  final List<MovieModel> listPopular;
  final List<MovieModel> listNowPlaying;
  final List<MovieModel> listUpcoming;

  const HomeCubitState({
    required this.status,
    required this.listTrendingDay,
    required this.listTrendingWeek,
    required this.listPopular,
    required this.listNowPlaying,
    required this.listUpcoming,
  });

  HomeCubitState copyWith({
    Status? status,
    List<MovieModel>? listTrendingDay,
    List<MovieModel>? listTrendingWeek,
    List<MovieModel>? listPopular,
    List<MovieModel>? listNowPlaying,
    List<MovieModel>? listUpcoming,
  }) {
    return HomeCubitState(
      status: status ?? this.status,
      listTrendingDay: listTrendingDay ?? this.listTrendingDay,
      listTrendingWeek: listTrendingWeek ?? this.listTrendingWeek,
      listPopular: listPopular ?? this.listPopular,
      listNowPlaying: listNowPlaying ?? this.listNowPlaying,
      listUpcoming: listUpcoming ?? this.listUpcoming,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listTrendingDay,
        listTrendingWeek,
        listPopular,
        listTrendingDay.length,
        listTrendingWeek.length,
        listPopular.length,
        listNowPlaying.length,
        listNowPlaying,
        listUpcoming.length,
        listUpcoming,

      ];
}

enum Status { initial, loading, success, error }
