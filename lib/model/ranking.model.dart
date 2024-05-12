import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class RankingModel {
  int? id;
  bool? adult;
  String? backdrop_path;
  List<int>? genre_ids;
  String? original_language;
  String? original_title;
  String? overview;
  double? popularity;
  String? poster_path;
  String? release_date;
  String? title;
  bool? video;
  double? vote_average;
  int? vote_count;
  String? heroId;
  int? point;
  RankingModel({
    this.id,
    this.adult,
    this.backdrop_path,
    this.genre_ids,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.release_date,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
    this.heroId,
    this.point,
  });

  RankingModel copyWith({
    int? id,
    bool? adult,
    String? backdrop_path,
    List<int>? genre_ids,
    String? original_language,
    String? original_title,
    String? overview,
    double? popularity,
    String? poster_path,
    String? release_date,
    String? title,
    bool? video,
    double? vote_average,
    int? vote_count,
    String? heroId,
    int? point,
  }) {
    return RankingModel(
      id: id ?? this.id,
      adult: adult ?? this.adult,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      genre_ids: genre_ids ?? this.genre_ids,
      original_language: original_language ?? this.original_language,
      original_title: original_title ?? this.original_title,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      poster_path: poster_path ?? this.poster_path,
      release_date: release_date ?? this.release_date,
      title: title ?? this.title,
      video: video ?? this.video,
      vote_average: vote_average ?? this.vote_average,
      vote_count: vote_count ?? this.vote_count,
      heroId: heroId ?? this.heroId,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'adult': adult,
      'backdrop_path': backdrop_path,
      'genre_ids': genre_ids,
      'original_language': original_language,
      'original_title': original_title,
      'overview': overview,
      'popularity': popularity,
      'poster_path': poster_path,
      'release_date': release_date,
      'title': title,
      'video': video,
      'vote_average': vote_average,
      'vote_count': vote_count,
      'heroId': heroId,
      'point': point,
    };
  }

  factory RankingModel.fromMap(Map<String, dynamic> map) {
    return RankingModel(
      id: map['id'] != null ? map['id'] as int : null,
      adult: map['adult'] != null ? map['adult'] as bool : null,
      backdrop_path: map['backdrop_path'] != null ? map['backdrop_path'] as String : null,
      genre_ids: map['genre_ids'] != null ? List<int>.from((map['genre_ids'] as List<dynamic>)) : null,
      original_language: map['original_language'] != null ? map['original_language'] as String : null,
      original_title: map['original_title'] != null ? map['original_title'] as String : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      popularity: map['popularity'] != null ? map['popularity'] as double : null,
      poster_path: map['poster_path'] != null ? map['poster_path'] as String : null,
      release_date: map['release_date'] != null ? map['release_date'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      video: map['video'] != null ? map['video'] as bool : null,
      vote_average: map['vote_average'] != null ? map['vote_average'] as double : null,
      vote_count: map['vote_count'] != null ? map['vote_count'] as int : null,
      heroId: map['heroId'] != null ? map['heroId'] as String : null,
      point: map['point'] != null ? map['point'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RankingModel.fromJson(String source) => RankingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
