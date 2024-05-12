// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class KeywordModel {
  final int? id;
  final String? name;
  KeywordModel({
    this.id,
    this.name,
  });

  KeywordModel copyWith({
    int? id,
    String? name,
  }) {
    return KeywordModel(
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

  factory KeywordModel.fromMap(Map<String, dynamic> map) {
    return KeywordModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KeywordModel.fromJson(String source) => KeywordModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
