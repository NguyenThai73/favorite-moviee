import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_movie/constants/dialog.show.image.dart';
import 'package:favorite_movie/constants/movie.item.dart';
import 'package:favorite_movie/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cast.deltail.cubit.dart';
import 'cast.deltail.cubit.state.dart';

class CastDetailScreen extends StatelessWidget {
  const CastDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastDetailCubit, CastDetailCubitState>(
      builder: (context, state) {
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
            title: Text(
              state.castDetailModel.name ?? "",
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            centerTitle: true,
          ),
          body: (state.status == CastDetailStatus.loading)
              ? const SizedBox.shrink()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10, right: 20),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ]),
                                width: 100,
                                height: 150,
                                child: CachedNetworkImage(
                                  imageUrl: "$urlImageBase${state.castDetailModel.profile_path}",
                                  fit: BoxFit.cover,
                                )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.castDetailModel.name ?? "",
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Birth day: ${state.castDetailModel.birthday}",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  state.castDetailModel.deathday != null && state.castDetailModel.deathday != ""
                                      ? Container(
                                          margin: const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Birth day: ${state.castDetailModel.birthday}",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  Text(
                                    "Place of birth: ${state.castDetailModel.place_of_birth}",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Popularity: ${state.castDetailModel.popularity}",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(state.castDetailModel.biography ?? ""),
                        state.listImage.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Images",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      width: MediaQuery.of(context).size.width - 20,
                                      height: 150,
                                      child: ListView.separated(
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          var item = state.listImage[index];
                                          return GestureDetector(
                                            onTap: () {
                                              context.showDialogImage("$urlImageBase${item.file_path}");
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                              width: 100,
                                              child: CachedNetworkImage(
                                                imageUrl: "$urlImageBase${item.file_path}",
                                                fit: BoxFit.cover,
                                                errorWidget: (context, url, error) {
                                                  return Image.asset(
                                                    "assets/noava.png",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            width: 20,
                                          );
                                        },
                                        itemCount: state.listImage.length,
                                      ),
                                    ),
                                  ],
                                ))
                            : const SizedBox.shrink(),
                        state.listMovie.isNotEmpty
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Movies",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 206,
                                    child: ListView.separated(
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.listMovie.length,
                                      itemBuilder: (context, index) {
                                        var item = state.listMovie[index];
                                        return MovieItem(movie: item);
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 20,
                                        );
                                      },
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
