import 'package:favorite_movie/controller/movie.controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.cubit.state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit()
      : super(const HomeCubitState(
            status: Status.initial, listTrendingDay: [], listTrendingWeek: [], listPopular: [], listNowPlaying: [], listUpcoming: [])) {
    getData();
  }
  final MovieController movieController = MovieController();
  getData() async {
    emit(state.copyWith(status: Status.loading));
    var listTrendingDay = await movieController.getListTrendingDay(page: 1);
    var listTrendingWeek = await movieController.getListTrendingWeek(page: 1);
    var listPopular = await movieController.getPopular(page: 1);
    var listNowPlaying = await movieController.getListNowPlaying(page: 1);
    var listUpcoming = await movieController.getUpcoming(page: 1);

    emit(state.copyWith(
      status: Status.success,
      listTrendingDay: listTrendingDay?.results ?? [],
      listTrendingWeek: listTrendingWeek?.results ?? [],
      listPopular: listPopular?.results ?? [],
      listNowPlaying: listNowPlaying?.results ?? [],
      listUpcoming: listUpcoming?.results ?? [],
    ));
  }
}
