// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_movie/constants/loading.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:favorite_movie/screen/home_screen/trending/trending.day.component.dart';
import 'package:favorite_movie/screen/home_screen/trending/trending.week.component.dart';
import 'package:favorite_movie/screen/movie_detail/movie.detail.screen.dart';
import 'package:favorite_movie/screen/movie_detail/vote.cubit.dart';
import 'package:favorite_movie/screen/ranking/ranking.cubit.dart';
import 'package:favorite_movie/screen/ranking/ranking.cubit.state.dart';
import 'package:favorite_movie/screen/search/search.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account/avatar.widget.dart';
import '../movie_detail/movie.detail.cubit.dart';
import '../search/search.page.dart';
import 'home.cubit.dart';
import 'home.cubit.state.dart';
import 'nowplaying/now.playing.component.dart';
import 'popular/popular.component.dart';
import 'upcoming/upcoming.component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                                // BlocProvider(
                                //   lazy: false,
                                //   create: (BuildContext context) => context.read<FavoriteCubit>(),
                                // ),
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
            child: BlocBuilder<HomeCubit, HomeCubitState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Top ranking",
                                    style: TextStyle(fontSize: 25, color: Color(0xFF325A3E), fontWeight: FontWeight.w700),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 15, bottom: 26, top: 5),
                                child: BlocBuilder<RankingCubit, RankingCubitState>(
                                  builder: (context, state) {
                                    if (state.listRank.isEmpty) {
                                      return SizedBox.shrink();
                                    }
                                    var list = [];
                                    if (state.listRank.length > 2) {
                                      list = state.listRank.sublist(0, 3);
                                    } else {
                                      list = state.listRank;
                                    }

                                    return CarouselSlider(
                                        options: CarouselOptions(
                                          autoPlayInterval: Duration(milliseconds: 4000),
                                          autoPlay: true,
                                          aspectRatio: 16 / 9,
                                          enlargeCenterPage: true,
                                          viewportFraction: 1,
                                          onPageChanged: (index, reason) {},
                                        ),
                                        items: [
                                          for (var i = 0; i < list.length; i++)
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push<void>(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext context) => MultiBlocProvider(
                                                      providers: [
                                                        BlocProvider(
                                                          create: (context) => MovieDetailCubit(movieModel: MovieModel(id: list[i].id)),
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
                                              child: Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: CachedNetworkImage(
                                                      imageUrl: "$urlImageBase${list[i].backdrop_path}",
                                                      fit: BoxFit.fitWidth,
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                      imageBuilder: (context, imageProvider) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth)),
                                                        );
                                                      },
                                                      errorWidget: (context, url, error) {
                                                        return Container(
                                                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10), color: Colors.grey.withOpacity(0.5)),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.error,
                                                              size: 35,
                                                              color: Color.fromARGB(255, 255, 141, 132),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Positioned.fill(
                                                    child: Container(
                                                      color: Color.fromARGB(50, 0, 0, 0),
                                                    ),
                                                  ),
                                                  Positioned.fill(
                                                      child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                                                              width: 65,
                                                              child: Image.asset(
                                                                "assets/top${i + 1}.png",
                                                                fit: BoxFit.cover,
                                                              )),
                                                          Container(
                                                            margin: EdgeInsets.only(top: 10),
                                                            child: Text(
                                                              "Point: ${list[i].point ?? 0}",
                                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                          padding: EdgeInsets.all(10),
                                                          child: Text(
                                                            "${list[i].title}",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ))
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            )
                                        ]);
                                  },
                                ),
                              ),
                              TrendingDayComponent(
                                listData: state.listTrendingDay,
                              ),
                              const SizedBox(height: 30),
                              TrendingWeekComponent(
                                listData: state.listTrendingWeek,
                              ),
                              const SizedBox(height: 30),
                              PopularComponent(
                                listData: state.listPopular,
                              ),
                              const SizedBox(height: 30),
                              NowPlayingComponent(
                                listData: state.listPopular,
                              ),
                              const SizedBox(height: 30),
                              UpcomingComponent(
                                listData: state.listPopular,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(child: state.status == Status.loading ? LoadingApp() : SizedBox.shrink())
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
