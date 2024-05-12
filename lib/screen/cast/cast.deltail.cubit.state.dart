// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/cast.detail.model.dart';
import 'package:favorite_movie/model/image.model.dart';
import 'package:favorite_movie/model/movie.model.dart';

class CastDetailCubitState extends Equatable {
  final CastDetailStatus status;
  final CastDetailModel castDetailModel;
  final List<ImageModel> listImage;
  final List<MovieModel> listMovie;
  const CastDetailCubitState({
    required this.status,
    required this.castDetailModel,
    required this.listImage,
    required this.listMovie,
  });

  CastDetailCubitState copyWith({
    CastDetailStatus? status,
    CastDetailModel? castDetailModel,
    List<ImageModel>? listImage,
    List<MovieModel>? listMovie,
  }) {
    return CastDetailCubitState(
      status: status ?? this.status,
      castDetailModel: castDetailModel ?? this.castDetailModel,
      listImage: listImage ?? this.listImage,
      listMovie: listMovie ?? this.listMovie,
    );
  }

  @override
  List<Object> get props => [
        status,
        castDetailModel,
        listImage,
        listImage.length,
        listMovie,
        listMovie.length,
      ];
}

enum CastDetailStatus { initial, loading, success, error }
