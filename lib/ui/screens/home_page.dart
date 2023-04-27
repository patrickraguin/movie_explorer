import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_explorer/blocs/movies_cubit.dart';
import 'package:movie_explorer/blocs/movies_state.dart';
import 'package:movie_explorer/blocs/user_cubit.dart';
import 'package:movie_explorer/models/movie.dart';
import 'package:movie_explorer/ui/screens/profile_page.dart';
import 'package:movie_explorer/ui/widgets/movie_card.dart';

import '../../models/data_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MoviesCubit>().loadMovies();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                  child: Text(
                'MovieExplorer',
                style: TextStyle(color: Colors.white),
              )),
            ),
            ListTile(
              leading: const Icon(Icons.person_rounded),
              title: const Text('Profile'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Se déconnecter'),
              onTap: () => context.read<UserCubit>().logout(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () => context.read<MoviesCubit>().loadMovies(),
            child: BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
              switch (state.dataState) {
                case DataState.loading:
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: CircularProgressIndicator()));
                case DataState.loaded:
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Populaires',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        SizedBox(
                          height: 160,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.popular.length,
                              separatorBuilder: (context, index) => const SizedBox(
                                    width: 16,
                                  ),
                              itemBuilder: (context, index) {
                                final Movie movie = state.popular[index];
                                return SizedBox(width: 280, child: MovieCard(movie: movie));
                              }),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Les mieux notés',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        SizedBox(
                          height: 160,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.topRated.length,
                              separatorBuilder: (context, index) => const SizedBox(
                                    width: 16,
                                  ),
                              itemBuilder: (context, index) {
                                final Movie movie = state.topRated[index];
                                return SizedBox(width: 280, child: MovieCard(movie: movie));
                              }),
                        ),
                      ],
                    ),
                  );
                case DataState.error:
                  return const Center(
                    child: Text('Une erreur est survenue, veuillez recommencer'),
                  );
              }
            }),
          ),
        ),
      ),
    );
  }
}
