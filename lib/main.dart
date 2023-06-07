import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/blocs/favorite_cubit.dart';
import 'package:movie_explorer/blocs/movies_cubit.dart';
import 'package:movie_explorer/blocs/profile_cubit.dart';
import 'package:movie_explorer/blocs/user_cubit.dart';
import 'package:movie_explorer/repositories/preferences_repository.dart';
import 'package:movie_explorer/repositories/tmdb_repository.dart';
import 'package:movie_explorer/repositories/user_repository.dart';
import 'package:movie_explorer/ui/screens/home_page.dart';
import 'package:movie_explorer/ui/screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final PreferencesRepository preferencesRepository = PreferencesRepository();
  final UserRepository userRepository = UserRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
  final UserCubit userCubit = UserCubit(userRepository);
  await userCubit.init();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => userCubit),
    BlocProvider(create: (_) => ProfileCubit(userRepository)),
    BlocProvider(create: (_) => MoviesCubit(TmdbRepository())),
    BlocProvider(create: (_) => FavoriteCubit(preferencesRepository))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteCubit>().loadFavorites();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<UserCubit, bool>(
          builder: (context, isConnected) => isConnected ? const HomePage() : const LoginPage()),
    );
  }
}
