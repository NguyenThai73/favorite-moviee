import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_movie/constants/format.dart';
import 'package:favorite_movie/constants/loading.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:favorite_movie/model/ranking.model.dart';
import 'package:favorite_movie/screen/account/avatar.widget.dart';
import 'package:favorite_movie/screen/movie_detail/movie.detail.cubit.dart';
import 'package:favorite_movie/screen/movie_detail/movie.detail.screen.dart';
import 'package:favorite_movie/screen/movie_detail/vote.cubit.dart';
import 'package:favorite_movie/screen/search/search.cubit.dart';
import 'package:favorite_movie/screen/search/search.page.dart';
import 'package:favorite_movie/screen/voters/voters.cubit.dart';
import 'package:favorite_movie/screen/voters/voters.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ranking.cubit.dart';
import 'ranking.cubit.state.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 15),
              const Avatar(),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => MultiBlocProvider(providers: [
                                BlocProvider(
                                  lazy: false,
                                  create: (BuildContext context) => SearchCubit(),
                                ),
                              ], child: const SearchPage()),
                            ),
                          );
                        },
                        child: Image.asset("assets/icon_search.png")),
                  ),
                  const SizedBox(width: 12),
                ],
              )),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<RankingCubit, RankingCubitState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const SizedBox(height: 15),
                          for (int i = 0; i < state.listRank.length; i++)
                            RankingItem(
                              rankingModel: state.listRank[i],
                              sttRank: i + 1,
                            )
                        ]),
                      ),
                    ),
                    Positioned.fill(child: state.status == RankingStatus.loadging ? const LoadingApp() : const SizedBox.shrink())
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RankingItem extends StatelessWidget {
  final RankingModel rankingModel;
  final int sttRank;
  const RankingItem({super.key, required this.rankingModel, required this.sttRank});

  @override
  Widget build(BuildContext context) {
    return sttRank < 7
        ? Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => MovieDetailCubit(movieModel: MovieModel(id: rankingModel.id)),
                        ),
                        BlocProvider(
                          create: (context) => VoteCubit(),
                        ),
                      ],
                      child: const MovieDetailScreen(),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 90,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/${sttRank}st.png",
                                  ),
                                  fit: BoxFit.fill)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
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
                              imageUrl: "$urlImageBase${rankingModel.poster_path}",
                              fit: BoxFit.cover,
                            )),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rankingModel.title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Release Date: ${rankingModel.release_date}",
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Point: ${formatNumber(rankingModel.point ?? 0)}",
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => BlocProvider(
                                                lazy: false,
                                                create: (context) => VotersCubit(rankingModel: rankingModel),
                                                child: const VotersScreen(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Center(
                                            child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.how_to_reg,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Voters",
                                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => MovieDetailCubit(movieModel: MovieModel(id: rankingModel.id)),
                        ),
                        BlocProvider(
                          create: (context) => VoteCubit(),
                        ),
                      ],
                      child: const MovieDetailScreen(),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 215, 215, 215),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(1, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                              "#$sttRank",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
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
                              imageUrl: "$urlImageBase${rankingModel.poster_path}",
                              fit: BoxFit.cover,
                            )),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    rankingModel.title ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Release Date: ${rankingModel.release_date}",
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Point: ${formatNumber(rankingModel.point ?? 0)}",
                                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => BlocProvider(
                                                lazy: false,
                                                create: (context) => VotersCubit(rankingModel: rankingModel),
                                                child: const VotersScreen(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Center(
                                            child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.how_to_reg,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Voters",
                                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
