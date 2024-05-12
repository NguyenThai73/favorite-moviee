// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/comment.model.dart';
import 'package:favorite_movie/model/user.app.model.dart';

class CommentCubitState extends Equatable {
  CommentStatus status;
  List<CommentModel> listComment;
  UserAppModel userAppModel;
  CommentCubitState({
    required this.status,
    required this.listComment,
    required this.userAppModel,
  });

  CommentCubitState copyWith({
    CommentStatus? status,
    List<CommentModel>? listComment,
    UserAppModel? userAppModel,
  }) {
    return CommentCubitState(
      status: status ?? this.status,
      listComment: listComment ?? this.listComment,
      userAppModel: userAppModel ?? this.userAppModel,
    );
  }

  @override
  List<Object> get props => [status, listComment, listComment.length, userAppModel];
}

enum CommentStatus { initial, loading, success, error }
