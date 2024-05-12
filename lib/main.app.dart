// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:favorite_movie/screen/account/account.cubit.dart';
import 'package:favorite_movie/screen/account/account.page.dart';
import 'package:favorite_movie/screen/favorite/favorite.page.dart';
import 'package:favorite_movie/screen/ranking/ranking.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'screen/home_screen/home.cubit.dart';
import 'screen/home_screen/home.screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final PageController pageController = PageController();
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => AccountCubit(),
        ),
        // BlocProvider(
        //   create: (context) => HomeCubit(),
        // ),
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              BlocProvider(
                create: (context) => HomeCubit(),
                child: const HomeScreen(),
              ),
              RankingScreen(),
              FavoritePage(),
              AccountPage(),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            height: 75,
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
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                      setState(() {
                        page = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icon_home.svg',
                          color: page == 0 ? Colors.black : Color(0xFFB4B4B4),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 12,
                            color: page == 0 ? Colors.black : Color(0xFFB4B4B4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                      setState(() {
                        page = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icon_rank.svg',
                          color: page == 1 ? Colors.black : Color(0xFFB4B4B4),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Ranking",
                          style: TextStyle(
                            fontSize: 12,
                            color: page == 1 ? Colors.black : Color(0xFFB4B4B4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                      setState(() {
                        page = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icon_heart.svg',
                          color: page == 2 ? Colors.black : Color(0xFFB4B4B4),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Favorite",
                          style: TextStyle(
                            fontSize: 12,
                            color: page == 2 ? Colors.black : Color(0xFFB4B4B4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateToPage(3, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                      setState(() {
                        page = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icon_user.svg',
                          color: page == 3 ? Colors.black : Color(0xFFB4B4B4),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Account",
                          style: TextStyle(
                            fontSize: 12,
                            color: page == 3 ? Colors.black : Color(0xFFB4B4B4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
