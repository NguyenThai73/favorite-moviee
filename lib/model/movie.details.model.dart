// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'collection.model.dart';
import 'countries.model.dart';
import 'genre.model.dart';
import 'language.model.dart';
import 'production.companies.model.dart';

class MovieDetailsModel {
  bool? adult;
  String? backdrop_path;
  CollectionModel? belongs_to_collection;
  int? budget;
  List<GenreModel>? genres;
  String? homepage;
  int? id;
  String? imdb_id;
  String? original_language;
  String? original_title;
  String? overview;
  double? popularity;
  String? poster_path;
  List<ProductionCompaniesModel>? production_companies;
  List<CountriesModel>? production_countries;
  String? release_date;
  int? revenue;
  int? runtime;
  List<LanguagesModel>? spoken_languages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? vote_average;
  int? vote_count;
  MovieDetailsModel({
    this.adult,
    this.backdrop_path,
    this.belongs_to_collection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdb_id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.production_companies,
    this.production_countries,
    this.release_date,
    this.revenue,
    this.runtime,
    this.spoken_languages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
  });

  MovieDetailsModel copyWith({
    bool? adult,
    String? backdrop_path,
    CollectionModel? belongs_to_collection,
    int? budget,
    List<GenreModel>? genres,
    String? homepage,
    int? id,
    String? imdb_id,
    String? original_language,
    String? original_title,
    String? overview,
    double? popularity,
    String? poster_path,
    List<ProductionCompaniesModel>? production_companies,
    List<CountriesModel>? production_countries,
    String? release_date,
    int? revenue,
    int? runtime,
    List<LanguagesModel>? spoken_languages,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? vote_average,
    int? vote_count,
  }) {
    return MovieDetailsModel(
      adult: adult ?? this.adult,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      belongs_to_collection:
          belongs_to_collection ?? this.belongs_to_collection,
      budget: budget ?? this.budget,
      genres: genres ?? this.genres,
      homepage: homepage ?? this.homepage,
      id: id ?? this.id,
      imdb_id: imdb_id ?? this.imdb_id,
      original_language: original_language ?? this.original_language,
      original_title: original_title ?? this.original_title,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      poster_path: poster_path ?? this.poster_path,
      production_companies: production_companies ?? this.production_companies,
      production_countries: production_countries ?? this.production_countries,
      release_date: release_date ?? this.release_date,
      revenue: revenue ?? this.revenue,
      runtime: runtime ?? this.runtime,
      spoken_languages: spoken_languages ?? this.spoken_languages,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      title: title ?? this.title,
      video: video ?? this.video,
      vote_average: vote_average ?? this.vote_average,
      vote_count: vote_count ?? this.vote_count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdrop_path': backdrop_path,
      'belongs_to_collection': belongs_to_collection?.toMap(),
      'budget': budget,
      'genres':
          (genres != null) ? genres?.map((x) => x.toMap()).toList() : null,
      'homepage': homepage,
      'id': id,
      'imdb_id': imdb_id,
      'original_language': original_language,
      'original_title': original_title,
      'overview': overview,
      'popularity': popularity,
      'poster_path': poster_path,
      'production_companies': (production_companies != null)
          ? production_companies?.map((x) => x.toMap()).toList()
          : null,
      'production_countries': (production_countries != null)
          ? production_countries?.map((x) => x.toMap()).toList()
          : null,
      'release_date': release_date,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': (spoken_languages != null)
          ? spoken_languages?.map((x) => x.toMap()).toList()
          : null,
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': vote_average,
      'vote_count': vote_count,
    };
  }

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailsModel(
      adult: map['adult'] != null ? map['adult'] as bool : null,
      backdrop_path:
          map['backdrop_path'] != null ? map['backdrop_path'] as String : null,
      belongs_to_collection: map['belongs_to_collection'] != null
          ? CollectionModel.fromMap(
              map['belongs_to_collection'] as Map<String, dynamic>)
          : null,
      budget: map['budget'] != null ? map['budget'] as int : null,
      genres: map['genres'] != null
          ? List<GenreModel>.from(
              (map['genres'] as List<dynamic>).map<GenreModel?>(
                (x) => GenreModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      homepage: map['homepage'] != null ? map['homepage'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      imdb_id: map['imdb_id'] != null ? map['imdb_id'] as String : null,
      original_language: map['original_language'] != null
          ? map['original_language'] as String
          : null,
      original_title: map['original_title'] != null
          ? map['original_title'] as String
          : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      popularity:
          map['popularity'] != null ? map['popularity'] as double : null,
      poster_path:
          map['poster_path'] != null ? map['poster_path'] as String : null,
      production_companies: map['production_companies'] != null
          ? List<ProductionCompaniesModel>.from(
              (map['production_companies'] as List<dynamic>)
                  .map<ProductionCompaniesModel?>(
                (x) =>
                    ProductionCompaniesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      production_countries: map['production_countries'] != null
          ? List<CountriesModel>.from(
              (map['production_countries'] as List<dynamic>).map<CountriesModel?>(
                (x) => CountriesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      release_date:
          map['release_date'] != null ? map['release_date'] as String : null,
      revenue: map['revenue'] != null ? map['revenue'] as int : null,
      runtime: map['runtime'] != null ? map['runtime'] as int : null,
      spoken_languages: map['spoken_languages'] != null
          ? List<LanguagesModel>.from(
              (map['spoken_languages'] as List<dynamic>).map<LanguagesModel?>(
                (x) => LanguagesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      tagline: map['tagline'] != null ? map['tagline'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      video: map['video'] != null ? map['video'] as bool : null,
      vote_average:
          map['vote_average'] != null ? map['vote_average'] as double : null,
      vote_count: map['vote_count'] != null ? map['vote_count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailsModel.fromJson(String source) =>
      MovieDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
