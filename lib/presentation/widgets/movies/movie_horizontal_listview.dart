import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movieplex/domain/entities/movie.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? onNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.onNextPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(children: [
        if (title != null || subtitle != null)
          _Title(title: title, subtitle: subtitle),
        Expanded(
            child: ListView.builder(
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _Slide(
                    movie: movies[index],
                  );
                }))
      ]),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
                  Image.network(movie.posterPath, fit: BoxFit.cover, width: 150,
                      loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ));
                }
                return FadeIn(child: child);
              }),
            ),
          ),

          const SizedBox(height: 5),

          // Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle.titleSmall,
            ),
          ),

          const SizedBox(height: 5),

          // Rating
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow.shade800, size: 15),
              const SizedBox(width: 5),
              Text(
                movie.voteAverage.toString(),
                style: textStyle.bodyMedium
                    ?.copyWith(color: Colors.yellow.shade800),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                movie.popularity.toString(),
                style: textStyle.bodyMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.titleSmall;

    return Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            if (title != null) Text(title!, style: titleStyle),
            const Spacer(),
            if (subtitle != null)
              FilledButton.tonal(
                  style:
                      const ButtonStyle(visualDensity: VisualDensity.compact),
                  onPressed: () {},
                  child: Text(
                    subtitle!,
                    style: subtitleStyle,
                  ))
          ],
        ));
  }
}
