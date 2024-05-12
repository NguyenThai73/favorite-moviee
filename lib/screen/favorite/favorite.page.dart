import 'package:favorite_movie/constants/movie.item.dart';
import 'package:favorite_movie/screen/account/avatar.widget.dart';
import 'package:favorite_movie/screen/favorite/favorite.cubit.dart';
import 'package:favorite_movie/screen/search/search.cubit.dart';
import 'package:favorite_movie/screen/search/search.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

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
          Expanded(child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
            builder: (context, state) {
              return Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: state.listFavoriteModel.map((e) {
                        double width = 0;
                        var widthScreen = MediaQuery.of(context).size.width / 2 - 20;
                        if (widthScreen > 206) {
                          width = 206;
                        } else {
                          width = widthScreen;
                        }
                        return SizedBox(
                          height: 206,
                          child: MovieItem(
                            width: width,
                            movie: e,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                  );
            },
          ))
        ],
      ),
    );
  }
}
