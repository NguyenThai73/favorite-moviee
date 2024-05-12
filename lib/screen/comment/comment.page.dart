import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_movie/constants/dialog.app.dart';
import 'package:favorite_movie/constants/loading.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/model/user.app.model.dart';
import 'package:favorite_movie/screen/block/block.cubit.dart';
import 'package:favorite_movie/screen/comment/comment.cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comment.cubit.state.dart';

class CommentPageScreen extends StatelessWidget {
  const CommentPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocBuilder<CommentCubit, CommentCubitState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF325A3E),
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    title: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, right: 10),
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: "$urlImageBase${context.read<CommentCubit>().movieDetailsModel.poster_path}",
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            context.read<CommentCubit>().movieDetailsModel.title ?? "",
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                          child: Stack(
                        children: [
                          Positioned.fill(
                            child: CachedNetworkImage(
                              imageUrl: "$urlImageBase${context.read<CommentCubit>().movieDetailsModel.backdrop_path}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Positioned.fill(
                            child: ListView.builder(
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                itemCount: state.listComment.length,
                                itemBuilder: (context, index) {
                                  final comment = state.listComment[index];
                                  return Container(
                                    margin: const EdgeInsets.only(top: 20, left: 16),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: GestureDetector(
                                            onTap: () async {
                                              if ((comment.createId != state.userAppModel.id)) {
                                                var response = await showDialog(
                                                  context: context,
                                                  builder: (context) => DialogApp(
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child: ClipOval(
                                                                child: (comment.avartar != null)
                                                                    ? CachedNetworkImage(
                                                                        imageUrl: comment.avartar ?? "",
                                                                        fit: BoxFit.cover,
                                                                        errorWidget: (context, url, error) {
                                                                          return Image.asset(
                                                                            "assets/noavatar.png",
                                                                            fit: BoxFit.cover,
                                                                          );
                                                                        },
                                                                      )
                                                                    : Image.asset(
                                                                        "assets/noavatar.png",
                                                                        fit: BoxFit.cover,
                                                                      )),
                                                          ),
                                                          const SizedBox(height: 15),
                                                          Text(
                                                            comment.name ?? "",
                                                            style: const TextStyle(
                                                              fontSize: 19,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.pop(context, true);
                                                                    },
                                                                    child: Container(
                                                                      width: 120,
                                                                      height: 50,
                                                                      alignment: Alignment.center,
                                                                      decoration: BoxDecoration(
                                                                        color: Color.fromARGB(255, 255, 130, 34),
                                                                        borderRadius: BorderRadius.circular(30),
                                                                      ),
                                                                      child: const Text('Block',
                                                                          style: TextStyle(
                                                                              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                                                                    )),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                if (response != null && response is bool && response == true) {
                                                  context.read<BlockCubit>().handleBlock(
                                                          user: UserAppModel(
                                                        id: comment.createId,
                                                        name: comment.name,
                                                        image: comment.avartar,
                                                      ));
                                                  context.read<CommentCubit>().removeComment(comment.createId ?? "");
                                                }
                                              }
                                            },
                                            child: ClipOval(
                                                child: (comment.avartar != null)
                                                    ? CachedNetworkImage(
                                                        imageUrl: comment.avartar ?? "",
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context, url, error) {
                                                          return Image.asset(
                                                            "assets/noavatar.png",
                                                            fit: BoxFit.cover,
                                                          );
                                                        },
                                                      )
                                                    : Image.asset(
                                                        "assets/noavatar.png",
                                                        fit: BoxFit.cover,
                                                      )),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 15),
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          padding: const EdgeInsets.all(16),
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(255, 155, 196, 167)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (comment.createId == state.userAppModel.id) ? "You" : comment.name ?? "",
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                comment.comment ?? "",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [Text(comment.createTime ?? "")],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 80,
                        padding: const EdgeInsets.only(bottom: 20, left: 16, top: 16, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: context.read<CommentCubit>().commentInput,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.0, fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                    counterStyle: const TextStyle(color: Colors.white),
                                    contentPadding: const EdgeInsets.all(15),
                                    isCollapsed: true,
                                    fillColor: const Color(0xFF325A3E),
                                    filled: true,
                                    hintText: 'Comment',
                                    hintStyle: const TextStyle(color: Color.fromARGB(132, 255, 255, 255), fontSize: 14, height: 1.0)),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  context.read<CommentCubit>().sendCommentMovie();
                                },
                                icon: const Icon(
                                  Icons.send,
                                  size: 26,
                                  color: Color(0xFF325A3E),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned.fill(child: state.status == CommentStatus.loading ? const LoadingApp() : const SizedBox.shrink())
            ],
          );
        },
      ),
    );
  }
}
