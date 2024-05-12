// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideosResponse {
  int? id;
  List<Video>? results;
  VideosResponse({
    this.id,
    this.results,
  });

  VideosResponse copyWith({
    int? id,
    List<Video>? results,
  }) {
    return VideosResponse(
      id: id ?? this.id,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
     
    };
  }

  factory VideosResponse.fromMap(Map<String, dynamic> map) {
    return VideosResponse(
      id: map['id'] != null ? map['id'] as int : null,
      results: map['results'] != null ? List<Video>.from((map['results'] as List<dynamic>).map<Video?>((x) => Video.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideosResponse.fromJson(String source) => VideosResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Video {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? published_at;
  String? id;
  Video({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.published_at,
    this.id,
  });

  Video copyWith({
    String? iso6391,
    String? iso31661,
    String? name,
    String? key,
    String? site,
    int? size,
    String? type,
    bool? official,
    String? published_at,
    String? id,
  }) {
    return Video(
      iso6391: iso6391 ?? this.iso6391,
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
      key: key ?? this.key,
      site: site ?? this.site,
      size: size ?? this.size,
      type: type ?? this.type,
      official: official ?? this.official,
      published_at: published_at ?? this.published_at,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iso6391': iso6391,
      'iso31661': iso31661,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'published_at': published_at,
      'id': id,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      iso6391: map['iso6391'] != null ? map['iso6391'] as String : null,
      iso31661: map['iso31661'] != null ? map['iso31661'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      key: map['key'] != null ? map['key'] as String : null,
      site: map['site'] != null ? map['site'] as String : null,
      size: map['size'] != null ? map['size'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      official: map['official'] != null ? map['official'] as bool : null,
      published_at: map['published_at'] != null ? map['published_at'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source) as Map<String, dynamic>);
}
