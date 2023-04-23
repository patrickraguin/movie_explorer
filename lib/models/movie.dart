class Movie {
  final int id;
  final String title;
  final String posterPath;
  final num vote;

  Movie(this.id, this.title, this.posterPath, this.vote);

  factory Movie.fromJson(Map<String, dynamic> json) =>
      Movie(json['id'], json['title'], json['poster_path'], json['vote_average']);
}
