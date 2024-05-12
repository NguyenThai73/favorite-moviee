// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class CountriesModel {
  String? iso_3166_1;
  String? english_name;
  String? native_name;
  CountriesModel({
    this.iso_3166_1,
    this.english_name,
    this.native_name,
  });

  CountriesModel copyWith({
    String? iso_3166_1,
    String? english_name,
    String? native_name,
  }) {
    return CountriesModel(
      iso_3166_1: iso_3166_1 ?? this.iso_3166_1,
      english_name: english_name ?? this.english_name,
      native_name: native_name ?? this.native_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iso_3166_1': iso_3166_1,
      'english_name': english_name,
      'native_name': native_name,
    };
  }

  factory CountriesModel.fromMap(Map<String, dynamic> map) {
    return CountriesModel(
      iso_3166_1: map['iso_3166_1'] != null ? map['iso_3166_1'] as String : null,
      english_name: map['english_name'] != null ? map['english_name'] as String : null,
      native_name: map['native_name'] != null ? map['native_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountriesModel.fromJson(String source) => CountriesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
