import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/blocs/favorite_cubit.dart';
import 'package:movie_explorer/blocs/movies_cubit.dart';
import 'package:movie_explorer/blocs/user_cubit.dart';
import 'package:movie_explorer/repositories/preferences_repository.dart';
import 'package:movie_explorer/repositories/tmdb_repository.dart';
import 'package:movie_explorer/repositories/user_repository.dart';
import 'package:movie_explorer/ui/screens/home_page.dart';
import 'package:movie_explorer/ui/screens/login_page.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => UserCubit(UserRepository(PreferencesRepository()))),
    BlocProvider(create: (_) => MoviesCubit(TmdbRepository())),
    BlocProvider(create: (_) => FavoriteCubit(PreferencesRepository()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteCubit>().loadFavorites();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<UserCubit, bool>(
          builder: (context, isConnected) => isConnected ? const HomePage() : const LoginPage()),
    );
  }
}
