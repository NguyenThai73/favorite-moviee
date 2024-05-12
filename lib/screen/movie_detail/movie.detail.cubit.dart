// ignore_for_file: unused_field, prefer_const_literals_to_create_immutables
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/model/movie.details.model.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:favorite_movie/model/search.image.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie.detail.cubit.state.dart';

class MovieDetailCubit extends Cubit<MovieDetailCubitState> {
  final MovieModel movieModel;
  MovieDetailCubit({required this.movieModel})
      : super(MovieDetailCubitState(
            status: MovieDetailStatus.initial,
            movieDetailsModel: MovieDetailsModel(),
            listCredits: [],
            listKeyword: [],
            listVideo: [],
            searchImageModel: SearchImageModel())) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: MovieDetailStatus.loading));
    var movie = await movieController.getMovieDetails(idMovie: movieModel.id ?? 0);
    var listCats = await movieController.getListCast(idMovie: movieModel.id ?? 0);
    var listKeyword = await movieController.getListKeyword(idMovie: movieModel.id ?? 0);
    var listVideo = await movieController.getListVideo(idMovie: movieModel.id ?? 0);
    SearchImageModel searchImageModel = await movieController.getImageMoview(idMovie: movieModel.id ?? 0) ?? SearchImageModel();
    emit(state.copyWith(
      status: MovieDetailStatus.success,
      movieDetailsModel: movie,
      listKeyword: listKeyword,
      listCredits: listCats,
      listVideo: listVideo,
      searchImageModel: searchImageModel,
    ));
  }
}
