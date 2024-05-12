// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductionCompaniesModel {
  int? id;
  String? logo_path;
  String? name;
  String? origin_country;
  ProductionCompaniesModel({
    this.id,
    this.logo_path,
    this.name,
    this.origin_country,
  });

  ProductionCompaniesModel copyWith({
    int? id,
    String? logo_path,
    String? name,
    String? origin_country,
  }) {
    return ProductionCompaniesModel(
      id: id ?? this.id,
      logo_path: logo_path ?? this.logo_path,
      name: name ?? this.name,
      origin_country: origin_country ?? this.origin_country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'logo_path': logo_path,
      'name': name,
      'origin_country': origin_country,
    };
  }

  factory ProductionCompaniesModel.fromMap(Map<String, dynamic> map) {
    return ProductionCompaniesModel(
      id: map['id'] != null ? map['id'] as int : null,
      logo_path: map['logo_path'] != null ? map['logo_path'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      origin_country: map['origin_country'] != null ? map['origin_country'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionCompaniesModel.fromJson(String source) => ProductionCompaniesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
