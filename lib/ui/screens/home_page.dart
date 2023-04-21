import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_explorer/blocs/movies_cubit.dart';
import 'package:movie_explorer/models/movie.dart';

import '../widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MoviesCubit>().loadMovies();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: BlocBuilder<MoviesCubit, List<Movie>>(builder: (context, movies) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Populaires',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => context.read<MoviesCubit>().loadMovies(),
                    child: ListView.separated(
                        itemCount: movies.length,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 16,
                            ),
                        itemBuilder: (context, index) {
                          final Movie movie = movies[index];
                          return MovieCard(movie: movie);
                        }),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
