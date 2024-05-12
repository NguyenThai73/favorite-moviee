// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'cast.model.dart';

class GetListCast {
  int id;
  List<CastModel> cast;
  GetListCast({
    required this.id,
    required this.cast,
  });

  GetListCast copyWith({
    int? id,
    List<CastModel>? cast,
  }) {
    return GetListCast(
      id: id ?? this.id,
      cast: cast ?? this.cast,
    );
  }


  factory GetListCast.fromMap(Map<String, dynamic> map) {
    return GetListCast(
      id: (map['id'] ?? 0) as int,
      cast: List<CastModel>.from((map['cast'] as List<dynamic>).map<CastModel>((x) => CastModel.fromJson(x as Map<String,dynamic>),),),
    );
  }


  factory GetListCast.fromJson(String source) => GetListCast.fromMap(json.decode(source) as Map<String, dynamic>);
}
