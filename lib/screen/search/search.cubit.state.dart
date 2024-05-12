// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/movie.model.dart';

class SearchCubitState extends Equatable {
  SearchStatus status;
  List<String> listHistoryFind;
  List<MovieModel> listMovie;
  SearchCubitState({
    required this.status,
    required this.listHistoryFind,
    required this.listMovie,
  });

  SearchCubitState copyWith({
    SearchStatus? status,
    List<String>? listHistoryFind,
    List<MovieModel>? listMovie,
  }) {
    return SearchCubitState(
      status: status ?? this.status,
      listHistoryFind: listHistoryFind ?? this.listHistoryFind,
      listMovie: listMovie ?? this.listMovie,
    );
  }

  @override
  List<Object> get props => [status, listHistoryFind, listHistoryFind.length, listMovie, listMovie.length];
}

enum SearchStatus { initial, loading, success, error }
