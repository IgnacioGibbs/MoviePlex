import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieplex/infrastructure/datasources/cast_datasource_impl.dart';
import 'package:movieplex/infrastructure/repositories/cast_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return CastRepositoryImpl(CastDataSource());
});
