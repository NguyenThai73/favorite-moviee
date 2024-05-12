// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_movie/model/comment.model.dart';
import 'package:favorite_movie/model/movie.details.model.dart';
import 'package:favorite_movie/model/user.app.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'comment.cubit.state.dart';

class CommentCubit extends Cubit<CommentCubitState> {
  final firebaseClould = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final MovieDetailsModel movieDetailsModel;
  List<String> listBlockId;
  final TextEditingController commentInput = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late StreamSubscription<CommentModel> streamComment;
  bool isFirst = true;
  CommentCubit({required this.movieDetailsModel, required this.listBlockId})
      : super(CommentCubitState(status: CommentStatus.initial, listComment: [], userAppModel: UserAppModel())) {
    getData();
  }

  getData() async {
    startStream();
    emit(state.copyWith(status: CommentStatus.loading));
    var userNow = await getUserNow();
    var listCommentMovie = await getCommentsMovie();
    List<CommentModel> listCommentNow = [];
    for (var element in listCommentMovie) {
      if (listBlockId.contains(element.createId)) {
      } else {
        listCommentNow.add(element);
      }
    }
    emit(state.copyWith(status: CommentStatus.success, userAppModel: userNow, listComment: listCommentNow));
  }

  Future<UserAppModel?> getUserNow() async {
    var user = firebaseAuth.currentUser;
    if (user != null) {
      return UserAppModel(id: user.uid, name: user.displayName, email: user.email, image: user.photoURL);
    }
    return null;
  }

  startStream() async {
    streamComment = streamCommentMovie().listen((event) async {
      if (isFirst) {
        isFirst = false;
      } else {
        if (listBlockId.contains(event.createId)) {
        } else {
          emit(state.copyWith(listComment: [event, ...state.listComment]));
        }
      }
    });
  }

  Stream<CommentModel> streamCommentMovie() {
    return firebaseClould
        .collection('comment')
        .doc("${movieDetailsModel.id}")
        .collection("data")
        .orderBy("createTime", descending: true)
        .limit(1)
        .withConverter<CommentModel>(
          fromFirestore: (snapshot, options) {
            return CommentModel.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots()
        .map((event) {
      var listChange = event.docChanges.where((element) => element.type == DocumentChangeType.added).map((e) {
        return e.doc.data();
      }).toList();
      if (listChange.isEmpty) {
        return CommentModel();
      }
      return listChange.first!;
    });
  }

  Future<List<CommentModel>> getCommentsMovie() async {
    var result = await firebaseClould
        .collection('comment')
        .doc("${movieDetailsModel.id}")
        .collection("data")
        .orderBy("createTime", descending: true)
        .withConverter<CommentModel>(
          fromFirestore: (snapshot, options) => CommentModel.fromMap(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toMap(),
        )
        .get();
    return result.docs.map((e) => e.data()).toList();
  }

  sendCommentMovie() async {
    if (commentInput.text.isNotEmpty) {
      var idComment = Uuid().v4();
      firebaseClould.collection('comment').doc("${movieDetailsModel.id}").collection("data").doc(idComment).set(CommentModel(
              comment: commentInput.text,
              avartar: state.userAppModel.image,
              name: state.userAppModel.name,
              createTime: DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now()),
              createId: state.userAppModel.id)
          .copyWith(id: idComment)
          .toMap());
      commentInput.text = "";
    }
  }

  removeComment(String blockId) {
    emit(state.copyWith(status: CommentStatus.loading));
    List<CommentModel> listCommentNew = [];
    for (var element in state.listComment) {
      if (blockId == element.createId) {
      } else {
        listCommentNew.add(element);
      }
    }
    emit(state.copyWith(status: CommentStatus.success, listComment: listCommentNew));
  }

  @override
  Future<void> close() async {
    streamComment.cancel();
    return super.close();
  }
}
