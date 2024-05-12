// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../model/movie.model.dart';

class DataPageModel {
  String pageName;
  List<MovieModel> listData;
  DataPageModel({
    required this.pageName,
    required this.listData,
  });
}
