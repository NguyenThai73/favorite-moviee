// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:favorite_movie/model/image.model.dart';

class ImageResponseModel {
  final int? id;
  final List<ImageModel>? profiles;
  ImageResponseModel({
    this.id,
    this.profiles,
  });

  ImageResponseModel copyWith({
    int? id,
    List<ImageModel>? profiles,
  }) {
    return ImageResponseModel(
      id: id ?? this.id,
      profiles: profiles ?? this.profiles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory ImageResponseModel.fromMap(Map<String, dynamic> map) {
    return ImageResponseModel(
      id: map['id'] != null ? map['id'] as int : null,
      profiles: map['profiles'] != null ? List<ImageModel>.from((map['profiles'] as List<dynamic>).map<ImageModel?>((x) => ImageModel.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageResponseModel.fromJson(String source) => ImageResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
