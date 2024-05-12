// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  final String? id;
  final String? avartar;
  final String? name;
  final String? comment;
  final String? createTime;
  final String? createId;
  CommentModel({
    this.id,
    this.avartar,
    this.name,
    this.comment,
    this.createTime,
    this.createId,
  });

  CommentModel copyWith({
    String? id,
    String? avartar,
    String? name,
    String? comment,
    String? createTime,
    String? createId,
  }) {
    return CommentModel(
      id: id ?? this.id,
      avartar: avartar ?? this.avartar,
      name: name ?? this.name,
      comment: comment ?? this.comment,
      createTime: createTime ?? this.createTime,
      createId: createId ?? this.createId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'avartar': avartar,
      'name': name,
      'comment': comment,
      'createTime': createTime,
      'createId': createId,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] != null ? map['id'] as String : null,
      avartar: map['avartar'] != null ? map['avartar'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      createTime: map['createTime'] != null ? map['createTime'] as String : null,
      createId: map['createId'] != null ? map['createId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
