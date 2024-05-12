// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_movie/constants/dialog.show.image.dart';
import 'package:favorite_movie/constants/error.dart';
import 'package:favorite_movie/constants/format.dart';
import 'package:favorite_movie/constants/loading.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/screen/block/block.cubit.dart';
import 'package:favorite_movie/screen/cast/cast.deltail.cubit.dart';
import 'package:favorite_movie/screen/cast/cast.deltail.screen.dart';
import 'package:favorite_movie/screen/favorite/favorite.cubit.dart';
import 'package:favorite_movie/screen/ranking/ranking.cubit.dart';
import 'package:favorite_movie/screen/ranking/ranking.cubit.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../comment/comment.cubit.dart';
import '../comment/comment.page.dart';
import 'movie.detail.cubit.dart';
import 'movie.detail.cubit.state.dart';
import 'vote.cubit.dart';
import 'vote.cubit.state.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailCubitState>(
      builder: (context, state) {
        return BlocConsumer<VoteCubit, VoteCubitState>(
          listener: (context, stateVote) {
            if (stateVote.voteStatus == VoteStatus.success) {
              context.read<RankingCubit>().addPointRank(context.read<MovieDetailCubit>().movieModel);
            }
            if (stateVote.voteStatus == VoteStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialogApp(),
              );
            }
          },
          builder: (context, stateVote) {
            return Stack(
              children: [
                Positioned.fill(
                    child: Stack(
                  children: [
                    Positioned.fill(
                      child: Scaffold(
                        body: state.status == MovieDetailStatus.loading
                            ? const SizedBox.shrink()
                            : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height * 0.25,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: CachedNetworkImage(
                                                imageUrl: "$urlImageBase${state.movieDetailsModel.backdrop_path}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(height: 10),
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
                                              imageUrl: "$urlImageBase${state.movieDetailsModel.poster_path}",
                                              fit: BoxFit.cover,
                                            )),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.movieDetailsModel.title ?? "",
                                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "Release Date: ${state.movieDetailsModel.release_date}",
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [Icon(Icons.schedule), Text(" ${state.movieDetailsModel.runtime} minutes")],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Vote Count: ${state.movieDetailsModel.vote_count}",
                                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      "Vote Average: ${state.movieDetailsModel.vote_average}",
                                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Revenue: ${formatNumber(state.movieDetailsModel.revenue ?? 0)} USD",
                                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      "Budget: ${formatNumber(state.movieDetailsModel.budget ?? 0)} USD",
                                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                state.movieDetailsModel.tagline ?? "",
                                                style: TextStyle(fontSize: 15, color: Colors.blue),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                        child: Text(
                                          state.movieDetailsModel.overview ?? "",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Keywords",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              width: MediaQuery.of(context).size.width - 20,
                                              height: 30,
                                              child: ListView.separated(
                                                physics: const AlwaysScrollableScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  var item = state.listKeyword[index];
                                                  return Container(
                                                    padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(width: 0.8, color: Colors.grey), borderRadius: BorderRadius.circular(15)),
                                                    child: Text(item.name ?? ""),
                                                  );
                                                },
                                                separatorBuilder: (context, index) {
                                                  return const SizedBox(
                                                    width: 20,
                                                  );
                                                },
                                                itemCount: state.listKeyword.length,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Cast",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              width: MediaQuery.of(context).size.width - 20,
                                              height: 170,
                                              child: ListView.separated(
                                                physics: const AlwaysScrollableScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  var item = state.listCredits[index];
                                                  return Container(
                                                    height: 170,
                                                    width: 100,
                                                    padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push<void>(
                                                          context,
                                                          MaterialPageRoute<void>(
                                                            builder: (BuildContext context) => BlocProvider(
                                                              lazy: false,
                                                              create: (context) => CastDetailCubit(castModel: item),
                                                              child: const CastDetailScreen(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 130,
                                                            width: 100,
                                                            child: CachedNetworkImage(
                                                              imageUrl: "$urlImageBase${item.profilePath}",
                                                              fit: BoxFit.cover,
                                                              errorWidget: (context, url, error) {
                                                                return Image.asset(
                                                                  "assets/noava.png",
                                                                  fit: BoxFit.cover,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          SizedBox(
                                                            width: 100,
                                                            child: Text(
                                                              item.name,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder: (context, index) {
                                                  return const SizedBox(
                                                    width: 20,
                                                  );
                                                },
                                                itemCount: state.listCredits.length,
                                              ),
                                            ),
                                          ],
                                        )),
                                    state.searchImageModel.posters != null
                                        ? Container(
                                            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Posters",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 5),
                                                  width: MediaQuery.of(context).size.width - 20,
                                                  height: 150,
                                                  child: ListView.separated(
                                                    physics: const AlwaysScrollableScrollPhysics(),
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, index) {
                                                      var item = state.searchImageModel.posters![index];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          context.showDialogImage("$urlImageBase${item.file_path}");
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
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
                                                    itemCount: state.searchImageModel.posters!.length,
                                                  ),
                                                ),
                                              ],
                                            ))
                                        : SizedBox.shrink(),
                                    state.searchImageModel.backdrops != null
                                        ? Container(
                                            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Backdrops",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 5),
                                                  width: MediaQuery.of(context).size.width - 20,
                                                  height: 100,
                                                  child: ListView.separated(
                                                    physics: const AlwaysScrollableScrollPhysics(),
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, index) {
                                                      var item = state.searchImageModel.backdrops![index];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          context.showDialogImage("$urlImageBase${item.file_path}");
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                          width: 150,
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
                                                    itemCount: state.searchImageModel.backdrops!.length,
                                                  ),
                                                ),
                                              ],
                                            ))
                                        : SizedBox.shrink(),
                                    Container(
                                        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Trailers",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              width: MediaQuery.of(context).size.width - 20,
                                              height: 150,
                                              child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: state.listVideo.length,
                                                  itemBuilder: (context, index) {
                                                    final trailer = state.listVideo[index];
                                                    return YoutubeComponent(youtubeid: trailer.key ?? "");
                                                  }),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ),
                        bottomNavigationBar: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 80,
                          child: Row(
                            children: [
                              BlocBuilder<RankingCubit, RankingCubitState>(
                                builder: (context, state) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Color.fromARGB(255, 0, 130, 52), borderRadius: BorderRadius.circular(30)),
                                        child: Center(
                                            child: Text(
                                          state.listRankId.contains(context.read<MovieDetailCubit>().movieModel.id)
                                              ? "#${findIndex(state.listRankId, context.read<MovieDetailCubit>().movieModel.id ?? 0) + 1}"
                                              : "NaN",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )),
                                      ),
                                      Text(
                                          "Point: ${state.listRankId.contains(context.read<MovieDetailCubit>().movieModel.id) ? "${state.listRank[findIndex(state.listRankId, context.read<MovieDetailCubit>().movieModel.id ?? 0)].point ?? 0}" : "0"}"),
                                    ],
                                  );
                                },
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: GestureDetector(
                                                onTap: () {
                                                  context.read<VoteCubit>().voteProduct("upRank");
                                                },
                                                child: Center(
                                                    child: Text(
                                                  "Movie voting +10",
                                                  style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600),
                                                ))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<BlockCubit, BlockCubitState>(
                                    builder: (context, stateBlock) {
                                      return Container(
                                        margin: EdgeInsets.only(left: 15),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Color.fromARGB(255, 0, 130, 52), borderRadius: BorderRadius.circular(30)),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push<void>(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder: (BuildContext context) => BlocProvider(
                                                  lazy: false,
                                                  create: (context) =>
                                                      CommentCubit(movieDetailsModel: state.movieDetailsModel, listBlockId: stateBlock.listBlockId),
                                                  child: const CommentPageScreen(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Center(
                                              child: Icon(
                                            Icons.comment,
                                            color: Colors.white,
                                          )),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(color: const Color(0xFFEFEAEA), borderRadius: BorderRadius.circular(20)),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  BlocBuilder<FavoriteCubit, FavoriteCubitState>(
                                    builder: (context, state) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 15),
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(color: const Color(0xFFEFEAEA), borderRadius: BorderRadius.circular(20)),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.read<FavoriteCubit>().handleFavorite(movie: context.read<MovieDetailCubit>().movieModel);
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.favorite,
                                              size: 20,
                                              color: state.listFavorite.contains(context.read<MovieDetailCubit>().movieModel.id ?? 0)
                                                  ? const Color(0xFFDF0505)
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(color: const Color(0xFFEFEAEA), borderRadius: BorderRadius.circular(20)),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (state.movieDetailsModel.homepage != null &&
                                            Uri.tryParse(state.movieDetailsModel.homepage ?? "") != null) {
                                          _launchInBrowser(Uri.tryParse(state.movieDetailsModel.homepage ?? "")!);
                                        }
                                      },
                                      child: const Center(
                                        child: Icon(
                                          Icons.language,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                Positioned.fill(
                    child: state.status == MovieDetailStatus.loading || stateVote.voteStatus == VoteStatus.loading
                        ? const LoadingApp()
                        : const SizedBox.shrink())
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class YoutubeComponent extends StatefulWidget {
  final String youtubeid;

  const YoutubeComponent({super.key, required this.youtubeid});

  @override
  State<YoutubeComponent> createState() => YoutubeComponentState();
}

class YoutubeComponentState extends State<YoutubeComponent> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeid,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false, disableDragSeek: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 150,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressColors: const ProgressBarColors(
              playedColor: Color.fromARGB(255, 0, 133, 60),
              handleColor: Color.fromARGB(255, 0, 180, 39),
            ),
          ),
        ),
      ),
    );
  }
}

int findIndex(List<int> numbers, int target) {
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] == target) {
      return i; // Trả về vị trí của số trong danh sách
    }
  }
  // Nếu không tìm thấy số trong danh sách, trả về -1
  return -1;
}
