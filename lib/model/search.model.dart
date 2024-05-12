// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'movie.model.dart';

class SearchModel {
  int page;
  List<MovieModel> results;
  int total_pages;
  int total_results;
  SearchModel({
    required this.page,
    required this.results,
    required this.total_pages,
    required this.total_results,
  });


  SearchModel copyWith({
    int? page,
    List<MovieModel>? results,
    int? total_pages,
    int? total_results,
  }) {
    return SearchModel(
      page: page ?? this.page,
      results: results ?? this.results,
      total_pages: total_pages ?? this.total_pages,
      total_results: total_results ?? this.total_results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'results': results.map((x) => x.toMap()).toList(),
      'total_pages': total_pages,
      'total_results': total_results,
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      page: (map['page'] ?? 0) as int,
      results: List<MovieModel>.from((map['results'] as List<dynamic>).map<MovieModel>((x) => MovieModel.fromMap(x as Map<String,dynamic>),),),
      total_pages: (map['total_pages'] ?? 0) as int,
      total_results: (map['total_results'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchModel.fromJson(String source) => SearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
