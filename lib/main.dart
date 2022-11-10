import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/business_logic/movies_cubit.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/screens/main_page.dart';
import 'package:movie_app/screens/splash_page.dart';
import 'package:movie_app/services/movies_services.dart';
import 'package:bloc/bloc.dart';

void main() {
  runApp(SplashPage(
    key: UniqueKey(),
    onInitializationComplete: () => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit(MovieRepository(MoviesServices())),
      child: MaterialApp(
        title: 'Movies',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: 'home',
        routes: {
          'home': (context) => MainPage(),
        },
      ),
    );
  }
}
