// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GenreModel {
  int? id;
  String? name;
  GenreModel({
    this.id,
    this.name,
  });

  GenreModel copyWith({
    int? id,
    String? name,
  }) {
    return GenreModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GenreModel.fromJson(String source) => GenreModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
