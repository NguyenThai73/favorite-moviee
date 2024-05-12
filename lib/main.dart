import 'package:favorite_movie/screen/block/block.cubit.dart';
import 'package:favorite_movie/screen/ranking/ranking.cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/movie.controller.dart';
import 'firebase_options.dart';
import 'screen/favorite/favorite.cubit.dart';
import 'screen/splash_screen/splash.cubit.dart';
import 'screen/splash_screen/splash.screen.dart';

final movieController = MovieController();
String urlImageBase = "https://image.tmdb.org/t/p/original/";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => BlockCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => RankingCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => SplashCubit(),
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
