// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'movie.model.dart';

class MovieListsModel {
  Dates? dates;
  int? page;
  List<MovieModel>? results;
  int? total_pages;
  int? total_results;
  MovieListsModel({
    this.dates,
    this.page,
    this.results,
    this.total_pages,
    this.total_results,
  });

  MovieListsModel copyWith({
    Dates? dates,
    int? page,
    List<MovieModel>? results,
    int? total_pages,
    int? total_results,
  }) {
    return MovieListsModel(
      dates: dates ?? this.dates,
      page: page ?? this.page,
      results: results ?? this.results,
      total_pages: total_pages ?? this.total_pages,
      total_results: total_results ?? this.total_results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dates': dates?.toMap(),
      'page': page,
      'results':
          (results != null) ? results?.map((x) => x.toMap()).toList() : [],
      'total_pages': total_pages,
      'total_results': total_results,
    };
  }

  factory MovieListsModel.fromMap(Map<String, dynamic> map) {
    return MovieListsModel(
      dates: map['dates'] != null
          ? Dates.fromMap(map['dates'] as Map<String, dynamic>)
          : null,
      page: map['page'] != null ? map['page'] as int : null,
      results: map['results'] != null
          ? List<MovieModel>.from(
              (map['results'] as List).map<MovieModel?>(
                (x) => MovieModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      total_pages:
          map['total_pages'] != null ? map['total_pages'] as int : null,
      total_results:
          map['total_results'] != null ? map['total_results'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieListsModel.fromJson(String source) =>
      MovieListsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Dates {
  String? maximum;
  String? minimum;
  Dates({
    this.maximum,
    this.minimum,
  });

  Dates copyWith({
    String? maximum,
    String? minimum,
  }) {
    return Dates(
      maximum: maximum ?? this.maximum,
      minimum: minimum ?? this.minimum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maximum': maximum,
      'minimum': minimum,
    };
  }

  factory Dates.fromMap(Map<String, dynamic> map) {
    return Dates(
      maximum: map['maximum'] != null ? map['maximum'] as String : null,
      minimum: map['minimum'] != null ? map['minimum'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dates.fromJson(String source) =>
      Dates.fromMap(json.decode(source) as Map<String, dynamic>);
}
