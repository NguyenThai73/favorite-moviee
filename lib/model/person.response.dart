// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PersonResponse {
  bool? adult;
  List<String>? also_known_as;
  String? biography;
  DateTime? birthday;
  dynamic deathday;
  int? gender;
  String? homepage;
  int? id;
  String? imdb_id;
  String? known_for_department;
  String? name;
  String? place_of_birth;
  double? popularity;
  String? profile_path;
  PersonResponse({
    this.adult,
    this.also_known_as,
    this.biography,
    this.birthday,
    required this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdb_id,
    this.known_for_department,
    this.name,
    this.place_of_birth,
    this.popularity,
    this.profile_path,
  });

  PersonResponse copyWith({
    bool? adult,
    List<String>? also_known_as,
    String? biography,
    DateTime? birthday,
    dynamic deathday,
    int? gender,
    String? homepage,
    int? id,
    String? imdb_id,
    String? known_for_department,
    String? name,
    String? place_of_birth,
    double? popularity,
    String? profile_path,
  }) {
    return PersonResponse(
      adult: adult ?? this.adult,
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
      popularity: popularity ?? this.popularity,
      profile_path: profile_path ?? this.profile_path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'also_known_as': also_known_as,
      'biography': biography,
      'birthday': birthday?.millisecondsSinceEpoch,
      'deathday': deathday,
      'gender': gender,
      'homepage': homepage,
      'id': id,
      'imdb_id': imdb_id,
      'known_for_department': known_for_department,
      'name': name,
      'place_of_birth': place_of_birth,
      'popularity': popularity,
      'profile_path': profile_path,
    };
  }

  factory PersonResponse.fromMap(Map<String, dynamic> map) {
    return PersonResponse(
      adult: map['adult'] != null ? map['adult'] as bool : null,
      also_known_as: map['also_known_as'] != null ? List<String>.from((map['also_known_as'] as List<dynamic>)) : null,
      biography: map['biography'] != null ? map['biography'] as String : null,
      birthday: map['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch((map['birthday'] ?? 0) as int) : null,
      deathday: map['deathday'] as dynamic,
      gender: map['gender'] != null ? map['gender'] as int : null,
      homepage: map['homepage'] != null ? map['homepage'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      imdb_id: map['imdb_id'] != null ? map['imdb_id'] as String : null,
      known_for_department: map['known_for_department'] != null ? map['known_for_department'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      place_of_birth: map['place_of_birth'] != null ? map['place_of_birth'] as String : null,
      popularity: map['popularity'] != null ? map['popularity'] as double : null,
      profile_path: map['profile_path'] != null ? map['profile_path'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonResponse.fromJson(String source) => PersonResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
