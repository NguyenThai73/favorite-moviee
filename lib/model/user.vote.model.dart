// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserVoteModel {
  String? image;
  String? name;
  String? email;
  String? id;
  int? point;
  UserVoteModel({
    this.image,
    this.name,
    this.email,
    this.id,
    this.point,
  });

  UserVoteModel copyWith({
    String? image,
    String? name,
    String? email,
    String? id,
    int? point,
  }) {
    return UserVoteModel(
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'email': email,
      'id': id,
      'point': point,
    };
  }

  factory UserVoteModel.fromMap(Map<String, dynamic> map) {
    return UserVoteModel(
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      point: map['point'] != null ? map['point'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserVoteModel.fromJson(String source) => UserVoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
