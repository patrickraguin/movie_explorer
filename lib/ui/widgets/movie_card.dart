import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_explorer/blocs/favorite_cubit.dart';
import 'package:movie_explorer/blocs/user_cubit.dart';
import 'package:movie_explorer/ui/screens/movie_page.dart';

import '../../models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoviePage(movie.id))),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w154/${movie.posterPath}',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        BlocBuilder<FavoriteCubit, List<int>>(builder: (context, state) {
                          final isFavorite = state.contains(movie.id);
                          if (isFavorite) {
                            return IconButton(
                                onPressed: () {
                                  context.read<FavoriteCubit>().removeFavorite(movie.id);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ));
                          } else {
                            return IconButton(
                                onPressed: () {
                                  context.read<FavoriteCubit>().addFavorite(movie.id);
                                },
                                icon: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.red,
                                ));
                          }
                        })
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RatingBarIndicator(
                      rating: movie.vote / 2,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                      direction: Axis.horizontal,
                    ),
                    TextButton(onPressed: () => context.read<UserCubit>().rate(movie.id), child: const Text('Voter'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
