import 'package:favorite_movie/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search.cubit.state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  final TextEditingController searchController = TextEditingController();
  SearchCubit() : super(SearchCubitState(status: SearchStatus.initial, listHistoryFind: [], listMovie: [])) {
    getData();
  }
  getData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var listHistory = prefs.getStringList("history") ?? [];
    emit(state.copyWith(
      status: SearchStatus.success,
      listHistoryFind: listHistory,
    ));
  }

  find() async {
    addHistory(searchController.text);
    findMovieDatabase(searchController.text);
  }

  findHistory(String findHistory) async {
    searchController.text = findHistory;
    findMovieDatabase(searchController.text);
  }

  addHistory(String historyNew) async {
    emit(state.copyWith(status: SearchStatus.initial));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(state.listHistoryFind.contains(historyNew)){
      state.listHistoryFind.remove(historyNew);
    }
    state.listHistoryFind.insert(0, historyNew);
    prefs.setStringList("history", state.listHistoryFind);
    emit(state.copyWith(status: SearchStatus.success, listHistoryFind: state.listHistoryFind));
  }

  removeHistory(String historyNew) async {
    emit(state.copyWith(status: SearchStatus.initial));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state.listHistoryFind.remove(historyNew);
    prefs.setStringList("history", state.listHistoryFind);
    emit(state.copyWith(status: SearchStatus.success, listHistoryFind: state.listHistoryFind));
  }

  findMovieDatabase(String name) async {
    emit(state.copyWith(
      status: SearchStatus.loading,
    ));
    var moview = await movieController.getDataSearch(findName: name, page: 1);
    emit(state.copyWith(status: SearchStatus.success, listMovie: moview?.results ?? []));
  }
}
