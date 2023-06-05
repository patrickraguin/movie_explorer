import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  const MoviePage(this.movieId, {Key? key}) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
