// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LanguagesModel {
  String? iso_639_1;
  String? name;
  String? english_name;
  LanguagesModel({
    this.iso_639_1,
    this.name,
    this.english_name,
  });


  LanguagesModel copyWith({
    String? iso_639_1,
    String? name,
    String? english_name,
  }) {
    return LanguagesModel(
      iso_639_1: iso_639_1 ?? this.iso_639_1,
      name: name ?? this.name,
      english_name: english_name ?? this.english_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iso_639_1': iso_639_1,
      'name': name,
      'english_name': english_name,
    };
  }

  factory LanguagesModel.fromMap(Map<String, dynamic> map) {
    return LanguagesModel(
      iso_639_1: map['iso_639_1'] != null ? map['iso_639_1'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      english_name: map['english_name'] != null ? map['english_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguagesModel.fromJson(String source) => LanguagesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
