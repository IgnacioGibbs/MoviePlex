import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:movieplex/domain/entities/movie.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    int randomNumber = Random().nextInt(1000);

    return FadeInUp(
      delay: Duration(milliseconds: randomNumber),
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
