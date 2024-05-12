// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserAppModel {
  String? image;
  String? name;
  String? email;
  String? id;
  UserAppModel({
    this.image,
    this.name,
    this.email,
    this.id,
  });

  UserAppModel copyWith({
    String? image,
    String? name,
    String? email,
    String? id,
  }) {
    return UserAppModel(
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'email': email,
      'id': id,
    };
  }

  factory UserAppModel.fromMap(Map<String, dynamic> map) {
    return UserAppModel(
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAppModel.fromJson(String source) => UserAppModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
