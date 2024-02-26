import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieplex/infrastructure/datasources/isar_datasource.dart';
import 'package:movieplex/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDataSourceImpl());
});
