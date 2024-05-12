import 'package:favorite_movie/constants/movie.item.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:favorite_movie/screen/listmovie/list.movie.screen.dart';
import 'package:flutter/material.dart';

class TrendingWeekComponent extends StatelessWidget {
  final List<MovieModel> listData;

  const TrendingWeekComponent({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Trending Week",
                style: TextStyle(fontSize: 20, color: Color(0xFF325A3E), fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ListMovieScreen(
                          titlePage:"Trending Week",
                          listMovie: listData,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "View more >",
                    style: TextStyle(fontSize: 12, color: Color(0xFF999898)),
                  )),
            ],
          ),
          listData.isNotEmpty
              ? SizedBox(
                  height: 206,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      var item = listData[index];
                      return MovieItem(movie: item);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 206,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                         width: 175,
                        decoration: BoxDecoration(color: Color.fromARGB(255, 224, 224, 224), borderRadius: BorderRadius.circular(20)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
