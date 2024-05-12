// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_movie/main.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:favorite_movie/screen/favorite/favorite.cubit.dart';
import 'package:favorite_movie/screen/movie_detail/movie.detail.cubit.dart';
import 'package:favorite_movie/screen/movie_detail/movie.detail.screen.dart';
import 'package:favorite_movie/screen/movie_detail/vote.cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieItem extends StatelessWidget {
  final double? width;
  final MovieModel movie;
  const MovieItem({super.key, required this.movie, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: Key("plant:${movie.id}"),
      width: width ?? 175,
      height: 206,
      child: GestureDetector(
        onTap: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MovieDetailCubit(movieModel: movie),
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
              child: Column(
                children: [
                  SizedBox(
                    width: 175,
                    height: 146,
                    child: (movie.poster_path != null && movie.poster_path != "")
                        ? CachedNetworkImage(
                            imageUrl: "$urlImageBase${movie.poster_path}",
                            imageBuilder: (context, imageProvider) => Container(
                              width: 175,
                              height: 146,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: 175,
                              height: 146,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                image: DecorationImage(image: AssetImage("assets/background.png"), fit: BoxFit.cover),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 175,
                              height: 146,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                image: DecorationImage(image: AssetImage("assets/background.png"), fit: BoxFit.cover),
                              ),
                            ),
                          )
                        : Container(
                            width: 175,
                            height: 146,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                              image: DecorationImage(image: AssetImage("assets/background.png"), fit: BoxFit.cover),
                            ),
                          ),
                  ),
                  Container(
                    width: 175,
                    height: 60,
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        border: Border(
                          left: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                          right: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                          bottom: BorderSide(width: 1, color: Color(0xFFD8D8D8)),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF34493A), fontWeight: FontWeight.w700),
                        ),
                        // Text(
                        //   formatNumber(int.tryParse(movie.vote_count.toString()) ?? 0),
                        //   style: const TextStyle(fontSize: 14, color: Color(0xFFDF0000)),
                        // )
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(movie.release_date ?? "", style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 135, 135, 135))),
                            Row(
                              children: [
                                Icon(
                                  Icons.stars,
                                  color: Color.fromARGB(255, 0, 94, 31),
                                  size: 20,
                                ),
                                Text(
                                  "${(movie.vote_average ?? 0)}",
                                  style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 117, 127, 120)),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 8),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<FavoriteCubit>().handleFavorite(movie: movie);
                          },
                          child: Center(
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: state.listFavorite.contains(movie.id ?? 0) ? const Color(0xFFDF0505) : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
