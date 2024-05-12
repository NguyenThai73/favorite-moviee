import 'package:favorite_movie/main.app.dart';
import 'package:favorite_movie/screen/block/block.cubit.dart';
import 'package:favorite_movie/screen/favorite/favorite.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_screen/login.cubit.dart';
import '../login_screen/login.screen.dart';
import 'splash.cubit.dart';
import 'splash.cubit.state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashCubitState>(
      listener: (context, state) {
        if (state.status == SplashStatus.login) {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => BlocProvider(
                create: (context) => LoginCubit(),
                child: const LoginScreen(),
              ),
            ),
          );
        } else {
          context.read<FavoriteCubit>().getData();
          context.read<BlockCubit>().getData();
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MainApp(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: const DecorationImage(image: AssetImage("assets/logo.png"))),
            ),
          ),
        );
      },
    );
  }
}
