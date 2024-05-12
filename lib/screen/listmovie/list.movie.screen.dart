import 'package:favorite_movie/constants/movie.item.dart';
import 'package:favorite_movie/model/movie.model.dart';
import 'package:flutter/material.dart';

class ListMovieScreen extends StatelessWidget {
  final String titlePage;
  final List<MovieModel> listMovie;
  const ListMovieScreen({super.key, required this.titlePage, required this.listMovie});

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
        title: Text(
          titlePage,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(
            width: 44,
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: listMovie.map((e) {
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
          )),
    );
  }
}
