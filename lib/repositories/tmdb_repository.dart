import 'package:dio/dio.dart';

import '../models/movie.dart';

class TmdbRepository {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3'));

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'api_key': 'f786d7920751b2397640a333295e76ad',
      'language': 'fr_FR',
      'page': 1,
      'region': 'FR'
    });

    if (response.statusCode == 200) {
      final List<Movie> movies = [];
      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      for (Map<String, dynamic> movieJson in results) {
        movies.add(Movie.fromJson(movieJson));
      }
      return movies;
    } else {
      throw Exception();
    }
  }
}
