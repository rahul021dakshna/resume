import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/local_database.dart';
import '../../data/repositories/resume_repository_impl.dart';
import '../../domain/repositories/resume_repository.dart';

final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return LocalDatabase.instance;
});

final resumeRepositoryProvider = Provider<ResumeRepository>((ref) {
  final localDb = ref.watch(localDatabaseProvider);
  return ResumeRepositoryImpl(localDb);
});
