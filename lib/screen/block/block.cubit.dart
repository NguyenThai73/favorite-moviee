// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:favorite_movie/model/user.app.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlockCubit extends Cubit<BlockCubitState> {
  final firebaseClould = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  BlockCubit() : super(BlockCubitState(status: BlockStatus.initial, listBlock: [], listBlockId: []));
  getData() async {
    emit(state.copyWith(status: BlockStatus.loading));
    var queryBlock = await firebaseClould.collection("block").doc(firebaseAuth.currentUser?.uid ?? "").collection("data").get();
    List<UserAppModel> listData = [];
    List<String> listDataId = [];
    for (var element in queryBlock.docs) {
      UserAppModel userItem = UserAppModel.fromMap(element.data());
      listData.add(userItem);
      listDataId.add(userItem.id ?? "");
    }
    emit(state.copyWith(status: BlockStatus.success, listBlockId: listDataId, listBlock: listData));
  }

  void handleBlock({required UserAppModel user}) {
    if (user.id != null) {
      emit(state.copyWith(status: BlockStatus.loading));
      if (state.listBlockId.contains(user.id)) {
        var index = 0;
        for (var i = 0; i < state.listBlockId.length; i++) {
          if (state.listBlockId[i] == user.id!) {
            index = i;
          }
        }
        state.listBlockId.remove(user.id);
        state.listBlock.removeAt(index);
        removeBlockUser(user);
      } else {
        state.listBlockId.add(user.id ?? "");
        state.listBlock.add(user);
        addBlockUser(user);
      }
      emit(state.copyWith(status: BlockStatus.success, listBlockId: state.listBlockId, listBlock: state.listBlock));
    }
  }

  addBlockUser(UserAppModel user) {
    firebaseClould.collection("block").doc(firebaseAuth.currentUser?.uid ?? "").collection("data").doc(user.id).set(
          user.toMap(),
        );
  }

  removeBlockUser(UserAppModel user) {
    firebaseClould.collection("block").doc(firebaseAuth.currentUser?.uid ?? "").collection("data").doc(user.id).delete();
  }
}

class BlockCubitState extends Equatable {
  final BlockStatus status;
  List<String> listBlockId;
  List<UserAppModel> listBlock;

  BlockCubitState({
    required this.status,
    required this.listBlockId,
    required this.listBlock,
  });

  BlockCubitState copyWith({
    BlockStatus? status,
    List<String>? listBlockId,
    List<UserAppModel>? listBlock,
  }) {
    return BlockCubitState(
      status: status ?? this.status,
      listBlockId: listBlockId ?? this.listBlockId,
      listBlock: listBlock ?? this.listBlock,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listBlockId,
        listBlockId.length,
        listBlock,
        listBlock.length,
      ];
}

enum BlockStatus { initial, loading, success, error }
