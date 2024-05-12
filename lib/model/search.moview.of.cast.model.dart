// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:favorite_movie/model/movie.model.dart';

class SearchMovieOfCastModel {
  final int? id;
  final List<MovieModel>? cast;
  SearchMovieOfCastModel({
    this.id,
    this.cast,
  });

  SearchMovieOfCastModel copyWith({
    int? id,
    List<MovieModel>? cast,
  }) {
    return SearchMovieOfCastModel(
      id: id ?? this.id,
      cast: cast ?? this.cast,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory SearchMovieOfCastModel.fromMap(Map<String, dynamic> map) {
    return SearchMovieOfCastModel(
      id: map['id'] != null ? map['id'] as int : null,
      cast: map['cast'] != null ? List<MovieModel>.from((map['cast'] as List<dynamic>).map<MovieModel?>((x) => MovieModel.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchMovieOfCastModel.fromJson(String source) => SearchMovieOfCastModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
