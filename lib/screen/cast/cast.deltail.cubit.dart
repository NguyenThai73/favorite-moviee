// ignore_for_file: unused_field, prefer_const_literals_to_create_immutables
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/model/cast.detail.model.dart';
import 'package:favorite_movie/model/cast.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cast.deltail.cubit.state.dart';

class CastDetailCubit extends Cubit<CastDetailCubitState> {
  final CastModel castModel;
  CastDetailCubit({required this.castModel})
      : super(CastDetailCubitState(
          status: CastDetailStatus.initial,
          castDetailModel: CastDetailModel(),
          listImage: [],
          listMovie: [],
        )) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: CastDetailStatus.loading));
    var castDetailModelGet = await movieController.getCastDetail(castId: castModel.id);
    var listImage = await movieController.getImageCastDetail(castId: castModel.id);
    var listMovie = await movieController.getMovieCastDetail(castId: castModel.id);
    emit(state.copyWith(
      status: CastDetailStatus.success,
      castDetailModel: castDetailModelGet,
      listImage: listImage,
      listMovie: listMovie,
    ));
  }
}
