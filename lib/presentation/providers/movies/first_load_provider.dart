import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieplex/presentation/providers/movies/movies_providers.dart';

final firstLoadProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;

  if (step1 || step2 || step3) {
    return true;
  }

  return false;
});
