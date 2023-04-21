import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/blocs/movies_cubit.dart';
import 'package:movie_explorer/repositories/tmdb_repository.dart';
import 'package:movie_explorer/ui/screens/home_page.dart';

void main() {
  runApp(BlocProvider(create: (_) => MoviesCubit(TmdbRepository()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
