// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CollectionModel {
  int? id;
  String? name;
  String? poster_path;
  String? backdrop_path;
  CollectionModel({
    this.id,
    this.name,
    this.poster_path,
    this.backdrop_path,
  });

  CollectionModel copyWith({
    int? id,
    String? name,
    String? poster_path,
    String? backdrop_path,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      poster_path: poster_path ?? this.poster_path,
      backdrop_path: backdrop_path ?? this.backdrop_path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'poster_path': poster_path,
      'backdrop_path': backdrop_path,
    };
  }

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      poster_path: map['poster_path'] != null ? map['poster_path'] as String : null,
      backdrop_path: map['backdrop_path'] != null ? map['backdrop_path'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionModel.fromJson(String source) => CollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
