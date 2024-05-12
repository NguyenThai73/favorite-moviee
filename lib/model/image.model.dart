// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class ImageModel {
  final double? aspect_ratio;
  final int? height;
  final String? iso_639_1;
  final String? file_path;
  final double? vote_average;
  final int? vote_count;
  final int? width;
  ImageModel({
    this.aspect_ratio,
    this.height,
    this.iso_639_1,
    this.file_path,
    this.vote_average,
    this.vote_count,
    this.width,
  });

  ImageModel copyWith({
    double? aspect_ratio,
    int? height,
    String? iso_639_1,
    String? file_path,
    double? vote_average,
    int? vote_count,
    int? width,
  }) {
    return ImageModel(
      aspect_ratio: aspect_ratio ?? this.aspect_ratio,
      height: height ?? this.height,
      iso_639_1: iso_639_1 ?? this.iso_639_1,
      file_path: file_path ?? this.file_path,
      vote_average: vote_average ?? this.vote_average,
      vote_count: vote_count ?? this.vote_count,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aspect_ratio': aspect_ratio,
      'height': height,
      'iso_639_1': iso_639_1,
      'file_path': file_path,
      'vote_average': vote_average,
      'vote_count': vote_count,
      'width': width,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      aspect_ratio: map['aspect_ratio'] != null ? map['aspect_ratio'] as double : null,
      height: map['height'] != null ? map['height'] as int : null,
      iso_639_1: map['iso_639_1'] != null ? map['iso_639_1'] as String : null,
      file_path: map['file_path'] != null ? map['file_path'] as String : null,
      vote_average: map['vote_average'] != null ? map['vote_average'] as double : null,
      vote_count: map['vote_count'] != null ? map['vote_count'] as int : null,
      width: map['width'] != null ? map['width'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) => ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
