// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/cast.model.dart';
import 'package:favorite_movie/model/key.word.model.dart';
import 'package:favorite_movie/model/movie.details.model.dart';
import 'package:favorite_movie/model/search.image.model.dart';
import 'package:favorite_movie/model/videos.response.dart';

class MovieDetailCubitState extends Equatable {
  final MovieDetailStatus status;
  final MovieDetailsModel movieDetailsModel;
  final List<CastModel> listCredits;
  final List<KeywordModel> listKeyword;
  final List<Video> listVideo;
  final SearchImageModel searchImageModel;
  const MovieDetailCubitState(
      {required this.status,
      required this.movieDetailsModel,
      required this.listCredits,
      required this.listKeyword,
      required this.listVideo,
      required this.searchImageModel});

  MovieDetailCubitState copyWith({
    MovieDetailStatus? status,
    MovieDetailsModel? movieDetailsModel,
    List<CastModel>? listCredits,
    List<KeywordModel>? listKeyword,
    List<Video>? listVideo,
    SearchImageModel? searchImageModel,
  }) {
    return MovieDetailCubitState(
      status: status ?? this.status,
      movieDetailsModel: movieDetailsModel ?? this.movieDetailsModel,
      listCredits: listCredits ?? this.listCredits,
      listKeyword: listKeyword ?? this.listKeyword,
      listVideo: listVideo ?? this.listVideo,
      searchImageModel: searchImageModel ?? this.searchImageModel,
    );
  }

  @override
  List<Object> get props => [
        status,
        listCredits,
        listCredits.length,
        movieDetailsModel,
        listVideo,
        listVideo.length,
        listKeyword,
        listKeyword.length,
        searchImageModel,
      ];
}

enum MovieDetailStatus { initial, loading, success, error, registerSuccess }
