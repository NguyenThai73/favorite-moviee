// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'image.model.dart';

class SearchImageModel {
  final List<ImageModel>? backdrops;
  final List<ImageModel>? logos;
  final List<ImageModel>? posters;
  SearchImageModel({
    this.backdrops,
    this.logos,
    this.posters,
  });

  SearchImageModel copyWith({
    List<ImageModel>? backdrops,
    List<ImageModel>? logos,
    List<ImageModel>? posters,
  }) {
    return SearchImageModel(
      backdrops: backdrops ?? this.backdrops,
      logos: logos ?? this.logos,
      posters: posters ?? this.posters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'backdrops': backdrops.map((x) => x?.toMap()).toList(),
      // 'logos': logos.map((x) => x?.toMap()).toList(),
      // 'posters': posters.map((x) => x?.toMap()).toList(),
    };
  }

  factory SearchImageModel.fromMap(Map<String, dynamic> map) {
    return SearchImageModel(
      backdrops: map['backdrops'] != null
          ? List<ImageModel>.from(
              (map['backdrops'] as List<dynamic>).map<ImageModel?>(
                (x) => ImageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      logos: map['logos'] != null
          ? List<ImageModel>.from(
              (map['logos'] as List<dynamic>).map<ImageModel?>(
                (x) => ImageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      posters: map['posters'] != null
          ? List<ImageModel>.from(
              (map['posters'] as List<dynamic>).map<ImageModel?>(
                (x) => ImageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchImageModel.fromJson(String source) => SearchImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
