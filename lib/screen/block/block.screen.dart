// ignore_for_file: unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_movie/model/user.app.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'block.cubit.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  InAppWebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF325A3E),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        leadingWidth: 50,
        title: const Text(
          "Block user",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(
            width: 44,
          )
        ],
      ),
      body: BlocBuilder<BlockCubit, BlockCubitState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.listBlock.length,
                itemBuilder: (context, index) {
                  final blockItem = state.listBlock[index];
                  return Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipOval(
                              child: (blockItem.image != null)
                                  ? CachedNetworkImage(
                                      imageUrl: blockItem.image ?? "",
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
                        const SizedBox(width: 15),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blockItem.name ?? "",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                        const SizedBox(width: 15),
                        GestureDetector(
                            onTap: () async{
                              context.read<BlockCubit>().handleBlock(user: UserAppModel(
                                id: blockItem.id,
                                name: blockItem.name,
                                image: blockItem.image,
                              ));
                            },
                            child: const Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
