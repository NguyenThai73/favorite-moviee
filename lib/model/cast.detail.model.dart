// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CastDetailModel {
  final List<String>? also_known_as;
  final String? biography;
  final String? birthday;
  final String? deathday;
  final int? gender;
  final String? homepage;
  final int? id;
  final String? imdb_id;
  final String? known_for_department;
  final String? name;
  final String? place_of_birth;
  final String? profile_path;
  final double? popularity;
  CastDetailModel({
    this.also_known_as,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdb_id,
    this.known_for_department,
    this.name,
    this.place_of_birth,
    this.profile_path,
    this.popularity,
  });

  CastDetailModel copyWith({
    List<String>? also_known_as,
    String? biography,
    String? birthday,
    String? deathday,
    int? gender,
    String? homepage,
    int? id,
    String? imdb_id,
    String? known_for_department,
    String? name,
    String? place_of_birth,
    String? profile_path,
    double? popularity,
  }) {
    return CastDetailModel(
      also_known_as: also_known_as ?? this.also_known_as,
      biography: biography ?? this.biography,
      birthday: birthday ?? this.birthday,
      deathday: deathday ?? this.deathday,
      gender: gender ?? this.gender,
      homepage: homepage ?? this.homepage,
      id: id ?? this.id,
      imdb_id: imdb_id ?? this.imdb_id,
      known_for_department: known_for_department ?? this.known_for_department,
      name: name ?? this.name,
      place_of_birth: place_of_birth ?? this.place_of_birth,
      profile_path: profile_path ?? this.profile_path,
      popularity: popularity ?? this.popularity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'also_known_as': also_known_as,
      'biography': biography,
      'birthday': birthday,
      'deathday': deathday,
      'gender': gender,
      'homepage': homepage,
      'id': id,
      'imdb_id': imdb_id,
      'known_for_department': known_for_department,
      'name': name,
      'place_of_birth': place_of_birth,
      'profile_path': profile_path,
      'popularity': popularity,
    };
  }

  factory CastDetailModel.fromMap(Map<String, dynamic> map) {
    return CastDetailModel(
      also_known_as: map['also_known_as'] != null ? List<String>.from((map['also_known_as'] as List<dynamic>)) : null,
      biography: map['biography'] != null ? map['biography'] as String : null,
      birthday: map['birthday'] != null ? map['birthday'] as String : null,
      deathday: map['deathday'] != null ? map['deathday'] as String : null,
      gender: map['gender'] != null ? map['gender'] as int : null,
      homepage: map['homepage'] != null ? map['homepage'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      imdb_id: map['imdb_id'] != null ? map['imdb_id'] as String : null,
      known_for_department: map['known_for_department'] != null ? map['known_for_department'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      place_of_birth: map['place_of_birth'] != null ? map['place_of_birth'] as String : null,
      profile_path: map['profile_path'] != null ? map['profile_path'] as String : null,
      popularity: map['popularity'] != null ? map['popularity'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CastDetailModel.fromJson(String source) => CastDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
